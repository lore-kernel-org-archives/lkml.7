Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166F1C282DC
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 19:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90BD213F2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 19:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKlsue1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfDFTc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 15:32:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37035 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfDFTc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 15:32:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id 8so5178141pfr.4;
        Sat, 06 Apr 2019 12:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2yaoJk61R7nWrPh3m3NjtylxYG5Sac+8txmfA7y56eM=;
        b=YKlsue1OlLw7uka+HoxtLktjQ0vuBewmbrTxbqlBK+yHwVKxtJ2Webs6kEmOqEbvLq
         eG8JNdjz77PzKvDU7udDYQH9BwrI9jrrTXYmUX9LEcD9Oc31l2/Ih4W9OAs23HSYrv5p
         UzzOjyWKKzOOalwIviSbTZm8dYtf0Kbs1bmEbea2SLClat456UHMd19rerHMDHtYvE51
         8DnTutiEmV4eCNs9BsGoS5R7QbLOsQT/Wl/CsN7E3mkdwiVlYu4XI/AFlN/txcC9e/su
         KfHrRusQ+T/jZBCnnuauHedfhhn6RrM6U3kChhjod5eGnlCVneLVqqqU1oExOCeGfAAE
         OIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2yaoJk61R7nWrPh3m3NjtylxYG5Sac+8txmfA7y56eM=;
        b=Oi3pWu8ElOQDomh5TA63K+hrwMMNZ1fHx/QypHAVsS0TqT9+9w5C+t8sPtzzjNbsx+
         9wrsZFy1IdXfUqi0uzT9MPDEZk8l7eB1aQR3mrmi936oTgzaUBAwmI9+lgr1Q7jmIcHd
         MQVqbLCto9FezDrYoyHX4hmT1/3kzxoegOxWRB9Uac1dNMJhMHCOeyq6codKCrGKji4K
         2OjXuAxohQOGw1ewFKBFqHelfbUU9yMjhIb28gCDWgExeC1OLnU85o/eYzZ+JatwG+Fz
         jlu0iaAy4u8ragyIiiY1WzI8gkrk47STbqz3A1t0wB+abg1YcToLhrdleU+q9ESGKUto
         ok0A==
X-Gm-Message-State: APjAAAVoSb6YtRU1AeNq138RLQcUChxuafCrBHCnkmyl7wi4RajfaV51
        wpaQ3pYX91oWHNlVjuTSnIpkq8e8
X-Google-Smtp-Source: APXvYqy1pdq20b3jBKj/Fu0VLZObYVCGr3d+2LjrIUXS0QLY0rkSH+G5aIxB+4qaJDfvPItZV7vY2w==
X-Received: by 2002:a63:29c8:: with SMTP id p191mr19468394pgp.197.1554579176130;
        Sat, 06 Apr 2019 12:32:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s19sm36399808pfe.74.2019.04.06.12.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 12:32:55 -0700 (PDT)
Subject: Re: [PATCH] watchdog: machzwd : fix warning Using plain integer as
 NULL pointer
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190406131415.GA3844@hari-Inspiron-1545>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <3d381fb9-4721-d2a9-9829-56697afd727c@roeck-us.net>
Date:   Sat, 6 Apr 2019 12:32:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190406131415.GA3844@hari-Inspiron-1545>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/19 6:14 AM, Hariprasad Kelam wrote:
> Changes passing function argument 0 to NULL to avoid below sparse
> warning
> 
>   CHECK   drivers/watchdog//machzwd.c
> drivers/watchdog//machzwd.c:321:25: warning: Using plain integer as NULL
> pointer
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>

[reluctantly]

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

If anyone is still using the HW supported by this driver, it would
be a prime target for conversion to use the watchdog subsystem.
This would reduce code size and improve driver stability.
_That_ would be useful.

The only reason for replacing 0 with NULL is to make a static checker
happy. This kind of change adds zero value to the code. Instead, it
takes time from those who have to review the patches and apply them.

If we ignore such patches, we'll get them again and again, taking
away even more time. If we don't ignore them, we encourage submitters
and get even more useless patches. If we try to discourage them, we
risk being accused of being unfriendly. This is a perfect lose-lose
situation for maintainers.

Guenter

> ---
>   drivers/watchdog/machzwd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/machzwd.c b/drivers/watchdog/machzwd.c
> index 88d823d..c3926d0 100644
> --- a/drivers/watchdog/machzwd.c
> +++ b/drivers/watchdog/machzwd.c
> @@ -318,7 +318,7 @@ static long zf_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>   	case WDIOC_GETBOOTSTATUS:
>   		return put_user(0, p);
>   	case WDIOC_KEEPALIVE:
> -		zf_ping(0);
> +		zf_ping(NULL);
>   		break;
>   	default:
>   		return -ENOTTY;
> 

