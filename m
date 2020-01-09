Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478DAC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6F220661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578589006;
	bh=9oyg27saFaqgN0kNufIh+bWG6/4Iwy6kaQ1n0BzczVk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kF1ggJur97vAs7R/rp4kelVLJUqOFmZpa5qmIiKqTrjgCFtJwRtQ8tkWVoNi8cpRm
	 eUJ2soLQSLS8A6d3mcXQqPbp3FXOET/lmOErxswtxDW72kQBHcBUczpBRXRvsLk5cE
	 lSjcn8V96X3hpin+NzLluy/4XE4Ucl5vxy8LRJ7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387939AbgAIQ4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:56:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731320AbgAIQ4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:56:43 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C9EA2075D;
        Thu,  9 Jan 2020 16:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578589002;
        bh=9oyg27saFaqgN0kNufIh+bWG6/4Iwy6kaQ1n0BzczVk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2CosUSQhDeszdClob89wkM5qUuLn+NGmxavbwwJtOjFrz9J9rb5rJcMgFQI1xDAQ4
         fUXa0Ef1aePHujZvmpoUW/06Em/BF7VVOjDi5q5fkKIAJuUjWK6nHJS6vh0B+JXDfJ
         atgBkzj5WtLXXdJkwB2Qpsf8KlWlFaaxn/mc4FF0=
Received: by mail-qk1-f178.google.com with SMTP id r14so6552712qke.13;
        Thu, 09 Jan 2020 08:56:42 -0800 (PST)
X-Gm-Message-State: APjAAAWloDLS5fQEZE4v7aOsCtA5Rup0GXo5SQg8RtAKLM93Amf5aA4m
        vCrzxnTi1CKTJIrJyR7rKHx71dJPQ1VRecow0A==
X-Google-Smtp-Source: APXvYqwejonPhLn1c6g5UIO7dw/MXR05QYRJuuZwXtZ9dn62B4O5MWFoIh0m1SoNLfPeYaTMJ9QV835I1LSeJT6q4Lo=
X-Received: by 2002:a05:620a:1eb:: with SMTP id x11mr10791122qkn.254.1578589001636;
 Thu, 09 Jan 2020 08:56:41 -0800 (PST)
MIME-Version: 1.0
References: <20200108052337.65916-1-drinkcat@chromium.org> <20200108052337.65916-5-drinkcat@chromium.org>
 <20200108132302.GA3817@sirena.org.uk> <CANMq1KBo8ND+YDHaCw3yZZ0RUr69-NSUcVbqu38DuZvHUB-LFw@mail.gmail.com>
In-Reply-To: <CANMq1KBo8ND+YDHaCw3yZZ0RUr69-NSUcVbqu38DuZvHUB-LFw@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 9 Jan 2020 10:56:29 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKvNBCVkiE4zKn0aXdrV4Ncx2bB6+KRpM+aPpMVzS4XbQ@mail.gmail.com>
Message-ID: <CAL_JsqKvNBCVkiE4zKn0aXdrV4Ncx2bB6+KRpM+aPpMVzS4XbQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] drm/panfrost: Add support for a second regulator
 for the GPU
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 4:52 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> On Wed, Jan 8, 2020 at 9:23 PM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Wed, Jan 08, 2020 at 01:23:34PM +0800, Nicolas Boichat wrote:
> >
> > > Some GPUs, namely, the bifrost/g72 part on MT8183, have a second
> > > regulator for their SRAM, let's add support for that.
> >
> > > +     pfdev->regulator_sram = devm_regulator_get_optional(pfdev->dev, "sram");
> > > +     if (IS_ERR(pfdev->regulator_sram)) {
> >
> > This supply is required for the devices that need it so I'd therefore
> > expect the driver to request the supply non-optionally based on the
> > compatible string rather than just hoping that a missing regulator isn't
> > important.
>
> That'd be a bit awkward to match, though... Currently all bifrost
> share the same compatible "arm,mali-bifrost", and it'd seem
> weird/wrong to match "mediatek,mt8183-mali" in this driver? I have no
> idea if any other Mali implementation will require a second regulator,
> but with the MT8183 we do need it, see below.

The current number of supported bifrost platforms is 0. It's only a
matter of time until SoC specific compatibles need to be used in the
driver. This is why we require them.

It could very well be that all bifrost implementations need 2
supplies. On chip RAMs are very frequently a separate thing which are
synthesized differently from logic. At least within a specific IP
model, I somewhat doubt there's a variable number of supplies. It
could be possible to connect both to the same supply, but the correct
way to handle that is both -supply properties point to the same
regulator.

Rob
