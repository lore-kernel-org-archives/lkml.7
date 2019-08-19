Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE5BC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE16F2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfHSFcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 01:32:33 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:40848 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725308AbfHSFcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 01:32:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TZpDnXo_1566192703;
Received: from bn0418deMacBook-Pro.local(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0TZpDnXo_1566192703)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 19 Aug 2019 13:31:58 +0800
Subject: Re: [PATCH v3 2/3] genirq: introduce update_irq_devid()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
        tao.ma@linux.alibaba.com, gerry@linux.alibaba.com,
        nanhai.zou@linux.alibaba.com, linyunsheng@huawei.com
References: <cover.1565857737.git.luoben@linux.alibaba.com>
 <6343a7e34ffdd0ddcd730996fc5dad3024e42251.1565857737.git.luoben@linux.alibaba.com>
 <alpine.DEB.2.21.1908151622410.1908@nanos.tec.linutronix.de>
From:   luoben <luoben@linux.alibaba.com>
Message-ID: <8161633d-638d-f4b2-f225-462f711c1212@linux.alibaba.com>
Date:   Mon, 19 Aug 2019 13:31:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908151622410.1908@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2019/8/15 下午10:58, Thomas Gleixner 写道:
> Ben,
>
> On Thu, 15 Aug 2019, Ben Luo wrote:
>
>> Sometimes, only the dev_id field of irqaction need to be changed.
>> E.g. KVM VM with device passthru via VFIO may switch irq injection
>> path between KVM irqfd and userspace eventfd. These two paths
>> share the same irq num and handler for the same vector of a device,
> s/irq num/interrupt number/
>
> Changelogs are text and should not contain cryptic abbreviations.
>
>> only with different dev_id referencing to different fds' contexts.
>>
>> So, instead of free/request irq, only update dev_id of irqaction.
> Please write functions like this: function_name() so they can be easily
> identified in the text as such.
>
>> This narrows the gap for setting up new irq (and irte, if has)
> What does that mean: "narrows the gap"
>
> What's the gap and why is it only made smaller and not closed?

Sorry for confusing. The so called 'gap' is a time window between 
free_irq() and request_irq().

For example, interrupt affinity setting in a VM (with VFIO passthrough 
device) will trigger VFIO to

do free-then-setup interrupt as below. After free_irq(), the target IRTE 
is invalidated, an in-flight

interrupt (buffering in hardware layer which cannot be synchronized in 
software) may cause a

DMAR fault before IRTE being setup again with exactly the same value as 
this entry was before cleared

[1566032533719954] modify_irte with index:28 irte_hi:0000000000000000 
irte_lo:0000000000000000
  0xffffffff81465520 : modify_irte+0x0/0x160 [kernel]
...
  0xffffffff810d2a89 : free_irq+0x39/0x90 [kernel]
  0xffffffffa02891e0 : vfio_msi_set_vector_signal+0x80/0x280 [vfio_pci]
  0x0 (inexact)

[1566032533719982] DMAR FAULT begin

[1566032533719971] modify_irte with index:28 irte_hi:000000000004a601 
irte_lo:00003fff00ac002d
  0xffffffff81465520 : modify_irte+0x0/0x160 [kernel]
...
  0xffffffff810d3d2b : request_threaded_irq+0x10b/0x1a0 [kernel]
  0xffffffffa02892d6 : vfio_msi_set_vector_signal+0x176/0x280 [vfio_pci]
  0x0 (inexact)

By using a new function who only updates devid, this gap can actually be 
closed since

this new function won't modify irte.

When posted interrupt is in use, the target IRTE does need to be 
modified because this IRTE

will be used by IOMMU to find the target CPU since hypervisor is 
bypassed. That is also the

reason why still call irq_bypass_register_producer() although the token 
of producer has not

been changed. irq_bypass_register_producer() will modify irte if posted 
interrupt is in use:

[1566032533720007] index:28 irte_hi:000000010004a601 
irte_lo:adb54bc000b98001
  0xffffffff81465520 : modify_irte+0x0/0x160 [kernel]
...
  0xffffffffa0338386 : vfio_msi_set_vector_signal+0x1b6/0x2c0 [vfio_pci]

>
>> and also gains some performance benefit.
>>
>> Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
>> Reviewed-by: Liu Jiang <gerry@linux.alibaba.com>
> I prefer to see the 'reviewed-by' as a reply on LKML rather than coming
> from some internal process.
>
>> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> While I reviewed the previous version, I surely did not give a
> 'Reviewed-by' tag. That tag means that the person did review the patch and
> did not find an issue. I surely found issues, right?
Sorry for that，I will amend the commit messages
>> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
>> index 6f9b20f..a76ef61 100644
>> --- a/kernel/irq/manage.c
>> +++ b/kernel/irq/manage.c
>> @@ -2064,6 +2064,84 @@ int request_threaded_irq(unsigned int irq, irq_handler_t handler,
>>   EXPORT_SYMBOL(request_threaded_irq);
>>   
>>   /**
>> + *	update_irq_devid - update irq dev_id to a new one
> Can you please name this: irq_update_devid(). We try to have a consistent
> name space for new functions.
ok, will name it to irq_update_devid() in next version.
>
>> + *	@irq: Interrupt line to update
>> + *	@dev_id: A cookie to find the irqaction to update
>> + *	@new_dev_id: New cookie passed to the handler function
> Can you please arrange these in tabular fashion:
>
>   *	@irq:		Interrupt line to update
>   *	@dev_id:	A cookie to find the irqaction to update
>   *	@new_dev_id:	New cookie passed to the handler function
>
>> + *	Sometimes, only the cookie data need to be changed.
>> + *	Instead of free/request irq, only update dev_id here
>> + *	Not only to gain some performance benefit, but also
>> + *	reduce the risk of losing interrupt.
>> + *
>> + *	E.g. irq affinity setting in a VM with VFIO passthru
> Again. Please write it out 'interrupt' and everything else.
>
>> + *	device is carried out in a free-then-request-irq way
>> + *	since lack of this very function. The free_irq()
> That does not make sense. The function is there for such a use case. So
> immediately when the VFIO change is merged this comment is stale and bogus.
>
>> + *	eventually triggers deactivation of IR domain, which
>> + *	will cleanup IRTE. There is a gap before request_irq()
>> + *	finally setup the IRTE again. In this gap, a in-flight
>> + *	irq buffering in hardware layer may trigger DMAR fault
>> + *	and be lost.
> Exactly this information wants to be in the changelog.
>
>> + *
>> + *	On failure, it returns a negative value. On success,
>> + *	it returns 0
>> + */
>> +int update_irq_devid(unsigned int irq, void *dev_id, void *new_dev_id)
>> +{
>> +	struct irq_desc *desc = irq_to_desc(irq);
>> +	struct irqaction *action, **action_ptr;
>> +	unsigned long flags;
>> +
>> +	if (in_interrupt()) {
>> +		WARN(1, "Trying to update IRQ %d (dev_id %p to %p) from IRQ context!\n",
>> +		     irq, dev_id, new_dev_id);
>> +		return -EPERM;
>> +	}
>    	if (WARN(....)
>
>> +
>> +	if (!desc)
>> +		return -EINVAL;
>> +
>> +	chip_bus_lock(desc);
> This does not need to take bus lock. The action pointer is sufficiently
> protected by desc->lock.
>
>> +	raw_spin_lock_irqsave(&desc->lock, flags);
>> +
>> +	/*
>> +	 * There can be multiple actions per IRQ descriptor, find the right
>> +	 * one based on the dev_id:
>> +	 */
>> +	action_ptr = &desc->action;
>> +	for (;;) {
>> +		action = *action_ptr;
>> +
>> +		if (!action) {
>> +			raw_spin_unlock_irqrestore(&desc->lock, flags);
>> +			chip_bus_sync_unlock(desc);
>> +			WARN(1, "Trying to update already-free IRQ %d (dev_id %p to %p)\n",
>> +			     irq, dev_id, new_dev_id);
>> +			return -ENXIO;
>> +		}
>> +
>> +		if (action->dev_id == dev_id) {
>> +			action->dev_id = new_dev_id;
>> +			break;
>> +		}
>> +		action_ptr = &action->next;
>> +	}
>> +
>> +	raw_spin_unlock_irqrestore(&desc->lock, flags);
>> +	chip_bus_sync_unlock(desc);
>> +
>> +	/*
>> +	 * Make sure it's not being used on another CPU:
>> +	 * There is a risk of UAF for old *dev_id, if it is
>> +	 * freed in a short time after this func returns
> function please. Also it does not matter whether the time is short or
> not. The point is:
>
>       	 Ensure that an interrupt in flight on another CPU which uses the
>       	 old 'dev_id' has completed because the caller can free the memory
> 	 to which it points after this function returns.
>
> But this has another twist:
>
>      CPU0				CPU1
>
>      interrupt
>      	primary_handler(old_dev_id)
> 	   do_stuff_on(old_dev_id)
> 	   return WAKE_THREAD;		update_dev_id()
>          wakeup_thread();
> 					  action->dev_id = new_dev_id;
>      irq_thread()
>          secondary_handler(new_dev_id)
> 	
> That's broken and synchronize_irq() does not protect against it.

Thanks to point it out, I will change to the following in next version, 
is that ok?

...

     /*
      * Ensure that an interrupt in flight on another CPU which uses the
      * old 'dev_id' has completed because the caller can free the memory
      * to which it points after this function returns. And also void to
      * update 'dev_id' in the middle of a threaded interrupt process, it
      * can lead to a twist that primary handler uses old 'dev_id' but new
      * 'dev_id' is used by secondary handler.
      */
     disable_irq(irq);
     raw_spin_lock_irqsave(&desc->lock, flags);

     /*
      * There can be multiple actions per IRQ descriptor, find the right
      * one based on the dev_id:
      */
     action_ptr = &desc->action;
     for (;;) {
         action = *action_ptr;

         if (!action) {
             raw_spin_unlock_irqrestore(&desc->lock, flags);
             enable_irq(irq);
             WARN(1, "Trying to update already-free IRQ %d "
                     "(dev_id %p to %p)\n", irq, dev_id, new_dev_id);
             return -ENXIO;
         }

         if (action->dev_id == dev_id) {
             action->dev_id = new_dev_id;
             break;
         }
         action_ptr = &action->next;
     }

     raw_spin_unlock_irqrestore(&desc->lock, flags);
     enable_irq(irq);

     return 0;

>
>> +	 */
>> +	synchronize_irq(irq);
> Thanks,
>
> 	tglx

I will also amend the changelog and function comments etc. in next version


Thanks,

             Ben

