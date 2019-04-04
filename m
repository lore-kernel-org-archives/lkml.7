Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EC5C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D857420882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsKYpVAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfDDHJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:09:58 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34692 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfDDHJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:09:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id b3so901992pfd.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 00:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=Ep7yAE9Tz9TS8d850uoLwOoDVwwt26dOm09Cl0KgWaU=;
        b=AsKYpVAjoweulSDpTqqaipCTpLIy0bz+T5Ud18MQveFv1tE93SUHCe4Uw5oP0zmAwP
         zQsT+8BPbBEukHeXxc0RSGRDFnHCpKmtg6RcOp9d/khYVpmEJHtlol+AEk+webemoNw6
         HOJIbeKz+/JPYM89uMi4hh1G5moBjjZprl/rp55j8eSi7T7XhrjqQ6nz1Nykj9UACXBU
         IG0hWXbhehdv/XDZGzGbRSqQoWEVJw1k1YW7oQfBAO6530XAgjy0VxCux2Q7R5Wr44U0
         I58koRaV3ifuHnBGwg7yS4Cz5Da4IolJi8eWGl/bFnHUeWM8Jx72YPKHS+AHm2H/Uucs
         qfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=Ep7yAE9Tz9TS8d850uoLwOoDVwwt26dOm09Cl0KgWaU=;
        b=fYz4qZrK8o1poZt0rfAdNZjx2wz7DMQPHu02pI2ck0ol8TkhZhGQfertdyLeZTNYqN
         6LaODMtnyH/uH2KFrN6vGsHkNPjod9NnWNy1nkNrGq/rzI6Duk3CVid3PW74pNLQhVQ7
         e52dSoIXrCvzbZ1ov1oik+TRcf+NMWJoshancGziNvGA5Ckt4GFVuEpfj0KTmLL7Fkzt
         z/wAtWkWGx3UqQVXyplWGRC/Mw9A0S3530lM/GTvYKRsTQY3TrhvTbwbYTOatAqb+kTl
         NoUyin1pgKWzI1nHGPRKcB2qxdVjoN2x6z4G8VyLXPVdyPNpv0YEDO8DNd1VzAEgUTK7
         /bSQ==
X-Gm-Message-State: APjAAAUImYPMAF+BfxB3AF07d/Yb3/wrQdMIJJwO/egtWfK5urj5SA2B
        4+dguEWgjqfMRQ2k7BhjMk7H7OgE
X-Google-Smtp-Source: APXvYqz+sPiODb5NzjUOdfC2RQRqAyUixsG8w4JhGUMC1qay2WlNcILrl59RbCiGO3HTAxuqmmDabQ==
X-Received: by 2002:a63:7943:: with SMTP id u64mr4199908pgc.91.1554361796950;
        Thu, 04 Apr 2019 00:09:56 -0700 (PDT)
Received: from arch-late ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id p26sm37472908pfa.49.2019.04.04.00.09.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 00:09:56 -0700 (PDT)
References: <20190403205801.GA19762@embeddedor>
User-agent: mu4e 1.0; emacs 27.0.50
From:   Rui Miguel Silva <rmfrfs@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: power_supply: Use struct_size() helper
In-reply-to: <20190403205801.GA19762@embeddedor>
Date:   Thu, 04 Apr 2019 08:09:51 +0100
Message-ID: <m37ecap7pc.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,
Thanks a lot for the patch.

On Wed 03 Apr 2019 at 21:58, Gustavo A. R. Silva wrote:
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

What are the odds of 2 people changing same code in greybus in
the same day :).

But it happened, so as Johan asked please rebase on top of his
patch. that would be great.

---
Cheers,
	Rui

> ---
>  drivers/staging/greybus/power_supply.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/greybus/power_supply.c 
> b/drivers/staging/greybus/power_supply.c
> index 0529e5628c24..40cc2d462ba0 100644
> --- a/drivers/staging/greybus/power_supply.c
> +++ b/drivers/staging/greybus/power_supply.c
> @@ -520,8 +520,8 @@ static int 
> gb_power_supply_prop_descriptors_get(struct gb_power_supply 
> *gbpsy)
>  
>  	op = gb_operation_create(connection,
>  				 GB_POWER_SUPPLY_TYPE_GET_PROP_DESCRIPTORS,
> -				 sizeof(req), sizeof(*resp) + 
> props_count *
> -				 sizeof(struct 
> gb_power_supply_props_desc),
> +				 sizeof(req),
> +				 struct_size(resp, props, 
> props_count),
>  				 GFP_KERNEL);
>  	if (!op)
>  		return -ENOMEM;

