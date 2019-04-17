Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07370C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC8C20693
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XHKA/AVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731224AbfDQHsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:48:37 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40657 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731171AbfDQHsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:48:36 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190417074834euoutp024d6e00fce344b9d2498133dc1053ea0b~WM3iTcVhY0434204342euoutp027
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 07:48:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190417074834euoutp024d6e00fce344b9d2498133dc1053ea0b~WM3iTcVhY0434204342euoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555487314;
        bh=yp22Q9om9PbOtWP1WnUp98117gd7aHO0YbNpzJ3oCTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XHKA/AVMKZWp04j9JgUh0E15KMPX06YdJ8yQDF5cuwyZ7X8UNlC8TWJzs1PuQfoiP
         wJPqPdbtxG1KOgWGuAEPIHfRd5KzVFaydpfptqlnahOwigzuAO3wQ5Sl9lR9XsMYJC
         dpb2aSiAEx1eIbC3y8668IzvaGgqTbZC+O105DyQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190417074833eucas1p19073b60a499c4e3e92e108a64c4e3ecb~WM3hYl0uZ0763207632eucas1p1c;
        Wed, 17 Apr 2019 07:48:33 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 91.38.04325.05AD6BC5; Wed, 17
        Apr 2019 08:48:32 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190417074832eucas1p26eca3ed8bf754787b4860206ba542e1c~WM3gn3rYZ2287122871eucas1p2w;
        Wed, 17 Apr 2019 07:48:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190417074832eusmtrp2dcc74a19340d1328c0374ff56d691613~WM3gYVYAu2697726977eusmtrp2-;
        Wed, 17 Apr 2019 07:48:32 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-48-5cb6da508a43
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 12.57.04140.05AD6BC5; Wed, 17
        Apr 2019 08:48:32 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190417074831eusmtip195768e1c2a506250e3df672170210f7b~WM3fu4ECU0059200592eusmtip1r;
        Wed, 17 Apr 2019 07:48:31 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org,
        l.luba@partner.samsung.com
Subject: [PATCH 1/3] include: dt-bindings: add Performance Monitoring Unit
 for Exynos
Date:   Wed, 17 Apr 2019 09:48:06 +0200
Message-Id: <1555487288-4777-2-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555487288-4777-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSeUhTcRzvt7e3Pa3ZcxP94RUMjOxQo4NXmaiIrcKQ6DQ7Znuo6abtqWWa
        F5oHHqVhas1lKa4xteaaplNTR0KiU4y8SKURptmI1MAOzcdb9N/n9znhyw9D+PWoMxYtSyDl
        MnGskGPL1r9ZMe0KndCH+zSX+BIvKppQYnRpFiWUxkGUKDF/QQiT6TmXGMha4BITGa6E1vwe
        JUbaHnGIxSIjICpMnSyiwfiBS9SNDrOIyUwVh8jpMHKJ3oVc1B8Xaao1QKRV53NEzbXpom6L
        gSUq1qmBaFHrHsoJs/WVkLHRSaTc2++KbdRgtgqJb7G7aX5Xh2SAtY0FwAaD+F5YPDfBLQC2
        GB9XAdhdXglogY8vAVizJmOERQDHHs6i/xKGkULACPUAKi2VKPNYT2QOFa53YRgH94Kt6ut0
        wAF/CuCP3jDag+D5LGgpM3BojwA/C2fKPGgPG/eA7VPTbBrz8KOweL6SxYy5w/HBfITGNvgx
        WD3z1srrubC5K5augXgQ1CxsZmgBnO/TcRnsCtdeKa12CmYU1QAGp0JzicLqOQR7+4ZRugbB
        PWFTmzdDB8DvNfc5TLsdHPtqT9PIOizVP0AYmgfz7vAZ9zaoKxyyDjnCek25tVwEVWXTLOY2
        CgC1y2vsu2BL1f+xxwCogROZSEkjSWqPjLzhRYmlVKIs0utqnFQL1r9P/2rfcivo/B3RA3AM
        CDfxVCsvw/moOIlKlvYAiCFCB16ARBfO50nEybdIedxleWIsSfUAF4wtdOKlbJi5wMcjxQlk
        DEnGk/J/Kguzcc4ACsNSZ/oRd8dLob2vzU+CT2S1KsfZ/vanUs4HBzQG1fa75OlKQ/g7wdgU
        cnh21bMj+1NaboO/GxnX1fJr3+czfgKW2P2cRPZt/CeaE3Ex7aDd5IGPJx1iik5HrSgHFaup
        gceRAaElRD0V9GyHz9b9Zrfue1yB5lrj6G1TVWD73B8hm4oS796OyCnxX4c8Gy06AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42I5/e/4Xd2AW9tiDBat4bLYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht7jVIGOx6fE1VovLu+awWXzuPcJoMeP8PiaLtUfuslss
        vX6RyeJ24wo2i9a9R9gtDr9pZ3UQ8Fgzbw2jx6ZVnWwem5fUexx8t4fJo2/LKkaPz5vkAtii
        9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DLOtaxg
        LtjOV/H4ylLmBsb/3F2MnBwSAiYSey73MHYxcnEICSxllPj7eioLREJMYtK+7ewQtrDEn2td
        bBBFnxgl5rWuY+5i5OBgE9CT2LGqECQuIrCcUeLYqrfMIA6zwHQmiTvvroBNEhYIlfjSehXM
        ZhFQldh97z6YzSvgKdH3aiYTxAY5iZvnOplBbE4BL4l5D06BxYWAarYeWMAygZFvASPDKkaR
        1NLi3PTcYiO94sTc4tK8dL3k/NxNjMC42Hbs55YdjF3vgg8xCnAwKvHwrvi5NUaINbGsuDL3
        EKMEB7OSCK9jypYYId6UxMqq1KL8+KLSnNTiQ4ymQEdNZJYSTc4HxmxeSbyhqaG5haWhubG5
        sZmFkjjveYPKKCGB9MSS1OzU1ILUIpg+Jg5OqQZGybasyENm4of0wj8fyfwjEnn8CE93+JP6
        M3EZYhyPHtvWCR72f/PlF6NOaAt7PuvfbRk3/Iy7p5c1XvUz5e61l7yb+ardy7CypFhw0V7+
        me0e0qkMGdHPF85Rqvzx+2mPXqSsqbDYzLBVCzl4Vy10OiNX6JtYc08t9ZpoWsHp5sD7CmtT
        NJVYijMSDbWYi4oTAY8tmYyhAgAA
X-CMS-MailID: 20190417074832eucas1p26eca3ed8bf754787b4860206ba542e1c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190417074832eucas1p26eca3ed8bf754787b4860206ba542e1c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190417074832eucas1p26eca3ed8bf754787b4860206ba542e1c
References: <1555487288-4777-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190417074832eucas1p26eca3ed8bf754787b4860206ba542e1c@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support of a new feature which can be used in DT:
Performance Monitoring Unit with defined event data type.
In this patch the event data types are defined for Exynos PPMU.
The patch also updates the MAINTAINERS file accordingly.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 MAINTAINERS                           |  5 +++++
 include/dt-bindings/pmu/exynos_ppmu.h | 24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 include/dt-bindings/pmu/exynos_ppmu.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3671fde..f4aac78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12376,6 +12376,11 @@ L:	linux-scsi@vger.kernel.org
 S:	Supported
 F:	drivers/scsi/pm8001/
 
+PMU EXYNOS DT BINDINGS
+M:	Lukasz Luba <l.luba@partner.samsung.com>
+S:	Maintained
+F:	include/dt-bindings/pmu/exynos_ppmu.h
+
 PNP SUPPORT
 M:	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
 S:	Maintained
diff --git a/include/dt-bindings/pmu/exynos_ppmu.h b/include/dt-bindings/pmu/exynos_ppmu.h
new file mode 100644
index 0000000..a6971eb
--- /dev/null
+++ b/include/dt-bindings/pmu/exynos_ppmu.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Samsung Exynos PPMU event types for counting in regs
+ *
+ * Copyright (c) 2019, Samsung
+ * Author: Lukasz Luba <l.luba@partner.samsung.com>
+ */
+
+#ifndef __DT_BINDINGS_PMU_EXYNOS_PPMU_H
+#define __DT_BINDINGS_PMU_EXYNOS_PPMU_H
+
+
+#define PPMU_RO_BUSY_CYCLE_CNT		0x0
+#define PPMU_WO_BUSY_CYCLE_CNT		0x1
+#define PPMU_RW_BUSY_CYCLE_CNT		0x2
+#define PPMU_RO_REQUEST_CNT		0x3
+#define PPMU_WO_REQUEST_CNT		0x4
+#define PPMU_RO_DATA_CNT		0x5
+#define PPMU_WO_DATA_CNT		0x6
+#define PPMU_RO_LATENCY			0x12
+#define PPMU_WO_LATENCY			0x16
+#define PPMU_V2_EVT3_RW_DATA_CNT	0x22
+
+#endif
-- 
2.7.4

