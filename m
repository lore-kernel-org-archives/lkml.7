Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD1BECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440102053B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hXnr3vL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbfJIPLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:11:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43702 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbfJIPLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:11:02 -0400
Received: by mail-ed1-f68.google.com with SMTP id r9so2342156edl.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 08:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=C7vV5Ta7kiN+Jx0dsp84oi99P0gny8OqQ+rZiWxEBQk=;
        b=hXnr3vL6PO1kH7F2wkslm/RjNKmVZY3XVz7tO/PS0bz12ywGqTlC5upN53sDakhHDT
         sUpY7UqPN9Y3i8wY737vRCcuFbf1YUDlTXhLR8ZFofzKJM3wJVCjWUGUnfWJan8SPniv
         VzpE+kX1ak69oMF6G597TNJCDR99bgGvUhbS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=C7vV5Ta7kiN+Jx0dsp84oi99P0gny8OqQ+rZiWxEBQk=;
        b=o1vWrgA0XFqYEtnbRgwGnVPJ38djw1rwOCuPZ0AaN+YWfNs8xnCl+kbJTfuJ0tci3R
         B4CUogjM5Z0W5NFC2ruGDI8jmuDLYstz0b5yvMr2dE9tDXIb9n2uQSRbuiOv6gWIdBZ/
         CvNwlbR/PjjYLscAZOQ8WRLP2M6maQnCKMB7byN6nH2AQoeGEtbdeiLcJSGQFVBFfA2I
         dIMAcraLa/xT+rd/ru+ZP6RXWKXFfNGm7nxNLAefWwYBdzBkz/Ue53v87y05/+ZW1zh7
         RJkzM+xOMnlJoWeewoQqNFdXLowDLY/fBgRWg86bzRhXgTbNaz5lGcByYSOctT49ql67
         jGKQ==
X-Gm-Message-State: APjAAAWj/ag/LD0wrc29j3mUjaN24MsAdyZlmjWe7OsKzA//25gob2o/
        rjglaxI6X1NOMNoE6AzIIPeAaw==
X-Google-Smtp-Source: APXvYqwTrH8nNXFpjqBvvrCTsz5k53RaNmz8K/Y+gt0Ek91OqtHE2k0ZinvAPu2kUyysshLL7Ub7ZQ==
X-Received: by 2002:a50:955e:: with SMTP id v30mr3455881eda.221.1570633859068;
        Wed, 09 Oct 2019 08:10:59 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id u27sm395824edb.48.2019.10.09.08.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 08:10:43 -0700 (PDT)
Date:   Wed, 9 Oct 2019 17:10:24 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Brian Starkey <Brian.Starkey@arm.com>, nd <nd@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        Ben Davis <Ben.Davis@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
Subject: Re: [PATCH 2/3] drm/komeda: Add drm_ctm_to_coeffs()
Message-ID: <20191009151024.GF16989@phenom.ffwll.local>
Mail-Followup-To: Ilia Mirkin <imirkin@alum.mit.edu>,
        Brian Starkey <Brian.Starkey@arm.com>, nd <nd@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        Ben Davis <Ben.Davis@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
References: <20190930045408.8053-1-james.qian.wang@arm.com>
 <20190930045408.8053-3-james.qian.wang@arm.com>
 <20190930110438.6w7jtw2e5s2ykwnd@DESKTOP-E1NTVVP.localdomain>
 <CAKb7UviDMLLJWZYV_aW2odJBfmSA8pH7TVuU7T9qpuy1713-EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKb7UviDMLLJWZYV_aW2odJBfmSA8pH7TVuU7T9qpuy1713-EA@mail.gmail.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 07:56:13AM -0400, Ilia Mirkin wrote:
> On Mon, Sep 30, 2019 at 7:05 AM Brian Starkey <Brian.Starkey@arm.com> wrote:
> >
> > Hi James,
> >
> > On Mon, Sep 30, 2019 at 04:54:41AM +0000, james qian wang (Arm Technology China) wrote:
> > > This function is used to convert drm_color_ctm S31.32 sign-magnitude
> > > value to komeda required Q2.12 2's complement
> > >
> > > Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@arm.com>
> > > ---
> > >  .../arm/display/komeda/komeda_color_mgmt.c    | 27 +++++++++++++++++++
> > >  .../arm/display/komeda/komeda_color_mgmt.h    |  1 +
> > >  2 files changed, 28 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> > > index c180ce70c26c..c92c82eebddb 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> > > @@ -117,3 +117,30 @@ void drm_lut_to_fgamma_coeffs(struct drm_property_blob *lut_blob, u32 *coeffs)
> > >  {
> > >       drm_lut_to_coeffs(lut_blob, coeffs, sector_tbl, ARRAY_SIZE(sector_tbl));
> > >  }
> > > +
> > > +/* Convert from S31.32 sign-magnitude to HW Q2.12 2's complement */
> > > +static s32 drm_ctm_s31_32_to_q2_12(u64 input)
> > > +{
> > > +     u64 mag = (input & ~BIT_ULL(63)) >> 20;
> > > +     bool negative = !!(input & BIT_ULL(63));
> > > +     u32 val;
> > > +
> > > +     /* the range of signed 2s complement is [-2^n, 2^n - 1] */
> > > +     val = clamp_val(mag, 0, negative ? BIT(14) : BIT(14) - 1);
> > > +
> > > +     return negative ? 0 - val : val;
> > > +}
> >
> > This function looks generally useful. Should it be in DRM core
> > (assuming there isn't already one there)?
> >
> > You can use a parameter to determine the number of bits desired in the
> > output.
> 
> I suspect every driver needs to do something similar. You can see what
> I did for nouveau here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=88b703527ba70659365d989f29579f1292ebf9c3
> 
> (look for csc_drm_to_base)
> 
> Would be great to have a common helper which correctly accounts for
> all the variability.

Yeah the sign-bit 31.32 fixed point format is probably the most ludicrous
uapi fumble we've ever done. A shared function, rolled out to drivers, to
switch it to a signed 2 complements integer sounds like a _very_ good
idea.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
