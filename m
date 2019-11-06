Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD49C5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D17321848
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573054467;
	bh=7o0q1tVU34dCkR+noOARbHQNLo/UWxe38206TY8hDCQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bZSDp3Ua/bjbNAdK92hJDzLhefB7gwBX5AbYg3YHPy28VZr5sZTYA/AkzgIE+PIrb
	 D/3EL7zfU6AXzBKT2UUIxWZ4HD557fM80ls8omkVeRQ5ikkT3LVzlXIDDS2PQ4Wot5
	 ztmI36GORsmpy7tYqZYtqof5XAU3LykbDuI018hY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfKFPe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 10:34:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:50270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbfKFPeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 10:34:25 -0500
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E015921A49;
        Wed,  6 Nov 2019 15:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573054465;
        bh=7o0q1tVU34dCkR+noOARbHQNLo/UWxe38206TY8hDCQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CoUNr07iSKhqHPQYnHgovAiFPeBTlPbuKlIlyB1ltw17DY4h0GUk69z0sH9UCrkwg
         QjSAKTQgidRAO2Sn0st+dAqdeImPVslmG40Ug8tl5jdYPapSS3OLGYLaJqd3ZYOxMC
         e/fp5kQL9QBc0OXKGEMS4kFmWLHFdgdIF/OprUEE=
Received: by mail-qk1-f170.google.com with SMTP id e2so24953116qkn.5;
        Wed, 06 Nov 2019 07:34:24 -0800 (PST)
X-Gm-Message-State: APjAAAVB9vnGV3OsvLRQXWiJO2D07XHmd++EANURsPQTDuRQ/V44P77e
        kEqvXKJ8dMCOEERfvE/iU0Vv4WGHSNYONgN2aQ==
X-Google-Smtp-Source: APXvYqw9sZsv2T4oRf/Kp1rPs5zLb4jFoqRUQy1D9khdGgEpEV2otZx+yv/nP+agw/RJymCxuNf+KXq8PP0l1j+ppZs=
X-Received: by 2002:a05:620a:226:: with SMTP id u6mr2467840qkm.393.1573054464031;
 Wed, 06 Nov 2019 07:34:24 -0800 (PST)
MIME-Version: 1.0
References: <20191104013932.22505-1-afaerber@suse.de> <20191104013932.22505-2-afaerber@suse.de>
 <CAL_JsqL3NOstoa5ZY1JE9e3Ay=WTmz153H-KbHErhi-GBX-5GA@mail.gmail.com> <82d17114302562e0c553e2ea936974f77734e86b.camel@suse.de>
In-Reply-To: <82d17114302562e0c553e2ea936974f77734e86b.camel@suse.de>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 6 Nov 2019 09:34:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLDFefWVdiPuAktctuBpBeOvG-OVhX2aZn=UaiN55nodg@mail.gmail.com>
Message-ID: <CAL_JsqLDFefWVdiPuAktctuBpBeOvG-OVhX2aZn=UaiN55nodg@mail.gmail.com>
Subject: Re: [PATCH 1/7] dt-bindings: gpu: mali-midgard: Tidy up conversion to YAML
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org,
        LAKML <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <mripard@kernel.org>,
        Guillaume Gardet <guillaume.gardet@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 9:07 AM Andreas F=C3=A4rber <afaerber@suse.de> wrote=
:
>
> Am Mittwoch, den 06.11.2019, 08:24 -0600 schrieb Rob Herring:
> > On Sun, Nov 3, 2019 at 7:40 PM Andreas F=C3=A4rber <afaerber@suse.de>
> > wrote:
> > > Instead of grouping alphabetically by third-party vendor, leading
> > > to
> > > one-element enums, sort by Mali model number, as done for Utgard.
> > >
> > > This already allows us to de-duplicate two "arm,mali-t760" sections
> > > and
> > > will make it easier to add new vendor compatibles.
> >
> > That was the intent. Not sure how I messed that up...
> >
> > This patch is problematic because there's changes in arm-soc juno/dt
> > branch and there's now a patch for exynos5420 (t628). I'd propose I
> > apply this such that we don't get a merge conflict with juno/dt and
> > we
> > finish resorting after rc1 (or when both branches are in Linus'
> > tree).
>
> This series has dependencies for the Realtek-side RFC patches and is
> not yet ready to merge, so you can take this prep PATCH through your
> tree for v5.6 probably, or feel free to rebase/rework as you see fit -
> I'd just appreciate being credited at least via Reported-by. :)

I was assuming the non-RFC patches are good to go, so I was going to
pick up 1, 2, and 7.

Rob
