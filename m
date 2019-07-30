Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C8BC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1A020693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHP2dn7k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbfG3C2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:28:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36606 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730904AbfG3C2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:28:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so29206498pgm.3;
        Mon, 29 Jul 2019 19:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fNGwib2V1mqGjrer2INZMFU62Am+9JjUwbZIzd/7DQs=;
        b=VHP2dn7kLttqlcQBbERJLzIpkJyi/GGl6JZXheY4z6ViliFFZGF1YsP70IT8YxG2Sf
         p9hvGgEjQdcGxViu1toHSIhZAr8RryAh0qZR4gjQyCpo8bLRggC0LQPLsT/3kImGj8jS
         xtqgHprYYAcr/n6tE51UU7RAY32nDxwwdhMthHUvio/MUljMmBBcPFGv4yrpNnmGISS2
         9mxWqvIuxmlr5HuqQGzgdpkbMpLAL1QJ/+mdnno+Buf/KcBqIEB9EoYtjmyK/k0T31ZG
         vOs3jV/GKWdxpKYM3cMafKtF6kIWNxBgOocL0zRrKz2P7W12XXcOzm8Ori5hNO/UQeuo
         UrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fNGwib2V1mqGjrer2INZMFU62Am+9JjUwbZIzd/7DQs=;
        b=fZc2QSejNL+TmXx447Kg+BiHZ+kwI2jW0Qn3jIHpCGWwQStZgd5ERSh7//iJu7dakX
         1SIqvH1CmpQwAbepA/P0LcNj2G7VwyBMBb2prc+0gkJMCIVv77wsYzTa5/NopmC4PHEF
         2uAq0mOkN/BdLP5e0+iEJPlHrTaJOY1Tf/Q0HrHarsUZqO+Hdnmv1ayB16D5emiU3s07
         J5DNjPyAIfFZcMyW42kVBGJtQIeWhRa2lXtkRPIw0KlG/BZaQ8+LLDXLTcLf4H1oIERW
         xMXNls4pTbN8Wx+bLqZnD1GXUionkwoG3qz3weY8gtqIGMJyLB9NK0z1KpSIEWZYWRWp
         QPeQ==
X-Gm-Message-State: APjAAAUvUV5NSv4QBaKs46BAAPGwchXPIBxslQqyAjjtluBaxwNb6mrS
        QEM/Oxr4OkB6yxCy8mC6ohU=
X-Google-Smtp-Source: APXvYqzeiAYdhr/rw1pXY7OYt51obI4XjCJd8Go2H7K0GEaVOTuuC77QX0O0du1/EGcgt4hPupgKcg==
X-Received: by 2002:a62:8f91:: with SMTP id n139mr40422399pfd.48.1564453696557;
        Mon, 29 Jul 2019 19:28:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c70sm8609400pfb.36.2019.07.29.19.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 19:28:15 -0700 (PDT)
Subject: Re: [PATCH 4/4] watchdog device drivers:pc87413_wdt: Continuing
 revision of conversion of pc87413_wdt to use common watchdog interface,
 removed undeclared identifiers
To:     Mark Balantzyan <mbalant3@gmail.com>
Cc:     wim@linux-watchdog.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, andrianov@ispras.ru
References: <20190730021540.66579-1-mbalant3@gmail.com>
 <20190730021540.66579-4-mbalant3@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8a47df2f-834f-19d6-c316-0e02c6666e73@roeck-us.net>
Date:   Mon, 29 Jul 2019 19:28:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730021540.66579-4-mbalant3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/19 7:15 PM, Mark Balantzyan wrote:
> There is a potential for the variable swc_base_addr in the call chain of the
> driver initialization function (init) to be used before initialization. This
> brought up the need for, by rewriting the driver to use the common watchdog
> interface, ensuring to have all resources in place. This patch addresses this
> need by rewriting into common watchdog interface utilization for the driver.
> 
> Signed-off-by: Mark Balantzyan <mbalant3@gmail.com>
> 
> ---
>   drivers/watchdog/pc87413_wdt.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/watchdog/pc87413_wdt.c b/drivers/watchdog/pc87413_wdt.c
> index bc6c4e19..6863145a 100644
> --- a/drivers/watchdog/pc87413_wdt.c
> +++ b/drivers/watchdog/pc87413_wdt.c
> @@ -370,7 +370,6 @@ reboot_unreg:
>   static void __exit pc87413_exit(void)
>   {
>   	watchdog_unregister_device(&pc87413wdt_wdd);
> -	unregister_reboot_notifier(&pc87413_notifier);

This needs to be in patch 2.

>   	release_region(swc_base_addr, 0x20);
>   
>   	pr_info("watchdog component driver removed\n");
> 

