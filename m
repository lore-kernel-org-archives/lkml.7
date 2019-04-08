Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E3CC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B4020880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dc/P5AOZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dc/P5AOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfDHGR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 02:17:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46372 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfDHGR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 02:17:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 873E460E57; Mon,  8 Apr 2019 06:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554704247;
        bh=z1hXdwssj7DpuhPU1og1IA40MP2w8+V8HlpcMNiaO8M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dc/P5AOZsuTl81jglTNDkYR6eOqeo6CYIClPW5iLZjtJ9qM3I8lMSbXsRvCMlfJAg
         mmUUXHUyCYvACKR4jNQK7zH01aY4PbTlOvGQ/PVAlxLwVwxc2MMHIuq15QqyX8v0h3
         boCdNjhyK3ozyEvR/i4QIb+LUFZdJ3zD2l3n5LrI=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CFE8A60398;
        Mon,  8 Apr 2019 06:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554704247;
        bh=z1hXdwssj7DpuhPU1og1IA40MP2w8+V8HlpcMNiaO8M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dc/P5AOZsuTl81jglTNDkYR6eOqeo6CYIClPW5iLZjtJ9qM3I8lMSbXsRvCMlfJAg
         mmUUXHUyCYvACKR4jNQK7zH01aY4PbTlOvGQ/PVAlxLwVwxc2MMHIuq15QqyX8v0h3
         boCdNjhyK3ozyEvR/i4QIb+LUFZdJ3zD2l3n5LrI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CFE8A60398
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] alarmtimer: return correct remaining time
To:     Andrei Vagin <avagin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>
References: <20190408041542.26338-1-avagin@gmail.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <309c7219-0154-272a-d535-6421e71f6ce5@codeaurora.org>
Date:   Mon, 8 Apr 2019 11:47:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408041542.26338-1-avagin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/8/2019 9:45 AM, Andrei Vagin wrote:
> To calculate a remaining time, we need to subtract the current time from
> the expiration time. Currently, arguments of ktime_sub are swapped.
>
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> ---
>   kernel/time/alarmtimer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
> index 2c97e8c2d29f..0519a8805aab 100644
> --- a/kernel/time/alarmtimer.c
> +++ b/kernel/time/alarmtimer.c
> @@ -594,7 +594,7 @@ static ktime_t alarm_timer_remaining(struct k_itimer *timr, ktime_t now)
>   {
>   	struct alarm *alarm = &timr->it.alarm.alarmtimer;
>   
> -	return ktime_sub(now, alarm->node.expires);
> +	return ktime_sub(alarm->node.expires, now);


Looks good to me.
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

>   }
>   
>   /**
