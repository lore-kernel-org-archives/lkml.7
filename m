Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66639C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3711320449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="t6tSjPUY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfDSSi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:38:27 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36468 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbfDSSho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:37:44 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190419134824euoutp0195f32f152e9fce0dbf65c212999abfb1~W5ESJ8q1k0632706327euoutp01_
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 13:48:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190419134824euoutp0195f32f152e9fce0dbf65c212999abfb1~W5ESJ8q1k0632706327euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555681704;
        bh=DYDvjBZVL6sxzkf5UpTzzrSynrTk6h2kigPuEB7raUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t6tSjPUYVqfKVRWEss5F+WYENS/FS13+yxVPvRDJL7HkOMMCxJtLrR1QQ0HfRzTNe
         dixUP4Wd/qlyT1NFEFNDlmJBLdOdVlDbS605lWqd+k2UsCQGXQBJdn2r67sy+5oyhy
         0GFulPTXHprUcskBr759H+BV/Ex/y+nkD0J0KzKg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190419134823eucas1p2bb89a58c740a9880af70bdc7835bf980~W5ERcJXTE1565215652eucas1p25;
        Fri, 19 Apr 2019 13:48:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 6F.59.04377.7A1D9BC5; Fri, 19
        Apr 2019 14:48:23 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190419134822eucas1p29c6eff0f500311749b33c4f556123cf0~W5EQpTCcX1595215952eucas1p2v;
        Fri, 19 Apr 2019 13:48:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190419134822eusmtrp13e03066af8a25f1fa894a733d656f727~W5EQbSzkG2843728437eusmtrp1T;
        Fri, 19 Apr 2019 13:48:22 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-70-5cb9d1a7ac80
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5C.BE.04140.6A1D9BC5; Fri, 19
        Apr 2019 14:48:22 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190419134821eusmtip2c497e59b885d504df3f4296d051f84a1~W5EPwBBNT0862908629eusmtip2h;
        Fri, 19 Apr 2019 13:48:21 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org,
        l.luba@partner.samsung.com, willy.mh.wolff.ml@gmail.com
Subject: [PATCH v3 3/4] Documentation: devicetree: add PPMU events
 description
Date:   Fri, 19 Apr 2019 15:48:07 +0200
Message-Id: <1555681688-19643-4-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7djPc7rLL+6MMfiwWdBi44z1rBbXvzxn
        tZh/5ByrRf/j18wW589vYLc42/SG3eJWg4zFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y26x
        9PpFJovbjSvYLFr3HmG3OPymndXi24lHjA6CHmvmrWH02DnrLrvHplWdbB6bl9R7HHy3h8mj
        b8sqRo/Pm+QC2KO4bFJSczLLUov07RK4Mn7sec1YMIW7YvrCRewNjJs4uxg5OSQETCQW/fjL
        1sXIxSEksIJR4takRawQzhdGiYkfDrJAOJ8ZJX5/P84E0/Jk3XWoxHJGiZnT1zGDJMBaZlwW
        72Lk4GAT0JPYsaoQJCwisJhR4tvhKJB6ZoFlTBL7mj+BDRIWCJA493wamM0ioCpxp+c42Bxe
        AS+JFa8/Qi2Tk7h5rpMZZCangLfE8rdlIHMkBE6xS6w8cZ8dJC4h4CLR8IAXolxY4tXxLewQ
        tozE6ck9LBB2sURD70JGCLtG4nH/XKgaa4nDxy+ygoxhFtCUWL9LHyLsKLF5xV9GiOl8Ejfe
        CoKEmYHMSdumM0OEeSU62oQgqjUktvRcgLpXTGL5mmlQwz0kpkz+CQ2oeYwSxy6fYp7AKD8L
        YdkCRsZVjOKppcW56anFRnmp5XrFibnFpXnpesn5uZsYgSnp9L/jX3Yw7vqTdIhRgINRiYf3
        wKSdMUKsiWXFlbmHGCU4mJVEeB1TtsQI8aYkVlalFuXHF5XmpBYfYpTmYFES561meBAtJJCe
        WJKanZpakFoEk2Xi4JRqYOR2v3z64aSu1RGPow6lL/m+uzAwZy9Di7fl2YnB2yRPsX10EBE9
        8nSHYZl9zKJfPmFaVerOHaKVbPpCXTVy5QcaDK+bcXjKtzLe2njQ/1fNvMkJrfcbVV71LTpq
        kbWsRWzJtF03qp851As9nqJQe/hAvKltDWewbjjzrtuLtgvc6fKOPqivpsRSnJFoqMVcVJwI
        AGHcZG5FAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t/xe7rLLu6MMVj8Ucpi44z1rBbXvzxn
        tZh/5ByrRf/j18wW589vYLc42/SG3eJWg4zFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y26x
        9PpFJovbjSvYLFr3HmG3OPymndXi24lHjA6CHmvmrWH02DnrLrvHplWdbB6bl9R7HHy3h8mj
        b8sqRo/Pm+QC2KP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLL
        Uov07RL0Mn7sec1YMIW7YvrCRewNjJs4uxg5OSQETCSerLvO0sXIxSEksJRRYlfLJXaIhJjE
        pH3boWxhiT/Xutggij4xSky72AvkcHCwCehJ7FhVCBIXEVjOKHFs1VtmEIdZYBuTxJ4ruxlB
        ioQF/CSmXDcFGcQioCpxp+c4M4jNK+AlseL1RyaIBXISN891MoOUcwp4Syx/WwYSFgIquf78
        DPMERr4FjAyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAuNk27GfW3Ywdr0LPsQowMGoxMN7
        YNLOGCHWxLLiytxDjBIczEoivI4pW2KEeFMSK6tSi/Lji0pzUosPMZoC3TSRWUo0OR8Yw3kl
        8YamhuYWlobmxubGZhZK4rznDSqjhATSE0tSs1NTC1KLYPqYODilGhhvnDj2RjUh/HC3ynyv
        V2Yzgi+azlrad8zh87+X//8zMX3Uu2Lnxr9f80OBSMR01kUvJ29sv2nB1DLFZ2V4dqbr4gwn
        6fWTu7j8u7QUWPtYvuwK/WIekbbQ7n2Vk6ckU5XIdpd/eS5VZSENDgvmvHo8aeYVhiIx/VYH
        kZt/LaX+hp5zUO6fVKHEUpyRaKjFXFScCABgJZ9QqQIAAA==
X-CMS-MailID: 20190419134822eucas1p29c6eff0f500311749b33c4f556123cf0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419134822eucas1p29c6eff0f500311749b33c4f556123cf0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419134822eucas1p29c6eff0f500311749b33c4f556123cf0
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419134822eucas1p29c6eff0f500311749b33c4f556123cf0@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the documenation by events description with new 'event-data-type'
field. Add example how the event might be defined in DT.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 .../devicetree/bindings/devfreq/event/exynos-ppmu.txt  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
index 3e36c1d..47feb5f 100644
--- a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
+++ b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
@@ -145,3 +145,21 @@ Example3 : PPMUv2 nodes in exynos5433.dtsi are listed below.
 			reg = <0x104d0000 0x2000>;
 			status = "disabled";
 		};
+
+The 'event' type specified in the PPMU node defines 'event-name'
+which also contains 'id' number and optionally 'event-data-type'.
+
+Example:
+
+		events {
+			ppmu_leftbus_0: ppmu-event0-leftbus {
+				event-name = "ppmu-event0-leftbus";
+				event-data-type = <PPMU_RO_DATA_CNT>;
+			};
+		};
+
+The 'event-data-type' defines the type of data which shell be counted
+by the counter. You can check include/dt-bindings/pmu/exynos_ppmu.h for
+all possible type, i.e. count read requests, count write data in bytes,
+etc. This field is optional and when it is missing, the driver code will
+use default data type.
-- 
2.7.4

