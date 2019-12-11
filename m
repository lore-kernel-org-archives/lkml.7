Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0802BC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 11:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE5024656
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 11:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLp0q+Aq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbfLKLrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 06:47:23 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:39898 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfLKLrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 06:47:23 -0500
Received: by mail-vk1-f194.google.com with SMTP id x199so6695013vke.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 03:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KPw4BWkTUh66N/l+oHgRw2epWlItk5ePmLSBKI5Tyjc=;
        b=fLp0q+Aq+pCU0RkbRVrb2N2a9Cbry6BHuCOylVJULtiPiEObiSOxp/zavD8nzE+zj5
         lKyW0NHDPZ0wyI2Z9BVSwsGC29TKNdK8TOKRQdV2ICMjyhsvO2bGHVWapjhh/k6lyHgp
         4AL6rw3TQQnY6t3Zl8z9oJ4GdUKiSRVij2DWsfvZDXfk7GomIsw45hb55Y9zE9UTW+j6
         TOwDPrUo/s0V38hskklMtX9r46NWjQHRUmSZm7NxUXfwLOvEIoz/6AufILKs6XIXdsm8
         PKYRhpob37eGDMbF3pU5G4FSkNKnqZvW1/9POYZoYBcKlRQxtekSjqiGzYeL7s4sc/WE
         VR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KPw4BWkTUh66N/l+oHgRw2epWlItk5ePmLSBKI5Tyjc=;
        b=sMh+4jJv6jBeZf1bLC90w1UhVmCgcy7lKT3om2LqlvgLAkv4VGwpubh6YNRDSLgfL/
         0aXXrYGkykdg2aGijPcxr9Ol4pLtEm+iIG39kF6CWQj8r9vh4VXlc7pgLeRZh/uJWBBo
         somaLt8J3gruhRMblOFAyC12AHmYhNApteljb5+MtteQ9xkRKP5Rt9ywsGiXuw9e3aiO
         b2nZMgJYmg6b8HE4YT4VdAKgy3LAtk+v64TltwtsjeTstwCC0Tq9t5x9oQ9nI2yxLNKQ
         WR6MrMeDo8h9nHTQXfPCHcuSqSFTPBVDkWlTdF/5fij0sqBPYv72Zcl5R5yr+YE5Gj7Y
         Ypkw==
X-Gm-Message-State: APjAAAWl5GKYyHevTDIzYFiR/xDfFg/7nD3s65ngokaIlXinmvNdCC0u
        BXgLo3rjStWShTGAeEvb6dlxwUCGETmzUGMDs9A+yQ==
X-Google-Smtp-Source: APXvYqy2WV0o0WTeidYaegKNg5xN9HKD7exGZ7ITgPnsyD2ep/rt00HnH9Ugu3XPBwH9a3J2kYJwc5f02NtnzlPD5SU=
X-Received: by 2002:a1f:3fcd:: with SMTP id m196mr2975528vka.28.1576064841951;
 Wed, 11 Dec 2019 03:47:21 -0800 (PST)
MIME-Version: 1.0
References: <1575966995-13757-1-git-send-email-kevin3.tang@gmail.com>
 <1575966995-13757-5-git-send-email-kevin3.tang@gmail.com> <CACvgo50Hgbb8ywX2RgFqkitxwBG64EhP9g1TSxgLkQf-6L6soA@mail.gmail.com>
 <CAFPSGXZMmfeBxkNhuNR59bX26_69_y5C13P7qY-UawVDa7Q3Jw@mail.gmail.com>
In-Reply-To: <CAFPSGXZMmfeBxkNhuNR59bX26_69_y5C13P7qY-UawVDa7Q3Jw@mail.gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Wed, 11 Dec 2019 11:46:06 +0000
Message-ID: <CACvgo50wCKq76Wj0xjJcuWxz5gvaOSbj1Hz8-Vi6eOSGH106yg@mail.gmail.com>
Subject: Re: [PATCH RFC 4/8] drm/sprd: add Unisoc's drm display controller driver
To:     tang pengchuan <kevin3.tang@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Orson Zhai <orsonzhai@gmail.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2019 at 09:18, tang pengchuan <kevin3.tang@gmail.com> wrote:
>
> Hi
>
> Emil Velikov <emil.l.velikov@gmail.com> =E4=BA=8E2019=E5=B9=B412=E6=9C=88=
11=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=881:14=E5=86=99=E9=81=93=EF=
=BC=9A
>>
>> Hi Kevin,
>>
>> On Tue, 10 Dec 2019 at 08:41, Kevin Tang <kevin3.tang@gmail.com> wrote:
>> >
>> > From: Kevin Tang <kevin.tang@unisoc.com>
>> >
>> > Adds DPU(Display Processor Unit) support for the Unisoc's display subs=
ystem.
>> > It's support multi planes, scaler, rotation, PQ(Picture Quality) and m=
ore.
>> >
>> > Cc: Orson Zhai <orsonzhai@gmail.com>
>> > Cc: Baolin Wang <baolin.wang@linaro.org>
>> > Cc: Chunyan Zhang <zhang.lyra@gmail.com>
>> > Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
>> > ---
>> >  drivers/gpu/drm/sprd/Makefile       |    6 +-
>> >  drivers/gpu/drm/sprd/disp_lib.c     |  290 +++++++
>> >  drivers/gpu/drm/sprd/disp_lib.h     |   40 +
>> >  drivers/gpu/drm/sprd/dpu/Makefile   |    8 +
>> >  drivers/gpu/drm/sprd/dpu/dpu_r2p0.c | 1464 ++++++++++++++++++++++++++=
+++++++++
>> >  drivers/gpu/drm/sprd/sprd_dpu.c     | 1152 ++++++++++++++++++++++++++=
+
>> >  drivers/gpu/drm/sprd/sprd_dpu.h     |  217 ++++++
>> >  7 files changed, 3176 insertions(+), 1 deletion(-)
>>
>> As we can see from the diff stat this patch is huge. So it would be fair=
ly hard
>> to provide meaningful review as-is.
>>
>> One can combine my earlier suggestion (to keep modeset/atomic out of 2/8=
), with
>> the following split:
>>  - 4/8 add basic atomic modeset support - one format, one rotation 0, no=
 extra
>>  attributes
>>  - 5/8 add extra formats
>>  - 6/8 add extra rotation support
>>  - ... add custom attributes
>
> Ok, i will split this patch, upstream modeset and atomic at first. clock,=
 gloabl, enhance, extra
> attributes  and so on will be upload later.

Amazing thank you. Please apply the similar logic and split patch 6/8
- that patch is twice larger than this one.

Some small general requests - please use plain text emails (see [1])
and trim unrelated fragments when replying.
Otherwise it is very easy to miss the comment that you and others have made=
.

HTH
Emil

[1] https://www.lifewire.com/how-to-send-a-message-in-plain-text-from-gmail=
-1171963
