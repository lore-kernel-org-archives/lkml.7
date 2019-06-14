Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AB3C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2043C20665
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CHPvPl+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfFNKSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 06:18:25 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33857 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbfFNKSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:18:24 -0400
Received: by mail-ot1-f66.google.com with SMTP id n5so2163385otk.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 03:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BluMzkCDQwyvUXl6lzhoZtoPJHAVNPhcRWOIM0TWe5A=;
        b=CHPvPl+jUh7JA/rRQipbNvx2eeCXj4MzMMwsR5yCx/D03/DvrLCHOLgRsWofA1G48U
         n4aIfJ3weW2OCpVKh2VRnG3ebK8M5ONtMEtIkC3fB3hNabi+ChyUQ9vYqqQbvssy8f4l
         fpe34arGIzFmrKgaR8q/8j9Lx0H8qNOC6IU60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BluMzkCDQwyvUXl6lzhoZtoPJHAVNPhcRWOIM0TWe5A=;
        b=Vy5KsjlxMsnzV3KrgNAxEAQarUPepCdSDeO1wrgVeDCIbdhbd7yw9FKViMiQxa887U
         oms+BNdxsinH+kpt9g6j46Agdzme0RWBEMjdc4X28FoJA0Zt7n6qdFmVpflizCloHWRU
         AWlPkf6haPG2CbbT8ULJ3M53DSWWQ1zGyPdCBo2ON0AQ6V0oyvt/NPTn4DgTV39Q0jng
         vQrlavsYWN3DfRgDYNiaTnN/kNRWV4J4k8Rgw/ydKfVMkX+3LxSwFsNE0pBmYhKPlnhw
         dvjP1SiSDc1Hm0HNPE416Zr7mBzYSy6i4wJQQnHV+TdQJe7VIes8YckK2qgNUF1fSjlG
         0dzQ==
X-Gm-Message-State: APjAAAUM1MAmERhSIwMG7dXFsAzVQ3iJRItL/rthgephcSRloIBcKW9a
        SPjV2SwkGc14AhSb4sVy0t4mtlVgEdE=
X-Google-Smtp-Source: APXvYqwrTh7Op1AtOq/c/UTII0/29kEuKbcU5RNLKXHpTnxtsz7soez+6wTm0QNpJCWsqqI+/QMkTQ==
X-Received: by 2002:a9d:529:: with SMTP id 38mr22880584otw.145.1560507502984;
        Fri, 14 Jun 2019 03:18:22 -0700 (PDT)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com. [209.85.210.54])
        by smtp.gmail.com with ESMTPSA id v203sm1050994oie.5.2019.06.14.03.18.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 03:18:21 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id e8so1169856otl.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 03:18:21 -0700 (PDT)
X-Received: by 2002:a9d:30c3:: with SMTP id r3mr9116550otg.141.1560507501049;
 Fri, 14 Jun 2019 03:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190614075640.106709-1-acourbot@chromium.org> <9fd990d12ea1488592c5a590046f001a187b9c3f.camel@perches.com>
In-Reply-To: <9fd990d12ea1488592c5a590046f001a187b9c3f.camel@perches.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 14 Jun 2019 19:18:09 +0900
X-Gmail-Original-Message-ID: <CAPBb6MVRA_tBwg_r-Z8Rx7pUkR8W47CN1dqWH5uk+_1ONhViog@mail.gmail.com>
Message-ID: <CAPBb6MVRA_tBwg_r-Z8Rx7pUkR8W47CN1dqWH5uk+_1ONhViog@mail.gmail.com>
Subject: Re: [PATCH v2] media: mtk-vcodec: remove unneeded proxy functions
To:     Joe Perches <joe@perches.com>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 6:11 PM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2019-06-14 at 16:56 +0900, Alexandre Courbot wrote:
> > We were getting the codec interface through a proxy function that does
> > not bring anything compared to just accessing the interface definition
> > directly, so just do that. Also make the decoder interfaces const.
> []
> > diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_h264_if.c b/drivers/media/platform/mtk-vcodec/vdec/vdec_h264_if.c
> []
> > @@ -485,16 +485,9 @@ static int vdec_h264_get_param(void *h_vdec, enum vdec_get_param_type type,
> >       return 0;
> >  }
> >
> > -static struct vdec_common_if vdec_h264_if = {
> > +const struct vdec_common_if vdec_h264_if = {
>
> probably better to fixup whatever chains prevent
> this (if any) from being static const

These are defined in per-codec source files and selected at runtime by
vdec_drv_if.c, so I don't think we can avoid declaring at least
something? The previous approach was to declare a function, but as you
can see we can remove quite some code by exporting the structs
directly.
