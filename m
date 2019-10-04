Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2F2C4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03E321D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guZdwt52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbfJDXDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 19:03:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38708 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDXDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 19:03:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id x10so4579582pgi.5;
        Fri, 04 Oct 2019 16:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=feQAKQjq6fBSMcPcdA6L++e/OBV7Pfg1LGJxyrh3J9E=;
        b=guZdwt5215UI3jIxOgFbzH1BlN7lau+HVadqySYi0Cc3JZ+1vzoj5cyonKFih5n/Jq
         ZIGWt7I+Gk08aJAxaNXsG4R0g4VAlmWELSg9F012///mXU+MBosq4xeSUkP9Pw/aHq8G
         Gzk2pFm3wuUD7n4LTuwFfMrM5ajP7Wb0q0GSaFXsAsDVRm6Jp/udiZcOH2VZR9BApTzO
         bhZJJWl6no3cSf8nTU40cFCUhgq2ZUghZpilfyMK8abpU88Ba18nhKkoFGXwEC1HaeQV
         yf2Z/TYYvjiDMlqetxtmRhXeaLSAuqD93cirvYuStkXZ4+gFidRuM2vdS7BSnAIXogVO
         Nmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=feQAKQjq6fBSMcPcdA6L++e/OBV7Pfg1LGJxyrh3J9E=;
        b=Uf4cSZU88T+KnobjrS9JcJln7G93pzEDLx5QazK4wMxMRP4dlBjTLX8vvoIpe0bjdo
         7bDzpkMtafaed0cembKCydi0H7PI3Zl8pOUfZ2qihVKcdkqbKfESOIounBm5FWeYJLEu
         nSrmpUwSTWfeXPKr6h0yGqzVS900K2IyAtKsy+Dyj5+hFky8QowQUKuJTqTwg1aQU0LX
         lAz6LL7abTRb/9jAfDHCnapOhSotNOPBJ3LWY4u16pxAv0QkY++nPZXPnzX8swOULEKP
         cX/rOyYX3ljgEDzAK/wvZb+rhVeweExOPOhGaJvdgMzZev/0FBuREUicxF5qPYOkDqxP
         /vLw==
X-Gm-Message-State: APjAAAWzJLfL4ldrrA7tHiz0jO1JQ0eVKz7y1/egQ4KRPIk9bby3WJLS
        HpA/GTMuOSJ6CqZW7aT/xkM=
X-Google-Smtp-Source: APXvYqw8xkaPAsKoElx5djin8+PSgaITVD4vomaOS/jXWxwYbwHWH/QvGujFPEAiKrtF45Gz2693XQ==
X-Received: by 2002:a63:1d0:: with SMTP id 199mr18191792pgb.329.1570230191075;
        Fri, 04 Oct 2019 16:03:11 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c62sm8685092pfa.92.2019.10.04.16.03.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 16:03:10 -0700 (PDT)
Date:   Fri, 4 Oct 2019 16:03:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 09/10] hwmon: (lm70) Avoid undefined reference to match
 table
Message-ID: <20191004230309.GF14687@roeck-us.net>
References: <20191004214334.149976-1-swboyd@chromium.org>
 <20191004214334.149976-10-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004214334.149976-10-swboyd@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 02:43:33PM -0700, Stephen Boyd wrote:
> We're going to remove of_match_ptr() from the definition of
> of_match_device() when CONFIG_OF=n. This way we can always be certain
> that of_match_device() acts the same when CONFIG_OF is set and when it
> isn't. Add of_match_ptr() here so that this doesn't break when that
> change is made to the of_match_device() API.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: <linux-hwmon@vger.kernel.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Please ack or pick for immediate merge so the last patch can be merged.
> 
>  drivers/hwmon/lm70.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
> index 4122e59f0bb4..57480dada955 100644
> --- a/drivers/hwmon/lm70.c
> +++ b/drivers/hwmon/lm70.c
> @@ -155,7 +155,7 @@ static int lm70_probe(struct spi_device *spi)
>  	struct lm70 *p_lm70;
>  	int chip;
>  
> -	match = of_match_device(lm70_of_ids, &spi->dev);
> +	match = of_match_device(of_match_ptr(lm70_of_ids), &spi->dev);
>  	if (match)
>  		chip = (int)(uintptr_t)match->data;
>  	else
> -- 
> Sent by a computer through tubes
> 
