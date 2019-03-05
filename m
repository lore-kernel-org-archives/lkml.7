Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBE3C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C2420684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kip953tA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfCEKT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 05:19:28 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54923 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfCEKT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 05:19:27 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190305101925euoutp01d07282dfdd481c64cb3f781cee2a50ab~JCL_vXBrV0539305393euoutp01D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2019 10:19:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190305101925euoutp01d07282dfdd481c64cb3f781cee2a50ab~JCL_vXBrV0539305393euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551781166;
        bh=A64lpTnXMDziX5A2MqXs12dEJqCDkwUHJprh5czbo/k=;
        h=From:To:Cc:Subject:Date:References:From;
        b=kip953tAENui1nBaok9f1iJFXk7IESoORuiSguT/igq46krEXrvsH6KM4tYAmQ/aN
         J7EnVqVpfSpN2U+F6Yv2EeQ9qatYMSLgtzLjhIRkUjTl/C0fOwnmAXV3+w8NrT2QiS
         I3xRxMlc0VS6CXKhL3tvaGezqZX6/MCr7GVulihU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190305101925eucas1p134ccc815a39c77c061d28358e65d4603~JCL_CTlvR0207202072eucas1p1g;
        Tue,  5 Mar 2019 10:19:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B8.9E.04294.C2D4E7C5; Tue,  5
        Mar 2019 10:19:24 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190305101924eucas1p24a058fcc034cc95bc33888087412ab48~JCL9VWvK22250822508eucas1p2q;
        Tue,  5 Mar 2019 10:19:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190305101924eusmtrp2f4ce84efbc18cc1630e39ef064a8803f~JCL9FamEH2082620826eusmtrp2N;
        Tue,  5 Mar 2019 10:19:24 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-86-5c7e4d2ccd68
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 60.46.04284.C2D4E7C5; Tue,  5
        Mar 2019 10:19:24 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190305101923eusmtip15206a9c550f30e3db47ce88ef49feea7~JCL8dtaPY3046130461eusmtip1o;
        Tue,  5 Mar 2019 10:19:23 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v5 0/8] Exynos5 Dynamic Memory Controller driver
Date:   Tue,  5 Mar 2019 11:19:03 +0100
Message-Id: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42LZduzneV0d37oYg0czrS02zljPanH9y3NW
        i/lHzrFa9D9+zWxx/vwGdouzTW/YLW41yFhc3jWHzeJz7xFGixnn9zFZrD1yl93iduMKNovD
        b9pZHXg9Nq3qZPM4+G4Pk0ffllWMHp83yQWwRHHZpKTmZJalFunbJXBlzNn+hrngvETFpcX9
        TA2Mr4S6GDk5JARMJE5//8LYxcjFISSwglHi3YR/bBDOF0aJnye2AWU4gJzPjBLXI2Aa/r9Z
        xw5Rs5xRoq3pAQtcw7+Z19lAGtgE9CR2rCoEaRARqJa4c30/M0gNs8BbRomZN7+wgCSEBRwk
        ur9uZwaxWQRUJX5uf84OYvMKeEpcPtPKCrFNTuLmuU5mCPs3m8SbhbUg8yUEXCTu7FWGCAtL
        vDq+hR3ClpH4v3M+E4RdLHG2YxUbhF0j0X5yB1SNtcTh4xdZQcYwC2hKrN+lDxF2lDj8/Ror
        xHQ+iRtvBUHCzEDmpG3TmSHCvBIdbdBg05DY0nMBapGYxPI106CGe0g8OPMc7HYhgViJF6tP
        M01glJuFsGsBI+MqRvHU0uLc9NRio7zUcr3ixNzi0rx0veT83E2MwJRx+t/xLzsYd/1JOsQo
        wMGoxMObYVYbI8SaWFZcmXuIUYKDWUmE9494XYwQb0piZVVqUX58UWlOavEhRmkOFiVx3mqG
        B9FCAumJJanZqakFqUUwWSYOTqkGxrzIGjsmnYNXZ9V871i6NnH6i8ZjLyLqrXlSFi5vursk
        7t71hUIvEmpSFpdwPNdjvOi/mHNWVMmxZdK5fReYjxoeqbQ+tCK74H7OBb+Tb7ry5jpHs8dL
        8cf9UJ+ct/300qPPd6ZKfJ0T7BIgnhK8OeyYzKfrYlHi940mnUrcdMfYa++SwqJbH5VYijMS
        DbWYi4oTATON6W8VAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsVy+t/xu7o6vnUxBlf2sFlsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLG4vGsOm8Xn3iOMFjPO72OyWHvkLrvF7cYVbBaH
        37SzOvB6bFrVyeZx8N0eJo++LasYPT5vkgtgidKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx
        1DM0No+1MjJV0rezSUnNySxLLdK3S9DLmLP9DXPBeYmKS4v7mRoYXwl1MXJySAiYSPx/s469
        i5GLQ0hgKaPE4+u7GCESYhKT9m1nh7CFJf5c62KDKPrEKNH6dztLFyMHB5uAnsSOVYUgNSIC
        9RL9by6B1TALfGeUOPRkAtggYQEHie6v25lBbBYBVYmf25+DDeUV8JS4fKaVFWKBnMTNc53M
        Exh5FjAyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAgM2m3Hfm7ewXhpY/AhRgEORiUe3gyz
        2hgh1sSy4srcQ4wSHMxKIrx/xOtihHhTEiurUovy44tKc1KLDzGaAi2fyCwlmpwPjKi8knhD
        U0NzC0tDc2NzYzMLJXHe8waVUUIC6YklqdmpqQWpRTB9TBycUg2MWW7Hr5QEr2NxrnjVvotB
        7koe/2K9hTUmbI66d59FPtvOPs3Uskfg14L1L5b8Unv0Ti3DujHrxrY7dx76iKt9aBdlNHBv
        0WyO02TOOr92+ppnBinSzE1rfSqZK97H3Ez3vfpPasetCc1fWU0eSjcV8uw9ftNe7PUsveKv
        DKcEI7NDMiWLzLSVWIozEg21mIuKEwGTX+IecAIAAA==
X-CMS-MailID: 20190305101924eucas1p24a058fcc034cc95bc33888087412ab48
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190305101924eucas1p24a058fcc034cc95bc33888087412ab48
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190305101924eucas1p24a058fcc034cc95bc33888087412ab48
References: <CGME20190305101924eucas1p24a058fcc034cc95bc33888087412ab48@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is v5 of the patch set which adds support of Dynamic Memory Controller
for Exynos5422 SoC.
The driver supports Dynamic Voltage and Frequency Scalling
for the DMC and DRAM. It also provides needed timings for different
speed operations of the DRAM memory.

changes:
v5:
- removed unneeded wrapper functions i.e. for regulator_set_voltage
- removed unused defines
- removed direct access to clock register base and used CCF for
  pause and timing set usage
- switched to OPP coming from DT according to Chanowoo's comments
- switched to timings coming from DT, added parsing function
- extended dt-binding with description of OPPs and timings
- according to Rob Herring comment, moved dt-binding file before driver code
  in the patch set.
- re-based on top of v5.0
v4:
- removed unneeded DPLL and G3D clocks IDs
- changed names of parent clocks for mout_mx_mspll_ccore_phy_p
  and added one more parent: mout_sclk_epll
- removed 933Mhz and 138MHz from the BPLL ratio table
v3:
- in DTS align to proper indent the clocks and clock-names entries
v2:
- changed file name exynos5-dmc.c -> exynos5422-dmc.c
  and related entries in other files
- changed dt-binding file name
- changed config entry to CONFIG_ARM_EXYNOS5422_DMC_DEVFREQ
- removed sysfs and print info messages (print only one line)
- removed function exynos5_read_chip_info and compact code
- changed dt-binding patch and move it up in the patch set
- new entries in MAINTAINERS are added with the driver c code
- clean-up in DTS file: renamed nodes to 'ppmu' and 'memory-controller',
  entries moved to suggested location (before nocp nodes or after),
  moved according to alfabetical order, compacted clocks names with right indent.

Regards,
Lukasz Luba


Lukasz Luba (8):
  clk: samsung: add needed IDs for DMC clocks in Exynos5420
  clk: samsung: add new clocks for DMC for Exynos5422 SoC
  clk: samsung: add BPLL rate table for Exynos 5422 SoC
  dt-bindings: devfreq: add Exynos5422 DMC device description
  drivers: devfreq: add DMC driver for Exynos5422
  DT: arm: exynos: add DMC device for exynos5422
  drivers: devfreq: events: add Exynos PPMU new events
  ARM: exynos_defconfig: enable DMC driver

 .../devicetree/bindings/devfreq/exynos5422-dmc.txt |  177 +++
 MAINTAINERS                                        |    8 +
 arch/arm/boot/dts/exynos5420.dtsi                  |   83 ++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |   87 ++
 arch/arm/configs/exynos_defconfig                  |    1 +
 drivers/clk/samsung/clk-exynos5420.c               |   67 +-
 drivers/devfreq/Kconfig                            |   13 +
 drivers/devfreq/Makefile                           |    1 +
 drivers/devfreq/event/exynos-ppmu.c                |    6 +
 drivers/devfreq/exynos5422-dmc.c                   | 1154 ++++++++++++++++++++
 include/dt-bindings/clock/exynos5420.h             |   18 +-
 11 files changed, 1609 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
 create mode 100644 drivers/devfreq/exynos5422-dmc.c

-- 
2.7.4

