Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB23C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBB2214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFLfJno4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbfH0OU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 10:20:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38176 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfH0OU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:20:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id e16so1911419wro.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 07:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iBAm6erRWZATcOthg0y2dJxIFllt+ucHuf1C3MzA8xw=;
        b=RFLfJno467RtH4FMFNsNGodYoehjqiEmmDcT0VHAQJujyCJrQoi0YkjOSL369QMh6H
         k5Li5GpbbvhBdrzdZKQ+vvxAw92nk+1X6N6OVTQxPBUjqhtv69OPNiU2eiypNiutjuOT
         4U3UeVOlM0Mlof1b0Rjcb12rIH38DcARvNw9UhyqmUpqiHhWyzXUgYlovd+GPoe6D1v2
         cqakq6Ntny2fBwXc0WWS45FRf5qQY/HjtwInf9MwZ6HDKqoa4gIXD2v8E8G/wsI83Fqg
         /Z5Okhwa3D0sbeKH0Vzpy5vcpeIYZ3nI3a0phBKECaVJ3Te3ofO/VqU4gNJaM0C4iUbG
         WmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iBAm6erRWZATcOthg0y2dJxIFllt+ucHuf1C3MzA8xw=;
        b=WIFHcqNLm+R4/PvS6f1gXESO/mkzeXSrZ5DHgGBnpJ6tam9neKYvD7GwS1/onvt4Uc
         8W7MmTLlDbdHeWJuZQFMqBuZRkKrcEdaSDJh1cj7EWIc9/331TzcLWj75nWzUo0bUXxf
         NxqEUw9ykJoD1EAd97KUeSMC/lepcxJuv/b04JT935o6phxXGZePANuk5g1qW8BY4s/k
         j5NNGvpkzzXN2O746vVQmJc262zIXLTO58gN348vA8PwxgBKLW7q5CIi6mc4zuiEfsC/
         K+GLNezynt0mj2kNGHTA1NS9wrdefbjuNPRja9ibrjxz5fo+llSTwYA/QdO3EYl1ZX//
         TyIQ==
X-Gm-Message-State: APjAAAVqTmhUqSlPM7l/Z79BHtKZr8GC2bHNNcbToTBcFHBYsc0rQvgH
        WvM/ou9p803JU334BVA/66TFhQCB/JzI7x6xjy8=
X-Google-Smtp-Source: APXvYqyf+l+zuM8bhu1HQmmKMsstVBdXQfSESMC96ize5xVQmpsWd4VMknKBd7ff6xmTFakrJ7EBlQeZs551NLPIbkY=
X-Received: by 2002:adf:dfc5:: with SMTP id q5mr31077656wrn.142.1566915624956;
 Tue, 27 Aug 2019 07:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190827070925.16080-1-yuehaibing@huawei.com> <fb49a1d9-8405-4f88-6f9a-af863bd0f657@amd.com>
In-Reply-To: <fb49a1d9-8405-4f88-6f9a-af863bd0f657@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 27 Aug 2019 10:20:13 -0400
Message-ID: <CADnq5_Pe-qnTWZrDxmC=xqHJBQ_SkaBv8go9mVWWp7MciC4NHA@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amd/display: remove unused function setFieldWithMask
To:     Harry Wentland <hwentlan@amd.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
        "Koo, Anthony" <Anthony.Koo@amd.com>,
        "Othman, Ahmad" <Ahmad.Othman@amd.com>,
        "Bernstein, Eric" <Eric.Bernstein@amd.com>,
        "Cyr, Aric" <Aric.Cyr@amd.com>,
        "alvin.lee3@amd.com" <alvin.lee3@amd.com>,
        "Tatla, Harmanprit" <Harmanprit.Tatla@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 10:01 AM Harry Wentland <hwentlan@amd.com> wrote:
>
> On 2019-08-27 3:09 a.m., YueHaibing wrote:
> > After commit a9f54ce3c603 ("drm/amd/display: Refactoring VTEM"),
> > there is no caller in tree.
> >
> > Reported-by: Hulk Robot <hulkci@huawei.com> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>

Applied.  Thanks!

Alex

> Harry
>
> > ---
> >  .../drm/amd/display/modules/info_packet/info_packet.c | 19 -------------------
> >  1 file changed, 19 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> > index 5f4b98d..d885d64 100644
> > --- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> > +++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> > @@ -114,25 +114,6 @@ enum ColorimetryYCCDP {
> >       ColorimetryYCC_DP_ITU2020YCbCr  = 7,
> >  };
> >
> > -void setFieldWithMask(unsigned char *dest, unsigned int mask, unsigned int value)
> > -{
> > -     unsigned int shift = 0;
> > -
> > -     if (!mask || !dest)
> > -             return;
> > -
> > -     while (!((mask >> shift) & 1))
> > -             shift++;
> > -
> > -     //reset
> > -     *dest = *dest & ~mask;
> > -     //set
> > -     //dont let value span past mask
> > -     value = value & (mask >> shift);
> > -     //insert value
> > -     *dest = *dest | (value << shift);
> > -}
> > -
> >  void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
> >               struct dc_info_packet *info_packet)
> >  {
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
