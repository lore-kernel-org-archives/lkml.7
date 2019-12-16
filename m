Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8194CC2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5640E206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F98ofzZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfLPKbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:31:01 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40059 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfLPKbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:31:00 -0500
Received: by mail-lj1-f194.google.com with SMTP id s22so6195132ljs.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 02:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R2CAqD7yphVxKpqpK+F/eAr7MRlAfENWVqw0CFqAnoY=;
        b=F98ofzZswi1ON1bAKTPSWd5+Icm6mrMRcWlGoNTeahpUdZxvSM6qFcZqGN4zAN4Osp
         NdlLEy7XHE0zbPmUPi2zZq5/U5/a9Ue2B+XfIh+EluUE+NoHaOMSjoxvxpExuwNfwwOs
         2oTEoPYR/rTYGmGXHzgc0Pr/FAj3QmcuhcAhTsRGt6RmxDIqCHgnOQMkUTOAHb4I3u1R
         m/2YQVrcDL+DR1UUH/SkmD8dEzpXTM4KzvF07eOk6LXi/nqEznJiz6kcl0yeiO3Lfg0O
         dcea358D79Zrq3wRs5ExA4+mnB0OVo8ZagEMOi3YmF/JKgrNYhNQ40lRqBXcsKfb/BZy
         RfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R2CAqD7yphVxKpqpK+F/eAr7MRlAfENWVqw0CFqAnoY=;
        b=A1/P7UQN4jw1RbSsnkUSiOBv4BmIeFz2OIGSZspTVkEQtUd01SCrTHnDpH7yv3U57T
         ayYgmsbrLKcAhIRKDLOsmE8fOgNrBTvDNzZHTDz41hvxCNNueROvRAifaZsvMUcglHhQ
         qjTmO3J1cH9+Leaa6DiEHX4P80i/DTNgMHfPbn0S7/YLQ8nvP2fVnIeKV1BtzVL/4wws
         fsOSNxl6uNNNWMi5X4bPzuqhuajygO6rrVK8y0rV0q0LVBGA4L+3D10P34WUIQBoXNWg
         17/nhsO3ywxyrxcE3TUVWh1GsgdW5SbA+dA2iWRQSUa3DNcHmN29dCjs5/hXkbongeD+
         O/pA==
X-Gm-Message-State: APjAAAVVbvL4XuuoysIKLYuDSvdxcb7ZQZdkiaAWH7GwFpVrZuZZPatV
        tRqo0BkxYv3onryWeT3nhmCyif3z634t2tj/bKoazA==
X-Google-Smtp-Source: APXvYqycu9hlE1s4S+Sge2Bqv8D+k87tga/cDOXtTcuobEYzip+IsUlyb9ENhVmckOFQwM0Ke6RmQOIym8zJ1np0yPg=
X-Received: by 2002:a05:651c:1049:: with SMTP id x9mr18594833ljm.233.1576492258842;
 Mon, 16 Dec 2019 02:30:58 -0800 (PST)
MIME-Version: 1.0
References: <20191215163810.52356-1-hdegoede@redhat.com> <20191215163810.52356-5-hdegoede@redhat.com>
In-Reply-To: <20191215163810.52356-5-hdegoede@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Dec 2019 11:30:46 +0100
Message-ID: <CACRpkdYLXU9SmrNZfk9vrJuai9O-evAoq_c1oPJ7Q=NQU8=gng@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/i915/dsi: Move Crystal Cove PMIC panel GPIO
 lookup from mfd to the i915 driver
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2019 at 5:38 PM Hans de Goede <hdegoede@redhat.com> wrote:

> Move the Crystal Cove PMIC panel GPIO lookup-table from
> drivers/mfd/intel_soc_pmic_core.c to the i915 driver.
>
> The moved looked-up table is adding a GPIO lookup to the i915 PCI
> device and the GPIO subsys allows only one lookup table per device,
>
> The intel_soc_pmic_core.c code only adds lookup-table entries for the
> PMIC panel GPIO (as it deals only with the PMIC), but we also need to be
> able to access some GPIOs on the SoC itself, which requires entries for
> these GPIOs in the lookup-table.
>
> Since the lookup-table is attached to the i915 PCI device it really
> should be part of the i915 driver, this will also allow us to extend
> it with GPIOs from other sources when necessary.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Looks OK to me
Acked-by: Linus Walleij <linus.walleij@linaro.org>

But Lee & Andy should have a final word on this.

Yours,
Linus Walleij
