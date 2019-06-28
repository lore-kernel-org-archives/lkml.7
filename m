Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CDBC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 05:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFEB2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 05:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sfyw3tVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfF1FuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 01:50:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46174 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfF1FuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 01:50:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id 81so2380015pfy.13;
        Thu, 27 Jun 2019 22:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=xbpQAYAfjyjoMDDuLtpqjMT1F1sFH7826ZzTz/6Eg7M=;
        b=Sfyw3tVO4AFVG/7BVg2T241CKDlF/1Zid8ewZ3ulAjc2WpWrCgHwG4uBsS1HbKUy1g
         jkGCkwVmb3i1Q9ZPnTLxoLNQYG/zGomGe4ffKDzoTgDPO0pCxcRZG34k3mO5BqgQuqTy
         ejNmP+i1GtpLDU7k5QMoigeAWRFcRz/BoVX+5l/gk+PrAJDlu0U0OLgfds+wEZvUWAl2
         uNE4iByyv9YlZa8I1t8AkmJ8Rf95Nn8TeybSrLYzrwuoNo+qXAHkzqLSnm8860jef/Mf
         WpSKcTGnHHdaHj3DYI1KL/ylKYiYXNbYyirWZ7uzKsxD0CNyczo4YKRpCS2KS/U3fv7x
         07wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=xbpQAYAfjyjoMDDuLtpqjMT1F1sFH7826ZzTz/6Eg7M=;
        b=a52/6Ky0qvgut2HuWuy7NSIMqRlHzC643cR3Ewdli+uNWh859nMSA9xWC1ujKIAnWS
         ZMuLepDsOG4hVfilD/G+F28RKoK501pUzpfhXtBcPP+BLpvXfhPz2wgMRze9HosSELg2
         bQJKn6iWwDIjRV+zMhWP43ufJE9/oeHxt5Xism5y6fqgVPfH2j42o4OuXI75YuM1m3tS
         cyNOv3VmYW5bY+1zz2tOaxJXFkGZg3BSIASIHQKSzmjDIMi9O8OwnwEWEZZMNawmRQCu
         O0KCcS/tsUvC2YG7HncS+9dUHeMQTGlgLlQNdirGANZY5tmCAx/az5vWsWfKu1TiTGcO
         XJoA==
X-Gm-Message-State: APjAAAVTM/iFY1KzW6af5cB2z/eVua5hjXBTUo1alPS3QOIFNY+QrcjT
        iKHGU6Ocxf2dIwN7LFyi9Wg=
X-Google-Smtp-Source: APXvYqzgw/8wuWG+WuTQBp4hYNRYShg5QTTEVCWWBpWSbXf28XwMbhz39DkDwz/PRD6nsFKyvtwKbw==
X-Received: by 2002:a17:90a:2706:: with SMTP id o6mr11134402pje.62.1561701018502;
        Thu, 27 Jun 2019 22:50:18 -0700 (PDT)
Received: from PSXP216MB0662.KORP216.PROD.OUTLOOK.COM ([40.100.44.181])
        by smtp.gmail.com with ESMTPSA id o95sm902089pjb.4.2019.06.27.22.50.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 22:50:17 -0700 (PDT)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH] video: fbdev: s3c-fb: fix sparse warnings about using
 incorrect types
Thread-Topic: [PATCH] video: fbdev: s3c-fb: fix sparse warnings about using
 incorrect types
Thread-Index: ATVhYXAyfWPTBNepn2TaTOmvIy9arGI0M2NlvIaGNxM=
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Fri, 28 Jun 2019 05:50:12 +0000
Message-ID: <PSXP216MB0662D369EFFABF260394F179AAFC0@PSXP216MB0662.KORP216.PROD.OUTLOOK.COM>
References: <CGME20190627125803eucas1p1eb6a37f5fa96fd732e41ab1501367de5@eucas1p1.samsung.com>
 <908fc26e-3bfa-c204-6c32-7d814fdcb37b@samsung.com>
In-Reply-To: <908fc26e-3bfa-c204-6c32-7d814fdcb37b@samsung.com>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/19, 9:58 PM, Bartlomiej Zolnierkiewicz wrote:
>=20
> Use ->screen_buffer instead of ->screen_base to fix sparse warnings.
>
> [ Please see commit 17a7b0b4d974 ("fb.h: Provide alternate screen_base
>   pointer") for details. ]
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/video/fbdev/s3c-fb.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> Index: b/drivers/video/fbdev/s3c-fb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/video/fbdev/s3c-fb.c
> +++ b/drivers/video/fbdev/s3c-fb.c
> @@ -1105,14 +1105,14 @@ static int s3c_fb_alloc_memory(struct s3
> =20
>  	dev_dbg(sfb->dev, "want %u bytes for window\n", size);
> =20
> -	fbi->screen_base =3D dma_alloc_wc(sfb->dev, size, &map_dma, GFP_KERNEL)=
;
> -	if (!fbi->screen_base)
> +	fbi->screen_buffer =3D dma_alloc_wc(sfb->dev, size, &map_dma, GFP_KERNE=
L);
> +	if (!fbi->screen_buffer)
>  		return -ENOMEM;
> =20
>  	dev_dbg(sfb->dev, "mapped %x to %p\n",
> -		(unsigned int)map_dma, fbi->screen_base);
> +		(unsigned int)map_dma, fbi->screen_buffer);
> =20
> -	memset(fbi->screen_base, 0x0, size);
> +	memset(fbi->screen_buffer, 0x0, size);
>  	fbi->fix.smem_start =3D map_dma;
> =20
>  	return 0;
> @@ -1129,9 +1129,9 @@ static void s3c_fb_free_memory(struct s3
>  {
>  	struct fb_info *fbi =3D win->fbinfo;
> =20
> -	if (fbi->screen_base)
> +	if (fbi->screen_buffer)
>  		dma_free_wc(sfb->dev, PAGE_ALIGN(fbi->fix.smem_len),
> -		            fbi->screen_base, fbi->fix.smem_start);
> +			    fbi->screen_buffer, fbi->fix.smem_start);
>  }
> =20
>  /**
