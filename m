Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D12C5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C5C2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561725190;
	bh=MAkVtQ6KAiuAqiUPmPnM2G2oThXYbzASkll4xmdcnaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Uw4gXhrRqsuVgduGRqSwNW5KP1d2cHqSUvV8NvLq5UknopCjjd+KvL/W04j98478T
	 q/C7zu3m9TsCPX7yd1Il7d7VqaE2YfRDOHv2oZmkUTbLXHPXTvOcI8UQpVUoXMq0Ft
	 TDyp11xwFK6y3EM0x7D/ypUIxOFfM8xH1LS2Ofng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfF1MdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:33:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39198 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfF1Maj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JKCqIHV1YuF0BSogkUbroVBUzOT9ZPq/zkchQ58FrUY=; b=ZXy2eKnc4pRwloaqI3XC2oyCnO
        mSruPT4ToVz+viuoujlGR2Nb1bfe941rUUWhmbOJOSL2I6yy9IcrT1ncrEeUx4KxMP6My68U2RV/Y
        ulN/2Blm3ld+wtnPIi8+YdAaNZa0wIVp6OgB6R8DUlfcWmNTia2ZDUZG34pKk+bO+I30zP+XvXdTQ
        NhKas929i2SepX4p+LXsfa5bT0miQgebVn9zOrhK5tNR/TxxO7qUS0jwm9oXBMtfpcwcA0mdsPS23
        ZsBNOhQg2iNaIb3vgV1LPUtVBGc57PznVsqkBOUbSjq2k0QCv6euM1BGOzzF/2ohcn0UA6h/nNjt9
        MIc8A0PQ==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq1T-00054t-US; Fri, 28 Jun 2019 12:30:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgq1S-0005R9-0z; Fri, 28 Jun 2019 09:30:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <agross@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 03/39] docs: perf: move to the admin-guide
Date:   Fri, 28 Jun 2019 09:29:56 -0300
Message-Id: <cf054e7044bbba8d73ad032a0a1c9790afbfd510.1561724493.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf infrastructure is used for userspace to track issues.
At least a good part of what's described here is related to
it.

So, add it to the admin-guide.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/admin-guide/index.rst                    | 1 +
 Documentation/{ => admin-guide}/perf/arm-ccn.rst       | 0
 Documentation/{ => admin-guide}/perf/arm_dsu_pmu.rst   | 0
 Documentation/{ => admin-guide}/perf/hisi-pmu.rst      | 0
 Documentation/{ => admin-guide}/perf/index.rst         | 2 --
 Documentation/{ => admin-guide}/perf/qcom_l2_pmu.rst   | 0
 Documentation/{ => admin-guide}/perf/qcom_l3_pmu.rst   | 0
 Documentation/{ => admin-guide}/perf/thunderx2-pmu.rst | 0
 Documentation/{ => admin-guide}/perf/xgene-pmu.rst     | 0
 MAINTAINERS                                            | 4 ++--
 drivers/perf/qcom_l3_pmu.c                             | 2 +-
 11 files changed, 4 insertions(+), 5 deletions(-)
 rename Documentation/{ => admin-guide}/perf/arm-ccn.rst (100%)
 rename Documentation/{ => admin-guide}/perf/arm_dsu_pmu.rst (100%)
 rename Documentation/{ => admin-guide}/perf/hisi-pmu.rst (100%)
 rename Documentation/{ => admin-guide}/perf/index.rst (95%)
 rename Documentation/{ => admin-guide}/perf/qcom_l2_pmu.rst (100%)
 rename Documentation/{ => admin-guide}/perf/qcom_l3_pmu.rst (100%)
 rename Documentation/{ => admin-guide}/perf/thunderx2-pmu.rst (100%)
 rename Documentation/{ => admin-guide}/perf/xgene-pmu.rst (100%)

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 0066b198cad4..b7e6d18f80ca 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -38,6 +38,7 @@ problems and bugs in particular.
    ramoops
    dynamic-debug-howto
    init
+   perf/index
 
 This is the beginning of a section with information of interest to
 application developers.  Documents covering various aspects of the kernel
diff --git a/Documentation/perf/arm-ccn.rst b/Documentation/admin-guide/perf/arm-ccn.rst
similarity index 100%
rename from Documentation/perf/arm-ccn.rst
rename to Documentation/admin-guide/perf/arm-ccn.rst
diff --git a/Documentation/perf/arm_dsu_pmu.rst b/Documentation/admin-guide/perf/arm_dsu_pmu.rst
similarity index 100%
rename from Documentation/perf/arm_dsu_pmu.rst
rename to Documentation/admin-guide/perf/arm_dsu_pmu.rst
diff --git a/Documentation/perf/hisi-pmu.rst b/Documentation/admin-guide/perf/hisi-pmu.rst
similarity index 100%
rename from Documentation/perf/hisi-pmu.rst
rename to Documentation/admin-guide/perf/hisi-pmu.rst
diff --git a/Documentation/perf/index.rst b/Documentation/admin-guide/perf/index.rst
similarity index 95%
rename from Documentation/perf/index.rst
rename to Documentation/admin-guide/perf/index.rst
index 4bf848e27f26..9d445451ea18 100644
--- a/Documentation/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ===========================
 Performance monitor support
 ===========================
diff --git a/Documentation/perf/qcom_l2_pmu.rst b/Documentation/admin-guide/perf/qcom_l2_pmu.rst
similarity index 100%
rename from Documentation/perf/qcom_l2_pmu.rst
rename to Documentation/admin-guide/perf/qcom_l2_pmu.rst
diff --git a/Documentation/perf/qcom_l3_pmu.rst b/Documentation/admin-guide/perf/qcom_l3_pmu.rst
similarity index 100%
rename from Documentation/perf/qcom_l3_pmu.rst
rename to Documentation/admin-guide/perf/qcom_l3_pmu.rst
diff --git a/Documentation/perf/thunderx2-pmu.rst b/Documentation/admin-guide/perf/thunderx2-pmu.rst
similarity index 100%
rename from Documentation/perf/thunderx2-pmu.rst
rename to Documentation/admin-guide/perf/thunderx2-pmu.rst
diff --git a/Documentation/perf/xgene-pmu.rst b/Documentation/admin-guide/perf/xgene-pmu.rst
similarity index 100%
rename from Documentation/perf/xgene-pmu.rst
rename to Documentation/admin-guide/perf/xgene-pmu.rst
diff --git a/MAINTAINERS b/MAINTAINERS
index 9d3a408f5ce1..55996c9f2e0a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1139,7 +1139,7 @@ APPLIED MICRO (APM) X-GENE SOC PMU
 M:	Khuong Dinh <khuong@os.amperecomputing.com>
 S:	Supported
 F:	drivers/perf/xgene_pmu.c
-F:	Documentation/perf/xgene-pmu.rst
+F:	Documentation/admin-guide/perf/xgene-pmu.rst
 F:	Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt
 
 APTINA CAMERA SENSOR PLL
@@ -7207,7 +7207,7 @@ M:	Shaokun Zhang <zhangshaokun@hisilicon.com>
 W:	http://www.hisilicon.com
 S:	Supported
 F:	drivers/perf/hisilicon
-F:	Documentation/perf/hisi-pmu.rst
+F:	Documentation/admin-guide/perf/hisi-pmu.rst
 
 HISILICON ROCE DRIVER
 M:	Lijun Ou <oulijun@huawei.com>
diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
index 90f88ce5192b..656e830798d9 100644
--- a/drivers/perf/qcom_l3_pmu.c
+++ b/drivers/perf/qcom_l3_pmu.c
@@ -8,7 +8,7 @@
  * the slices. User space needs to aggregate to individual counts to provide
  * a global picture.
  *
- * See Documentation/perf/qcom_l3_pmu.rst for more details.
+ * See Documentation/admin-guide/perf/qcom_l3_pmu.rst for more details.
  *
  * Copyright (c) 2015-2017, The Linux Foundation. All rights reserved.
  */
-- 
2.21.0

