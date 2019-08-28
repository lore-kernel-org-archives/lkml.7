Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD1EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE01217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfH1KIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:08:09 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:59212 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726253AbfH1KIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:08:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TagZSlR_1566986882;
Received: from bn0418deMacBook-Pro.local(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0TagZSlR_1566986882)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 28 Aug 2019 18:08:02 +0800
Subject: Re: [PATCH v4 3/3] vfio/pci: make use of irq_update_devid and
 optimize irq ops
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        tao.ma@linux.alibaba.com, gerry@linux.alibaba.com,
        nanhai.zou@linux.alibaba.com, linyunsheng@huawei.com
References: <cover.1566486156.git.luoben@linux.alibaba.com>
 <8721e56f15dbcb1e0a1d8fc645def7b9bc752988.1566486156.git.luoben@linux.alibaba.com>
 <20190827143305.1ac826e1@x1.home>
From:   Ben Luo <luoben@linux.alibaba.com>
Message-ID: <429ae9ed-de9d-f8de-de65-a41c3a0c501d@linux.alibaba.com>
Date:   Wed, 28 Aug 2019 18:08:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827143305.1ac826e1@x1.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2019/8/28 上午4:33, Alex Williamson 写道:
> On Thu, 22 Aug 2019 23:34:43 +0800
> Ben Luo <luoben@linux.alibaba.com> wrote:
>
>> When userspace (e.g. qemu) triggers a switch between KVM
>> irqfd and userspace eventfd, only dev_id of irq action
>> (i.e. the "trigger" in this patch's context) will be
>> changed, but a free-then-request-irq action is taken in
>> current code. And, irq affinity setting in VM will also
>> trigger a free-then-request-irq action, which actually
>> changes nothing, but only fires a producer re-registration
>> to update irte in case that posted-interrupt is in use.
>>
>> This patch makes use of irq_update_devid() and optimize
>> both cases above, which reduces the risk of losing interrupt
>> and also cuts some overhead.
>>
>> Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
>> ---
>>   drivers/vfio/pci/vfio_pci_intrs.c | 112 +++++++++++++++++++++++++-------------
>>   1 file changed, 74 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
>> index 3fa3f72..60d3023 100644
>> --- a/drivers/vfio/pci/vfio_pci_intrs.c
>> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
>> @@ -284,70 +284,106 @@ static int vfio_msi_enable(struct vfio_pci_device *vdev, int nvec, bool msix)
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
>> +		if (IS_ERR(trigger))
>> +			return PTR_ERR(trigger);
>> +	}
> I think this is a user visible change.  Previously the vector is
> disabled first, then if an error occurs re-enabling, we return an errno
> with the vector disabled.  Here we instead fail the ioctl and leave the
> state as if it had never happened.  For instance with QEMU, if they
> were trying to change from KVM to userspace signaling and entered this
> condition, previously the interrupt would signal to neither eventfd, now
> it would continue signaling to KVM. If QEMU's intent was to emulate
> vector masking, this could induce unhandled interrupts in the guest.
> Maybe we need a tear-down on fault here to maintain that behavior, or
> do you see some justification for the change?

Thanks for your comments, this reminds me to think more about the 
effects to users.

After I reviewed the related code in Qemu and VFIO, I think maybe there 
is a problem in current behavior
for the signal path changing case. Qemu has neither recovery nor retry 
code in case that ioctl with
'VFIO_DEVICE_SET_IRQS' command fails, so if the old signal path has been 
disabled on fault of setting
up new path, the corresponding vector may be disabled forever. Following 
is an example from qemu's
vfio_msix_vector_do_use():

         ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
         g_free(irq_set);
         if (ret) {
             error_report("vfio: failed to modify vector, %d", ret);
         }

I think the singal path before changing should be still working at this 
moment and the caller should keep it
working if the changing fails, so that at least we still have the old 
path instead of no path.

For masking vector case, the 'fd' should be -1, and the interrupt will 
be freed as before this patch.

>
>> +
>>   	irq = pci_irq_vector(pdev, vector);
>>   
>> +	/*
>> +	 * For KVM-VFIO case, interrupt from passthrough device will be directly
>> +	 * delivered to VM after producer and consumer connected successfully.
>> +	 * If producer and consumer are disconnected, this interrupt process
>> +	 * will fall back to remap mode, where interrupt handler uses 'trigger'
>> +	 * to find the right way to deliver the interrupt to VM. So, it is safe
>> +	 * to do irq_update_devid() before irq_bypass_unregister_producer() which
>> +	 * switches interrupt process to remap mode. To producer and consumer,
>> +	 * 'trigger' is only a token used for pairing them togather.
>> +	 */
>>   	if (vdev->ctx[vector].trigger) {
>> -		free_irq(irq, vdev->ctx[vector].trigger);
>> -		irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
>> -		kfree(vdev->ctx[vector].name);
>> -		eventfd_ctx_put(vdev->ctx[vector].trigger);
>> -		vdev->ctx[vector].trigger = NULL;
>> +		if (vdev->ctx[vector].trigger == trigger) {
>> +			/* switch back to remap mode */
>> +			irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
> I think we leak the fd context we acquired above in this case.
Thanks for pointing it out, I will fix this in next version.
>
> Why do we do anything in this case, couldn't we just 'put' the extra ctx
> and return 0 here?

Sorry for confusing and I do this for a reason,  I will add some more 
comments like this:

Unregistration here is for re-resigtraion later, which will trigger the 
reconnection of irq_bypass producer
and consumer, which in turn calls vmx_update_pi_irte() to update IRTE if 
posted interrupt is in use.
(vmx_update_pi_irte() will modify IRTE based on the information 
retrieved from KVM.)
Whether producer token changed or not, irq_bypass_register_producer() is 
a way (seems the only way) to
update IRTE by VFIO for posted interrupt. The IRTE will be used by IOMMU 
directly to find the target CPU
for an interrupt posted to VM, since hypervisor is bypassed.
>
>> +		} else if (trigger) {
>> +			ret = irq_update_devid(irq,
>> +					       vdev->ctx[vector].trigger, trigger);
>> +			if (unlikely(ret)) {
>> +				dev_info(&pdev->dev,
>> +					 "update devid of %d (token %p) failed: %d\n",
>> +					 irq, vdev->ctx[vector].trigger, ret);
>> +				eventfd_ctx_put(trigger);
>> +				return ret;
>> +			}
>> +			irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
> Can you explain this ordering, I would have expected that we'd
> unregister the bypass before we updated the devid.  Thanks,
>
> Alex
Actually, I have explained this in comments above this whole control 
block. I think it is safe and better to
update devid before irq_bypass_unregister_producer() which switches 
interrupt process from posted mode
to remap mode. So, if update fails, the posted interrupt can still work.

Anyway, to producer and consumer,  'trigger' is only a token used for 
pairing them togather.

Thanks,

     Ben

