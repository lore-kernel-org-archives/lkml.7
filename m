Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1779C7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81989218B8
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563883710;
	bh=nvBvzlCDrlw2nSkRwm+jqQZNCkb/0yrq0/hoIvGnykI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xe4BGJASSgLWNqcP0ycgjsyft0ThxJwy58ap3uRm6Msi/WssXaH1FPxS3IuJ+AWkn
	 8FQKFdEra2sifV9iCav3zWR92+d3HScj9jUN+d+PRitwEYeh1rtue1YlXtI08IlGQG
	 1/aD8+Uv/+PcuHyhycFsCsRKo7AXvavvjKDzMFFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389533AbfGWMI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 08:08:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387777AbfGWMI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 08:08:29 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D31B8223A2;
        Tue, 23 Jul 2019 12:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563883708;
        bh=nvBvzlCDrlw2nSkRwm+jqQZNCkb/0yrq0/hoIvGnykI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aw9YjpykC6CX2ocx7SES+UzwAHiNG+Ib9CZMBVPyP9nlsZbhnpBNtUhZEcT9KVGLH
         NzQklg+qHhvhOmQ5lthnaX0c2YJgxon1P0NX6okYPwtGPgTOSSLylAGYVQpCHkA3vD
         BB6l0JfAHHCHA06bXJiSGX8wxB+5+WuAN8fnslyo=
Received: by mail-lf1-f47.google.com with SMTP id v85so29136006lfa.6;
        Tue, 23 Jul 2019 05:08:27 -0700 (PDT)
X-Gm-Message-State: APjAAAUGW/TvyI9lcnEVAFCfAgGkAx5YzJaiW/rwXxBsn3u9cD26AG3N
        C0/E/DpSBWnEik+A+IsTJy6VtfB4HjQg1wn90vA=
X-Google-Smtp-Source: APXvYqw13qDeDRLye0Xy8u0GjyA8nlXejZvwnJiEBw7A7WJmtQt6RJeCPKPpMebsqdZgD8QGynWSPGSgTW6n8UtRsn8=
X-Received: by 2002:a19:f007:: with SMTP id p7mr34885531lfc.24.1563883705950;
 Tue, 23 Jul 2019 05:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190715124456eucas1p2acf15d00e3fa7b77fe3a2b10ce1ab74f@eucas1p2.samsung.com>
 <20190715124417.4787-1-l.luba@partner.samsung.com> <20190715124417.4787-28-l.luba@partner.samsung.com>
 <CAJKOXPfFZL8q9hM1vPsLq+Qxe-gMz4c8j0jgFKfdf5qs68MTmA@mail.gmail.com> <15310bd0-0fd4-8d62-82a9-7a9df6a8ced3@partner.samsung.com>
In-Reply-To: <15310bd0-0fd4-8d62-82a9-7a9df6a8ced3@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 23 Jul 2019 14:08:14 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdoun-2ankrcNzC70tXZi40iONxM3yPstdaiGBMPDjyRQ@mail.gmail.com>
Message-ID: <CAJKOXPdoun-2ankrcNzC70tXZi40iONxM3yPstdaiGBMPDjyRQ@mail.gmail.com>
Subject: Re: [PATCH v1 27/50] ARM: dts: exynos: align bus_wcore OPPs in Exynos5420
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

On Wed, 17 Jul 2019 at 18:58, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Hi Krzysztof,
>
> On 7/17/19 12:15 PM, Krzysztof Kozlowski wrote:
> > On Mon, 15 Jul 2019 at 14:44, Lukasz Luba <l.luba@partner.samsung.com> wrote:
> >>
> >> This is the most important bus in the Exynos5x SoC. The whole communication
> >> inside SoC does through that bus (apart from direct requests from CCI to
> >> DRAM controller). It is also modeled as a master bus in devfreq framework.
> >> It is also the only one OPP table throughout other buses which has voltage
> >> values. The devfreq software controls the speed of that bus and other
> >> buses. The other buses follows the rate of the master. There is only one
> >> regulator. The old lowest OPP had pair 925mV, 84MHz which is enough for
> >
> > s/lowest/slowest/
> please see below
> >
> >> this frequency. However, due to the fact that the other buses follows the
> >> WCORE bus by taking the OPP from their table with the same id, e.g. opp02,
> >> the children frequency should be stable with the set voltage.
> >> It could cause random faults very hard to debug.
> >> Thus, the patch removes the lowest OPP to make other buses' lowest OPPs
> >
> > s/lowest/slowest/
> Actually, I have double checked that, because we always used this
> terminology: low OPP, high OPP, lower OPPs, higher OPPs. I can change
> it here for you, but I think this is not something that people are used
> to. Please check EAS pdf documentation or this file:
> https://www.kernel.org/doc/Documentation/scheduler/sched-energy.txt
> i.e. "running at a lower OPP" or "high OPPs", "lowest OPPs".

Hmm, indeed, you're right. Don't change it then.

Best regards,
Krzysztof
