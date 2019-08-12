Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECA3C0650F
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 02:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9D62075B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 02:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfHLC7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 22:59:51 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:47610 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726200AbfHLC7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 22:59:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TZD5MR7_1565578788;
Received: from bn0418deMacBook-Pro.local(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0TZD5MR7_1565578788)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 12 Aug 2019 10:59:48 +0800
Subject: Re: [PATCH 1/2] genirq: introduce update_irq_devid()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
        tao.ma@linux.alibaba.com, gerry@linux.alibaba.com
References: <cover.1565263723.git.luoben@linux.alibaba.com>
 <39a5009c77d07c3ce42ef784465c05e36d5f684d.1565263723.git.luoben@linux.alibaba.com>
 <alpine.DEB.2.21.1908082138410.2882@nanos.tec.linutronix.de>
From:   luoben <luoben@linux.alibaba.com>
Message-ID: <46a5b5ea-8832-470b-2577-d7412e6a9cbd@linux.alibaba.com>
Date:   Mon, 12 Aug 2019 10:59:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908082138410.2882@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2019/8/9 上午3:56, Thomas Gleixner 写道:
> On Thu, 8 Aug 2019, Ben Luo wrote:
>> +int update_irq_devid(unsigned int irq, void *dev_id, void *new_dev_id)
>> +{
>> +	struct irq_desc *desc = irq_to_desc(irq);
>> +	struct irqaction *action, **action_ptr;
>> +	unsigned long flags;
>> +
>> +	WARN(in_interrupt(),
>> +			"Trying to update IRQ %d from IRQ context!\n", irq);
> This is broken. The function needs to return on that condition. Actually it
> cannot even be called from non-preemptible code.
>
> What's worse is that if the interrupt in question is handled concurrently,
> then it will either see the old or the new dev_id and because the interrupt
> handler loop runs with desc->lock dropped even more crap can happen because
> dev_id can be subject to load and store tearing.
>
> Staring at that, I see that there is the same issue in setup_irq() and
> free_irq(). It's actually worse there. I'll have a look.

ok,  will return with an error code in v2 in this case

>
>> +	/*
>> +	 * There can be multiple actions per IRQ descriptor, find the right
>> +	 * one based on the dev_id:
>> +	 */
>> +	action_ptr = &desc->action;
>> +	for (;;) {
>> +		action = *action_ptr;
>> +
>> +		if (!action) {
>> +			WARN(1, "Trying to update already-free IRQ %d\n", irq);
> That's wrong in two aspects:
>
>         1) The warn should be outside of the locked region.
>
>         2) Just having the irq number is not useful for debugging either
>         	  when the interrupt is shared.
will take care in v2
>> +			raw_spin_unlock_irqrestore(&desc->lock, flags);
>> +			chip_bus_sync_unlock(desc);
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
>> +	 */
>> +	synchronize_irq(irq);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(update_irq_devid);
> EXPORT_SYMBOL_GPL() please.
thanks, will use EXPORT_SYMBOL_GPL in v2
>
> Thanks,
>
> 	tglx

Thanks,

      Ben

