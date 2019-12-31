Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C734C2D0DC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 10:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0A82080A
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 10:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577786561;
	bh=L6pbf2QruXo+8gbqw74AACciyQXWx0N8dseV6On/A8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wIORTf581NxninsjA/X3rTKKikGu6FSVuwwwo0G28C2CvgXt4b0NZp83tvc5rTFOa
	 ZIFwvldvHYk2WAYsShUU/dlFBSNGcdixPrPWc2+Fxrcw26EhYRYhHCN4Bi9Psy/LJL
	 l5MXVCIp9bPiG273L3fxVqbwAyjp5duURiTxQIo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfLaKCk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 05:02:40 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38192 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfLaKCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 05:02:40 -0500
Received: by mail-ed1-f66.google.com with SMTP id i16so34897737edr.5;
        Tue, 31 Dec 2019 02:02:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IZNO2B93r2pFFlnRWI7aH+tyFL6pJezUFxkzlZmNo64=;
        b=F7rCyWMz/QJpWXueGCerSTIZYoI+6zH1picD+idniE2eHcAryZeta2MqmmKXPsi4/x
         eFS+FHqiFQeBqOOWPTShNye3629uH413CabsFUP4LLmaISMbfWZXVnmykfiFg5+zkcW/
         BCdqgRN1oTaOjBGEwOX09BwojbwnZwtF8B0myt20zSuioNtGGFTZT/NQrGfYhPUMs/hg
         0rHUYFzhv+MZs9oz+KiPoIF2yFyMokKfLTON4EMQ5c+oHwv3hMMfcQKOFJ70+ERcPpWp
         lm+1igXaSqSmUuHTcV/avqCnZdPUTq3PxWsXM4Nx2YU1j30Nym7WLn0BWfbue4nugXNB
         JMeg==
X-Gm-Message-State: APjAAAWRrlKHqJflX0WQTzmVb95pcwqBJQfXAXDJXbnlOaGpIJ4a+9gS
        666EfENP9j451j6pLUM+/HE=
X-Google-Smtp-Source: APXvYqxFwi68FxTrovhQw9UWqT1zbwtC7DLhd+1ydbZmMVil9u27U+QxKMg991OwmjSp7qoqklGktw==
X-Received: by 2002:a50:a7a5:: with SMTP id i34mr74736915edc.128.1577786557398;
        Tue, 31 Dec 2019 02:02:37 -0800 (PST)
Received: from pi3 ([194.230.155.138])
        by smtp.googlemail.com with ESMTPSA id dd17sm5908761edb.9.2019.12.31.02.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 02:02:36 -0800 (PST)
Date:   Tue, 31 Dec 2019 11:02:34 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, leonard.crestez@nxp.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [RFC PATCH v3 4/7] arm: dts: exynos: Add interconnect bindings
 for Exynos4412
Message-ID: <20191231100234.GA7024@pi3>
References: <20191220115653.6487-1-a.swigon@samsung.com>
 <CGME20191220120144eucas1p119ececf161a6d45a6a194e432bbbd1f9@eucas1p1.samsung.com>
 <20191220115653.6487-5-a.swigon@samsung.com>
 <20191230154405.GC4918@pi3>
 <2922135223b01126277ef92a53e6b294bc17bb5c.camel@samsung.com>
 <20191231092254.GA6939@pi3>
 <99427c18b1fcca3bc21e69609500abdbbef59167.camel@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <99427c18b1fcca3bc21e69609500abdbbef59167.camel@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 10:41:47AM +0100, Artur Świgoń wrote:
> On Tue, 2019-12-31 at 10:22 +0100, Krzysztof Kozlowski wrote:
> > On Tue, Dec 31, 2019 at 08:18:01AM +0100, Artur Świgoń wrote:
> > > Hi,
> > > 
> > > On Mon, 2019-12-30 at 16:44 +0100, Krzysztof Kozlowski wrote:
> > > > On Fri, Dec 20, 2019 at 12:56:50PM +0100, Artur Świgoń wrote:
> > > > > This patch adds the following properties to the Exynos4412 DT:
> > > > >   - exynos,interconnect-parent-node: to declare connections between
> > > > >     nodes in order to guarantee PM QoS requirements between nodes;
> > > > >   - #interconnect-cells: required by the interconnect framework.
> > > > > 
> > > > > Note that #interconnect-cells is always zero and node IDs are not
> > > > > hardcoded anywhere.
> > > > > 
> > > > > Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> > > > > ---
> > > > >  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 5 +++++
> > > > >  1 file changed, 5 insertions(+)
> > > > 
> > > > The order of patches is confusing. Patches 4 and 6 are split - do the
> > > > depend on 5? I doubt but...
> > > 
> > > Let me elaborate:
> > > 
> > > The order of the patches in this series is such that every subsequent
> > > patch adds some functionality (and, of course, applying patches one-by-one
> > > yields a working kernel at every step). Specifically for patches 04--07:
> > > 
> > >  -- patch 04 adds interconnect _provider_ properties for Exynos4412;
> > >  -- patch 05 implements interconnect provider logic (depends on patch 04);
> > >  -- patch 06 adds interconnect _consumer_ properties for Exynos4412 mixer;
> > >  -- patch 07 implements interconnect consumer logic (depends on patches
> > >     05 & 06);
> > > 
> > > My reasoning is that this order allows to e.g., merge the interconnect
> > > provider for exynos-bus and leave the consumers for later (not limited to
> > > the mixer). I hope this makes sense.
> > 
> > It is wrong. The driver should not depend on DTS changes because:
> > 1. DTS always go through separate branch and tree, so last patch
> >    will have to wait up to 3 cycles (!!!),
> > 2. You break backward compatibility.
> 
> It is up to the definition of "depends". The driver is _not_ broken without
> the DTS patches, but the interconnect functionality will not be available.
> 
> The only requirement is that if we want to have a working interconnect
> consumer, there needs to be a working interconnet provider (and I used
> the word "depends" to specify what needs what in order to work as intended).
> 

The order of patches should reflect first of all real dependency.
Whether it compiles, works at all and does not break anything.  Logical
dependency of "when the feature will start working" is
irrelevant to DTS because DTS goes in separate way and driver is
independent of it.

> I still think the order of these patches is the most logical one for someone
> reading this RFC as a whole.

I am sorry but it brings only confusion. DTS is orthogonal of the
driver code. You could even post the patchset without DTS (although then
it would raise questions where is the user of it, but still, you
could).

Further, DTS describes also hardware so you could send certain DTS
patches without driver implementation to describe the hardware.

Driver code and DTS are kind of different worlds so mixing them up for
logical review does not really make any sense.

Not mentioning it is different than most of other patches on mailing
lists.

BTW, it is the same as bindings which should (almost) always go first as
separate patches.

> 
> > In certain cases dependency on DTS changes is ok:
> > 1. Cleaning up deprecated properties,
> > 2. Ignoring the backward compatibility for e.g. new platforms.
> > 
> > None of these are applicable here.
> > 
> > You need to rework it, put DTS changes at the end. This clearly shows
> > that there is no wrong dependency.
> > 
> > > 
> > > > Adjust the title to match the contents - you are not adding bindings but
> > > > properties to bus nodes. Also the prefix is ARM: (look at recent
> > > > commits).
> > > 
> > > OK.
> > > 
> > > > > 
> > > > > diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > > index 4ce3d77a6704..d9d70eacfcaf 100644
> > > > > --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > > +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > > @@ -90,6 +90,7 @@
> > > > >  &bus_dmc {
> > > > >  	exynos,ppmu-device = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
> > > > >  	vdd-supply = <&buck1_reg>;
> > > > > +	#interconnect-cells = <0>;
> > > > 
> > > > This does not look like property of Odroid but Exynos4412 or Exynos4.
> > > 
> > > Strangely enough, this file is where the 'exynos,parent-bus' (aka. 'devfreq')
> > > properties are located (and everything in this RFC concerns devfreq).
> > 
> > I cannot find exynos,parent-bus in exynos4412-odroid-common.dtsi. Can
> > you elaborate?
> 
> Currently a name change is being made: 'devfreq' -> 'exynos,parent-bus'
> https://patchwork.kernel.org/patch/11304549/
> (a dependency of this RFC; also available in devfreq-testing branch)

I see. That property also does not look like board (Odroid) specific so
it should be moved to Exynos4412 DTSI.

Best regards,
Krzysztof

