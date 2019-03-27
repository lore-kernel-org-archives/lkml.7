Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101D3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07472147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9FG3qXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbfC0RcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:32:18 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41022 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbfC0RcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:32:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id y5so3629107plk.8;
        Wed, 27 Mar 2019 10:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4G2ryqjT1Rma4M3vOdY6crlxttI9MfBUyzV5fMa6fNI=;
        b=p9FG3qXXPJLr5inlIy0KkgayClRbeR0AMf+8rMGWGpRp3H+Rhv3aObBwTwxm3Mcx5/
         LUNw4WgffsQpvvRixF/M4ASdqbga77pqsMVENdbPLenu+I5IUuCguYCuW6R8WJvTnzi9
         8zd33trKHvlsq7+2CB7jdLC5nYojgmszwQCl6HQMDipoGD9vCxO0fidVhfHo3/QOoK8A
         i9D68Nm/eqbBPcHx6IR3wSTyCYQKistc+s2RMM+nCYg8qnOnj2iF4SAc7PO3iBvH/P8j
         99OCU12CYzo8H0nGKd25N661AvymUC6jDTxJsgQJzsjPBFAvXwg9vQUX3nHldCJDbxOa
         UmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4G2ryqjT1Rma4M3vOdY6crlxttI9MfBUyzV5fMa6fNI=;
        b=jubJISqNrdSIfOMyuQWAbUyhu1qvedBpz0LhI8h3I7e5JMyUx0+W98Nzd67PwtfbGp
         +cIBuuEviAUnlZkWL3i9R2h8Buonp4ZtKtAthICyFyKXjrUF4Vd99YzOUV/dnIO+3agr
         mBtvNgHQ3vCErhj+vyjA+jIYhYC1C4H9mr9nvvoew8YBAf8O0o7FjU13wLpK4Ucadsix
         smtQxCA/AMsFzoQ8SCK3lMSuKxK5a8gZEbO25TJnzjTRtD05zVZKtac6SlvZbdvipwu9
         SZDMYY+T7JNOBbb5L+S3Nk0winN6pQYjBcWtp5jZ4bWEZJhnM9fxlBclYucePrmrdeaZ
         /HtA==
X-Gm-Message-State: APjAAAUvf43D48xtXnfpnlMSyi7XlfLUBFFAnDztEIL3Rby84FLrkAOG
        qp+1uGS6j/MYq20dgMbU+exOtcYP5Sg=
X-Google-Smtp-Source: APXvYqx47NTibChC0BBjBL79NaKxky5r1qXL6vmigXMNSpgTkPuRWOaiAQN98HakG/yfmUG1B86oWg==
X-Received: by 2002:a17:902:bb05:: with SMTP id l5mr18394797pls.311.1553707937304;
        Wed, 27 Mar 2019 10:32:17 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i189sm33010649pfc.71.2019.03.27.10.32.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 10:32:16 -0700 (PDT)
Date:   Wed, 27 Mar 2019 10:32:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     peter_hong@fintek.com.tw, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V2 1/2] watchdog: f71808e_wdt: separate declaration and
 assignment
Message-ID: <20190327173214.GB9951@roeck-us.net>
References: <1553668971-18801-1-git-send-email-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553668971-18801-1-git-send-email-hpeter+linux_kernel@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 02:42:50PM +0800, Ji-Ze Hong (Peter Hong) wrote:
> Separate declaration and assignment in watchdog_start()
> 
> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Note though that it would be much more valuable if you could consider
converting the driver to use the watchdog subsystem instead of trying
to clean up the current code.

Thanks,
Guenter

> ---
>  drivers/watchdog/f71808e_wdt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
> index 9a1c761258ce..bd2ced9f39f4 100644
> --- a/drivers/watchdog/f71808e_wdt.c
> +++ b/drivers/watchdog/f71808e_wdt.c
> @@ -338,8 +338,10 @@ static int f71862fg_pin_configure(unsigned short ioaddr)
>  
>  static int watchdog_start(void)
>  {
> +	int err;
> +
>  	/* Make sure we don't die as soon as the watchdog is enabled below */
> -	int err = watchdog_keepalive();
> +	err = watchdog_keepalive();
>  	if (err)
>  		return err;
>  
> -- 
> 2.7.4
> 
