Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B777C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23E2204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ceg8JjVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfDSSh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:37:58 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52271 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbfDSShy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:37:54 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190419134822euoutp027bb184517efc014a9073b7cb7945d4f1~W5EP-yk9-0662906629euoutp02-
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 13:48:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190419134822euoutp027bb184517efc014a9073b7cb7945d4f1~W5EP-yk9-0662906629euoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555681702;
        bh=7cjJVb3VI4Rewv1loqT5RQMPb21HM1f08DfLAyKWsPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ceg8JjVWJ/rQKpfVe5um+ZCBRJJ0Xh+02u+hfCfZXaSwO/Iu//iv5fs9CFHXIiDTw
         xvLNufTRnjZrzlHl1UUABVOJqkZbR1bQq1L+WKd8TXLmyREeF70VbbUN2akiANOmnP
         nG1A36gFT0WuEliPS4ME7dnT4DFcFCs1/kYIJB1Y=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190419134821eucas1p1a89011acc93eb3522f545d80b5238b99~W5EPTA9Cv1720317203eucas1p1p;
        Fri, 19 Apr 2019 13:48:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id CC.59.04377.4A1D9BC5; Fri, 19
        Apr 2019 14:48:20 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190419134820eucas1p154e839769af0e1b8bae17ce3efa0ba93~W5EOaIG7V0556405564eucas1p1H;
        Fri, 19 Apr 2019 13:48:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190419134820eusmtrp14e775b1765e6a96b2cffeed5e381837d~W5EOMHdiC2847828478eusmtrp1E;
        Fri, 19 Apr 2019 13:48:20 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-68-5cb9d1a44d2a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 69.BE.04140.3A1D9BC5; Fri, 19
        Apr 2019 14:48:20 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190419134819eusmtip27326f751da252e269e886d113ec5ae5d~W5ENghLaL0928709287eusmtip2I;
        Fri, 19 Apr 2019 13:48:19 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org,
        l.luba@partner.samsung.com, willy.mh.wolff.ml@gmail.com
Subject: [PATCH v3 1/4] include: dt-bindings: add Performance Monitoring
 Unit for Exynos
Date:   Fri, 19 Apr 2019 15:48:05 +0200
Message-Id: <1555681688-19643-2-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSbUhTYRTHfe7ddu/U5XWaPi0zmAUapCVGTxSl6IdZX4L6UGtkMy8quWm7
        alpB00hTNEWxzJzL9xc013UtlZSarym6pFDTjHKR+RaYZgkVebtW337nf/7nfx4OD4lLWaGM
        jNUm0jqtOk4uchRYetdsu6tG2lR7Ku8dQA+Lm4VobGVGiIzdw0KUZ5/Hkc1mItBQ+gKBJvRe
        iLWPCtHL9lIRWs7tBqjY1omhpu4pAlWPjWBoMq1OhG50dBOoayFTiFb7p0Gwq6KxrBEo2kqm
        CAXbkCVStFRdUzz7/ART3DI3AMUy632cUDoeiqLjYpNpXcDhc44xk2aDIKHGJSXfwOJ6MO+c
        DUgSUkEwZ0KWDRxJKVUHYFFaoYgvVgA0ZfRgfLEMYMFUBcgG4j8TM316nG/UAjhjuCv4N7L0
        wUhwuSLKH7Y2XOQG3KlKAFe7lJwHp2ow2Hn9C8Y13CglHP9ZSHAsoHZCW0u9iGMJdRQOLllw
        fps3fD2chXOZYuoYrF1M5uUBAmYt+/IcBsvfD2w8zg3O9ZkJnr3gYGGOgGcG6nPLNzxXoT3P
        sOE5CLv6RoRcPE75web2AF4OgW+MrRh/oU1wfNGVk/F1LLDcwXlZAm9mSHm3LzTnvMB49oC1
        jbc3whVwaq4I8McpA7C+4DGeD7aX/F92H4AG4EknMZpomgnU0pf8GbWGSdJG+5+P17Bg/ScN
        /upbaQXtPyKtgCKB3FnytKBNJRWqk5lUjRVAEpe7S0KizCqpJEqdepnWxUfokuJoxgq2kgK5
        p+SKw7szUipanUhfoOkEWve3i5FimR7sM/ZbNpf6FIX3RtCZkamfYsNmjYyryaXcy6s0XRr+
        IMRg8p11D6YWAte0c9P7nfymU8QV8fQrzCSr1wYRyuri4Ca29vTqc4/Rsz1jmslQK9sx8HEH
        a5ccUW4Z8BmSbdNYSPdvq9pTFU7fTwyJe3JVZGl6qMPXhJi3jxZOxssFTIx67y5cx6h/A2eg
        fHRFAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xe7pLLu6MMTjyjNFi44z1rBbXvzxn
        tZh/5ByrRf/j18wW589vYLc42/SG3eJWg4zFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y26x
        9PpFJovbjSvYLFr3HmG3OPymndXi24lHjA6CHmvmrWH02DnrLrvHplWdbB6bl9R7HHy3h8mj
        b8sqRo/Pm+QC2KP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLL
        Uov07RL0Mm5vmctSsIy/YsLcTcwNjK95uhg5OSQETCSeH29g7mLk4hASWMooMefCBEaIhJjE
        pH3b2SFsYYk/17rYIIo+MUqsWtPL2sXIwcEmoCexY1UhSFxEYDmjxLFVb8EmMQtsY5LYc2U3
        2CRhgQiJ/Q132EBsFgFVifObV4LZvAJeEqc/bmOG2CAncfNcJzPIUE4Bb4nlb8tAwkJAJdef
        n2GewMi3gJFhFaNIamlxbnpusZFecWJucWleul5yfu4mRmCkbDv2c8sOxq53wYcYBTgYlXh4
        D0zaGSPEmlhWXJl7iFGCg1lJhNcxZUuMEG9KYmVValF+fFFpTmrxIUZToJsmMkuJJucDoziv
        JN7Q1NDcwtLQ3Njc2MxCSZz3vEFllJBAemJJanZqakFqEUwfEwenVAPj6lUeQcwLr9oX5Cw+
        PZ1xlXDeKqsnu3l8vYTc36fYr3tvObPd9sKCXun/v9X36D5gPnfcVkpR4tGkv79sHM8cFS9l
        vntv3v1X3oXnXIP0a+JDfxWfPN6z+q/tst/vCtjPJvmV/LsrJf2mc/nms2rvZO78W3Jttm+f
        2T4TMYb9IucMZri/9RA4psRSnJFoqMVcVJwIAG3f1QOqAgAA
X-CMS-MailID: 20190419134820eucas1p154e839769af0e1b8bae17ce3efa0ba93
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419134820eucas1p154e839769af0e1b8bae17ce3efa0ba93
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419134820eucas1p154e839769af0e1b8bae17ce3efa0ba93
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419134820eucas1p154e839769af0e1b8bae17ce3efa0ba93@eucas1p1.samsung.com>
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

