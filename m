Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62901C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306112183E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aJgMo+7c";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OldgrXnO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfCUUbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:31:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37432 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbfCUUbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:31:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7F62260EA5; Thu, 21 Mar 2019 20:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553200294;
        bh=A7x9mXnovuI5jQSyyKxuIbxr4RSUjpbsFr8tFQIArcU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aJgMo+7cBcqbUkrFPFHyUPZ7+8/MUeue5KkwT8kl9TrzNjogXOwcCYFRfwLfTLzWP
         O3DIdNQvLQYfaspsZ6FCH9W9/KbkDGXG4uBYCGI+giRNaW14CYmSqaPUDw980mEz+J
         Ea1l2iCMmCP28c4JuN02hDtafUKK/kWudZSHZkBI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id BEF6460DB6;
        Thu, 21 Mar 2019 20:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553200293;
        bh=A7x9mXnovuI5jQSyyKxuIbxr4RSUjpbsFr8tFQIArcU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OldgrXnOHNxu+S2sFgn70cP1WwNsc8kOy6Cd4kNHHF7p5UL/JFpQlYDG8tVWynZw1
         McgBWRQLfW7X0omNfLoGfLaUo1jjiUSbSPKcrEROpgSKhrcPkpj32/eER3o3thTMoZ
         IYEgBOhS3C7atpYMV2hqzZ2gRiSM2/jKhGAEDkqc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 21 Mar 2019 13:31:33 -0700
From:   Sodagudi Prasad <psodagud@codeaurora.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] genirq: call cancel_work_sync from
 irq_set_affinity_notifier
In-Reply-To: <alpine.DEB.2.21.1903211651030.1784@nanos.tec.linutronix.de>
References: <1553119211-29761-1-git-send-email-psodagud@codeaurora.org>
 <alpine.DEB.2.21.1903211651030.1784@nanos.tec.linutronix.de>
Message-ID: <fd8a18f33a3f385575048969482fd22f@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-21 09:19, Thomas Gleixner wrote:
> Prasad,
> 
> On Wed, 20 Mar 2019, Prasad Sodagudi wrote:
> 
>> Subject: [PATCH] genirq: call cancel_work_sync from 
>> irq_set_affinity_notifier
> 
> Please do not decribe WHAT the code change is. Give a consice 
> explanation
> WHY this change is done. The above is like '[PATCH] foo: Increment bar 
> by 5'.
> 
>   [PATCH] genirq: Prevent UAF and work list corruption
> 
>> When ever notification of IRQ affinity changes, call
>> cancel_work_sync from irq_set_affinity_notifier to cancel
>> all pending works to avoid work list corruption.
> 
> Again, you describe first WHAT you are doing instead of telling WHY.
> 
>   When irq_set_affinity_notifier() replaces the notifier, then the
>   reference count on the old notifier is dropped which causes it to be
>   freed. But nothing ensures that the old notifier is not longer queued 
> in
>   the work list. If it is queued this results in a use after free and
>   possibly in work list corruption.
> 
>   Ensure that the work is canceled before the reference is dropped.
> 
> See?

Hi Tglx,

Thanks for suggesting commit text and modifications.

> 
> This gives precise context first and then describes the cure.
> 
> Also it is completely irrelevant whether this is achieved by calling
> cancel_work_sync() or by something else. What matters is that it's
> canceled. Changelogs describe context and concepts not implementation
> details. The implementation details are in the patch itself.
> 
>> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
>> ---
>>  kernel/irq/manage.c | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
>> index 9ec34a2..da8b2ee 100644
>> --- a/kernel/irq/manage.c
>> +++ b/kernel/irq/manage.c
>> @@ -356,6 +356,9 @@ static void irq_affinity_notify(struct work_struct 
>> *work)
>>  	desc->affinity_notify = notify;
>>  	raw_spin_unlock_irqrestore(&desc->lock, flags);
>> 
>> +	if (!notify && old_notify)
>> +		cancel_work_sync(&old_notify->work);
> 
> That '!notify' doesn't make any sense.

Yes. I will remove this in the next patch set.  Thanks for reviewing.

-thanks, Prasad
> 
> Thanks,
> 
> 	tglx

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
