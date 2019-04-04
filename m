Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D769C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007F82075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="U8aX7RVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfDDRW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:22:26 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:30912 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfDDRWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:22:25 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190404172221epoutp039d5378923e17d01af3f6cee92e0763f5~SVT0FULO43116731167epoutp03o;
        Thu,  4 Apr 2019 17:22:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190404172221epoutp039d5378923e17d01af3f6cee92e0763f5~SVT0FULO43116731167epoutp03o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554398542;
        bh=HQR+G2emtUmm4maCLODqFC9pKnQ8zyhOwrM32gCCfZE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=U8aX7RVtQcFxquVlDSObHovp4oVsAMyl8ItglGSOn+IiixUr1/NbBUwwnUbnQiItb
         wzv6VlOS7nW1348w+uhPTERRg1xzPlZbWzmMXEbKgAgU9poOUp2dHdkPjgWgy0Rr3U
         bsYuuD/hUhO1+F7JMFXV02GMeIgkoQpxGme3sMn4=
Received: from epsmges1p5.samsung.com (unknown [182.195.42.57]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190404172220epcas1p403675fa48337060486ee1107d9e57567~SVTzCwiPy2790127901epcas1p4H;
        Thu,  4 Apr 2019 17:22:20 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.07.04108.C4D36AC5; Fri,  5 Apr 2019 02:22:20 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190404172220epcas1p3a6a8d843780321c4914a63d589c56b33~SVTyqRkDg0537505375epcas1p39;
        Thu,  4 Apr 2019 17:22:20 +0000 (GMT)
X-AuditID: b6c32a39-89fff7000000100c-f4-5ca63d4c48c2
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.B9.03598.C4D36AC5; Fri,  5 Apr 2019 02:22:20 +0900 (KST)
Received: from AMDC3061.DIGITAL.local ([106.120.51.75]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PPG00B165KSW780@mmp1.samsung.com>; Fri, 05 Apr 2019
        02:22:20 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        pankaj.dubey@samsung.com, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH RFC 0/8] Exynos Adaptive Supply Voltage support
Date:   Thu, 04 Apr 2019 19:17:27 +0200
Message-id: <20190404171735.12815-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsWy7bCmvq6P7bIYg3/NBhYbZ6xntbj+5Tmr
        xfwj51gt+h+/ZrY4f34Du8Wmx9dYLS7vmsNmMeP8PiaLtUfuslssvX6RyeJ24wo2i0Vbv7Bb
        tO49wm5x+E07qwOfx5p5axg9Nq3qZPPYvKTeo2/LKkaPz5vkAlijuGxSUnMyy1KL9O0SuDIe
        9/xnK7gsXfH7xxrGBsaPol2MnBwSAiYSszuXMXYxcnEICexglJi5fTozhPOdUeLb5TPMMFXX
        nqxjh0jsZpT48uE/lPOTUWLe9JesIFVsAoYSvUf7GEFsEQFhiXtLl4MVMQt8Z5I49fopWJGw
        gL3Eqjn32UFsFgFViedt84FWcHDwClhLHNlXA7FNXmL1hgNgZ0gIrGCTuPBzOSNEwkXiw4zF
        rCD1EgLSEpeO2kLUNDNK9Oy+zQ7hTGCUuH98AVSDtcTh4xfBFjML8Em8+9oD1cwr0dEmBFHi
        IfGpYwdYiZBArMTphy9YJjCKL2BkWMUollpQnJueWmxYYKpXnJhbXJqXrpecn7uJERyTWpY7
        GI+d8znEKMDBqMTD28CyLEaINbGsuDL3EKMEB7OSCG/w96UxQrwpiZVVqUX58UWlOanFhxil
        OViUxHnXOzjHCAmkJ5akZqemFqQWwWSZODilGhh7UoLOmzfqWrUxSGcme3R96f5cIPsv2SaB
        k63znFnis69NXEu8XfXF77gm5B78VCy2qPja4Z1H3gozvtzG4cD747oc/3+x+/s9nPddq+e7
        k/XYcJK8+onvXVuOSy/7VLfy2Lw+/wcm7dPYhc8/9ejbsP2J3PLN763+66/7dZBhgly+473A
        zYVKLMUZiYZazEXFiQDJt1/yxQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKLMWRmVeSWpSXmKPExsVy+t9jAV0f22UxBttei1lsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gs1h65y26x9PpFJovbjSvYLBZt/cJu
        0br3CLvF4TftrA58HmvmrWH02LSqk81j85J6j74tqxg9Pm+SC2CN4rJJSc3JLEst0rdL4Mp4
        3POfreCydMXvH2sYGxg/inYxcnJICJhIXHuyjr2LkYtDSGAno8SdNQeZIJyfjBKNR5ezgVSx
        CRhK9B7tYwSxRQSEJe4tXc4OYjMLfGeSmD0vD8QWFrCXWDXnPlicRUBV4nnbfOYuRg4OXgFr
        iSP7aiCWyUus3nCAeQIj1wJGhlWMkqkFxbnpucVGBYZ5qeV6xYm5xaV56XrJ+bmbGIGBte2w
        Vt8OxvtL4g8xCnAwKvHwajAtixFiTSwrrsw9xCjBwawkwhv8fWmMEG9KYmVValF+fFFpTmrx
        IUZpDhYlcd7beccihQTSE0tSs1NTC1KLYLJMHJxSDYzCJ1v5/ePN8wteXV3PLCl/dWawc5lF
        vuOFEz1HTwbNSKrIuO/2Lum2a8+lI/osQS5ZUtuWLf7xVGWKha8876P3CeVWR5g43tzQeP8s
        K0tAy1nsUfSLL8pmErKzFn2bsK/8jvTsSTPcz266x358/uF9W7+oaf45bzIt2nvb1BfTzj3b
        bXpth7CcEktxRqKhFnNRcSIAWAKNECgCAAA=
X-CMS-MailID: 20190404172220epcas1p3a6a8d843780321c4914a63d589c56b33
CMS-TYPE: 101P
X-CMS-RootMailID: 20190404172220epcas1p3a6a8d843780321c4914a63d589c56b33
References: <CGME20190404172220epcas1p3a6a8d843780321c4914a63d589c56b33@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Adaptive Supply Voltage (ASV) on Exynos SoCs is a technique of adjusting
subsystem operating points, i.e. power supply voltage for given clock 
frequency, in order to better match actual capabilities of the hardware 
and optimize power consumption.  This applies to subsystems of the SoC like: 
CPU clusters, GPU, the memory controller or camera ISP.  During production 
process the SoC chip is assigned to one of several bins (ASV groups) and 
the group information is encoded in the SoC CHIPID block registers and/or 
OTP memory.  This information is then used to select more finely matching 
operating points for devices.

The motivation of this patch set was, amongst others, to ensure proper 
Odroid XU3/XU4 operation with highest performance operating points.

This patch set adds a driver parsing ASV tables from DT and finely 
adjusting CPU operating points to optimize power consumption and ensure 
proper operation for each SoC revision.

I just recently noticed there are already somewhat similar drivers located
in drivers/power/avs, I'm considering moving exynos-asv driver there in next 
iteration of this patch set. 

This patch set includes Exynos CHIPID driver posted by Pankaj Dubey and
futher improved by Bartlomiej Zolnierkiewicz [1].

Tested on Odroid XU3, XU3 Lite, XU4 and Exynos5433 TM2 board (with further 
patches not included in this series).

The DT binding documented in patch 3/8 doesn't describe any hardware,
it's purely software description.  I'd like to get some feedback specially
on that one, I thought it was reasonable to put that data in DT.  There 
will be many of this tables, per each SoC type and the driver looks much
better with those tables in DT IMHO. 

[1] https://lkml.org/lkml/2018/11/15/908

Pankaj Dubey (3):
  soc: samsung: Add exynos chipid driver support
  ARM: EXYNOS: enable exynos_chipid for ARCH_EXYNOS
  ARM64: EXYNOS: enable exynos_chipid for ARCH_EXYNOS

Sylwester Nawrocki (5):
  soc: samsung: Exynos chipid driver update
  dt-bindings: exynos: Add ASV tables binding documentation
  soc: samsung: Add Exynos Adaptive Supply Voltage driver
  ARM: EXYNOS: Enable exynos-asv driver for ARCH_EXYNOS
  ARM: dts: exynos: Add ASV tables for exynos5422/5800

 .../devicetree/bindings/arm/samsung/asv.txt   |  76 +++++
 arch/arm/boot/dts/exynos5.dtsi                |   2 +-
 arch/arm/boot/dts/exynos5800.dtsi             | 207 +++++++++++++
 arch/arm/mach-exynos/Kconfig                  |   2 +
 arch/arm64/Kconfig.platforms                  |   1 +
 drivers/soc/samsung/Kconfig                   |  16 +
 drivers/soc/samsung/Makefile                  |   5 +
 drivers/soc/samsung/exynos-asv.c              | 279 ++++++++++++++++++
 drivers/soc/samsung/exynos-asv.h              | 114 +++++++
 drivers/soc/samsung/exynos-chipid.c           | 113 +++++++
 drivers/soc/samsung/exynos-chipid.h           |  48 +++
 drivers/soc/samsung/exynos5422-asv.c          | 209 +++++++++++++
 drivers/soc/samsung/exynos5422-asv.h          |  25 ++
 13 files changed, 1096 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/asv.txt
 create mode 100644 drivers/soc/samsung/exynos-asv.c
 create mode 100644 drivers/soc/samsung/exynos-asv.h
 create mode 100644 drivers/soc/samsung/exynos-chipid.c
 create mode 100644 drivers/soc/samsung/exynos-chipid.h
 create mode 100644 drivers/soc/samsung/exynos5422-asv.c
 create mode 100644 drivers/soc/samsung/exynos5422-asv.h

-- 
2.17.1

