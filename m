Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B6CC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6302173B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563359902;
	bh=EM4gS8mAGQDedVZGGONZaY9+yCWKAtPAjdPsCsgwOjA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GCpKZrpjQTbb+O7i9o2uL2UQGojD7ceIAJbo9I1DM6/fSVqqaoCdBEfzu3TSd6q9E
	 tdK43qYV4jRM+n7f2MIjv2CyZesvS0tSvDDverzmatPTf4cHKPLg3Hnw3ggdCKTBxV
	 t8b+3ebcjNwxrEayZ1RH6j1YjaXyLdyX5vsT5Bw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfGQKiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 06:38:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfGQKiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 06:38:20 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD69D21841;
        Wed, 17 Jul 2019 10:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563359899;
        bh=EM4gS8mAGQDedVZGGONZaY9+yCWKAtPAjdPsCsgwOjA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iRsjFQQrjNmtgbLMWeCNYdP0HGgaJWhgSbmm4IFi1xfBbXDlGPTq0g1IbbV//YZKu
         2b5cV+HpOsyjs4M/rtvOjKCAF7sKti/mkOhI72YCfT6DF9ts21rHt8wmUCeKSISB9X
         mruzAs2Z53mWa/5mlIqXimCpnP8SxfjDE1XfYHiY=
Received: by mail-lf1-f44.google.com with SMTP id 62so11179945lfa.8;
        Wed, 17 Jul 2019 03:38:18 -0700 (PDT)
X-Gm-Message-State: APjAAAUT+Pwyh6lpjziHjZ7JyPOqJ6i/B+nPGMJt2Nv1MAlK3ubxpo3T
        o4afYfBP+WoJAgRe9m7nRcxUHJ7q1aE0M0czKm4=
X-Google-Smtp-Source: APXvYqyz/tFKkDEsgYJcEhlF6kY6XpGjK9nVGrDgAi01UppvCkUTP4w/fba1Vfs3b/0mz9atjli4OodMVqblc2ZpNYI=
X-Received: by 2002:ac2:4d1c:: with SMTP id r28mr16893853lfi.159.1563359896938;
 Wed, 17 Jul 2019 03:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190715124455eucas1p13bfc0c1d113225db9607e4c0dbac353c@eucas1p1.samsung.com>
 <20190715124417.4787-1-l.luba@partner.samsung.com> <20190715124417.4787-27-l.luba@partner.samsung.com>
 <CAJKOXPc3qsM5Xe5JViDZXYfes+_veb-KX3fnZjpkUCrphBcu-Q@mail.gmail.com> <8ed83c77-57f7-78a4-e437-714cfc7b5c58@partner.samsung.com>
In-Reply-To: <8ed83c77-57f7-78a4-e437-714cfc7b5c58@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 17 Jul 2019 12:38:05 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdMUV6JP0R4kj=cFKd7QUdrtMXtSm4S9pfF77zvKu4v1g@mail.gmail.com>
Message-ID: <CAJKOXPdMUV6JP0R4kj=cFKd7QUdrtMXtSm4S9pfF77zvKu4v1g@mail.gmail.com>
Subject: Re: [PATCH v1 26/50] ARM: dts: exynos: align NOC100 bus OPPs in Exynos5420
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com, Andrzej Hajda <a.hajda@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2019 at 12:27, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
>
> On 7/17/19 12:10 PM, Krzysztof Kozlowski wrote:
> > On Mon, 15 Jul 2019 at 14:44, Lukasz Luba <l.luba@partner.samsung.com> wrote:
> >>
> >> The NOC100 has a parent which clock rate is set tot 400MHz. The OPPs which
> >> are not possible to set are removed and new one is added.
> >
> > I think it is just NOC bus... or are there more of such and this is 100 MHz one?
> Yes, there is a bus NOC100 with a dedicated clock tree in the HW (with
> 3 muxes and one divider), which makes possible to take different PLL as
> a source then WCORE have, divide the rate from it and even switch for a
> while to alternative stable PLL (on the 2nd mux to SPLL (after a
> divider)) to wait for main PLL rate change stability delay. Max rate is
> limited to 100MHz for this NOC100 bus.

I think we misunderstood each other. I am saying, that the bus is
called "NOC" in the DTSI. Not NOC100. So unless there are more of
NOCs, stick to existing name NOC, even if it is not the most accurate.

Best regards,
Krzysztof
