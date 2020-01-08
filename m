Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A32C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 22:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9371206DA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 22:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XY5GOnFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgAHWwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 17:52:45 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39330 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbgAHWwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 17:52:44 -0500
Received: by mail-qk1-f193.google.com with SMTP id c16so4273486qko.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 14:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bQ8sePp1UB/buB3CQpsdDQjSw45clnU/8Z5dyE7MCUQ=;
        b=XY5GOnFn0zgYevPRNgkVz3RQithuZHY98uxSsiNEuf6vWLkXUGm9VbUWdjyqnbrO0p
         hSlRJ/xH3cUk/dTtQws1Y2BllgiV24bBnUj3yqD6jDFghwhecYRGqhwHtvzQlLjYIres
         pmL7s49IWRxqVAkNWYGTMoSy/oHAsP79XvpSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bQ8sePp1UB/buB3CQpsdDQjSw45clnU/8Z5dyE7MCUQ=;
        b=YdN0xLt6rc7qHfpI+W13AfxRCp60CcSLMb9Jny0Usep5ytktqTccI4emFun5qJdPVp
         8dDs0zRjktL/bjAz4Myjs0jBo0K3mq4XJO5J2HNjqccDgs/Dkg7Mvg06FKF8xtUsKVZd
         K/SBtv6KZIlloWS81UcimIqIkfOGQA4I9rlPziRg/4m1LZR+GxPCL53tjILF6xngPLQD
         WRr2LZbhVZPL7zApDzikHfWRG4d8bux2RSsKrD0Z5fOav9kXbl3xEl9hA5ACspDP+KPD
         TiX+yBR3pTHgx7YiVolZar0E4ytKY6N67wLQB5l3fYxFISgcUlCr8M7iguCMvkLgZQYq
         oTDA==
X-Gm-Message-State: APjAAAXzdYscU9K1Sj0C8lmMHkYJceVmzetvAzaqsBcBtJbpblKThHou
        NaFfKCz6+1rJZ5LjttkHkLfztMwKp0JGdjRYMJS7Gw==
X-Google-Smtp-Source: APXvYqw2JjwDeqMh2CT5SlyR30QLXuZPvZ+1N9eFdrRhTkkWcwjICSQnRUvYtFyz4OeBrSGR4GBFkA8sANeEtDRg/YU=
X-Received: by 2002:a37:6551:: with SMTP id z78mr7090523qkb.144.1578523963679;
 Wed, 08 Jan 2020 14:52:43 -0800 (PST)
MIME-Version: 1.0
References: <20200108052337.65916-1-drinkcat@chromium.org> <20200108052337.65916-5-drinkcat@chromium.org>
 <20200108132302.GA3817@sirena.org.uk>
In-Reply-To: <20200108132302.GA3817@sirena.org.uk>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 9 Jan 2020 06:52:32 +0800
Message-ID: <CANMq1KBo8ND+YDHaCw3yZZ0RUr69-NSUcVbqu38DuZvHUB-LFw@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] drm/panfrost: Add support for a second regulator
 for the GPU
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        dri-devel@lists.freedesktop.org,
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

On Wed, Jan 8, 2020 at 9:23 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Jan 08, 2020 at 01:23:34PM +0800, Nicolas Boichat wrote:
>
> > Some GPUs, namely, the bifrost/g72 part on MT8183, have a second
> > regulator for their SRAM, let's add support for that.
>
> > +     pfdev->regulator_sram = devm_regulator_get_optional(pfdev->dev, "sram");
> > +     if (IS_ERR(pfdev->regulator_sram)) {
>
> This supply is required for the devices that need it so I'd therefore
> expect the driver to request the supply non-optionally based on the
> compatible string rather than just hoping that a missing regulator isn't
> important.

That'd be a bit awkward to match, though... Currently all bifrost
share the same compatible "arm,mali-bifrost", and it'd seem
weird/wrong to match "mediatek,mt8183-mali" in this driver? I have no
idea if any other Mali implementation will require a second regulator,
but with the MT8183 we do need it, see below.

> Though I do have to wonder given the lack of any active
> management of the supply if this is *really* part of the GPU or if it's
> more of a SoC thing, it's not clear what exactly adding this code is
> achieving.

Well if devfreq was working (see patch 7
https://patchwork.kernel.org/patch/11322851/ for a partial
implementation), it would adjust both mali and sram regulators, see
the OPP table in patch 2
(https://patchwork.kernel.org/patch/11322825/): SRAM voltage needs to
be increased for frequencies >=698Mhz.

Now if you have some better idea how to implement this, I'm all ears!

Thanks.
