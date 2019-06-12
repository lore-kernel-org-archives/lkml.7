Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B42C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BA4215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560358824;
	bh=7aLU5Bqdlqn7abZ+7OODf6LyuDW/idcWFbauu3DZwuc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YQ2Emo9BZYEv1+J6FtrF9Uyzu8kYFVyqp5Y7FZzCBkkmSGgA44R0PbXZEoyhDrPGD
	 hoGMUzK7Uj9LLjGBV66FJY8HjhoNxMBzOeL0wS1haRxfDotIuSUl7A2Lmq94GCMSx9
	 jgtArPMaZL92n9mk9zkY+63cSAfpzMoXKINHIiBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438228AbfFLRAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:00:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:49092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbfFLRAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:00:23 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 483C821744;
        Wed, 12 Jun 2019 17:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560358821;
        bh=7aLU5Bqdlqn7abZ+7OODf6LyuDW/idcWFbauu3DZwuc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XzlPb9hN+5HIVFHLTsbbBjJh0oCS51YAarc73vQgyAqEMvCTRSY3Cc+I3HadF0U8n
         TmFCY0gdRA4dNN4aXftcOgHuFjB3pflK51gSyl3nxKLvR0RnpRjNji8ySWlnhKH6gV
         FiprotSDsesZ/mHQ2y71KyooIyFktigjimda/WPU=
Received: by mail-qt1-f173.google.com with SMTP id x2so18369410qtr.0;
        Wed, 12 Jun 2019 10:00:21 -0700 (PDT)
X-Gm-Message-State: APjAAAVkZAMDn3Knb8V4DNsPuPcYH2dRouv/SMUIIKLdq0cSaAJMMDRg
        PVE0w0GsDx+9jXsD7wNAymTcRFh+5QIo5OFndA==
X-Google-Smtp-Source: APXvYqy5uOAOwR6lIcM4YkoRgaS0Q4eE5PZ1OGinObQbMWVdvD1Ij2PRCU4Me2E6xB25hQAWGRnvsjIhll2KDB9J+LQ=
X-Received: by 2002:ac8:3908:: with SMTP id s8mr71080428qtb.224.1560358820525;
 Wed, 12 Jun 2019 10:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190612010011.90185-1-wangkefeng.wang@huawei.com> <0702fa2d-1952-e9fc-8e17-a93f3b90a958@gmail.com>
In-Reply-To: <0702fa2d-1952-e9fc-8e17-a93f3b90a958@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 12 Jun 2019 11:00:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKsjK237W+-Yz4McxSZG=Gd3Pfp2JtgMnfAqiNRUcCg1g@mail.gmail.com>
Message-ID: <CAL_JsqKsjK237W+-Yz4McxSZG=Gd3Pfp2JtgMnfAqiNRUcCg1g@mail.gmail.com>
Subject: Re: [PATCH next] of/fdt: Fix defined but not used compiler warning
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 10:45 AM Frank Rowand <frowand.list@gmail.com> wrot=
e:
>
> Hi Kefeng,
>
> If Rob agrees, I'd like to see one more change in this patch.
>
> Since the only caller of of_fdt_match() is of_flat_dt_match(),
> can you move the body of of_fdt_match() into  of_flat_dt_match()
> and eliminate of_fdt_match()?

That's fine as long as we think there's never any use for of_fdt_match
after init? Fixup of nodes in an overlay for example.

Rob

>
> (Noting that of_flat_dt_match() consists only of the call to
> of_fdt_match().)
>
> -Frank
>
>
> On 6/11/19 6:00 PM, Kefeng Wang wrote:
> > When CONFIG_OF_EARLY_FLATTREE is disabled, there is a compiler warning,
> >
> > drivers/of/fdt.c:129:19: warning: =E2=80=98of_fdt_match=E2=80=99 define=
d but not used [-Wunused-function]
> >  static int __init of_fdt_match(const void *blob, unsigned long node,
> >
> > Move of_fdt_match() and of_fdt_is_compatible() under CONFIG_OF_EARLY_FL=
ATTREE
> > to fix it.
> >
> > Cc: Stephen Boyd <swboyd@chromium.org>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > ---
> >  drivers/of/fdt.c | 106 +++++++++++++++++++++++------------------------
> >  1 file changed, 53 insertions(+), 53 deletions(-)
> >
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index 3d36b5afd9bd..d6afd5b22940 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -78,38 +78,6 @@ void __init of_fdt_limit_memory(int limit)
> >       }
> >  }
> >
> > -/**
> > - * of_fdt_is_compatible - Return true if given node from the given blo=
b has
> > - * compat in its compatible list
> > - * @blob: A device tree blob
> > - * @node: node to test
> > - * @compat: compatible string to compare with compatible list.
> > - *
> > - * On match, returns a non-zero value with smaller values returned for=
 more
> > - * specific compatible values.
> > - */
> > -static int of_fdt_is_compatible(const void *blob,
> > -                   unsigned long node, const char *compat)
> > -{
> > -     const char *cp;
> > -     int cplen;
> > -     unsigned long l, score =3D 0;
> > -
> > -     cp =3D fdt_getprop(blob, node, "compatible", &cplen);
> > -     if (cp =3D=3D NULL)
> > -             return 0;
> > -     while (cplen > 0) {
> > -             score++;
> > -             if (of_compat_cmp(cp, compat, strlen(compat)) =3D=3D 0)
> > -                     return score;
> > -             l =3D strlen(cp) + 1;
> > -             cp +=3D l;
> > -             cplen -=3D l;
> > -     }
> > -
> > -     return 0;
> > -}
> > -
> >  static bool of_fdt_device_is_available(const void *blob, unsigned long=
 node)
> >  {
> >       const char *status =3D fdt_getprop(blob, node, "status", NULL);
> > @@ -123,27 +91,6 @@ static bool of_fdt_device_is_available(const void *=
blob, unsigned long node)
> >       return false;
> >  }
> >
> > -/**
> > - * of_fdt_match - Return true if node matches a list of compatible val=
ues
> > - */
> > -static int __init of_fdt_match(const void *blob, unsigned long node,> =
-                             const char *const *compat)
> > -{
> > -     unsigned int tmp, score =3D 0;
> > -
> > -     if (!compat)
> > -             return 0;
> > -
> > -     while (*compat) {
> > -             tmp =3D of_fdt_is_compatible(blob, node, *compat);
> > -             if (tmp && (score =3D=3D 0 || (tmp < score)))
> > -                     score =3D tmp;
> > -             compat++;
> > -     }
> > -
> > -     return score;
> > -}
> > -
> >  static void *unflatten_dt_alloc(void **mem, unsigned long size,
> >                                      unsigned long align)
> >  {
> > @@ -764,6 +711,59 @@ const void *__init of_get_flat_dt_prop(unsigned lo=
ng node, const char *name,
> >       return fdt_getprop(initial_boot_params, node, name, size);
> >  }
> >
> > +/**
> > + * of_fdt_is_compatible - Return true if given node from the given blo=
b has
> > + * compat in its compatible list
> > + * @blob: A device tree blob
> > + * @node: node to test
> > + * @compat: compatible string to compare with compatible list.
> > + *
> > + * On match, returns a non-zero value with smaller values returned for=
 more
> > + * specific compatible values.
> > + */
> > +static int of_fdt_is_compatible(const void *blob,
> > +                   unsigned long node, const char *compat)
> > +{
> > +     const char *cp;
> > +     int cplen;
> > +     unsigned long l, score =3D 0;
> > +
> > +     cp =3D fdt_getprop(blob, node, "compatible", &cplen);
> > +     if (cp =3D=3D NULL)
> > +             return 0;
> > +     while (cplen > 0) {
> > +             score++;
> > +             if (of_compat_cmp(cp, compat, strlen(compat)) =3D=3D 0)
> > +                     return score;
> > +             l =3D strlen(cp) + 1;
> > +             cp +=3D l;
> > +             cplen -=3D l;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * of_fdt_match - Return true if node matches a list of compatible val=
ues
> > + */
> > +static int __init of_fdt_match(const void *blob, unsigned long node,
> > +                            const char *const *compat)
> > +{
> > +     unsigned int tmp, score =3D 0;
> > +
> > +     if (!compat)
> > +             return 0;
> > +
> > +     while (*compat) {
> > +             tmp =3D of_fdt_is_compatible(blob, node, *compat);
> > +             if (tmp && (score =3D=3D 0 || (tmp < score)))
> > +                     score =3D tmp;
> > +             compat++;
> > +     }
> > +
> > +     return score;
> > +}
> > +
> >  /**
> >   * of_flat_dt_is_compatible - Return true if given node has compat in =
compatible list
> >   * @node: node to test
> >
>
