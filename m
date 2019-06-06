Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD83C28EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9506720684
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vDshi1l7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfFFNJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 09:09:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33647 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFFNJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:09:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id x15so1506424pfq.0;
        Thu, 06 Jun 2019 06:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B4ic1BbBQecFrj1MGh2BMBg9JVQjeKWbUL+bnD0lSKE=;
        b=vDshi1l7yqtgR6iUbKk1XeJSbh6Tj8W17eEmP48DEUTD3MoW/nEDkAtvoi2RyqRzcD
         3rdUGAwdHSVc1lQ3/CjkJV45v/vJVqn8jAG4pjYXN/xCQWYsV1iMJUylJpCkXvwLePoY
         G42350mxOQ1jFxD9/XRo6ObFmnwljOCtN6XC0w6pgl5V+eo1cYs6Bjhwl2OXMma7h0qT
         Xtr3XMTmp8wy35ruc6Ah8OSsDkvapm9pzoNeD1snwq4Q4TWKNmVO+hRdZAbTl0ccFFN4
         nzj3bOn+wqbSd/nWHMH5FaOam0HUliCC1065TJl3ymizwVXKzSiTJnjDCujcopzVwl8c
         AJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=B4ic1BbBQecFrj1MGh2BMBg9JVQjeKWbUL+bnD0lSKE=;
        b=n4EJQcJZu42xfEY/nV4T+QH/bjXqd0/2KRcALuCIBHFDnBmB+ik9TAkUD008uNiuHT
         awQvoaoxPqQXfTwz9UCegTh4KlzANANFYp18VDURe6FZ0o7SOHTogZLVXaWCD4q9sZL5
         h4gLd7BvU15l8JjoxX7adgo9Sa0uU+FYoLAJzVWZHlNwzpQykcq180+GHBHb6LkB8dM6
         VaKrNGCEwmLyp6WT5qsg0tS6eHmjd8JZ5iai/SEwWkchWqUZ+8xMORm4+CCZ+MI6LWE3
         UXwjS3ntNjSMR5hEoa/1ZVaqrdtFYkcWJ+1pGDwdnfOvh+hfN07P8psKoCDwh1b+SiDI
         BIFQ==
X-Gm-Message-State: APjAAAU9O9P7wJUxWlsly8e2qa+5xPo2aknc0iyVDgDDR2Y9FltVX7Xq
        ijU+tqJyb/TYe4ZLAUrfN2M=
X-Google-Smtp-Source: APXvYqxh27brZ/hWsLblzuGkhIK9bUXMf1VqsxhyNb8ZBO05seyPGw5FDdvc7XpVyQ9OzvD3tpeqYg==
X-Received: by 2002:aa7:8f24:: with SMTP id y4mr10697096pfr.36.1559826596691;
        Thu, 06 Jun 2019 06:09:56 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i3sm1996120pfa.175.2019.06.06.06.09.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 06:09:56 -0700 (PDT)
Date:   Thu, 6 Jun 2019 06:09:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (smsc47m1) fix (suspicious) outside array
 bounds warnings
Message-ID: <20190606130954.GA10669@roeck-us.net>
References: <20190606085242.31347-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606085242.31347-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 05:52:42PM +0900, Masahiro Yamada wrote:
> Kbuild test robot reports outside array bounds warnings.
> 
> This is reproducible for ARCH=sh allmodconfig with the kernel.org
> toolchains available at:
> 
> https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.1.0/x86_64-gcc-8.1.0-nolibc-sh4-linux.tar.xz
> 
>   CC [M]  drivers/hwmon/smsc47m1.o
> drivers/hwmon/smsc47m1.c: In function 'fan_div_store':
> drivers/hwmon/smsc47m1.c:370:49: warning: array subscript [0, 2] is outside array bounds of 'u8[3]' {aka 'unsigned char[3]'} [-Warray-bounds]
>   tmp = 192 - (old_div * (192 - data->fan_preload[nr])
>                                 ~~~~~~~~~~~~~~~~~^~~~
> drivers/hwmon/smsc47m1.c:372:19: warning: array subscript [0, 2] is outside array bounds of 'u8[3]' {aka 'unsigned char[3]'} [-Warray-bounds]
>   data->fan_preload[nr] = clamp_val(tmp, 0, 191);
>   ~~~~~~~~~~~~~~~~~^~~~
> drivers/hwmon/smsc47m1.c:373:53: warning: array subscript [0, 2] is outside array bounds of 'const u8[3]' {aka 'const unsigned char[3]'} [-Warray-bounds]
>   smsc47m1_write_value(data, SMSC47M1_REG_FAN_PRELOAD[nr],
>                              ~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> 
> Looking at the code, I believe these are false positives.
> 
> While it is ridiculous to patch our driver to make the insane
> compiler happy, clarifying the unreachable path will be helpful
> not only for compilers but also for humans.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied.

Thanks,
Guenter

> ---
> 
> Changes in v2:
>  - Use unreachable() instead of WARN_ON()
>  - Mention that the report seems suspicious
> 
>  drivers/hwmon/smsc47m1.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
> index cc6aca6e436c..6d366c9cb906 100644
> --- a/drivers/hwmon/smsc47m1.c
> +++ b/drivers/hwmon/smsc47m1.c
> @@ -351,6 +351,8 @@ static ssize_t fan_div_store(struct device *dev,
>  		tmp |= data->fan_div[2] << 4;
>  		smsc47m1_write_value(data, SMSC47M2_REG_FANDIV3, tmp);
>  		break;
> +	default:
> +		unreachable();
>  	}
>  
>  	/* Preserve fan min */
