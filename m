Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFE5C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3CBF20684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bqdAuRFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfCEKTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 05:19:35 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56037 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbfCEKTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 05:19:31 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190305101930euoutp02affc5772411b8372dedf9bca42c8734e~JCMDFQQxj1526615266euoutp02b
        for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2019 10:19:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190305101930euoutp02affc5772411b8372dedf9bca42c8734e~JCMDFQQxj1526615266euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551781170;
        bh=GE+bl6k1FIrWZyz5fhXcNfc9BA8rEl/CAbCBj0X1tsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bqdAuRFTlTd9noHTs/q0Jpz52HPYC39h+WLIHA8Uis/0v/dQOeytkARLH9AAWXQB/
         GnsR3C1nO4NBFae1pN9TMP7djqRhZ0MQY7FkgxEwj5nF/fIoLozRqjZZTqof2MKnQn
         aZzPw311phS6la7VKRxLoRiV6jmMUik3BbuBly3U=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190305101930eucas1p199de317f5c365efc576f844998f6e242~JCMClcO_e0214702147eucas1p1Z;
        Tue,  5 Mar 2019 10:19:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 69.4F.04441.13D4E7C5; Tue,  5
        Mar 2019 10:19:29 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190305101929eucas1p1dd30eee4c28dce142573e21d08c9abbd~JCMB6tWTz2998229982eucas1p1r;
        Tue,  5 Mar 2019 10:19:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190305101929eusmtrp2ad30aca8067d1243be4486203ef410b4~JCMBrnM492083020830eusmtrp2L;
        Tue,  5 Mar 2019 10:19:29 +0000 (GMT)
X-AuditID: cbfec7f2-a1ae89c000001159-15-5c7e4d312451
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5E.1F.04128.03D4E7C5; Tue,  5
        Mar 2019 10:19:29 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190305101928eusmtip13889a061b9996a0a623085f1ff228199~JCMBBKV7X3044430444eusmtip19;
        Tue,  5 Mar 2019 10:19:28 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v5 8/8] ARM: exynos_defconfig: enable DMC driver
Date:   Tue,  5 Mar 2019 11:19:11 +0100
Message-Id: <1551781151-5562-9-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djP87qGvnUxBqcOGFtsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLG4vGsOm8Xn3iOMFjPO72OyWHvkLrvF7cYVbBaH
        37SzOvB6bFrVyeZx8N0eJo++LasYPT5vkgtgieKySUnNySxLLdK3S+DKmDd/J3PBddaK179X
        sDcw/mfpYuTkkBAwkfh/6QtrFyMXh5DACkaJrgVT2EESQgJfGCUmzpCDSHxmlHj2YgU7TMe+
        R6+ZIBLLGSVevD4L5QB1fHu9CaiKg4NNQE9ix6pCkAYRgWqJO9f3M4PUMAu8ZZSYefML2G5h
        AQeJS78bWEFsFgFVifYps5lAbF4BT4njPVOYILbJSdw818kMYnMKeEnsX7gebJCEwGR2iQ9L
        QaZyADkuEj8uikDUC0u8Or4F6lIZif8750PNKZY427GKDcKukWg/uQOqxlri8PGLrCBjmAU0
        Jdbv0ocIO0qc/L0NajqfxI23giBhZiBz0rbpUGFeiY42IYhqDYktPRegFolJLF8zDWq4h8Sv
        M7OZIaEzl1Fi1ccJ7BMY5WchLFvAyLiKUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMjMKGc
        /nf80w7Gr5eSDjEKcDAq8fBmmNXGCLEmlhVX5h5ilOBgVhLh/SNeFyPEm5JYWZValB9fVJqT
        WnyIUZqDRUmct5rhQbSQQHpiSWp2ampBahFMlomDU6qBMfCmrbJ62d+Z76QnvI7qU7OWsq/f
        czXELOSI0xfTlnL151b9Pr/0JEW1FKx/ce08o8YR1n9Os1Y9cZvzwtv8nvffJGeZurm8234n
        4p2JgizXPunPOmGn73lNb1m/Sm515V8VjYsLApe+NT1xd332xSyxrTVNT4LZr86WjzAVnmGr
        e25NrlCDEktxRqKhFnNRcSIAYo+4lSQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsVy+t/xu7qGvnUxBqf+MFpsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLG4vGsOm8Xn3iOMFjPO72OyWHvkLrvF7cYVbBaH
        37SzOvB6bFrVyeZx8N0eJo++LasYPT5vkgtgidKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx
        1DM0No+1MjJV0rezSUnNySxLLdK3S9DLmDd/J3PBddaK179XsDcw/mfpYuTkkBAwkdj36DUT
        iC0ksJRR4vSlTIi4mMSkfdvZIWxhiT/Xutggaj4xSvRd8O1i5OBgE9CT2LGqECQsIlAv0f/m
        ElAJFwezwHdGiUNPJjCCJIQFHCQu/W5gBbFZBFQl2qfMBtvFK+ApcbxnChPEfDmJm+c6mUFs
        TgEvif0L1zND7PKUmPp1IcsERr4FjAyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAgN827Gf
        W3Ywdr0LPsQowMGoxMObYVYbI8SaWFZcmXuIUYKDWUmE9494XYwQb0piZVVqUX58UWlOavEh
        RlOgoyYyS4km5wOjL68k3tDU0NzC0tDc2NzYzEJJnPe8QWWUkEB6YklqdmpqQWoRTB8TB6dU
        A+MBTbsn37rL1s66fswy3eb+b5b1kVn3Ld+onj60/MmFX/Jfir0vTlX7upFnm7fatohlL3+f
        c5G9rrrAdupaxk1HZ85q7dazSrmStdfpWPX8Yw5xDpdvuDEt3larndDluiUnKHVt3ca5ZU0x
        0yc/DFzQ4hems2/SBr5lylOmqGs8fMHfWvM4b/oVJZbijERDLeai4kQAITIk0YYCAAA=
X-CMS-MailID: 20190305101929eucas1p1dd30eee4c28dce142573e21d08c9abbd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190305101929eucas1p1dd30eee4c28dce142573e21d08c9abbd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190305101929eucas1p1dd30eee4c28dce142573e21d08c9abbd
References: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190305101929eucas1p1dd30eee4c28dce142573e21d08c9abbd@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable driver for Dynamic Memory Controller dynamic frequency and
voltage scaling in Exynos5422 SoCs.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index d635edf..b5dddcc 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -291,6 +291,7 @@ CONFIG_DEVFREQ_GOV_PERFORMANCE=y
 CONFIG_DEVFREQ_GOV_POWERSAVE=y
 CONFIG_DEVFREQ_GOV_USERSPACE=y
 CONFIG_ARM_EXYNOS_BUS_DEVFREQ=y
+CONFIG_ARM_EXYNOS5422_DMC_DEVFREQ=y
 CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=y
 CONFIG_EXYNOS_IOMMU=y
 CONFIG_EXTCON=y
-- 
2.7.4

