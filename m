Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257F9C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA00214AE
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XNeJTWv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfFGPJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:09:43 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54746 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729042AbfFGPJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:09:42 -0400
Received: by mail-it1-f195.google.com with SMTP id m138so1585112ita.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 08:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nSNwEwVBB35crYOfAcA03OB3tW5Yj6TRGwmQgBYzS/M=;
        b=XNeJTWv5IXSPKxj4O4Mhj3ddn0md3FRvFIIWRXJE8yJDd7Ys9oWZo1L5YVOYAWERSg
         nt6UPyZCSw5l/L9g1sx0bJXO+XoJOUTcB5+fPaFnQfDzH4h0BXIekTVxh29osI+nndYh
         89KgZAmKZSRHoBH7RCHlinKsP3GvccK957wV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nSNwEwVBB35crYOfAcA03OB3tW5Yj6TRGwmQgBYzS/M=;
        b=aaYo5ZpYjh3REOXL2lXKpr6hp21sbJriTdvp97w4B8u+Y6aRZRUcuFkvDTPErNaTRA
         j1q23tOLAKLimltWBOYIZrQXT8IO4yG7T2vZc8sonEDFfL8ihujqJiLW1/Q4LXYCGypf
         IiOEuaiJZ8eSW671Y/J2ywh+r464IT4+1I2OaFtY1Fvjr9LnJFm/hSeqXCeAvjwGTuuy
         fIcJhHXODECNFuLYyCUFjFRhwxoBj5BH+1zMDcsuwmz0U+XYIccTidQZsSIuSLqECPjI
         Wfm2W4dT2S8oylCCFh60U7CVWjZfhN/HemSn1jMqmFU92JRyvcfmGfR9V87mrtlcTmUK
         60BQ==
X-Gm-Message-State: APjAAAXgrMpvVPLgLoqDI76hcBsQ80lorZ4JTIB8sD74a0eMZJC3njIJ
        8VbOBFTQXXj+74AfO19G0sgQ10DFtrs=
X-Google-Smtp-Source: APXvYqwmeT56rFD44CbnWdKgTmPP8E8Agh1cZ+s1Po7Ulh0KLoSLKZixh90UhI4tTmcSvSpPNH9XZw==
X-Received: by 2002:a24:6508:: with SMTP id u8mr5004771itb.28.1559920181626;
        Fri, 07 Jun 2019 08:09:41 -0700 (PDT)
Received: from mail-it1-f180.google.com (mail-it1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id i195sm944017ite.41.2019.06.07.08.09.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 08:09:40 -0700 (PDT)
Received: by mail-it1-f180.google.com with SMTP id i21so3209949ita.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 08:09:40 -0700 (PDT)
X-Received: by 2002:a24:b106:: with SMTP id o6mr3886319itf.97.1559920180064;
 Fri, 07 Jun 2019 08:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <lsq.1549201507.384106140@decadent.org.uk> <lsq.1549201508.623062416@decadent.org.uk>
In-Reply-To: <lsq.1549201508.623062416@decadent.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 7 Jun 2019 08:09:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U263K-OEdnDzL=4oxLHXTkqgQygYCup=jSCRGvv+vMsw@mail.gmail.com>
Message-ID: <CAD=FV=U263K-OEdnDzL=4oxLHXTkqgQygYCup=jSCRGvv+vMsw@mail.gmail.com>
Subject: Re: [PATCH 3.16 025/305] media: uvcvideo: Fix uvc_alloc_entity()
 allocation alignment
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Denis Kirjanov <kda@linux-powerpc.org>,
        Nadav Amit <namit@vmware.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Tomasz Figa <tfiga@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Feb 3, 2019 at 5:50 AM Ben Hutchings <ben@decadent.org.uk> wrote:
>
> 3.16.63-rc1 review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Nadav Amit <namit@vmware.com>
>
> commit 89dd34caf73e28018c58cd193751e41b1f8bdc56 upstream.
>
> The use of ALIGN() in uvc_alloc_entity() is incorrect, since the size of
> (entity->pads) is not a power of two. As a stop-gap, until a better
> solution is adapted, use roundup() instead.
>
> Found by a static assertion. Compile-tested only.
>
> Fixes: 4ffc2d89f38a ("uvcvideo: Register subdevices for each entity")
>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -826,7 +826,7 @@ static struct uvc_entity *uvc_alloc_enti
>         unsigned int size;
>         unsigned int i;
>
> -       extra_size = ALIGN(extra_size, sizeof(*entity->pads));
> +       extra_size = roundup(extra_size, sizeof(*entity->pads));
>         num_inputs = (type & UVC_TERM_OUTPUT) ? num_pads : num_pads - 1;
>         size = sizeof(*entity) + extra_size + sizeof(*entity->pads) * num_pads
>              + num_inputs;

Funny that this commit made its way to 3.16 but didn't make its way to
4.19 (at least checking 4.19.43).  I haven't seen any actual crashes
caused by the lack of this commit but it seems like the kind of thing
we probably want picked back to other stable kernels too.

-Doug
