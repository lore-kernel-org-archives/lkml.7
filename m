Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678ACC3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 04:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3152E23431
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 04:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfHaEi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 00:38:57 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:53133 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725298AbfHaEi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 00:38:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Tav9ztU_1567226330;
Received: from bn0418deMacBook-Pro.local(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0Tav9ztU_1567226330)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 31 Aug 2019 12:38:50 +0800
Subject: Re: [PATCH v5 3/3] vfio/pci: make use of irq_update_devid and
 optimize irq ops
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        tao.ma@linux.alibaba.com, gerry@linux.alibaba.com,
        nanhai.zou@linux.alibaba.com
References: <cover.1567151182.git.luoben@linux.alibaba.com>
 <9a8b3fc5d82c3c46feb0de673fbe898cfd884d63.1567151182.git.luoben@linux.alibaba.com>
 <20190830140616.090954b7@x1.home>
From:   Ben Luo <luoben@linux.alibaba.com>
Message-ID: <7b8967d8-8d03-5422-9222-f80778b59f6c@linux.alibaba.com>
Date:   Sat, 31 Aug 2019 12:38:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830140616.090954b7@x1.home>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2019/8/31 ÉÏÎç4:06, Alex Williamson Ð´µÀ:
> On Fri, 30 Aug 2019 16:42:06 +0800
> Ben Luo <luoben@linux.alibaba.com> wrote:
>
>> When userspace (e.g. qemu) triggers a switch between KVM
>> irqfd and userspace eventfd, only dev_id of irqaction
>> (i.e. the "trigger" in this patch's context) will be
>> changed, but a free-then-request-irq action is taken in
>> current code. And, irq affinity setting in VM will also
>> trigger a free-then-request-irq action, which actually
>> changes nothing, but only need to bounce the irqbypass
>> registraion in case that posted-interrupt is in use.
>>
>> This patch makes use of irq_update_devid() and optimize
>> both cases above, which reduces the risk of losing interrupt
>> and also cuts some overhead.
>>
>> Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
>> ---
>>   drivers/vfio/pci/vfio_pci_intrs.c | 124 ++++++++++++++++++++++++++------------
>>   1 file changed, 87 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
>> index 3fa3f72..d3a93d7 100644
>> --- a/drivers/vfio/pci/vfio_pci_intrs.c
>> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
>> @@ -284,70 +284,120 @@ static int vfio_msi_enable(struct vfio_pci_device *vdev, int nvec, bool msix)
>>   static int vfio_msi_set_vector_signal(struct vfio_pci_device *vdev,
>>   				      int vector, int fd, bool msix)
>>   {
>> +	struct eventfd_ctx *trigger = NULL;
>>   	struct pci_dev *pdev = vdev->pdev;
>> -	struct eventfd_ctx *trigger;
>>   	int irq, ret;
>>   
>>   	if (vector < 0 || vector >= vdev->num_ctx)
>>   		return -EINVAL;
>>   
>> +	if (fd >= 0) {
>> +		trigger = eventfd_ctx_fdget(fd);
>> +		if (IS_ERR(trigger)) {
>> +			/* oops, going to disable this interrupt */
>> +			dev_info(&pdev->dev,
>> +				 "get ctx error on bad fd: %d for vector:%d\n",
>> +				 fd, vector);
> I think a user could trigger this maliciously as a denial of service by
> simply providing a bogus file descriptor.  The user is informed of the
> error by the return value, why do we need to spam the logs?
Ah, you are right, I will remove this log in next version
>> +		}
>> +	}
>> +
>>   	irq = pci_irq_vector(pdev, vector);
>>   
>> +	/*
>> +	 * 'trigger' is NULL or invalid, disable the interrupt
>> +	 * 'trigger' is same as before, only bounce the bypass registration
>> +	 * 'trigger' is a new invalid one, update it to irqaction and other
> s/invalid/valid/
sorry for typo :)
>> +	 * data structures referencing to the old one; fallback to disable
>> +	 * the interrupt on error
>> +	 */
>>   	if (vdev->ctx[vector].trigger) {
>> -		free_irq(irq, vdev->ctx[vector].trigger);
>> +		/*
>> +		 * even if the trigger is unchanged we need to bounce the
>> +		 * interrupt bypass connection to allow affinity changes in
>> +		 * the guest to be realized.
>> +		 */
>>   		irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
>> -		kfree(vdev->ctx[vector].name);
>> -		eventfd_ctx_put(vdev->ctx[vector].trigger);
>> -		vdev->ctx[vector].trigger = NULL;
>> +
>> +		if (vdev->ctx[vector].trigger == trigger) {
>> +			/* avoid duplicated referencing to the same trigger */
>> +			eventfd_ctx_put(trigger);
>> +
>> +		} else if (trigger && !IS_ERR(trigger)) {
>> +			ret = irq_update_devid(irq,
>> +					       vdev->ctx[vector].trigger, trigger);
>> +			if (unlikely(ret)) {
>> +				dev_info(&pdev->dev,
>> +					 "update devid of %d (token %p) failed: %d\n",
>> +					 irq, vdev->ctx[vector].trigger, ret);
>> +				eventfd_ctx_put(trigger);
>> +				free_irq(irq, vdev->ctx[vector].trigger);
>> +				kfree(vdev->ctx[vector].name);
>> +				eventfd_ctx_put(vdev->ctx[vector].trigger);
>> +				vdev->ctx[vector].trigger = NULL;
>> +				return ret;
>> +			}
>> +			eventfd_ctx_put(vdev->ctx[vector].trigger);
>> +			vdev->ctx[vector].producer.token = trigger;
>> +			vdev->ctx[vector].trigger = trigger;
>> +
>> +		} else {
>> +			free_irq(irq, vdev->ctx[vector].trigger);
>> +			kfree(vdev->ctx[vector].name);
>> +			eventfd_ctx_put(vdev->ctx[vector].trigger);
>> +			vdev->ctx[vector].trigger = NULL;
>> +		}
>>   	}
>>   
>>   	if (fd < 0)
>>   		return 0;
>> +	else if (IS_ERR(trigger))
>> +		return PTR_ERR(trigger);
>>   
>> -	vdev->ctx[vector].name = kasprintf(GFP_KERNEL, "vfio-msi%s[%d](%s)",
>> -					   msix ? "x" : "", vector,
>> -					   pci_name(pdev));
>> -	if (!vdev->ctx[vector].name)
>> -		return -ENOMEM;
>> +	if (!vdev->ctx[vector].trigger) {
>> +		vdev->ctx[vector].name = kasprintf(GFP_KERNEL,
>> +						   "vfio-msi%s[%d](%s)",
>> +						   msix ? "x" : "", vector,
>> +						   pci_name(pdev));
>> +		if (!vdev->ctx[vector].name) {
>> +			eventfd_ctx_put(trigger);
>> +			return -ENOMEM;
>> +		}
>>   
>> -	trigger = eventfd_ctx_fdget(fd);
>> -	if (IS_ERR(trigger)) {
>> -		kfree(vdev->ctx[vector].name);
>> -		return PTR_ERR(trigger);
>> -	}
>> +		/*
>> +		 * The MSIx vector table resides in device memory which may be
>> +		 * cleared via backdoor resets. We don't allow direct access to
>> +		 * the vector table so even if a userspace driver attempts to
>> +		 * save/restore around such a reset it would be unsuccessful.
>> +		 * To avoid this, restore the cached value of the message prior
>> +		 * to enabling.
>> +		 */
>> +		if (msix) {
>> +			struct msi_msg msg;
>>   
>> -	/*
>> -	 * The MSIx vector table resides in device memory which may be cleared
>> -	 * via backdoor resets. We don't allow direct access to the vector
>> -	 * table so even if a userspace driver attempts to save/restore around
>> -	 * such a reset it would be unsuccessful. To avoid this, restore the
>> -	 * cached value of the message prior to enabling.
>> -	 */
>> -	if (msix) {
>> -		struct msi_msg msg;
>> +			get_cached_msi_msg(irq, &msg);
>> +			pci_write_msi_msg(irq, &msg);
>> +		}
>>   
>> -		get_cached_msi_msg(irq, &msg);
>> -		pci_write_msi_msg(irq, &msg);
>> -	}
>> +		ret = request_irq(irq, vfio_msihandler, 0,
>> +				  vdev->ctx[vector].name, trigger);
>> +		if (ret) {
>> +			kfree(vdev->ctx[vector].name);
>> +			eventfd_ctx_put(trigger);
>> +			return ret;
>> +		}
>>   
>> -	ret = request_irq(irq, vfio_msihandler, 0,
>> -			  vdev->ctx[vector].name, trigger);
>> -	if (ret) {
>> -		kfree(vdev->ctx[vector].name);
>> -		eventfd_ctx_put(trigger);
>> -		return ret;
>> +		vdev->ctx[vector].producer.token = trigger;
>> +		vdev->ctx[vector].producer.irq = irq;
>> +		vdev->ctx[vector].trigger = trigger;
>>   	}
>>   
>> -	vdev->ctx[vector].producer.token = trigger;
>> -	vdev->ctx[vector].producer.irq = irq;
>> +	/* setup bypass connection and make irte updated */
>>   	ret = irq_bypass_register_producer(&vdev->ctx[vector].producer);
>>   	if (unlikely(ret))
>>   		dev_info(&pdev->dev,
>>   		"irq bypass producer (token %p) registration fails: %d\n",
>>   		vdev->ctx[vector].producer.token, ret);
>>   
>> -	vdev->ctx[vector].trigger = trigger;
>> -
>>   	return 0;
>>   }
>>   
