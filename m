Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEC3C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED24A2190F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563883609;
	bh=DKrbsHStPDRY+4kxJ4/+/qAdj1UDVR+qwitPFb6G9XQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Cd6hybtvi9vVda8mcUmzXN02Ip9sQPj0FGrWhT71KiwcOJa+SPJ7FYdLLavjGQeEX
	 Sc7jyL1yRiouwfTBJqsoXeXygLCcH5Bo7D7CqAZBmyYQdnnUV7YXAJWxKWrtRos/we
	 w/d0FaenCnK14xfYd0gyAFfOY0HRluP2BX93Kr08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389361AbfGWMGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 08:06:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbfGWMGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 08:06:47 -0400
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D7942238E;
        Tue, 23 Jul 2019 12:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563883606;
        bh=DKrbsHStPDRY+4kxJ4/+/qAdj1UDVR+qwitPFb6G9XQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ts2zKnryAHCcWuV+jQCtZ1fXUaMYtk/rse8t/JdjssvTDla0eLrQ7l7Fy7A91meAb
         4dq5/+DeF78UIQcOHR3q6qljcYC+4rwJc2IGbOzlxegYgRIX8xVXiAozEtcohEjzSQ
         NgbJODdAIYTnBIHU6w/0RraMEYcpUUjG5MLfKfAY=
Received: by mail-lf1-f51.google.com with SMTP id u10so29137682lfm.12;
        Tue, 23 Jul 2019 05:06:45 -0700 (PDT)
X-Gm-Message-State: APjAAAVbVfIZ0hJpoM11wp+xUFDO6jte7b6wvxP//so07W6yI3b3LePa
        W7ZgxVpX8sLzxA1KJppeia6ej+kioGvRjjEoxWQ=
X-Google-Smtp-Source: APXvYqw0eaw2TRxK/9H3Y8sqHS2pEMb0cITDxk01/sRGaTfe105d+yhQepbEgz1kqWQFScY4g8NDo+cJjofy04prss4=
X-Received: by 2002:a19:f007:: with SMTP id p7mr34881578lfc.24.1563883603819;
 Tue, 23 Jul 2019 05:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190715124504eucas1p1afe0da2c6ac3a8b45d85017a77ba9edf@eucas1p1.samsung.com>
 <20190715124417.4787-1-l.luba@partner.samsung.com> <20190715124417.4787-38-l.luba@partner.samsung.com>
 <CAJKOXPfrGgAczQ-=1aE453RpJ9BN10ZDmFcrEMPkNyF6GcGtNA@mail.gmail.com>
 <2fe2e840-f4b2-773b-7d92-4ffb8502d4e6@partner.samsung.com>
 <CAJKOXPd3gm7no-0TnPmgFg+X3FgdiM6ov5rtzFSM6hKEdEzRCg@mail.gmail.com>
 <518c26ca-4254-056c-d6d0-ae1b4b63709c@partner.samsung.com>
 <CAJKOXPfDX06s7eMctbnPabxho2EaWcTM4xAGKCd_+O6jCCDcRQ@mail.gmail.com> <7ad899c5-347d-546e-a2e9-d96f0203210c@partner.samsung.com>
In-Reply-To: <7ad899c5-347d-546e-a2e9-d96f0203210c@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 23 Jul 2019 14:06:32 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdC7U64dqFJzJNJJXPQ8_K_SXUOVrNGjOQqcDyNsmskwA@mail.gmail.com>
Message-ID: <CAJKOXPdC7U64dqFJzJNJJXPQ8_K_SXUOVrNGjOQqcDyNsmskwA@mail.gmail.com>
Subject: Re: [PATCH v1 37/50] ARM: dts: exynos: change parent and rate of
 bus_fsys in Exynos5422
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

On Wed, 17 Jul 2019 at 14:56, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
>
> On 7/17/19 1:11 PM, Krzysztof Kozlowski wrote:
> > On Wed, 17 Jul 2019 at 13:06, Lukasz Luba <l.luba@partner.samsung.com> wrote:
> >>
> >>
> >>
> >> On 7/17/19 12:45 PM, Krzysztof Kozlowski wrote:
> >>> On Wed, 17 Jul 2019 at 12:39, Lukasz Luba <l.luba@partner.samsung.com> wrote:
> >>>>>>
> >>>>>>     &bus_fsys {
> >>>>>>            devfreq = <&bus_wcore>;
> >>>>>> +       assigned-clocks = <&clock CLK_MOUT_ACLK200_FSYS>,
> >>>>>> +                         <&clock CLK_DOUT_ACLK200_FSYS>,
> >>>>>> +                         <&clock CLK_FOUT_DPLL>;
> >>>>>> +       assigned-clock-parents = <&clock CLK_MOUT_SCLK_DPLL>;
> >>>>>> +       assigned-clock-rates = <0>, <240000000>,<1200000000>;
> >>>>>
> >>>>> Here and in all other patches:
> >>>>> I am not entirely sure that this should be here. It looks like
> >>>>> property of the SoC. Do we expect that buses will be configured to
> >>>>> different clock rates between different boards?
> This is the board file for Exynos5420/5422/5800 which enables buses.
> Thus, I have change them here. Patch 49/50 adds these buses to
> Exynos5800 (Peach Pi). In Exynos5420 there is no clock tree for
> bus_isp266. The parents for different devices could be also different.
> It is because i.e. in 5420 there is 2 bit in the WCORE 1st mux while in
> 5422 there is 3 bits (6 parents possible).
> That's why I have picked exynos5422-odroid-core.dtsi to reference
> the bus devices and pinned them into proper parent and changed rate.
> When you check patch 49/50 for 5800 not all the parents are the same.
>
> (1) I could create a dedicated files like: exynos5422-bus.dtsi,
> exynos5420-bus.dtsi, exynos5800-bus.dtsi which would include some
> base file with the basic &bus_X and set the right parent, rate.
> Then these files would be included into proper board file like:
> exynos5800-peach-pi.dts.
> Is this something that you would like to see?

I see now. Are there any differences in all these properties between
Peach Pi and Odroids? Both of them are using exynos5800.dtsi so that
could be a place for all clock assignments.

Best regards,
Krzysztof
