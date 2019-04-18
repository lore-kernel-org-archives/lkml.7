Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99C4C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB2420693
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="up8f4/Iz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389119AbfDRNi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:38:57 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49706 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389093AbfDRNiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:38:55 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190418133854euoutp0224a6e11f0fcf44cf1d83029542349266~WlSs9tp_g0788107881euoutp02G
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 13:38:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190418133854euoutp0224a6e11f0fcf44cf1d83029542349266~WlSs9tp_g0788107881euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555594734;
        bh=7cjJVb3VI4Rewv1loqT5RQMPb21HM1f08DfLAyKWsPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=up8f4/IzGSZLTU5PoqdahTqXBDP3tI1CKMDKZPSWF6sXY9oq4FqAlRFXldfn4vNNC
         dU9Moml/5EMxgHZ7PeXue79NgXy6QRXkB+LdFWrQwKZx1VCOyPJNl9T8DRti2KxnyL
         rMqbEyLbsnz3+p+3XnY6/XRD78T49GSBh+7tv7mY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190418133852eucas1p2ebbe0543263b103a9fe4ca3a7f506204~WlSri9dlJ2704327043eucas1p2f;
        Thu, 18 Apr 2019 13:38:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 54.82.04325.CED78BC5; Thu, 18
        Apr 2019 14:38:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190418133851eucas1p192c8530255d6a4ce2aa8d8115f84a3db~WlSqqwBxt2247222472eucas1p14;
        Thu, 18 Apr 2019 13:38:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190418133851eusmtrp15386fa27ec50134c4c77f85c9e123355~WlSqcn-_s2480124801eusmtrp1R;
        Thu, 18 Apr 2019 13:38:51 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-b4-5cb87dec6abc
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8C.66.04146.BED78BC5; Thu, 18
        Apr 2019 14:38:51 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190418133850eusmtip21b6273cfda26c84d180b36bd1efc689c~WlSptywPB1998719987eusmtip2a;
        Thu, 18 Apr 2019 13:38:50 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org,
        l.luba@partner.samsung.com, willy.mh.wolff.ml@gmail.com
Subject: [PATCH v2 1/4] include: dt-bindings: add Performance Monitoring
 Unit for Exynos
Date:   Thu, 18 Apr 2019 15:38:29 +0200
Message-Id: <1555594712-18341-2-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555594712-18341-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfSyUcRz3u+eeex7meFwvvsnYbrWVDTVtfi0rNq2r1qp/0erKM4xT3RMi
        RYpSKukFNydWYU+Ec9l1oeJyVsvLshTTjIo4mbebppSn51r/ffZ5+X4+++1HE4oG0ouOSzzF
        ahPVCUqZi7Sx/Uenv+2sKWrTt37A9UW1JO6bGyXxPUsniW+MTBC4q6uOwm+zbBTuz/TGhpH3
        JH5nLpHh2WsWhIu6WiS4xjJI4Yd9PRI8cL5KhrObLRRus10isb1jGIV6qKpLq5HqqW6QUhn4
        XJmq4UGG6uX3JonqupFHqlmDzwEqwiUkmk2IS2a1gduPuMQOGPXSExXup/P1BiITTbheQc40
        MFug7OM0cQW50AqmCkHhr2xCEBTMHIL5rymiMIug7l299F+ia6ZEIgqVCHI6DI74cmJpPn/Z
        RdMyJgBM/EkhsJK5j8DeFiF4CKZCAi0XZiSCsIKJgM9P8mQCljLrob5ggRCycmYP8HyaWOYD
        Hztz/y5yZvbCnLmFFO4A85qCpupiJJrCgR9/LBHxChi3GikRe8ObW3mO1RxkXit3+NNh5Ibe
        4dkGbdYeUuglmI1Qaw4U6TAoLxlFAg2MG3yY9BBoYhkWNBYSIi2HyzkK0b0BjHndjgGrobL6
        ruO4CpaMF2Xi65QiGHqmI/ORr+5/WRlCPPJkkzhNDMsFJbIpAZxawyUlxgQcO64xoOWv9GbJ
        Om9CLT+PtiKGRkpXOcSZohSkOplL1bQioAnlSnlYtDFKIY9Wp6ax2uOHtUkJLNeK1tJSpaf8
        jNNQpIKJUZ9i41n2BKv9p0poZ69MpO4dKwulmW733qjgmcB954J9+eeWKZ3edzfmm3U7UuLN
        dpt+F+3u3z48sI6dejH34U7o1aGF2v2H0pKDQ9qsTm5rOpB5uuZVltfr0a2Ri7crdn4ydxzU
        WssDbY/I98qbGX7TYxG2GXfK6r1Y3Bfe+iVo1eRv++bd9s6A1JT0SKWUi1Vv9iO0nPoPjQL2
        GUYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t/xe7qva3fEGNy6KWOxccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbnGrQcZi0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbdY
        ev0ik8XtxhVsFq17j7BbHH7Tzmrx7cQjRgdBjzXz1jB67Jx1l91j06pONo/NS+o9Dr7bw+TR
        t2UVo8fnTXIB7FF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZll
        qUX6dgl6Gbe3zGUpWMZfMWHuJuYGxtc8XYycHBICJhLnP81h6mLk4hASWMoo8WVpFzNEQkxi
        0r7t7BC2sMSfa11sILaQwCdGiRt/S7oYOTjYBPQkdqwqBOkVEVjOKHFs1VtmEIdZYBuTxJ4r
        uxlBGoQFIiT27FzECmKzCKhKbJz0gxmkmVfAS2LVqiqI+XISN891gu3lFPCW+LJrHyvELi+J
        fTt+sExg5FvAyLCKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjME62Hfu5eQfjpY3BhxgFOBiV
        eHglMnfECLEmlhVX5h5ilOBgVhLhdUzZEiPEm5JYWZValB9fVJqTWnyI0RToponMUqLJ+cAY
        ziuJNzQ1NLewNDQ3Njc2s1AS5z1vUBklJJCeWJKanZpakFoE08fEwSnVwKiQfl7sw4Ztilvf
        2V2/+Ez1RJHx+9t8kao5d2pn/PLw3tC1mTUl65X4xdyJyloX2DRq8r0K1vhw72rQ322wMLq4
        K+NqV9GDeVlfBGV7Zrxx4Wm5ey74vLC82I8Y/sS5B1vEt0wsynOL75jF171AJ/TU/7CVl6PC
        ZtnVKCXoPHv3VZgrODo5Q4mlOCPRUIu5qDgRAMc+MNCpAgAA
X-CMS-MailID: 20190418133851eucas1p192c8530255d6a4ce2aa8d8115f84a3db
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190418133851eucas1p192c8530255d6a4ce2aa8d8115f84a3db
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190418133851eucas1p192c8530255d6a4ce2aa8d8115f84a3db
References: <1555594712-18341-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190418133851eucas1p192c8530255d6a4ce2aa8d8115f84a3db@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support of a new feature which can be used in DT:
Performance Monitoring Unit with defined event data type.
In this patch the event data types are defined for Exynos PPMU.
The patch also updates the MAINTAINERS file accordingly and
adds the header file to devfreq event subsystem.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 MAINTAINERS                           |  1 +
 include/dt-bindings/pmu/exynos_ppmu.h | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 include/dt-bindings/pmu/exynos_ppmu.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3671fde..1ba4b9b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4560,6 +4560,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
 S:	Supported
 F:	drivers/devfreq/event/
 F:	drivers/devfreq/devfreq-event.c
+F:	include/dt-bindings/pmu/exynos_ppmu.h
 F:	include/linux/devfreq-event.h
 F:	Documentation/devicetree/bindings/devfreq/event/
 
diff --git a/include/dt-bindings/pmu/exynos_ppmu.h b/include/dt-bindings/pmu/exynos_ppmu.h
new file mode 100644
index 0000000..08fdce9
--- /dev/null
+++ b/include/dt-bindings/pmu/exynos_ppmu.h
@@ -0,0 +1,26 @@
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
+#define PPMU_V2_RO_DATA_CNT		0x4
+#define PPMU_V2_WO_DATA_CNT		0x5
+#define PPMU_V2_EVT3_RW_DATA_CNT	0x22
+
+#endif
-- 
2.7.4

