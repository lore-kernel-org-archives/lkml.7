Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB0AC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D179620883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="GUBckHGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfDIGQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 02:16:14 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:17534 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726062AbfDIGQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 02:16:11 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3969ADr001591;
        Tue, 9 Apr 2019 08:15:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=RWmNuDPXr7RK3mH1Z/MT404kTSZ3CLUUERUEjjcPdqI=;
 b=GUBckHGVLhpDjgzHtYwaIMfyZW2Q3zNlTNWnf0RPsKKYNeehfRkK5q3fbQDpqGnN3/ic
 xJWtHudbgSrf8B9eXHb1F1CGDmi1a54s8X8RxzmDWOREYF1cDHchhzYTGDvGonNx3vip
 UjVFgRCplBOnkxXg/rtIt0GT1fCjB/Ot4nAeVjuNDU6AVumXFb8x5Da1CiEsC4dWWaeq
 5KfeVhrA46uZwIjvey10PY7G8P0rthLnTCJE8aB0zxiXO5i47+8J8ENIzL2+Ozb7jHWb
 2OO64D6iuaNtdQF7Xr69RHig3VxK+1W2k/IIsdtp1nAU9qmQBzugPocH8ylEDBvw1hEQ 4w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rprcnxrg1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 09 Apr 2019 08:15:58 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 28CE138;
        Tue,  9 Apr 2019 06:15:57 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0293E2411;
        Tue,  9 Apr 2019 06:15:57 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 9 Apr 2019
 08:15:56 +0200
Received: from localhost (10.129.172.100) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 9 Apr 2019 08:15:56
 +0200
From:   Mickael Guene <mickael.guene@st.com>
To:     <linux-media@vger.kernel.org>
CC:     <hugues.fruchet@st.com>, Mickael Guene <mickael.guene@st.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-kernel@vger.kernel.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        "Sakari Ailus" <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>
Subject: [PATCH v5 1/3] media: uapi: Add MEDIA_BUS_FMT_BGR888_3X8 media bus format
Date:   Tue, 9 Apr 2019 08:15:47 +0200
Message-ID: <1554790549-795-2-git-send-email-mickael.guene@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554790549-795-1-git-send-email-mickael.guene@st.com>
References: <1554790549-795-1-git-send-email-mickael.guene@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.172.100]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-09_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds MEDIA_BUS_FMT_BGR888_3X8 used by STM MIPID02 CSI-2 to
PARALLEL bridge driver when input format is MEDIA_BUS_FMT_BGR888_1X24.

Signed-off-by: Mickael Guene <mickael.guene@st.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 Documentation/media/uapi/v4l/subdev-formats.rst | 107 ++++++++++++++++++++++++
 include/uapi/linux/media-bus-format.h           |   3 +-
 2 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/Documentation/media/uapi/v4l/subdev-formats.rst b/Documentation/media/uapi/v4l/subdev-formats.rst
index bf1dbb6..ab1a48a 100644
--- a/Documentation/media/uapi/v4l/subdev-formats.rst
+++ b/Documentation/media/uapi/v4l/subdev-formats.rst
@@ -980,6 +980,113 @@ The following tables list existing packed RGB formats.
       - r\ :sub:`2`
       - r\ :sub:`1`
       - r\ :sub:`0`
+    * .. _MEDIA-BUS-FMT-BGR888-3X8:
+
+      - MEDIA_BUS_FMT_BGR888_3X8
+      - 0x101b
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      - b\ :sub:`7`
+      - b\ :sub:`6`
+      - b\ :sub:`5`
+      - b\ :sub:`4`
+      - b\ :sub:`3`
+      - b\ :sub:`2`
+      - b\ :sub:`1`
+      - b\ :sub:`0`
+    * -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      - g\ :sub:`7`
+      - g\ :sub:`6`
+      - g\ :sub:`5`
+      - g\ :sub:`4`
+      - g\ :sub:`3`
+      - g\ :sub:`2`
+      - g\ :sub:`1`
+      - g\ :sub:`0`
+    * -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      - r\ :sub:`7`
+      - r\ :sub:`6`
+      - r\ :sub:`5`
+      - r\ :sub:`4`
+      - r\ :sub:`3`
+      - r\ :sub:`2`
+      - r\ :sub:`1`
+      - r\ :sub:`0`
     * .. _MEDIA-BUS-FMT-GBR888-1X24:
 
       - MEDIA_BUS_FMT_GBR888_1X24
diff --git a/include/uapi/linux/media-bus-format.h b/include/uapi/linux/media-bus-format.h
index d6a5a3b..2a6b253 100644
--- a/include/uapi/linux/media-bus-format.h
+++ b/include/uapi/linux/media-bus-format.h
@@ -34,7 +34,7 @@
 
 #define MEDIA_BUS_FMT_FIXED			0x0001
 
-/* RGB - next is	0x101b */
+/* RGB - next is	0x101c */
 #define MEDIA_BUS_FMT_RGB444_1X12		0x1016
 #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_BE	0x1001
 #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_LE	0x1002
@@ -50,6 +50,7 @@
 #define MEDIA_BUS_FMT_RGB666_1X24_CPADHI	0x1015
 #define MEDIA_BUS_FMT_RGB666_1X7X3_SPWG		0x1010
 #define MEDIA_BUS_FMT_BGR888_1X24		0x1013
+#define MEDIA_BUS_FMT_BGR888_3X8		0x101b
 #define MEDIA_BUS_FMT_GBR888_1X24		0x1014
 #define MEDIA_BUS_FMT_RGB888_1X24		0x100a
 #define MEDIA_BUS_FMT_RGB888_2X12_BE		0x100b
-- 
2.7.4

