Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8D3C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D8022CF5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbfH0UdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:33:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbfH0UdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:33:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 039EE307CDEA;
        Tue, 27 Aug 2019 20:33:13 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E51735D6B0;
        Tue, 27 Aug 2019 20:33:11 +0000 (UTC)
Date:   Tue, 27 Aug 2019 14:33:05 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Ben Luo <luoben@linux.alibaba.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        tao.ma@linux.alibaba.com, gerry@linux.alibaba.com,
        nanhai.zou@linux.alibaba.com, linyunsheng@huawei.com
Subject: Re: [PATCH v4 3/3] vfio/pci: make use of irq_update_devid and
 optimize irq ops
Message-ID: <20190827143305.1ac826e1@x1.home>
In-Reply-To: <8721e56f15dbcb1e0a1d8fc645def7b9bc752988.1566486156.git.luoben@linux.alibaba.com>
References: <cover.1566486156.git.luoben@linux.alibaba.com>
        <8721e56f15dbcb1e0a1d8fc645def7b9bc752988.1566486156.git.luoben@linux.alibaba.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 27 Aug 2019 20:33:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2019 23:34:43 +0800
Ben Luo <luoben@linux.alibaba.com> wrote:

> When userspace (e.g. qemu) triggers a switch between KVM
> irqfd and userspace eventfd, only dev_id of irq action
> (i.e. the "trigger" in this patch's context) will be
> changed, but a free-then-request-irq action is taken in
> current code. And, irq affinity setting in VM will also
> trigger a free-then-request-irq action, which actually
> changes nothing, but only fires a producer re-registration
> to update irte in case that posted-interrupt is in use.
> 
> This patch makes use of irq_update_devid() and optimize
> both cases above, which reduces the risk of losing interrupt
> and also cuts some overhead.
> 
> Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
> ---
>  drivers/vfio/pci/vfio_pci_intrs.c | 112 +++++++++++++++++++++++++-------------
>  1 file changed, 74 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
> index 3fa3f72..60d3023 100644
> --- a/drivers/vfio/pci/vfio_pci_intrs.c
> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> @@ -284,70 +284,106 @@ static int vfio_msi_enable(struct vfio_pci_device *vdev, int nvec, bool msix)
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
> +		if (IS_ERR(trigger))
> +			return PTR_ERR(trigger);
> +	}

I think this is a user visible change.  Previously the vector is
disabled first, then if an error occurs re-enabling, we return an errno
with the vector disabled.  Here we instead fail the ioctl and leave the
state as if it had never happened.  For instance with QEMU, if they
were trying to change from KVM to userspace signaling and entered this
condition, previously the interrupt would signal to neither eventfd, now
it would continue signaling to KVM.  If QEMU's intent was to emulate
vector masking, this could induce unhandled interrupts in the guest.
Maybe we need a tear-down on fault here to maintain that behavior, or
do you see some justification for the change?

> +
>  	irq = pci_irq_vector(pdev, vector);
>  
> +	/*
> +	 * For KVM-VFIO case, interrupt from passthrough device will be directly
> +	 * delivered to VM after producer and consumer connected successfully.
> +	 * If producer and consumer are disconnected, this interrupt process
> +	 * will fall back to remap mode, where interrupt handler uses 'trigger'
> +	 * to find the right way to deliver the interrupt to VM. So, it is safe
> +	 * to do irq_update_devid() before irq_bypass_unregister_producer() which
> +	 * switches interrupt process to remap mode. To producer and consumer,
> +	 * 'trigger' is only a token used for pairing them togather.
> +	 */
>  	if (vdev->ctx[vector].trigger) {
> -		free_irq(irq, vdev->ctx[vector].trigger);
> -		irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
> -		kfree(vdev->ctx[vector].name);
> -		eventfd_ctx_put(vdev->ctx[vector].trigger);
> -		vdev->ctx[vector].trigger = NULL;
> +		if (vdev->ctx[vector].trigger == trigger) {
> +			/* switch back to remap mode */
> +			irq_bypass_unregister_producer(&vdev->ctx[vector].producer);

I think we leak the fd context we acquired above in this case.

Why do we do anything in this case, couldn't we just 'put' the extra ctx
and return 0 here?

> +		} else if (trigger) {
> +			ret = irq_update_devid(irq,
> +					       vdev->ctx[vector].trigger, trigger);
> +			if (unlikely(ret)) {
> +				dev_info(&pdev->dev,
> +					 "update devid of %d (token %p) failed: %d\n",
> +					 irq, vdev->ctx[vector].trigger, ret);
> +				eventfd_ctx_put(trigger);
> +				return ret;
> +			}
> +			irq_bypass_unregister_producer(&vdev->ctx[vector].producer);

Can you explain this ordering, I would have expected that we'd
unregister the bypass before we updated the devid.  Thanks,

Alex

> +			eventfd_ctx_put(vdev->ctx[vector].trigger);
> +			vdev->ctx[vector].producer.token = trigger;
> +			vdev->ctx[vector].trigger = trigger;
> +		} else {
> +			free_irq(irq, vdev->ctx[vector].trigger);
> +			irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
> +			kfree(vdev->ctx[vector].name);
> +			eventfd_ctx_put(vdev->ctx[vector].trigger);
> +			vdev->ctx[vector].trigger = NULL;
> +		}
>  	}
>  
>  	if (fd < 0)
>  		return 0;
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

