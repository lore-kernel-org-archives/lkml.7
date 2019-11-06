Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037CCC5DF65
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA08C2187F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573051015;
	bh=vlXZpNZoJiZw0moABeBNaD+/PavQRurfOu7gykExpKY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EpvrHGEgMJpi/0EcCgUXZRHH+oM9FMcefbjZog+c6JU5SOCSagEnid1JusXWTV6WX
	 /5T12AaRGLzUlPjxZZowvMobS3gsQMDxhzCFbZTINv0lk6qziCFSqGksfjSQyvLEFx
	 mPG2c/O5/KNe+DsGnkOH9rrAw3A5L/ZYlViJtBNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731994AbfKFOgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 09:36:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:54404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731973AbfKFOgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 09:36:53 -0500
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E6FC222C2;
        Wed,  6 Nov 2019 14:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573051013;
        bh=vlXZpNZoJiZw0moABeBNaD+/PavQRurfOu7gykExpKY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rXLXKG77ox5Exb7OgGuWzYQD0J5wZe5xWO7ETkwRJ2xIvJJyINp+/DaL6OApB5q1n
         UMU5V6hzFG5xbIJRAJtA3J/MdMyejfWPumsFOcwymxnETkNJTAFRBpX9F+rd27rBPh
         CSMfhdfiyd4LIEHgQd5MAZX3TP+eGwFablygUjbs=
Received: by mail-lf1-f41.google.com with SMTP id v8so18186351lfa.12;
        Wed, 06 Nov 2019 06:36:52 -0800 (PST)
X-Gm-Message-State: APjAAAX+wY4j2ybSbcsN+X57bFJh/LLsUTBq1U01z9BZyZVyjYFY/+kP
        C73Pq/SAtECjdB+FCtbJIj4k8nEG8MrxRyDc9d8=
X-Google-Smtp-Source: APXvYqy81A/2+lWcpeO2gkzgbqW8TQsAHsbUEDFF+X+/DsCRQrIr3qeMIW85fIoFrSsx9XX2WotPoKKCooOri+vcmco=
X-Received: by 2002:a19:22d3:: with SMTP id i202mr24254981lfi.69.1573051011148;
 Wed, 06 Nov 2019 06:36:51 -0800 (PST)
MIME-Version: 1.0
References: <20191104013932.22505-1-afaerber@suse.de> <20191104013932.22505-2-afaerber@suse.de>
 <CAL_JsqL3NOstoa5ZY1JE9e3Ay=WTmz153H-KbHErhi-GBX-5GA@mail.gmail.com>
In-Reply-To: <CAL_JsqL3NOstoa5ZY1JE9e3Ay=WTmz153H-KbHErhi-GBX-5GA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 6 Nov 2019 15:36:40 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdiE=L-8ymra=GC22=5QqOpJWW+hWqTUvNmwi5+caOPrA@mail.gmail.com>
Message-ID: <CAJKOXPdiE=L-8ymra=GC22=5QqOpJWW+hWqTUvNmwi5+caOPrA@mail.gmail.com>
Subject: Re: [PATCH 1/7] dt-bindings: gpu: mali-midgard: Tidy up conversion to YAML
To:     Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        linux-realtek-soc@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <mripard@kernel.org>,
        Guillaume Gardet <guillaume.gardet@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2019 at 15:25, Rob Herring <robh@kernel.org> wrote:
>
> On Sun, Nov 3, 2019 at 7:40 PM Andreas F=C3=A4rber <afaerber@suse.de> wro=
te:
> >
> > Instead of grouping alphabetically by third-party vendor, leading to
> > one-element enums, sort by Mali model number, as done for Utgard.
> >
> > This already allows us to de-duplicate two "arm,mali-t760" sections and
> > will make it easier to add new vendor compatibles.
>
> That was the intent. Not sure how I messed that up...
>
> This patch is problematic because there's changes in arm-soc juno/dt
> branch and there's now a patch for exynos5420 (t628). I'd propose I
> apply this such that we don't get a merge conflict with juno/dt and we
> finish resorting after rc1 (or when both branches are in Linus' tree).

After resubmit, you could take the exynos5420 bindings one (and I'll
take the DTS). However the submitter should base then on latest next,
assuming you'll apply this one.

Best regards,
Krzysztof
