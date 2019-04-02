Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5974AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE5C2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCqvLiRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfDBTFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:05:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44098 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbfDBTFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:05:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id y7so18007240wrn.11;
        Tue, 02 Apr 2019 12:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/kzSS7I44cbQHt5yfd4P6F7uSD/9/JilNPQUlfkRHO8=;
        b=OCqvLiROWIPb8cB+cxicj98qDs3wO3mpBERrFzQiV5qxk8marC84E/ZXN3pkaaIegc
         sfwysn91jYpuPr5RpfV7OfqVCTS/EoJ4MwqKFQecEUdv7OeIMvjY6wzAUlSTact9QSqW
         DHBZT+bLa5eij+JAWSvcxVDtsXAOTGixovdNgNm5LArc5E7FMghyWVCJLnlUTUW6BuZc
         0UYc1Ii79OULzNbQEzcCRH1ZbOcMaLPFMEym19ZjRH+/pmmlcSAl2YIEpTHIQ95tKwHX
         aimzuoKxwIN42soHtjQSlkjM5cacBRsbDT0htWO98Zvt3E6N9vslGkS9voCgQ58AWbBK
         3SNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/kzSS7I44cbQHt5yfd4P6F7uSD/9/JilNPQUlfkRHO8=;
        b=PQoqGZ6hOrVspukDevlKnKPn4ceIh+YwPZcrNJim511XGMEOG+GvkqrOJn7Iv1muHc
         /ZvcxCz6hZTHsEYqCmEe/9DMjyRHppniVBrZ3Q/Ltlrh16y9PJnHTXEMFbBrX3THq55R
         iGrFJVGnWi7OqnJkF6md4kpZDrbUY8KKXQTpaVRAjK0KKGy6Xz9qBzMDQ/1YFbKBWbYv
         3X4IPGp+CEf6HNvyRP9SdqXn7VtjVnFp678wRyT4bjpFJFhfgyZaY9YA0yOl6m0/rY97
         K3Ny1b+Wx8s1mSwQwkVZgZ18+xOJ4jUIVHDglmAkmZs9tGAHDo4GL/tEJiKX05aLjoun
         nSLQ==
X-Gm-Message-State: APjAAAV8l6ePv/6ebm4efTAqRhbAOIq42MDhJhgX+7YeOyuxucFqSWif
        tz7dbgJ8IVgToMIa0SvlKlSg9T+e
X-Google-Smtp-Source: APXvYqxtYqrgaHRxlyNGyo0upR3FWjvWHk2+oXVmmoqq1w/Q4GeN9hTq8X124znxw6/sQ/GBjLY7ig==
X-Received: by 2002:adf:ce8c:: with SMTP id r12mr15438976wrn.60.1554231939520;
        Tue, 02 Apr 2019 12:05:39 -0700 (PDT)
Received: from [192.168.1.19] (ckb186.neoplus.adsl.tpnet.pl. [83.31.77.186])
        by smtp.gmail.com with ESMTPSA id n189sm21402340wmb.28.2019.04.02.12.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 12:05:38 -0700 (PDT)
Subject: Re: [PATCH] leds: blinkm: clean up double assignment to
 data->i2c_addr
To:     Colin King <colin.king@canonical.com>
Cc:     Jan-Simon Moeller <jansimon.moeller@gmx.de>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190330203757.8877-1-colin.king@canonical.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <7360f559-7260-48b5-029d-e12a19bd967f@gmail.com>
Date:   Tue, 2 Apr 2019 21:05:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190330203757.8877-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

Thank you for the patch.

On 3/30/19 9:37 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently data->i2c_addr is being assigned twice, first with the
> value 0x09 and then immediately afterwards with the value 0x08.
> The first assignment is redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/leds/leds-blinkm.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/leds/leds-blinkm.c b/drivers/leds/leds-blinkm.c
> index 851c1920b63c..11b771fb933b 100644
> --- a/drivers/leds/leds-blinkm.c
> +++ b/drivers/leds/leds-blinkm.c
> @@ -594,7 +594,6 @@ static int blinkm_probe(struct i2c_client *client,
>   		goto exit;
>   	}
>   
> -	data->i2c_addr = 0x09;
>   	data->i2c_addr = 0x08;
>   	/* i2c addr  - use fake addr of 0x08 initially (real is 0x09) */
>   	data->fw_ver = 0xfe;
> 

Applied.

-- 
Best regards,
Jacek Anaszewski
