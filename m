Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B842C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 19:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019C42168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 19:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e2mpUCC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfJATqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 15:46:50 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40072 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfJATqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 15:46:49 -0400
Received: by mail-io1-f65.google.com with SMTP id h144so51102664iof.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 12:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ezIl2rVOYhRKOvRq4MrUQe29fvd7yUyJUEWRFAhpnt0=;
        b=e2mpUCC48bvayHuosTQRwn76fYaJRvUOiMdLE//GZ8dT7W3TjunXwZ1bpGJGcg4Nki
         5Le+Sqq6KSofb/nxGerlQWa7OxXcinIBxu+woGTI5ta92J0n/h3BcIeJsVXb26h8VHNb
         d6MjUtVvxfat6NPoDde1GqoEmX6dhSvd3ZArM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ezIl2rVOYhRKOvRq4MrUQe29fvd7yUyJUEWRFAhpnt0=;
        b=dSOGGx/duIcJhzGVw9aGC2TFJzge/f25JJuSNDUW4TZEGeCy/MG6pxQMQ3ej0SHYbJ
         CTrGW819symfBqFrITHsqU6CUR3+B1aFGvl+Itpi7pshRcZvuaeVJ+dSdTZ+JpDsJj2l
         8WrXF0JFixHapNEIcWJfu7ymOScQY2X7rq7f4BKg+EiAbtdN0bNCmdJz5pfF5e65CkVp
         OkOpKuIESMqwFfkZF7A8801qr8K30C5l/LzW0N9At3l2QzjcLFI16mKuM9zb23BjRaQE
         tdbXzXT51YG8yeOMA6gRfXq+8tMdCykZuCE+DGNZG1Xf20fFCzsIvhKtxeTLUOS5aZf6
         MMKA==
X-Gm-Message-State: APjAAAV/OaHoTQmLGuNzszlRATMpQdx0pj0tbTTW+BlX5twP2sEDeQj9
        NzyoakySBQ4tXrEfVZeld80LL/kXdCU=
X-Google-Smtp-Source: APXvYqx7193LxpNjOxQWFvvL9AGXJCNgihAh8S2qfpDjED+TeZLvNNdH7el8+oNauKl6xymgXho6UQ==
X-Received: by 2002:a92:451:: with SMTP id 78mr28685917ile.69.1569959208698;
        Tue, 01 Oct 2019 12:46:48 -0700 (PDT)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id 128sm3370788iox.35.2019.10.01.12.46.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2019 12:46:47 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id b136so51161466iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 12:46:47 -0700 (PDT)
X-Received: by 2002:a6b:b213:: with SMTP id b19mr6360479iof.58.1569959207391;
 Tue, 01 Oct 2019 12:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190926124115.1.Ice34ad5970a375c3c03cb15c3859b3ee501561bf@changeid>
 <20191001174104.GD4786@sirena.co.uk>
In-Reply-To: <20191001174104.GD4786@sirena.co.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 1 Oct 2019 12:46:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UE4K8Oj99KA5HNBxX0pXu11bkHjdwcmwwW3Z-+_nDiLA@mail.gmail.com>
Message-ID: <CAD=FV=UE4K8Oj99KA5HNBxX0pXu11bkHjdwcmwwW3Z-+_nDiLA@mail.gmail.com>
Subject: Re: [PATCH] regulator: Document "regulator-boot-on" binding more thoroughly
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        ckeepax@opensource.cirrus.com,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 1, 2019 at 10:41 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Sep 26, 2019 at 12:41:18PM -0700, Douglas Anderson wrote:
>
> > -    description: bootloader/firmware enabled regulator
> > +    description: bootloader/firmware enabled regulator.
> > +      It's expected that this regulator was left on by the bootloader.
> > +      If the bootloader didn't leave it on then OS should turn it on
> > +      at boot but shouldn't prevent it from being turned off later.
>
> This is good...
>
> > +      This property is intended to only be used for regulators where
> > +      Linux cannot read the state of the regulator at bootup.
>
> ...but we shouldn't say "Linux" here since the DT binding is for all
> OSs, not just Linux.  I'd say "software" instead.  Really the
> expectation is that things wouldn't support readback at all, though it's
> possible there's some weird hardware out there that will support
> readback some of the time I guess.

Argh.  I knew not to mention "Linux" and kept it in mind to write the
first part.  ...but then I must have just spaced.  I also removed the
"at bootup" part since it seemed better.

-Doug
