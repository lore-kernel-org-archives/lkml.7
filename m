Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987E9C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 00:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59BB620815
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 00:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVGK/YZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732438AbfJAABc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 20:01:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44906 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfJAABc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 20:01:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id q21so6545550pfn.11;
        Mon, 30 Sep 2019 17:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S1Tcvw53vTIhG8BDZpsK1nMUL0vc/+3Wm51G/BAKoSM=;
        b=JVGK/YZvWQ7NugZ0aSaeMet59nBW+h5TYNoG4jaNh5+3PrGQo4wC3zbPKlVrFIVr3N
         I5KB5f7Bcockfo/8GTuzT82CGQlAEpz56c1D59qO/hau2Pf4EXznsk1fq0Sh6m/+A5HF
         l8H8PxJt+i2UfNRFCtkxj5mkcMCExJKPOOJSth2X9bJNgnRlMaXdjRHCYGNE+8WQzDfI
         /baeFNeq3SVLfN7TK2CL6lnuGvhOcDzE7WPzFSckRSFZ2It6FFdmggq9kIPVgCqfdaWe
         lA1ZzoWZItN1sf/9pmUyZHNpOZcOe/xO0+xp/Wk93fp5nH8WloLRoL4zebJ6GjBncYel
         hAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S1Tcvw53vTIhG8BDZpsK1nMUL0vc/+3Wm51G/BAKoSM=;
        b=o9vGqsYO001Dqa4n2tscipbf5wHgBBFsW0vheNjKe1R+WXuG5P2CthyI1SvYOGh4lB
         zYa1mxWUhuUUcgU41JYY7RpOFEvZTkhJHvfqV/eZZgt4pEslvIn1lzPL0vOKo3LFf+KB
         UTVVqz07w/evvfG9L9zQv1h76IDd+uaPO83ex5HelBOpQd3+S0QTkK6xveoruaLaKxG9
         XJbHaikYu9xgSkqzTptFB3/EFZ23E76UhrVV3KISD4wgNwcyBfC8CFv4i4vwlaeOQmFy
         Dq3doRczP/RvQo3KBKm9Y0v4N476/NzHUZnP/HFdV7N5C4YfrDmsigYYU6zhX/xSQA+S
         MOOw==
X-Gm-Message-State: APjAAAVtrxRWG9fcS6O6JxLZDfk3dda9ll7Aa4ORzTgXX/7jfdSW4bON
        WEV+lEbkMqE1iyJWo3irRnRJE1J2
X-Google-Smtp-Source: APXvYqw3nf7fYryZvUIGtLdiWfw6ymi9kjgQ17OT4xdzVggb+IaYJKl/SRNvphO+8l27lQA0ftfjIw==
X-Received: by 2002:a63:1e16:: with SMTP id e22mr8392746pge.413.1569888090966;
        Mon, 30 Sep 2019 17:01:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p189sm13003597pfp.163.2019.09.30.17.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 17:01:29 -0700 (PDT)
Subject: Re: [PATCH v2] hwmon: (applesmc) fix UB and udelay overflow
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     clang-built-linux@googlegroups.com, jdelvare@suse.com,
        =?UTF-8?Q?Tomasz_Pawe=c5=82_Gajc?= <tpgxyz@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAKwvOd=GVdHhsdHOMpuhEKkWMssW37keqX5c59+6fiEgLs+Q1g@mail.gmail.com>
 <20190924174728.201464-1-ndesaulniers@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a2e08779-e0ba-2711-9e0d-444d812c0182@roeck-us.net>
Date:   Mon, 30 Sep 2019 17:01:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924174728.201464-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/19 10:47 AM, Nick Desaulniers wrote:
> Fixes the following 2 issues in the driver:
> 1. Left shifting a signed integer is undefined behavior. Unsigned
>     integral types should be used for bitwise operations.
> 2. The delay scales from 0x0010 to 0x20000 by powers of 2, but udelay
>     will result in a linkage failure when given a constant that's greater
>     than 20000 (0x4E20). Agressive loop unrolling can fully unroll the
>     loop, resulting in later iterations overflowing the call to udelay.
> 
> 2 is fixed via splitting the loop in two, iterating the first up to the
> point where udelay would overflow, then switching to mdelay, as
> suggested in Documentation/timers/timers-howto.rst.
> 
> Reported-by: Tomasz Paweł Gajc <tpgxyz@gmail.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/678
> Debugged-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Changes V1 -> V2:
> * The first loop in send_byte() needs to break out on the same condition
>    now. Technically, the loop condition could even be removed. The diff
>    looks funny because of the duplicated logic between existing and newly
>    added for loops.
> 

That is a delay()-internal dependency, and completely undocumented. This code
will fall apart if the implementation of udelay() is ever changed. This
also depends on the architecture - in some cases, mdelay() is implemented
as udelay(n * 1000).

>   drivers/hwmon/applesmc.c | 35 +++++++++++++++++++++++++++++++----
>   1 file changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> index 183ff3d25129..c76adb504dff 100644
> --- a/drivers/hwmon/applesmc.c
> +++ b/drivers/hwmon/applesmc.c
> @@ -46,6 +46,7 @@
>   #define APPLESMC_MIN_WAIT	0x0010
>   #define APPLESMC_RETRY_WAIT	0x0100
>   #define APPLESMC_MAX_WAIT	0x20000
> +#define APPLESMC_UDELAY_MAX	20000
>   

This is not really a problem in this driver; it is a system problem.
Anyone can call udelay() with a parameter longer than 20,000 us.
We can't add code like this all over the place because the implementation
of delay() is broken.

Besides, calling delay() with a parameter of 20,000 or more is a strong
indication that something is really wrong with the code. More on that
see below.

>   #define APPLESMC_READ_CMD	0x10
>   #define APPLESMC_WRITE_CMD	0x11
> @@ -157,14 +158,23 @@ static struct workqueue_struct *applesmc_led_wq;
>   static int wait_read(void)
>   {
>   	u8 status;
> -	int us;
> -	for (us = APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<= 1) {
> +	unsigned int us;
> +
> +	for (us = APPLESMC_MIN_WAIT; us < APPLESMC_UDELAY_MAX; us <<= 1) {
>   		udelay(us);

>   		status = inb(APPLESMC_CMD_PORT);
>   		/* read: wait for smc to settle */
>   		if (status & 0x01)
>   			return 0;
>   	}
> +	/* switch to mdelay for longer sleeps */
> +	for (; us < APPLESMC_MAX_WAIT; us <<= 1) {
> +		mdelay(us);

Shouldn't that be us / 1000 ? Seems to me the above will wait for
at least 20000 ms, which is a a tiny bit long.

Also, mdelay(n) is by default implemented as udelay(n * 1000).

Also, at the very least, this should be something like

		if (us < limit)
			delay(us);
		else
			mdelay(us / 1000);

instead of introducing a second loop. But more on that below.

> +		status = inb(APPLESMC_CMD_PORT);
> +		/* read: wait for smc to settle */
> +		if (status & 0x01)
> +			return 0;
> +	}
>   
>   	pr_warn("wait_read() fail: 0x%02x\n", status);
>   	return -EIO;
> @@ -177,10 +187,10 @@ static int wait_read(void)
>   static int send_byte(u8 cmd, u16 port)
>   {
>   	u8 status;
> -	int us;
> +	unsigned int us;
>   
>   	outb(cmd, port);
> -	for (us = APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<= 1) {
> +	for (us = APPLESMC_MIN_WAIT; us < APPLESMC_UDELAY_MAX; us <<= 1) {
>   		udelay(us);
>   		status = inb(APPLESMC_CMD_PORT);
>   		/* write: wait for smc to settle */
> @@ -190,6 +200,23 @@ static int send_byte(u8 cmd, u16 port)
>   		if (status & 0x04)
>   			return 0;
>   		/* timeout: give up */
> +		if (us << 1 == APPLESMC_UDELAY_MAX)
> +			break;
> +		/* busy: long wait and resend */
> +		udelay(APPLESMC_RETRY_WAIT);
> +		outb(cmd, port);
> +	}
> +	/* switch to mdelay for longer sleeps */
> +	for (; us < APPLESMC_MAX_WAIT; us <<= 1) {
> +		mdelay(us);

Again, I fail to understand why waiting for a multiple of 20 seconds
under any circumstances would make any sense. Maybe the idea was
to divide us by 1000 before entering the second loop ?

Looking into the code, there is no need to use udelay() in the first
place. It should be possible to replace the longer waits with
usleep_range(). Something like

		if (us < some_low_value)	// eg. 0x80
			delay(us)
		else
			usleep_range(us, us * 2);

should do, and at the same time prevent the system from turning
into a space heater.

Thanks,
Guenter

> +		status = inb(APPLESMC_CMD_PORT);
> +		/* write: wait for smc to settle */
> +		if (status & 0x02)
> +			continue;
> +		/* ready: cmd accepted, return */
> +		if (status & 0x04)
> +			return 0;
> +		/* timeout: give up */
>   		if (us << 1 == APPLESMC_MAX_WAIT)
>   			break;
>   		/* busy: long wait and resend */
> 

