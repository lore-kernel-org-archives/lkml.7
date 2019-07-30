Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6AFC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B7B206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="o1eKgPg+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QxM2Jxx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbfG3Hx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 03:53:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49866 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbfG3Hx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:53:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5772C607DF; Tue, 30 Jul 2019 07:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564473207;
        bh=I5Z/jdTrRMXYJjBwUB5kQ34K8iBiwLsT3vud+4Ac4+U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=o1eKgPg+kCx+JZrkUWXo41CCzcOgABVf2/kdQEeG81yZ4p3MVyXa6SKMpvBjIJJXS
         oTWRj8uNUZKzVTExAbuWeiM7ffHaQXnTdacBYMKD6NeONToyKTVszVzxwS2dvKPOUX
         Vf/d8B4aKhxLlhWYbtZaTNXAjC9D1R99LTUWBikc=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 94BFF6037C;
        Tue, 30 Jul 2019 07:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564473206;
        bh=I5Z/jdTrRMXYJjBwUB5kQ34K8iBiwLsT3vud+4Ac4+U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QxM2Jxx9TiYp72J1T163dPWRsWqdlMKqCTtgtIEGG6Bg4Q9AeWLxZxhyh44FV3p9q
         YdwMDDI6ydRooVFb5LurRM9lrrwuMTs1D/dwSpQOQcTSy6dCgAJ+gGR5bR2CI4Pvtb
         EBSVu66xO+156V7tmfMpKD6Cj1/s0sp58a7QfEfM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 94BFF6037C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 2/2] locking/mutex: Use mutex flags macro instead of hard
 code value
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org
References: <1564397578-28423-1-git-send-email-mojha@codeaurora.org>
 <1564397578-28423-2-git-send-email-mojha@codeaurora.org>
 <20190729110727.GB31398@hirez.programming.kicks-ass.net>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <a80972a1-8e24-33cb-0088-49ef0e680540@codeaurora.org>
Date:   Tue, 30 Jul 2019 13:23:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729110727.GB31398@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/29/2019 4:37 PM, Peter Zijlstra wrote:
> On Mon, Jul 29, 2019 at 04:22:58PM +0530, Mukesh Ojha wrote:
>> Let's use the mutex flag macro(which got moved from mutex.c
>> to linux/mutex.h in the last patch) instead of hard code
>> value which was used in __mutex_owner().
>>
>> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
>> ---
>>   include/linux/mutex.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
>> index 79b28be..c3833ba 100644
>> --- a/include/linux/mutex.h
>> +++ b/include/linux/mutex.h
>> @@ -87,7 +87,7 @@ struct mutex {
>>    */
>>   static inline struct task_struct *__mutex_owner(struct mutex *lock)
>>   {
>> -	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~0x07);
>> +	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~MUTEX_FLAGS);
>>   }
> I would _much_ rather move __mutex_owner() out of line, you're exposing
> far too much stuff.

if i understand you correctly, you want me to move __mutex_owner() to 
mutex.c
__mutex_owner() is used in mutex_is_locked() and mutex_trylock_recursive 
inside linux/mutex.h.

Shall i move them as well ?

Thanks,
Mukesh


