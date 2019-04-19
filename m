Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB15C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF4320645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lDuK7NcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbfDSTJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:09:35 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54681 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbfDSTHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:07:54 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190419141940euoutp02fbc5c6a3dc3cb6b540265354f755308e~W5flk1rR32260722607euoutp02Y
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 14:19:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190419141940euoutp02fbc5c6a3dc3cb6b540265354f755308e~W5flk1rR32260722607euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555683580;
        bh=laRurPPqZGLm21JPTycL20HYCYlH4Nx5jtw/RR3oQv8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=lDuK7NcP4IBUNtuqIJcTd4n28RM82rSOpZrRjR/YC0OWgHMMAgsbveDnYkZLScczf
         DZY6RhP6JFYlSBltSHigOaiZ5pDAccD/DRwCKmuwvhTiIXSi6LnlsD9asxs1veewRm
         Vz3wQAapI7xmVUJa4wOeoJM9rsF+r8K47nGqN4fQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190419141939eucas1p23b391ac0c0158c9e4255499df89ed137~W5fkesHWX3160331603eucas1p2B;
        Fri, 19 Apr 2019 14:19:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6A.B2.04325.AF8D9BC5; Fri, 19
        Apr 2019 15:19:38 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190419141938eucas1p16ee6cdf897184df33cf67b55c5f3c449~W5fjMpx4m0188401884eucas1p1A;
        Fri, 19 Apr 2019 14:19:38 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190419141937eusmtrp1007d1aa685d250e62534f44018fb2fdd~W5fi_juGG1759317593eusmtrp1R;
        Fri, 19 Apr 2019 14:19:37 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-74-5cb9d8fad053
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E7.02.04146.9F8D9BC5; Fri, 19
        Apr 2019 15:19:37 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190419141937eusmtip230c2262191a52e35f17d79aa58010bcf~W5fiOwPSS3043530435eusmtip27;
        Fri, 19 Apr 2019 14:19:36 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v6 0/10] Exynos5 Dynamic Memory Controller driver
Date:   Fri, 19 Apr 2019 16:19:18 +0200
Message-Id: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRju29nOjsPJcVp+zBsMIjPUotsHiWZJHYRoQkXUImceVHJTd9Sy
        9WOpqVveUNChmV0oxTQvW6JWmtPUNJ2ipmlGKWbUMsJrWpHzTPr3fM/lfV5ePgITNfLERLQy
        gVYp5TESXMBt6Pxl9lkda5LtTinyR3X6Gh4aXZjlobKOfh56/HMaoIKeUg56c0uBcqe/Ychs
        ruWjvhQLH41r3NBQ820czWd3AKQ3t3BQdcckH03cqMBRuyWDh1qHQ9DEmgNa6p4Ch52opcV8
        LlWiGeRSTcWTfKq+UotT2alzONU295xD5RgrAWXoVVPz9R5Su3MC/wg6JjqJVvkFhAmi8rJq
        eXGft19NHe8HGtDqrgN2BCT3wSdTY7gOCAgRWQFgzUwa3yqIyAUA9Q+SWGEewM6pWu5mYjS3
        DmOFcgB182YO+1hPZJSlAR0gCJz0hY2V8daAM6mG70dbNwIYaeHAvtWVjUlOZBA0Vjdv1HHJ
        7XBkeRmzYiEZAsd/fMLZNg/4rl+7EYZkJx8OvP4DWCEYZlWt2LAT/Npl5LPYDfYWZNlWZaAm
        +57Ncx1O55baPIdge9cgz7ooRu6ENc1+LB0Ec8qHMSsNSQc49t3RSmPrML+hyEYLYWa6iHV7
        QWPWAIfF22B5VaFtOAUNDy22I16AHx7p+XnAo/h/110AKoELncgoImlmr5K+4svIFUyiMtL3
        UqyiHqz/p96/XYuNoOV3uAmQBJDYC1/mN8lEPHkSk6wwAUhgEmdhUIRRJhJGyJOv0arYi6rE
        GJoxAVeCK3ERqrd8PC8iI+UJ9GWajqNVmyqHsBNrgK9PsGCFzIx3vHO0zds94WxbeX7jqR1h
        2rHQnMBC2UnpiPbE6WddBw1+M0/jxSE38aEDkpJaoSBkSPpKGbtfFxqYAydMZ8THxKGu4T3H
        o+z9+wyONfYm0jIbcH+rMKPpSIynNGWp4W2A29QLdfQur7WC9AZtuyZ4Vv5lqFud4SnhMlHy
        Pd6YipH/A4PQnF9LAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsVy+t/xe7o/b+yMMZg0xcBi44z1rBbXvzxn
        tZh/5ByrxeqPjxktJp+ay2RxpjvXov/xa2aL8+c3sFucbXrDbnGrQcbi8q45bBafe48wWsw4
        v4/JYu2Ru+wWtxtXsFkcftPOarH/ipfF7d98Ft9OPGJ0EPb49nUSi8fshossHjtn3WX32LSq
        k82jt/kdm8fBd3uYPPq2rGL02Hy62uPzJrkAzig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMT
        Sz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jAk9G1gLnqlWNN86x9jAuF+2i5GTQ0LAROJ6/0bm
        LkYuDiGBpYwS3XMnMUMkxCQm7dvODmELS/y51sUGUfSJUWLN5U6WLkYODjYBPYkdqwpBakQE
        6iX631wCq2EWaGCWWLP9KitIQljAUWLL2l1gg1gEVCWufv8OtoBXwEvi1vuHbBAL5CRunutk
        nsDIs4CRYRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgbGw79nPzDsZLG4MPMQpwMCrx8B6Y
        tDNGiDWxrLgy9xCjBAezkgivY8qWGCHelMTKqtSi/Pii0pzU4kOMpkDLJzJLiSbnA+M2ryTe
        0NTQ3MLS0NzY3NjMQkmc97xBZZSQQHpiSWp2ampBahFMHxMHp1QDo0md6I/J95JUI3ge2MwO
        yXCN+r13dlTW3T8vqzqWr3C+Wbc7saW+/JqPSdKy2alsvtwqm+N/ywkdskhtFvn4oWXPyyln
        GBUdL5msfGNevfdW0Yf7mWxt+w5NMNidcFJhwb4jt7t9mjMrNoa9O+l78cHz3BbVVUGhcu/2
        X1WuP8DPvv/n4Wn39JRYijMSDbWYi4oTASJCETOjAgAA
X-CMS-MailID: 20190419141938eucas1p16ee6cdf897184df33cf67b55c5f3c449
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419141938eucas1p16ee6cdf897184df33cf67b55c5f3c449
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419141938eucas1p16ee6cdf897184df33cf67b55c5f3c449
References: <CGME20190419141938eucas1p16ee6cdf897184df33cf67b55c5f3c449@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is v6 of the patch set which adds support of Dynamic Memory Controller
for Exynos5422 SoC.
The driver supports Dynamic Voltage and Frequency Scalling
for the DMC and DRAM. It also provides needed timings for different
speed operations of the DRAM memory.

The patch set depends on changes to Exynos PPMU posted on LKLM as:
[PATCH v3 0/4] Exynos Performance Monitoring Counters enhancements

changes:
v6:
- driver code has been converted to use generic code which parses DT memory
  definition in drivers/memory/of_memory.c
- extended of_memory by LPDDR3 support (there was LPDDR2 made by TI)
- extended jedec_lpddr.h by the needed structures for LPDDR3 (AC timings)
- driver file moved to proper directory, where other memory controllers
  live, which is in this case drivers/memory/samsung/
- driver code now uses regmap_{read|write} to access registers for pausing
  and changing timings set, as suggested by Chanwoo
- DT contains simple definition of memory device, similar to LPDDR2 made by TI
- driver code generates the needed timings for registered OPPs, based on
  memory description in DT
- patch 1 contains Rob's ACK,
- simplified memory bandwidth calculation
- added debug information files with timings, raw counters and statistics
- updated dt-bindings files accordingly
- based on v5.1-rc5 (+ PPMU patches)
v5:
- removed unneeded wrapper functions i.e. for regulator_set_voltage
- removed unused defines
- removed direct access to clock register base and used CCF for
  pause and timing set usage
- switched to OPP comming from DT according to Chanowoo's comments
- switched to timings comming from DT, added parsing function
- extended dt-binding with description of OPPs and timings
- according to Rob Herring comment, moved dt-binding file before driver code
  in the patch set.
- rebased on top of v5.0
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

Lukasz Luba (10):
  clk: samsung: add needed IDs for DMC clocks in Exynos5420
  clk: samsung: add new clocks for DMC for Exynos5422 SoC
  clk: samsung: add BPLL rate table for Exynos 5422 SoC
  Documentation: dt: device tree bindings for LPDDR3 memories
  drivers: memory: extend of_memory by LPDDR3 support
  dt-bindings: memory-controllers: add Exynos5422 DMC device description
  drivers: memory: add DMC driver for Exynos5422
  drivers: devfreq: events: add Exynos PPMU new events
  ARM: dts: exynos: add DMC device for exynos5422
  ARM: exynos_defconfig: enable DMC driver

 .../devicetree/bindings/lpddr3/lpddr3-timings.txt  |   57 +
 .../devicetree/bindings/lpddr3/lpddr3.txt          |   93 +
 .../bindings/memory-controllers/exynos5422-dmc.txt |   73 +
 MAINTAINERS                                        |    8 +
 arch/arm/boot/dts/exynos5420.dtsi                  |  120 ++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |  120 ++
 arch/arm/configs/exynos_defconfig                  |    1 +
 drivers/clk/samsung/clk-exynos5420.c               |   59 +-
 drivers/devfreq/event/exynos-ppmu.c                |    6 +
 drivers/memory/of_memory.c                         |  125 ++
 drivers/memory/of_memory.h                         |   20 +-
 drivers/memory/samsung/Kconfig                     |   17 +
 drivers/memory/samsung/Makefile                    |    1 +
 drivers/memory/samsung/exynos5422-dmc.c            | 1793 ++++++++++++++++++++
 include/dt-bindings/clock/exynos5420.h             |   18 +-
 include/memory/jedec_ddr.h                         |   62 +
 16 files changed, 2566 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/lpddr3/lpddr3-timings.txt
 create mode 100644 Documentation/devicetree/bindings/lpddr3/lpddr3.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
 create mode 100644 drivers/memory/samsung/exynos5422-dmc.c

-- 
2.7.4

