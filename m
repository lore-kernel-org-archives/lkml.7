Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B67C4320D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 18:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54915214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 18:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4DyYPgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437020AbfIXSie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 14:38:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35689 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393530AbfIXSid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 14:38:33 -0400
Received: by mail-wm1-f67.google.com with SMTP id y21so1191375wmi.0;
        Tue, 24 Sep 2019 11:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HLu8vpceEOnJOAJQ9RhyxlImOiyyYOYIlhMAs4JJqtQ=;
        b=D4DyYPgIXlLR78EJzyTMKJWMvh/8cZGadQzaqEpu/ymTwTdShC54XZ6dFuUUmx6yBd
         Nhjrmo+Y0+XhshV8KGiv1CiM6jdJvROE0n6pk5yXAkS3qU2HXkobJXBUhajSWcuj5eeW
         WohcPbDEQR63F9V0V32YHEdJ2xCqvYdNIbeTOuYTDbCTkWJWdg8vwisLqCleTfkvQb/w
         Ki2QN3ksOtOXuTlw3HhvK860OwuH0Gzltg8dQdzjmZOuzeAd8Iw/gZGpDm6N2dUb4vQH
         n1cIr/smWLMtoEwk8ZPJS9usksUk4AeTCykPQIfJIAmZmB7qGtkXYbC+XPubDKBGs0EV
         2EbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HLu8vpceEOnJOAJQ9RhyxlImOiyyYOYIlhMAs4JJqtQ=;
        b=WG2eNI+5/McC5UwN5b8fYGWp/1Zy9BOuv0QxamdW6xanwKNmf1eJoiV4iYll13WZc5
         +DxZvjiXnycdggL3Yi+BNnCLuhdKTw/klKwg4Lx2eGKGxvUANRFnuhzYS12LUyAG0uT7
         e3PeRZ/PgH5ib7yeJ82QpjpM/Ec2JgVkldXAvINd0brB16sQi8GXhQEho9bpkOlG29ZH
         dEjFJxO/zHNPPkdbQ73uj3D2dxdC07uYTHwvNrlAuo1UXa4UaV3SKP4iRfAfaZto7SeN
         ynYrUB9tsjaG2YkiTOSJOaw6OHOazP62joIgNXe98/9i3uT5niFkqt7oW2xcbqMPnKdx
         EL1g==
X-Gm-Message-State: APjAAAXGUzB43xmhkcRR4+2k1Wza+YEteo7of1jHCYfQGoPqlkU/Fnur
        6U3fZ7kpUN6y6iSEJxyqNiE=
X-Google-Smtp-Source: APXvYqwPzbuzlTP4DukYnRQ5GsgSR/f37A8g7hI5SoRwhSXOO4KM8fVj+qXsf6rOms4hDdqx7HKbdA==
X-Received: by 2002:a7b:c451:: with SMTP id l17mr1534682wmi.61.1569350310368;
        Tue, 24 Sep 2019 11:38:30 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id a6sm3404899wrr.85.2019.09.24.11.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 11:38:29 -0700 (PDT)
Date:   Tue, 24 Sep 2019 11:38:27 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux@roeck-us.net, clang-built-linux@googlegroups.com,
        jdelvare@suse.com,
        Tomasz =?utf-8?B?UGF3ZcWC?= Gajc <tpgxyz@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (applesmc) fix UB and udelay overflow
Message-ID: <20190924183827.GA2800937@archlinux-threadripper>
References: <CAKwvOd=GVdHhsdHOMpuhEKkWMssW37keqX5c59+6fiEgLs+Q1g@mail.gmail.com>
 <20190924174728.201464-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190924174728.201464-1-ndesaulniers@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 10:47:28AM -0700, Nick Desaulniers wrote:
> Fixes the following 2 issues in the driver:
> 1. Left shifting a signed integer is undefined behavior. Unsigned
>    integral types should be used for bitwise operations.
> 2. The delay scales from 0x0010 to 0x20000 by powers of 2, but udelay
>    will result in a linkage failure when given a constant that's greater
>    than 20000 (0x4E20). Agressive loop unrolling can fully unroll the
>    loop, resulting in later iterations overflowing the call to udelay.
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
>   now. Technically, the loop condition could even be removed. The diff
>   looks funny because of the duplicated logic between existing and newly
>   added for loops.
> 
>  drivers/hwmon/applesmc.c | 35 +++++++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> index 183ff3d25129..c76adb504dff 100644
> --- a/drivers/hwmon/applesmc.c
> +++ b/drivers/hwmon/applesmc.c
> @@ -46,6 +46,7 @@
>  #define APPLESMC_MIN_WAIT	0x0010
>  #define APPLESMC_RETRY_WAIT	0x0100
>  #define APPLESMC_MAX_WAIT	0x20000
> +#define APPLESMC_UDELAY_MAX	20000
>  
>  #define APPLESMC_READ_CMD	0x10
>  #define APPLESMC_WRITE_CMD	0x11
> @@ -157,14 +158,23 @@ static struct workqueue_struct *applesmc_led_wq;
>  static int wait_read(void)
>  {
>  	u8 status;
> -	int us;
> -	for (us = APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<= 1) {
> +	unsigned int us;
> +
> +	for (us = APPLESMC_MIN_WAIT; us < APPLESMC_UDELAY_MAX; us <<= 1) {
>  		udelay(us);
>  		status = inb(APPLESMC_CMD_PORT);
>  		/* read: wait for smc to settle */
>  		if (status & 0x01)
>  			return 0;
>  	}
> +	/* switch to mdelay for longer sleeps */
> +	for (; us < APPLESMC_MAX_WAIT; us <<= 1) {
> +		mdelay(us);
> +		status = inb(APPLESMC_CMD_PORT);
> +		/* read: wait for smc to settle */
> +		if (status & 0x01)
> +			return 0;
> +	}
>  
>  	pr_warn("wait_read() fail: 0x%02x\n", status);
>  	return -EIO;
> @@ -177,10 +187,10 @@ static int wait_read(void)
>  static int send_byte(u8 cmd, u16 port)
>  {
>  	u8 status;
> -	int us;
> +	unsigned int us;
>  
>  	outb(cmd, port);
> -	for (us = APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<= 1) {
> +	for (us = APPLESMC_MIN_WAIT; us < APPLESMC_UDELAY_MAX; us <<= 1) {
>  		udelay(us);
>  		status = inb(APPLESMC_CMD_PORT);
>  		/* write: wait for smc to settle */
> @@ -190,6 +200,23 @@ static int send_byte(u8 cmd, u16 port)
>  		if (status & 0x04)
>  			return 0;
>  		/* timeout: give up */
> +		if (us << 1 == APPLESMC_UDELAY_MAX)
> +			break;
> +		/* busy: long wait and resend */
> +		udelay(APPLESMC_RETRY_WAIT);
> +		outb(cmd, port);
> +	}
> +	/* switch to mdelay for longer sleeps */
> +	for (; us < APPLESMC_MAX_WAIT; us <<= 1) {
> +		mdelay(us);
> +		status = inb(APPLESMC_CMD_PORT);
> +		/* write: wait for smc to settle */
> +		if (status & 0x02)
> +			continue;
> +		/* ready: cmd accepted, return */
> +		if (status & 0x04)
> +			return 0;
> +		/* timeout: give up */
>  		if (us << 1 == APPLESMC_MAX_WAIT)
>  			break;
>  		/* busy: long wait and resend */
> -- 
> 2.23.0.351.gc4317032e6-goog
> 

This resolves the __bad_udelay appearance at -O3 for me. I am not
familiar enough with this code to give a reviewed by though!

Also, for some odd reason, I couldn't apply your patch with 'git apply':

% curl -LSs https://lore.kernel.org/lkml/20190924174728.201464-1-ndesaulniers@google.com/raw | git apply
error: corrupt patch at line 117

It looks like some of the '=' got changed into =3D and some spaces got
changed into =20. Weird encoding glitch?

Cheers,
Nathan
