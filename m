Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6D3C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 11:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB6D2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 11:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbfI3L40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 07:56:26 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:39291 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbfI3L40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 07:56:26 -0400
Received: by mail-vk1-f196.google.com with SMTP id u4so2586443vkl.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 04:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XK+Pj//CAf98OmvrIc+Zkz8mL+/Q71gw+jEEwWOAJHE=;
        b=eSInWx7WCUV6tRFSEM+Mm5SA43u6NL7pTbAwxfddk54eQzWBKylfsgrhgOziQsdOXm
         IOQ21HBWtwfZJjebGZM3A8zY3tA8PXQjF117U8YkiuqO6rj0XzJkd2x+/060sSoHz04t
         KIZsxIMH68Sln7KFDklRLcCo5pGWfN5vlF9pCVXv7P4EpSSrLmSpLSGczqDk5lVMxCLy
         /PO0ouSQQznA0MvOWv7cXrPwDUkgjrjIPU7qLgEcdZO92qODpCSkfcNL6dMyiHv77AMM
         Zw/8o84MhYkb/QcSlt3OfEf23vJd9DObaWjXCTmwUEA2uHc0nMjFkaadtF83131pcKPK
         5YWA==
X-Gm-Message-State: APjAAAUrMpy+5nQBl3v1Y9vuTlj1avDEMnB69Eks/Gyy5kTtzI7DFiTh
        q2MVRoGjZIJ2tDBZnWz7N8W/dhbZq8BLmMV3kY0=
X-Google-Smtp-Source: APXvYqyp3oqLhmTa6dfK6tao5pcqoru4TZ3YQ6anF9MveP7plK/oRqyonurgvgfZ4sQelX1+qjAQP5Ngs9QvGZXbQT0=
X-Received: by 2002:a1f:e387:: with SMTP id a129mr11405vkh.14.1569844585010;
 Mon, 30 Sep 2019 04:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190930045408.8053-1-james.qian.wang@arm.com>
 <20190930045408.8053-3-james.qian.wang@arm.com> <20190930110438.6w7jtw2e5s2ykwnd@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20190930110438.6w7jtw2e5s2ykwnd@DESKTOP-E1NTVVP.localdomain>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Mon, 30 Sep 2019 07:56:13 -0400
Message-ID: <CAKb7UviDMLLJWZYV_aW2odJBfmSA8pH7TVuU7T9qpuy1713-EA@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/komeda: Add drm_ctm_to_coeffs()
To:     Brian Starkey <Brian.Starkey@arm.com>
Cc:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        nd <nd@arm.com>, Ayan Halder <Ayan.Halder@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "sean@poorly.run" <sean@poorly.run>, Ben Davis <Ben.Davis@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 7:05 AM Brian Starkey <Brian.Starkey@arm.com> wrote:
>
> Hi James,
>
> On Mon, Sep 30, 2019 at 04:54:41AM +0000, james qian wang (Arm Technology China) wrote:
> > This function is used to convert drm_color_ctm S31.32 sign-magnitude
> > value to komeda required Q2.12 2's complement
> >
> > Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@arm.com>
> > ---
> >  .../arm/display/komeda/komeda_color_mgmt.c    | 27 +++++++++++++++++++
> >  .../arm/display/komeda/komeda_color_mgmt.h    |  1 +
> >  2 files changed, 28 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> > index c180ce70c26c..c92c82eebddb 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> > @@ -117,3 +117,30 @@ void drm_lut_to_fgamma_coeffs(struct drm_property_blob *lut_blob, u32 *coeffs)
> >  {
> >       drm_lut_to_coeffs(lut_blob, coeffs, sector_tbl, ARRAY_SIZE(sector_tbl));
> >  }
> > +
> > +/* Convert from S31.32 sign-magnitude to HW Q2.12 2's complement */
> > +static s32 drm_ctm_s31_32_to_q2_12(u64 input)
> > +{
> > +     u64 mag = (input & ~BIT_ULL(63)) >> 20;
> > +     bool negative = !!(input & BIT_ULL(63));
> > +     u32 val;
> > +
> > +     /* the range of signed 2s complement is [-2^n, 2^n - 1] */
> > +     val = clamp_val(mag, 0, negative ? BIT(14) : BIT(14) - 1);
> > +
> > +     return negative ? 0 - val : val;
> > +}
>
> This function looks generally useful. Should it be in DRM core
> (assuming there isn't already one there)?
>
> You can use a parameter to determine the number of bits desired in the
> output.

I suspect every driver needs to do something similar. You can see what
I did for nouveau here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=88b703527ba70659365d989f29579f1292ebf9c3

(look for csc_drm_to_base)

Would be great to have a common helper which correctly accounts for
all the variability.

Cheers,

  -ilia
