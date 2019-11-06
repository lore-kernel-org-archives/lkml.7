Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8BAC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6A22173E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573050315;
	bh=t22la/XtVNC5KQNqEOFeF0+C1rhKgq+qOSEIqpk5BHA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=u75Cq+Di0zz7H2lRmpi9EBdi0Tx0CKeqZxIBvdEb/42r1tNwodaDo5+jR+n3zmRDj
	 5bRdIxl4+lNjTSwEsq19nR1PjWv8wDmx62AjgCAXGPF5B1eTm2GfsoDA7jGjQZcDDA
	 MOkJCM0GIxEh13TP/kNHFNlE2J7K7mq236vpkahA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731996AbfKFOZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 09:25:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:46956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728462AbfKFOZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 09:25:13 -0500
Received: from mail-yw1-f41.google.com (mail-yw1-f41.google.com [209.85.161.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AC1F222C4;
        Wed,  6 Nov 2019 14:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573050312;
        bh=t22la/XtVNC5KQNqEOFeF0+C1rhKgq+qOSEIqpk5BHA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yMmYaPKVAuHLBJl+V9hcNV4Bdja+di11oystN/HBPVsX2VVth4PM3toVOn3T+5Qni
         TNMuQFXL7UMzuqxylzuRIkofuibnjKujINuB5rcGtAkWzBr8zJ8hSJ0e9o0f07cOIC
         XQl+cC7bfJ3KBwLkY7NAaB/tlddnnXmckFIrCegQ=
Received: by mail-yw1-f41.google.com with SMTP id s6so9622420ywe.5;
        Wed, 06 Nov 2019 06:25:12 -0800 (PST)
X-Gm-Message-State: APjAAAU4xJOAQS8AkXSk2j+4ATnQ35kgOwsm3VxxIX1WMR7/t+sc9BbK
        m5hS9M3jJwKbh92dk9O2A0Nnjhvgt8+6WCBbNw==
X-Google-Smtp-Source: APXvYqzZFcvicyLbyVKKqZBBg3KUfyX6DrTKhbmcP3UuFixdP0C+dSzUm2vlJQ+TJwMuEZWoGfVcj47a+BgKJoaNCRQ=
X-Received: by 2002:a81:a196:: with SMTP id y144mr1774534ywg.507.1573050311255;
 Wed, 06 Nov 2019 06:25:11 -0800 (PST)
MIME-Version: 1.0
References: <20191104013932.22505-1-afaerber@suse.de> <20191104013932.22505-2-afaerber@suse.de>
In-Reply-To: <20191104013932.22505-2-afaerber@suse.de>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 6 Nov 2019 08:24:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL3NOstoa5ZY1JE9e3Ay=WTmz153H-KbHErhi-GBX-5GA@mail.gmail.com>
Message-ID: <CAL_JsqL3NOstoa5ZY1JE9e3Ay=WTmz153H-KbHErhi-GBX-5GA@mail.gmail.com>
Subject: Re: [PATCH 1/7] dt-bindings: gpu: mali-midgard: Tidy up conversion to YAML
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org,
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
        Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 3, 2019 at 7:40 PM Andreas F=C3=A4rber <afaerber@suse.de> wrote=
:
>
> Instead of grouping alphabetically by third-party vendor, leading to
> one-element enums, sort by Mali model number, as done for Utgard.
>
> This already allows us to de-duplicate two "arm,mali-t760" sections and
> will make it easier to add new vendor compatibles.

That was the intent. Not sure how I messed that up...

This patch is problematic because there's changes in arm-soc juno/dt
branch and there's now a patch for exynos5420 (t628). I'd propose I
apply this such that we don't get a merge conflict with juno/dt and we
finish resorting after rc1 (or when both branches are in Linus' tree).

Rob
