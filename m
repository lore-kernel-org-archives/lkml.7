Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685E4C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB7B2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBwFtKvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbfHNNjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:39:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33099 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfHNNjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:39:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so53603739pfq.0;
        Wed, 14 Aug 2019 06:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pEriqsQ7CQvEEvoCUgLilgpVMRHXmKM4NZ9ssbqI1u8=;
        b=iBwFtKvZ9Q7SNkpgJ55uaD8NoFW3yFTFslHTK7AC5RzcwI/2HQh/2HUnK7lN0X4Gp1
         I/fZ6a5699/WPbci9Yvf5/XDJu0eKE3A279hAovvbsfrRzXCDmqPSLt1iikVfehqSmxA
         F6APPLlwkqj731BP1W08E/b8aa92nOl8xsT/OlBKcuAojZhvxtpyzs7RsG3aRm2joXnc
         bUOVazG0hF7MQYW7zuQVadNGixMzjUYmhPcR/IvO7xprlLGEviJzCBU0sHBcrO5GwlhQ
         VLRIDqeKl2OcDXRY27iIKJNRW7vWTgLaqnPUT63TkYDlpXxN3lf3xP9BRAcNiiMPo00J
         TXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pEriqsQ7CQvEEvoCUgLilgpVMRHXmKM4NZ9ssbqI1u8=;
        b=bsSBrJXGCeU02vC/F5JJWIqluzKzcRnz5qUVUqM7hU+I3W0pln2HfvHED7tjF3X4pq
         C29fiFwRbcOP0QGIThERsxNXzY5YeJf/WJxymywTRGjC9pe6HnLah0pQqslMnWrYENo0
         H5b+fe0J0FAVvBCPtqxUoB8BaeYaG+xEDJndstOq2s0UY6plF+1Zchv7PYXOfMrrh7sL
         Jwd6P9+ZZ53FqyFZE2VlmUjHsGMv0eDJLU22ZYmB5mxkpFeiJzuupbKQreC0UBmh6Qlm
         3M83FPOJYC0M34P/FZCt7w+gTOXfCa51iBLShNTJE2wS1QxLtTn0S8TYx0TPd2RRhikU
         dyEA==
X-Gm-Message-State: APjAAAW5qH/rC10jJBipecj9UN9aElmpCZ7S+OLGbm479EzQ1HXxjoUg
        QSE++6m7+RwnGioUjA6qJg4=
X-Google-Smtp-Source: APXvYqwd4cYb6Hn+fTUOTqBOuQ3rOnxuBdLj5GdN/aMaxEctRsLNddhbrvjtpfPjobi5nALjn1Jecw==
X-Received: by 2002:a17:90a:d792:: with SMTP id z18mr7252334pju.36.1565789954050;
        Wed, 14 Aug 2019 06:39:14 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f20sm144273462pgg.56.2019.08.14.06.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 06:39:13 -0700 (PDT)
Date:   Wed, 14 Aug 2019 06:39:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     Jean Delvare <jdelvare@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] hwmon: raspberrypi: update MODULE_AUTHOR() email
 address
Message-ID: <20190814133912.GA3222@roeck-us.net>
References: <1565720249-6549-1-git-send-email-wahrenst@gmx.net>
 <1565720249-6549-2-git-send-email-wahrenst@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565720249-6549-2-git-send-email-wahrenst@gmx.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 08:17:28PM +0200, Stefan Wahren wrote:
> The email address listed in MODULE_AUTHOR() will be disabled in the
> near future. Replace it with my private one.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/raspberrypi-hwmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --
> 2.7.4
> 
> diff --git a/drivers/hwmon/raspberrypi-hwmon.c b/drivers/hwmon/raspberrypi-hwmon.c
> index efe4bb1..d3a64a3 100644
> --- a/drivers/hwmon/raspberrypi-hwmon.c
> +++ b/drivers/hwmon/raspberrypi-hwmon.c
> @@ -146,7 +146,7 @@ static struct platform_driver rpi_hwmon_driver = {
>  };
>  module_platform_driver(rpi_hwmon_driver);
> 
> -MODULE_AUTHOR("Stefan Wahren <stefan.wahren@i2se.com>");
> +MODULE_AUTHOR("Stefan Wahren <wahrenst@gmx.net>");
>  MODULE_DESCRIPTION("Raspberry Pi voltage sensor driver");
>  MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS("platform:raspberrypi-hwmon");
