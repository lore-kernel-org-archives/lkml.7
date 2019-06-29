Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21012C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 10:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD21D20828
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 10:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFUFXPg5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfF2KkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 06:40:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41467 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfF2KkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 06:40:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id m7so4639391pls.8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 03:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y2Mp0qROMF2T8wQmXHDuriRG6lKkCCwBXq/1jhIUsW4=;
        b=NFUFXPg5TiylMSHadNbB0wXsOI6grxm+VM4Ol82/rR2j01JvY++v3Kqg5kDKqZjB4J
         /+Ys7DVJaCiD+7slZQ1OE4tyXvVDHeIzXGLp+nkfaHGoycxmAlaxKhnrYKODQ8ZxW58L
         gWe2ojp+qu0oXIbIu8wyKIPAF4in96J72Oq6IdJ9zpeK7tsskeeYZ9xecR6QVo+ZgxBS
         pFDLSaMwydTEAoj+XdRWoVLrAkHVljlTurrNeN/GfdrHMycohNk2gAtl2RGrO4DN0d+C
         9Cef9SehFUUZ7+97QNcBe8dpFlzUPCZyiInLO0cIRy1+xvIyzHFHFuzgfol+qUVd5ijK
         rZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y2Mp0qROMF2T8wQmXHDuriRG6lKkCCwBXq/1jhIUsW4=;
        b=KPQFJQXy01KEh2GXmc4XEhp/ReIhz58AKsWgW5fkA9CHFmIgXMWh7kqeeljVnjDJbG
         VkvkiCjTyVq8nzXfVzuL6QRYb7Yg1NKRTUl/dniJGDRW4B5vHLEvMvcbL0jRkplysJdo
         MOQ1SVVKdiEtaQ0bsO+6N+W0SpXzlFsjj1E20VwnZzjc3Ilnhw/A5oUpB+p3QVEn6JVT
         4EDxD8jYtEzpbFXQBX5iAAWF+eyb+0cROQzJQ8+fcYW38LuRGtkcNFHDtVE0kfJbG8KL
         tiOp0KGUrHqEGmRjmV2UUqHJxBXas8t05Z9l1ZrDGZdmwhKJyK4egJn/otgY4UZGHAvl
         ak4Q==
X-Gm-Message-State: APjAAAXe2y7tsyp69LSGV6cYOXqVhnKpGs659qKWQH2idD0UMH07f1Wp
        09NLyG90gy7eXXGhGN3XKm0L4mbV
X-Google-Smtp-Source: APXvYqwu1wYH3M9AgEB22Hk9+l7wHMQXfW5V7Lqsl6Wy6yjjMMBaWQqVFqmuS4PcZeVECGSuTQTIRg==
X-Received: by 2002:a17:902:8689:: with SMTP id g9mr7258592plo.252.1561804814741;
        Sat, 29 Jun 2019 03:40:14 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id e11sm8224348pfm.35.2019.06.29.03.40.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 03:40:14 -0700 (PDT)
Date:   Sat, 29 Jun 2019 16:10:11 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] staging/rtl8723bs/hal: fix comparison to
 true/false is error prone
Message-ID: <20190629104011.GA15715@hari-Inspiron-1545>
References: <20190629102722.GA15300@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190629102722.GA15300@hari-Inspiron-1545>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 29, 2019 at 03:57:22PM +0530, Hariprasad Kelam wrote:

Please ignore this patch
> fix below issues reported by checkpatch
> 
> CHECK: Using comparison to false is error prone
> CHECK: Using comparison to true is error prone
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/staging/rtl8723bs/hal/odm_CfoTracking.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c b/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
> index a733046..7883b26 100644
> --- a/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
> +++ b/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
> @@ -221,7 +221,7 @@ void ODM_CfoTracking(void *pDM_VOID)
>  		pCfoTrack->CFO_ave_pre = CFO_ave;
>  
>  		/* 4 1.4 Dynamic Xtal threshold */
> -		if (pCfoTrack->bAdjust == false) {
> +		if (!pCfoTrack->bAdjust) {
>  			if (CFO_ave > CFO_TH_XTAL_HIGH || CFO_ave < (-CFO_TH_XTAL_HIGH))
>  				pCfoTrack->bAdjust = true;
>  		} else {
> -- 
> 2.7.4
> 
