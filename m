Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF373C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 20:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76A92073F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 20:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfH3UGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 16:06:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbfH3UGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 16:06:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 63BAE51EE8;
        Fri, 30 Aug 2019 20:06:17 +0000 (UTC)
Received: from x1.home (ovpn-118-102.phx2.redhat.com [10.3.118.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3BA05D9D3;
        Fri, 30 Aug 2019 20:06:16 +0000 (UTC)
Date:   Fri, 30 Aug 2019 14:06:16 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Ben Luo <luoben@linux.alibaba.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        tao.ma@linux.alibaba.com, gerry@linux.alibaba.com,
        nanhai.zou@linux.alibaba.com
Subject: Re: [PATCH v5 3/3] vfio/pci: make use of irq_update_devid and
 optimize irq ops
Message-ID: <20190830140616.090954b7@x1.home>
In-Reply-To: <9a8b3fc5d82c3c46feb0de673fbe898cfd884d63.1567151182.git.luoben@linux.alibaba.com>
References: <cover.1567151182.git.luoben@linux.alibaba.com>
        <9a8b3fc5d82c3c46feb0de673fbe898cfd884d63.1567151182.git.luoben@linux.alibaba.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 30 Aug 2019 20:06:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 16:42:06 +0800
Ben Luo <luoben@linux.alibaba.com> wrote:

> When userspace (e.g. qemu) triggers a switch between KVM
> irqfd and userspace eventfd, only dev_id of irqaction
> (i.e. the "trigger" in this patch's context) will be
> changed, but a free-then-request-irq action is taken in
> current code. And, irq affinity setting in VM will also
> trigger a free-then-request-irq action, which actually
> changes nothing, but only need to bounce the irqbypass
> registraion in case that posted-interrupt is in use.
> 
> This patch makes use of irq_update_devid() and optimize
> both cases above, which reduces the risk of losing interrupt
> and also cuts some overhead.
> 
> Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
> ---
>  drivers/vfio/pci/vfio_pci_intrs.c | 124 ++++++++++++++++++++++++++------------
>  1 file changed, 87 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
> index 3fa3f72..d3a93d7 100644
> --- a/drivers/vfio/pci/vfio_pci_intrs.c
> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> @@ -284,70 +284,120 @@ static int vfio_msi_enable(struct vfio_pci_device *vdev, int nvec, bool msix)
>  static int vfio_msi_set_vector_signal(struct vfio_pci_device *vdev,
>  				      int vector, int fd, bool msix)
>  {
> +	struct eventfd_ctx *trigger = NULL;
>  	struct pci_dev *pdev = vdev->pdev;
> -	struct eventfd_ctx *trigger;
>  	int irq, ret;
>  
>  	if (vector < 0 || vector >= vdev->num_ctx)
>  		return -EINVAL;
>  
> +	if (fd >= 0) {
> +		trigger = eventfd_ctx_fdget(fd);
> +		if (IS_ERR(trigger)) {
> +			/* oops, going to disable this interrupt */
> +			dev_info(&pdev->dev,
> +				 "get ctx error on bad fd: %d for vector:%d\n",
> +				 fd, vector);

I think a user could trigger this maliciously as a denial of service by
simply providing a bogus file descriptor.  The user is informed of the
error by the return value, why do we need to spam the logs?

> +		}
> +	}
> +
>  	irq = pci_irq_vector(pdev, vector);
>  
> +	/*
> +	 * 'trigger' is NULL or invalid, disable the interrupt
> +	 * 'trigger' is same as before, only bounce the bypass registration
> +	 * 'trigger' is a new invalid one, update it to irqaction and other

s/invalid/valid/

> +	 * data structures referencing to the old one; fallback to disable
> +	 * the interrupt on error
> +	 */
>  	if (vdev->ctx[vector].trigger) {
> -		free_irq(irq, vdev->ctx[vector].trigger);
> +		/*
> +		 * even if the trigger is unchanged we need to bounce the
> +		 * interrupt bypass connection to allow affinity changes in
> +		 * the guest to be realized.
> +		 */
>  		irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
> -		kfree(vdev->ctx[vector].name);
> -		eventfd_ctx_put(vdev->ctx[vector].trigger);
> -		vdev->ctx[vector].trigger = NULL;
> +
> +		if (vdev->ctx[vector].trigger == trigger) {
> +			/* avoid duplicated referencing to the same trigger */
> +			eventfd_ctx_put(trigger);
> +
> +		} else if (trigger && !IS_ERR(trigger)) {
> +			ret = irq_update_devid(irq,
> +					       vdev->ctx[vector].trigger, trigger);
> +			if (unlikely(ret)) {
> +				dev_info(&pdev->dev,
> +					 "update devid of %d (token %p) failed: %d\n",
> +					 irq, vdev->ctx[vector].trigger, ret);
> +				eventfd_ctx_put(trigger);
> +				free_irq(irq, vdev->ctx[vector].trigger);
> +				kfree(vdev->ctx[vector].name);
> +				eventfd_ctx_put(vdev->ctx[vector].trigger);
> +				vdev->ctx[vector].trigger = NULL;
> +				return ret;
> +			}
> +			eventfd_ctx_put(vdev->ctx[vector].trigger);
> +			vdev->ctx[vector].producer.token = trigger;
> +			vdev->ctx[vector].trigger = trigger;
> +
> +		} else {
> +			free_irq(irq, vdev->ctx[vector].trigger);
> +			kfree(vdev->ctx[vector].name);
> +			eventfd_ctx_put(vdev->ctx[vector].trigger);
> +			vdev->ctx[vector].trigger = NULL;
> +		}
>  	}
>  
>  	if (fd < 0)
>  		return 0;
> +	else if (IS_ERR(trigger))
> +		return PTR_ERR(trigger);
>  
> -	vdev->ctx[vector].name = kasprintf(GFP_KERNEL, "vfio-msi%s[%d](%s)",
> -					   msix ? "x" : "", vector,
> -					   pci_name(pdev));
> -	if (!vdev->ctx[vector].name)
> -		return -ENOMEM;
> +	if (!vdev->ctx[vector].trigger) {
> +		vdev->ctx[vector].name = kasprintf(GFP_KERNEL,
> +						   "vfio-msi%s[%d](%s)",
> +						   msix ? "x" : "", vector,
> +						   pci_name(pdev));
> +		if (!vdev->ctx[vector].name) {
> +			eventfd_ctx_put(trigger);
> +			return -ENOMEM;
> +		}
>  
> -	trigger = eventfd_ctx_fdget(fd);
> -	if (IS_ERR(trigger)) {
> -		kfree(vdev->ctx[vector].name);
> -		return PTR_ERR(trigger);
> -	}
> +		/*
> +		 * The MSIx vector table resides in device memory which may be
> +		 * cleared via backdoor resets. We don't allow direct access to
> +		 * the vector table so even if a userspace driver attempts to
> +		 * save/restore around such a reset it would be unsuccessful.
> +		 * To avoid this, restore the cached value of the message prior
> +		 * to enabling.
> +		 */
> +		if (msix) {
> +			struct msi_msg msg;
>  
> -	/*
> -	 * The MSIx vector table resides in device memory which may be cleared
> -	 * via backdoor resets. We don't allow direct access to the vector
> -	 * table so even if a userspace driver attempts to save/restore around
> -	 * such a reset it would be unsuccessful. To avoid this, restore the
> -	 * cached value of the message prior to enabling.
> -	 */
> -	if (msix) {
> -		struct msi_msg msg;
> +			get_cached_msi_msg(irq, &msg);
> +			pci_write_msi_msg(irq, &msg);
> +		}
>  
> -		get_cached_msi_msg(irq, &msg);
> -		pci_write_msi_msg(irq, &msg);
> -	}
> +		ret = request_irq(irq, vfio_msihandler, 0,
> +				  vdev->ctx[vector].name, trigger);
> +		if (ret) {
> +			kfree(vdev->ctx[vector].name);
> +			eventfd_ctx_put(trigger);
> +			return ret;
> +		}
>  
> -	ret = request_irq(irq, vfio_msihandler, 0,
> -			  vdev->ctx[vector].name, trigger);
> -	if (ret) {
> -		kfree(vdev->ctx[vector].name);
> -		eventfd_ctx_put(trigger);
> -		return ret;
> +		vdev->ctx[vector].producer.token = trigger;
> +		vdev->ctx[vector].producer.irq = irq;
> +		vdev->ctx[vector].trigger = trigger;
>  	}
>  
> -	vdev->ctx[vector].producer.token = trigger;
> -	vdev->ctx[vector].producer.irq = irq;
> +	/* setup bypass connection and make irte updated */
>  	ret = irq_bypass_register_producer(&vdev->ctx[vector].producer);
>  	if (unlikely(ret))
>  		dev_info(&pdev->dev,
>  		"irq bypass producer (token %p) registration fails: %d\n",
>  		vdev->ctx[vector].producer.token, ret);
>  
> -	vdev->ctx[vector].trigger = trigger;
> -
>  	return 0;
>  }
>  

