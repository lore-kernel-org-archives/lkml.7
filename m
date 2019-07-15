Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9E0C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D554F2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="U28iKta9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbfGOMoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:44:38 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60087 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbfGOMoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:44:37 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124435euoutp01652a34e91760cb01563a8a8354f93b0b~xlUZ0q4uH1950319503euoutp01Q
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:44:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190715124435euoutp01652a34e91760cb01563a8a8354f93b0b~xlUZ0q4uH1950319503euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194675;
        bh=mnhr5Q+nqFJ14GP8+IuANmhop048Hw+aOQuTTF0FCuw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=U28iKta98c/CNT1Llobctv6obP7c3dQscoN2M/IP5lAbswkUjZr5dLI0uHytSKU1T
         4icw9olaCK8eKLiLLHQDoRRV220DCThZBI3bkD2gNDJZVOJw6Vbei1/sjqQD+lvbOZ
         tNqqWezmaqyKyeJgsRXgYkg8VVx+B8ZvJf9z/amY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190715124434eucas1p2480b9abb90ad28e0cc76cc7f246e847d~xlUY9WdeK1849318493eucas1p2i;
        Mon, 15 Jul 2019 12:44:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5F.C1.04377.2357C2D5; Mon, 15
        Jul 2019 13:44:34 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124433eucas1p2a292f236ea55751117836742c1ca5d23~xlUYJsP131544915449eucas1p2t;
        Mon, 15 Jul 2019 12:44:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124433eusmtrp1e8b56280bd67116b2f3b3afc781d1774~xlUX7bwbe0421504215eusmtrp1Z;
        Mon, 15 Jul 2019 12:44:33 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-c4-5d2c7532e0f0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CB.30.04146.1357C2D5; Mon, 15
        Jul 2019 13:44:33 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124432eusmtip2e09a4c7f98a6095cbf1fd25df33d3473~xlUXKIwlM0518605186eusmtip2b;
        Mon, 15 Jul 2019 12:44:32 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, a.hajda@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v1 00/50] Exynos5x clocks and buses changes
Date:   Mon, 15 Jul 2019 14:43:27 +0200
Message-Id: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djP87pGpTqxBuu2CFncWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KC6blNSczLLUIn27BK6MOX//MxacM6nofbmBuYFxm1YXIyeH
        hICJxPU1N5m6GLk4hARWMEq0TXsA5XxhlFixuYsdwvnMKLHpZAcLTMu/f9+ZQWwhgeWMEv33
        HeA6Fp1dC1TEwcEmoCexY1UhSI2IwBJGiSM/k0BqmAVuMknsebKTFaRGWMBa4t9nNxCTRUBV
        YnuTP0g5r4CdRM/pG2wQq+QlVm84wAzSKiGwiV3iWeM5JoiEi8TuA28ZIWxhiVfHt7BD2DIS
        pyf3QN1ZLNHQuxCqpkbicf9cqBpricPHL4KdwCygKbF+lz5E2FHixc7JYGEJAT6JG28FQcLM
        QOakbdOZIcK8Eh1tQhDVGhJbei5AHSMmsXzNNKjhHhKP1x1kBCkXEoiV2H9MdAKj3CyEVQsY
        GVcxiqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIEJqLT/45/2cG460/SIUYBDkYlHl6HFO1Y
        IdbEsuLK3EOMEhzMSiK8tl+BQrwpiZVVqUX58UWlOanFhxilOViUxHmrGR5ECwmkJ5akZqem
        FqQWwWSZODilGhi1Dyz0jnggs7f/wttdb44uLP+z4/QiXj4vU4H1xod8dFtjoq/x8Ya/fZh2
        O9dNkC9drOP5vI1dDPlrPh1f7FqeZcVvcZv5hKyFwZP7auuUL0kl7Ny2KHtF2rNZr0w+rRWy
        FzzYd2nW1ErG4PCge0W29Sam71oy00zqd4itu+XPpChhWmlglqnEUpyRaKjFXFScCAC8v07q
        QAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42I5/e/4PV3DUp1Yg33vJS1urTvHarFxxnpW
        i+tfnrNazD8C5PY/fs1scf78BnaLs01v2C1uNchYbHp8jdXiY889VovLu+awWcw4v4/JYu2R
        u+wWS69fZLK4eMrV4nbjCjaL1r1H2C0Ov2lntfh3bSOLg7DHmnlrGD3e32hl99i0qpPNY/OS
        eo+D7/YwefRtWcXo8XmTXAB7lJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamS
        vp1NSmpOZllqkb5dgl7GnL//GQvOmVT0vtzA3MC4TauLkZNDQsBE4t+/78wgtpDAUkaJV/tD
        IeJiEpP2bWeHsIUl/lzrYoOo+cQoMfMwkM3BwSagJ7FjVSFIWERgBaPE5BPeXYxcHMwCr5kk
        jhx9xwpSIyxgLfHvsxuIySKgKrG9yR+knFfATqLn9A02iOnyEqs3HGCewMizgJFhFaNIamlx
        bnpusaFecWJucWleul5yfu4mRmAMbDv2c/MOxksbgw8xCnAwKvHwOqRoxwqxJpYVV+YeYpTg
        YFYS4bX9ChTiTUmsrEotyo8vKs1JLT7EaAq0eyKzlGhyPjA+80riDU0NzS0sDc2NzY3NLJTE
        eTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MC6o91y8p+nT/PfqC3M+nXuabOfZ/mLea5FdsyXW
        3uRfmlbb92lTzGIvLq/2EtPgnNADS/b2btx0OPXe9U/5sx4HHDGvr516PFEwlFcn+/qKi8aC
        D0scd30WCJr/36a2I1FUJfJ41kLrkkkJ6+R2lLfYyomphva37HqqKxhgFZDz4MTaFevkVJRY
        ijMSDbWYi4oTAUUmgxOXAgAA
X-CMS-MailID: 20190715124433eucas1p2a292f236ea55751117836742c1ca5d23
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124433eucas1p2a292f236ea55751117836742c1ca5d23
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124433eucas1p2a292f236ea55751117836742c1ca5d23
References: <CGME20190715124433eucas1p2a292f236ea55751117836742c1ca5d23@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The patch set fixes clock settings for the Exynos5420/5422/5800 SoCs which
can be found in Odroid XU3/4, Google Peach Pi. Support for DT board files
with Exynos5420 (like Google Peach Pit) are under development.  The old
implementation did not configure properly the clock rates or the
connections which could cause performance issues or instability.  The
Exynos5x SoC has complex clocks topology. Some of the NoC clock branches
provide clock to the device internal buses or AXI interface and had wrong
settings.

In the old configuration the OPP values where not reflecting the actually
set frequencies, which were possible by setting the divider value on the
clock tree. The algorithms in governors, which use these frequencies,
relied on wrong assumption during their calculations. It also applies to
device drivers code, which does not check the rate of the clock but relay
on OPP values, which in some cases are different.  It is not only the bus
frequency but also the connected component internal buses (accelerators
like e.g. G2D, scaler, rotator) frequency.  Wrong frequency set due to
impossible division from PLL rate caused that some devices had lower than
possible clock for internal logic and for the AXI bus which transfers the
data.  For example fixes for MMC controller, where OPP max frequency
changed from 150MHz to 240MHz, changing the PLL rate to proper value caused
performance increase up to 20% (FSYS2 OPP table).

Affected components inside SoC: image rotator, usb3.0 and 2.0 controller,
jpeg accelerator, image/video scaler, mmc controller, ISP, display
controller, all NoC buses.

Some of the clocks have name which might indicate their max speed, e.g.
CLK_DOUT_ACLK266 but it is not true.  The max speed clock from this example
is 300MHz (according to the RM) and has been reflected accordingly in this
patch set.

Main changes:
- defined new clocks or added IDs to take them from DT nodes
- set proper PLLs frequency for: MPLL, DPLL, which would handle children
  clock requirements down in the tree,
- changed parents of some clocks to proper PLL or to proper parent clock,
- properly calculated OPP values for the buses keeping in mind the parent
  clock frequency and possible values derived from there by one clock
divider with proper bit length indicating maximum allowed divider; thanks
to that it is possible to set the requested frequency in all children
without changing the PLL frequency, which also makes the governor frequency
values assumption true,
- some OPPs were removed because it was not possible to set them due to
  different base frequency, which would require of changing PLL rate, which
might affect other devices connected to this PLL and their misscalculated
rates.

The last two patches touches Exynos5800 and are optional. They have been
checked due to some issues with disabling parent, which accidently was
populated up to MPLL and shut down the PLL. They might be used for testing
on Peach Pi.

The patch set is based on Samsung clock repo and branch 'for-v5.3/next'
[1].

Regards,
Lukasz Luba

[1] https://git.kernel.org/pub/scm/linux/kernel/git/snawrocki/clk.git/log/?h=for-v5.3/next

Lukasz Luba (50):
  clk: samsung: add new IDs for Exynos5420 clocks
  clk: samsung: add IDs for Exynos5420 NoC clocks
  clk: samsung: change parent of dout_aclk400_wcore in Exynos5420
  clk: samsung: add IDs to manage aclk400_mscl in Exynos5420
  clk: samsung: add IDs to aclk400_isp in Exynos5420
  clk: samsung: add IDs to ACLK266 clocks in Exynos5420
  clk: samsung: add IDs to ACLK266_G2D clocks in Exynos5420
  clk: samsung: change aclk266_isp clocks definitions Exynos5420
  clk: samsung: add IDs to FSYS clocks in Exynos5x
  clk: samsung: change ACLK100_NOC clocks definitions Exynos5x
  clk: samsung: add IDs to UART clocks in Exynos5420
  clk: add ID to PWM MUX in Exynos5420
  clk: samsung: add DPLL rate table in Exynos5420
  clk: samsung: add CLK_MOUT_SCLK_CPLL in the Exynos5420
  clk: samsung: add MPLL rate table in Exynos5420
  clk: samsung: add SPLL rate table in Exynos5420
  clk: samsung: add CLK_MOUT_MMC0 in the Exynos5420
  ARM: dts: exynos: add bus_isp with OPP table
  ARM: dts: exynos: change OPPs values for FSYS2 in Exynos5420
  ARM: dts: exynos: change and rename FSYS OPP table in Exynos5420
  ARM: dts: exynos: add OPP into FSYS APB bus in Exynos5420
  ARM: dts: exynos: OPPs for bus_disp1 in Exynos5420
  ARM: dts: exynos: change lowest OPP in bus_disp1_fimd in Exynos5420
  ARM: dts: exynos: align OPPs with PLL rate for MSCL in Exynos5420
  ARM: dts: exynos: add 300MHz to bus_disp1_fimd in Exynos5420
  ARM: dts: exynos: align NOC100 bus OPPs in Exynos5420
  ARM: dts: exynos: align bus_wcore OPPs in Exynos5420
  ARM: dts: exynos: change OPPs for g2d and g2d_acp buses in Exynos5420
  ARM: dts: exynos: align OPPs of bus_gen in Exynos5420
  ARM: dts: exynos: add bus_isp266 into Exynos5800
  ARM: dts: exynos: align lowest OPP in bus_jpeg in Exynos5420
  ARM: dts: exynos: remove lowest OPP from bus_mfc in Exynos5420
  ARM: dts: exynos: set parent clocks to UARTs in Exynos5420
  ARM: dts: exynos: set parent clocks to PWM in Exynos5420
  ARM: dts: exynos: change speed and parent of NoC clock in Exynos5420
  ARM: dts: exynos: change ACLK100_NOC config in Exynos5422
  ARM: dts: exynos: change parent and rate of bus_fsys in Exynos5422
  ARM: dts: exynos: change parent and rate of bus_fsys2 in Exynos5422
  ARM: dts: exynos: change parent and rate of bus_fsys_acp in Exynos5422
  ARM: dts: exynos: change parent and rate of bus_gen in Exynos5422
  ARM: dts: exynos: change parent and rate of bus_g2d in Exynos5422
  ARM: dts: exynos: change parent and rate of bus_mscl in Exynos5422
  ARM: dts: exynos: add bus_isp in Exynos5422
  ARM: dts: exynos: change rate of bus_jpeg in Exynos5422
  ARM: dts: exynos: change rate of bus_disp1_fimd in Exynos5422
  ARM: dts: exynos: change rates of bus_disp1 in Exynos5422
  ARM: dts: exynos: change rate of bus_gscl_scaler in Exynos5422
  ARM: dts: exynos: set proper parents to bus_isp266 Exynos5422
  ARM: dts: exynos: add buses support for Exynos5800 Peach Pi
  ARM: dts: exynos: change MMC0 clock parent in Exynos5800 Peach Pi

 arch/arm/boot/dts/exynos5420.dtsi             | 116 +++++++-----
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi |  74 ++++++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts     | 175 ++++++++++++++++++
 arch/arm/boot/dts/exynos5800.dtsi             |  10 +
 drivers/clk/samsung/clk-exynos5420.c          | 109 +++++++----
 include/dt-bindings/clock/exynos5420.h        |  27 ++-
 6 files changed, 429 insertions(+), 82 deletions(-)

-- 
2.17.1

