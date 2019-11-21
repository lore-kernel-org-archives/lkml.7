Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AC3C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9082206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uLLUc/Sv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfKUTQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 14:16:43 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33015 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfKUTQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 14:16:43 -0500
Received: by mail-lj1-f196.google.com with SMTP id t5so4550167ljk.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 11:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ziahN+ttEd97d/5G5z+3cx0j+N8D4TfwxF73+tgCoU0=;
        b=uLLUc/SvsjhbA0LZqgK5b/dX/fOzl5h51BgJE1HTB/13AunSW9a5zLHQ/cNfyDZg56
         Vy6dFsZCpM1+HZQd3aPHTfbIr0chJ1LCkFG6kUKta8v3pAwCLGQZ3jrMD1kCIrAT9yVB
         3yyZ2qX3hT2g7ECsWZJFGv9YGZi9Dn9ljrCS30bSJkalHUAzFy3G8jxFfM3zELT2Fwuc
         MNeJ4NBFMN3RkVGRqUHUpuYD9C+fiS5948R9TgHB62mJ80oDjuQK5c0fDJoCUhXEA73j
         1liNW4YTFW64VGm/iRRpn5TdmpEm7G1IedCMkceBsIyDlDGsG5vyEC4IzwOBce9YCoID
         KJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ziahN+ttEd97d/5G5z+3cx0j+N8D4TfwxF73+tgCoU0=;
        b=OCZ6HGFNU1hAlT4D9xnxg9++t7AtkQHt+lBX8IGzX3aOGDJijBJZQe/PYl9ow0b6CV
         V52f9VzR4mjCwIdRIyfeIDBqXqqZCZPfNSXlq1/OndVdEVBaXlBCxgmy1TGks5jYy3Ab
         dNKBMJP+TcO68H8+T0uBT3jAvWvPtDTS84wv+VLZSb6KgRFUNPcGTByuWdRXKDbSjyFo
         ZUoz+8tMEt2GBn50ksqfgphFShfYGb7PVTm0n7I9eQqdtnGkoKX6K6IRmcLAqdGKRH5x
         b6H5pgPXZPgDIbDvX2JANunqibsB/kusTW5gYm5Y7BiFY+uPGhPflky91kRaAYlJem9L
         cswQ==
X-Gm-Message-State: APjAAAXKA2IE84ot0qbjqwOR8vcDNIGvaZFJZQ4pQt7FeNhSsvgqkdoF
        ZP9NoqQnK3pfNkX/vK0V3qD0SjmL9l5Zh6EQB6cqFw==
X-Google-Smtp-Source: APXvYqyjb5+/REtjK/bEEh0WptrT7h8T1UiI0QahdyGO8qMUxCXU5NSGXt8rKmXDp2mNfZV4+RB/PM8IYT9s+eyrh/A=
X-Received: by 2002:a2e:8e28:: with SMTP id r8mr8884490ljk.21.1574363801085;
 Thu, 21 Nov 2019 11:16:41 -0800 (PST)
MIME-Version: 1.0
References: <20191121071205.27511-1-james.qian.wang@arm.com>
 <20191121071205.27511-7-james.qian.wang@arm.com> <20191121094926.GC6236@phenom.ffwll.local>
 <20191121102101.GA32514@jamwan02-TSP300>
In-Reply-To: <20191121102101.GA32514@jamwan02-TSP300>
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 22 Nov 2019 05:16:29 +1000
Message-ID: <CAPM=9tw8KDh1bkErYXGsc1Yvc0H9NEEUJ3eA0BSqgGOWDaPhxg@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] drm/komeda: Expose side_by_side by sysfs/config_id
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ben Davis <Ben.Davis@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019 at 20:21, james qian wang (Arm Technology China)
<james.qian.wang@arm.com> wrote:
>
> On Thu, Nov 21, 2019 at 10:49:26AM +0100, Daniel Vetter wrote:
> > On Thu, Nov 21, 2019 at 07:12:55AM +0000, james qian wang (Arm Technology China) wrote:
> > > There are some restrictions if HW works on side_by_side, expose it via
> > > config_id to user.
> > >
> > > Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.com>
> > > ---
> > >  drivers/gpu/drm/arm/display/include/malidp_product.h | 3 ++-
> > >  drivers/gpu/drm/arm/display/komeda/komeda_dev.c      | 1 +
> > >  2 files changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/arm/display/include/malidp_product.h b/drivers/gpu/drm/arm/display/include/malidp_product.h
> > > index 1053b11352eb..96e2e4016250 100644
> > > --- a/drivers/gpu/drm/arm/display/include/malidp_product.h
> > > +++ b/drivers/gpu/drm/arm/display/include/malidp_product.h
> > > @@ -27,7 +27,8 @@ union komeda_config_id {
> > >                     n_scalers:2, /* number of scalers per pipeline */
> > >                     n_layers:3, /* number of layers per pipeline */
> > >                     n_richs:3, /* number of rich layers per pipeline */
> > > -                   reserved_bits:6;
> > > +                   side_by_side:1, /* if HW works on side_by_side mode */
> > > +                   reserved_bits:5;
> > >     };
> > >     __u32 value;
> > >  };
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> > > index c3fa4835cb8d..4dd4699d4e3d 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> > > @@ -83,6 +83,7 @@ config_id_show(struct device *dev, struct device_attribute *attr, char *buf)
> >
> > Uh, this sysfs file here looks a lot like uapi for some compositor to
> > decide what to do. Do you have the userspace for this?
>
> Yes, our HWC driver uses this config_id and product_id for identifying the
> HW caps.
>

This seems like it should be done more in the kernel, why does
userspace needs all that info, to make more informed decisions?

How would drm_hwcomposer get the same result?

I'd prefer we just remove the sysfs nodes from upstream unless we have
an upstream user for them.

Dave.
