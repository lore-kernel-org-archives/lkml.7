Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D60C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF786206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYVSFu6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732579AbfG3PtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:49:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40627 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728874AbfG3PtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:49:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so30048377pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 08:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=43Zzz7LDd7UVoaQey8hQ90fg18MtS6aSB7Sxnrox+yo=;
        b=XYVSFu6II2aBDHgCkklPATMigNKxVdX5hsABv9qco4xcXRUO5H1NfhNMqScJ2S3vOV
         rDN3+QjWKTzv+sLY6CKLUCwOhn4T27//DHgfh4jwubFLko0w8AhUllRAzf6eBiPbOLik
         0OO8Tdlev9i60cz12tGqeKdWhqiCR4pec7uqoWRg89UFy/LuaJ6Pw6w65mIn8XpJ3GXg
         oAOMNJN8FkZUt9r/2hbckySe8tEwJxozKR2R8RT/TVNlPUjUFZO6z0dg2tB/H4N0X/WU
         uNPbYRP5LlevI1hWa/75T18uRIG+jSI9KDe9tsAlVs+lAwXizR2aB7hxII58zhRuKZfe
         x1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=43Zzz7LDd7UVoaQey8hQ90fg18MtS6aSB7Sxnrox+yo=;
        b=bEF8sg5myleXoS5CPkynZojgQFaIaji8ZhKuM81YQWxWifX1nOibqFGxQ1ZwnGEi8l
         +Z/16I4xgmUeVBNctzXdXmC/+ZSQbvb8ax7X/ABtcC4cP8CWb2XQHjgIc4+zA8eE90hQ
         9DoelO4K8Qh8srbplcEQ97BX7tXdIGVOrbRliJs3ZVVfNA6cu0TIoc9muSahK3Lm1lVe
         f3BMLJ/LcCKxIYNggbabHxZuoQqEgHnsL/Welo077hYjFczERWBs9DckvBvdAhcnV1N4
         LQLmX1eJcitMUkfCd86o0bHgf1pDsC2TjN6JtKC81RQHoaBTU43ayUyb3WNbWZnbvnAJ
         hLkQ==
X-Gm-Message-State: APjAAAUzC+j8TQAhaDDAdf8Jy/u9QcHqDidSNzWkrFobgZ+UBQd7la+9
        V504M2/FeQSubCfbN/2khZn1ccEx
X-Google-Smtp-Source: APXvYqxNBAFY8CKbzGQKaZUyBaeqeFmtEyI64K+kkg8zg2UN3DZaSo1UW5eHEZs7+nYcHqr/c2wOpA==
X-Received: by 2002:aa7:81d4:: with SMTP id c20mr42810553pfn.235.1564501748648;
        Tue, 30 Jul 2019 08:49:08 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p187sm103274235pfg.89.2019.07.30.08.49.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 08:49:07 -0700 (PDT)
Date:   Tue, 30 Jul 2019 08:49:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     uclinux-h8-devel@lists.sourceforge.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] h8300: Add missing symbol "BOOT_LINK_OFFSET"
Message-ID: <20190730154906.GA18870@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 10:55:00PM +0900, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  arch/h8300/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
> index ecfc4b4b6373..6974513b1ae9 100644
> --- a/arch/h8300/Kconfig
> +++ b/arch/h8300/Kconfig
> @@ -45,4 +45,7 @@ config NR_CPUS
>  	int
>  	default 1
>  
> +config BOOT_LINK_OFFSET
> +	hex	"zImage link offset"
> +

"hex" requires a default value. The above declaration generates
"CONFIG_BOOT_LINK_OFFSET=" in the configuration file, which is invalid
and can not be fixed with "make ARCH=h8300 olddefconfig". This in turn
results in "make" requesting a value when it encounters the symbol,
meaning that automated builds of h8300 images are no longer possible,
at least not without workarounds.

Guenter
