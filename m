Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1182C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74044206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7cGgUSM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388310AbfDRI7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:59:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53577 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfDRI7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:59:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id q16so1861299wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 01:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=0+uwiO9oDMAwW0TrDMTH4kPAtFdyBROEpZB5N5iY8VU=;
        b=U7cGgUSMg2MGhAzr6mbqg/I/15tEldHPk/a9Igk8Zv2wKPSbz0j1aOUUgEFUsNdvci
         uPQdeiQTD7GXYmAUJYpsIDejhaJrI7RTdivmz/JXjOAUWBBIP5EsP7dAOqtiYVvmG06t
         RFDwt1RsjU0jaruqPGzoORf5DMr/nppvfSlwNheltUPTKMxfSJIKHgHuP1liJSytUz7L
         Lus3hJuedw+CvB1nQj7WkzRKPLWbgZ37rDVClDtAfXhsaM63+dJ38DobBAJ4DaA7rKq/
         IkSYmS7OWHchRdZS0KdGuTzv9KxLUSZGAqim5HtOgegeU6wJp2xYZUmKERTAEulmUSSx
         RrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=0+uwiO9oDMAwW0TrDMTH4kPAtFdyBROEpZB5N5iY8VU=;
        b=FLAGoKoGN1A/Sb7ksQqq0ZQQg6cx+ING4XZiEZbxQuSpfnysJggKz86qTS9jv/TBcq
         QhkRsVg0ZmbIprMQPR/AY9sVvFrUmiOXoLCvOm1xZXk8th7pTQZPiDAGxdB/Oxh4htZA
         T7ZZ8elz7fhJFRY9xch0qt2UNGp5f91YRD9i5QOXbPSRJaE8dHjI8ohGoJfT5USuuq8n
         3sBgGe1K2IX7GH0aO4cF8tMJNi/K+AUh2z42OFtVq6hdKaFstUI7wydS8d6pALCHJNES
         16m5OoDpycU3GNokDfH+6mcrnlCDElKKYZ+0I9w3rkn2xcD4ZC104FRF4rYS3OHTA7jQ
         HETw==
X-Gm-Message-State: APjAAAWXK4bvOuOt7mUdV93HUN8pmOGlNOwiceSXILv3W0sDtwo0of+c
        niZ8w+IcupJCnRzhqg1adD+ECVH3
X-Google-Smtp-Source: APXvYqx5F6mrq/QrKGOWAGUSamN1YKmoShUflmvL9MEpAD5bjIWmu0fRbVDN37CKlwEfGkiaFvxpbg==
X-Received: by 2002:a1c:9c03:: with SMTP id f3mr2249579wme.67.1555577958855;
        Thu, 18 Apr 2019 01:59:18 -0700 (PDT)
Received: from arch-late (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id h84sm1283228wmf.15.2019.04.18.01.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 01:59:18 -0700 (PDT)
References: <20190417184440.GA6025@embeddedor>
User-agent: mu4e 1.0; emacs 27.0.50
From:   Rui Miguel Silva <rmfrfs@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: greybus: power_supply: use struct_size() helper
In-reply-to: <20190417184440.GA6025@embeddedor>
Date:   Thu, 18 Apr 2019 09:59:17 +0100
Message-ID: <m3zhonpu3e.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oi Gustavo,
Thanks for the patch, and the rebasing.

On Wed 17 Apr 2019 at 19:44, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded 
> version
> in order to avoid any potential type mistakes, in particular in 
> the
> context in which this code is being used.
>
> So, replace code of the following form:
>
> sizeof(*resp) + props_count * sizeof(struct 
> gb_power_supply_props_desc)
>
> with:
>
> struct_size(resp, props, props_count)
>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Rui Miguel Silva <rmfrfs@gmail.com>

---
Cheers,
	Rui


> ---
> Changes in v2:
>  - Rebase on top of 47830c1127ef ("staging: greybus: 
>  power_supply: fix prop-descriptor request size")
>
>  drivers/staging/greybus/power_supply.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/greybus/power_supply.c 
> b/drivers/staging/greybus/power_supply.c
> index ae5c0285a942..34b40a409ea3 100644
> --- a/drivers/staging/greybus/power_supply.c
> +++ b/drivers/staging/greybus/power_supply.c
> @@ -520,8 +520,8 @@ static int 
> gb_power_supply_prop_descriptors_get(struct gb_power_supply 
> *gbpsy)
>  
>  	op = gb_operation_create(connection,
>  				 GB_POWER_SUPPLY_TYPE_GET_PROP_DESCRIPTORS,
> -				 sizeof(*req), sizeof(*resp) + 
> props_count *
> -				 sizeof(struct 
> gb_power_supply_props_desc),
> +				 sizeof(*req),
> +				 struct_size(resp, props, 
> props_count),
>  				 GFP_KERNEL);
>  	if (!op)
>  		return -ENOMEM;

