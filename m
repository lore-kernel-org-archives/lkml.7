Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE46BC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9283F20679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMOs+pdP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfHLOTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:19:46 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45327 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbfHLOTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:19:46 -0400
Received: by mail-ed1-f66.google.com with SMTP id x19so97907678eda.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 07:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iivSnktAPjnlSD94HraPJYOzwcYbsXnIpC6UfUdyt1w=;
        b=fMOs+pdPUCunxL+VlNcjw0inCDUYczP4DNptKnjmA+iIs5iSqH+wFAb8OrnnzW+/WA
         dKDu7dbSukUIPfTFBWJhE/zpPpNi4d/npgGREOyPQobiFFC3IkgFfnIRh5pau+IDtYkB
         zIo9yf9VPrennmv7Um0d2pvSe/Fi9IFiNOn55hi69JQbNsX/Ye5yN7O5CHomfR/atg0U
         jRyjuKUVRfUTjYa79LmeQYD6FjnhXfPmX2Xcpxlgw3b0e21TR6gNCSzw/QzpZLPqoOwE
         b5LuCj6lzisfF7UXyeh8hseX96dcFgAWM/BpeA6nnDEk63beE/fsFT0cKPfX2iq/FsyX
         CGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iivSnktAPjnlSD94HraPJYOzwcYbsXnIpC6UfUdyt1w=;
        b=WOmKFHVxhPWIWDL0ZjGRGW1ct/TpAsYJYbwrhGLanrtloKGF1w0AHcrWr/61apbk3x
         rLs2V0bClhaElsKWIrSrCiua3Ppbt8WXvyLBc/iNTaYR1TczaxKJgYAO8s755QJc87V1
         mLl32Jpyr330z+bb1kk1vAVA7oZKWsNpZUXhSLZDqah2g1RV8lYgVpt8gk3mYpPkzFuG
         pCHbVFpPjQswxM6/PsDw9g+cZyGFU6SBF2dcT2lNmvenDP2bX4r4tEAxYDW2h72nOCKf
         l1oWSWA2lcGd0xN/2b0nljVTDMXamuIrSxU2916h0FlX3tidfTx9fEtpQVid99kx32hr
         RDtg==
X-Gm-Message-State: APjAAAXk/iiPzlGwwhXVYkAVtaUHfz7hYcQOe6l5rNNuXmF0HCvZYmad
        bBVzbITRU4YIirvKYu9fDBk13n+yCLusmZo1V4otlQ==
X-Google-Smtp-Source: APXvYqwQwtRUxyYdAzg6UYSw5I32xydKcD2cfRkVoq9f+wPzG7Wf/Glg+QM3pFBDeHQfTN47bFsy95PkFkLII4ZwZEs=
X-Received: by 2002:a50:b66f:: with SMTP id c44mr36867903ede.171.1565619584492;
 Mon, 12 Aug 2019 07:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190809030352.8387-1-hslester96@gmail.com> <20190809151114.GD3963@sirena.co.uk>
 <CANhBUQ09+q9_=7nMs63w4KRLGOhW1=z-AnuwOzAnUrWRY6uC6A@mail.gmail.com>
 <20190812110719.GE4592@sirena.co.uk> <CANhBUQ2XWAJBgfzbiiffaJ60wnoP__kDPHOF4d+Z_1b1HzSpPQ@mail.gmail.com>
In-Reply-To: <CANhBUQ2XWAJBgfzbiiffaJ60wnoP__kDPHOF4d+Z_1b1HzSpPQ@mail.gmail.com>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Mon, 12 Aug 2019 22:19:33 +0800
Message-ID: <CANhBUQ1QZUU9Fv+usQhUvs4ehy-OTTf2UWRKb333Bsfga=422Q@mail.gmail.com>
Subject: Re: [PATCH] regulator: core: Add devres versions of regulator_enable/disable
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 8:51 PM Chuhong Yuan <hslester96@gmail.com> wrote:
>
> On Mon, Aug 12, 2019 at 7:07 PM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Sat, Aug 10, 2019 at 09:44:45AM +0800, Chuhong Yuan wrote:
> > > On Fri, Aug 9, 2019 at 11:11 PM Mark Brown <broonie@kernel.org> wrote:
> >
> > > > I'm not super keen on managed versions of these functions since they're
> > > > very likely to cause reference counting issues between the probe/remove
> > > > path and the suspend/resume path which aren't obvious from the code, I'm
> > > > especially worried about double frees on release.
> >
> > > I find that 29 of 31 cases I found call regulator_disable() only when encounter
> > > probe failure or in .remove.
> > > So I think the devm versions of regulator_enable/disable() will not cause big
> > > problems.
> >
> > There's way more drivers using regulators than that...
> >
>
> I wrote a new coccinelle script to detect all regulator_disable() in .remove,
> 101 drivers are found in total.
> Within them, 25 drivers cannot benefit from devres version of regulator_enable()
> since they have additional non-devm operations after
> regulator_disable() in .remove.

I find 6 of 25 can benefit from devm_regulator_enable().
They are included in my previously found 147 cases so I incorrectly skipped them
while checking.
Therefore, there are 82 cases that can benefit from devm_regulator_enable() and
66 of them(80.5%) only call regulator_disable() when fail in probe or
in .remove.

> Within the left 76 cases, 60 drivers (79%) only use
> regulator_disable() when encounter
> probe failure or in .remove.
> The left 16 cases mostly use regulator_disable() in _suspend().
> Furthermore, 3 cases of 76 are found to forget to disable regulator
> when fail in probe.
> So I think a devres version of regulator_enable/disable() has more
> benefits than potential
> risk.
>
> > > I even found a driver to forget to disable regulator when encounter
> > > probe failure,
> > > which is drivers/iio/adc/ti-adc128s052.c.
> > > And a devm version of regulator_enable() can prevent such mistakes.
> >
> > Yes, it's useful for that.
