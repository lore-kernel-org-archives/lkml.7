Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCBBC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F63A222FC
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Lb5aU9z/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfHGJld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 05:41:33 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:20320 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726498AbfHGJlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 05:41:31 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x779b0go000392;
        Wed, 7 Aug 2019 11:41:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=P2Lxpk/eGcloJl8K8e2dAEZgux/iin59KPH93G5OUOM=;
 b=Lb5aU9z/qLBDpv1n8TpYqNBqTSvNk0DeVyC+HQ2xTeRhy9fEXQ1y4vay2Y6fLxCLmBxp
 qR6vW5l63nLazlhuw9Gsx4iGMjlF1FoiO2+oNLS4LJJA79etTfYVc5uKvwzv1o6V1Kqd
 KIDYUP//efwc0lDnZ0sIpOivYyINuNLotz0jvdNgwjvQYyc+t/ns+bCNPcjSjOTKknYV
 IJCn67X2vtMJ2CXDuoxTr1mnJfxbvP9c9bWNIH5hNfDnK8Z9YVG63SWoSGd8ax4r98qe
 sZGnlYQ2qGmUhu34Ctc3FWcaJP5Jhl3wJl0dKo14al4uSTwDI8bHvn8jPh+zBsYeszbR iw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2u501v61jx-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 07 Aug 2019 11:41:26 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BAC4D41;
        Wed,  7 Aug 2019 09:41:25 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A69712DAD92;
        Wed,  7 Aug 2019 11:41:25 +0200 (CEST)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 7 Aug 2019
 11:41:25 +0200
Received: from localhost (10.201.20.178) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 7 Aug 2019 11:41:24
 +0200
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <fabien.dessenne@st.com>, <s-anna@ti.com>,
        Loic Pallardy <loic.pallardy@st.com>
Subject: [RESEND 1/2] remoteproc: replace bool from struct rproc by u8
Date:   Wed, 7 Aug 2019 11:41:18 +0200
Message-ID: <1565170879-3185-2-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565170879-3185-1-git-send-email-loic.pallardy@st.com>
References: <1565170879-3185-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-07_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Post [1] and checkpatch tool indicate that usage of bool type
in structure is now no more allowed/advised.
This patch replaces bool by unsigned char (u8) and reorders
struct rproc fields to avoid padding.

[1] https://lkml.org/lkml/2017/11/21/384

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 include/linux/remoteproc.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 16ad66683ad0..8cd22fecea61 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -472,15 +472,15 @@ struct rproc_dump_segment {
  * @index: index of this rproc device
  * @crash_handler: workqueue for handling a crash
  * @crash_cnt: crash counter
- * @recovery_disabled: flag that state if recovery was disabled
  * @max_notifyid: largest allocated notify id.
  * @table_ptr: pointer to the resource table in effect
  * @cached_table: copy of the resource table
  * @table_sz: size of @cached_table
- * @has_iommu: flag to indicate if remote processor is behind an MMU
- * @auto_boot: flag to indicate if remote processor should be auto-started
  * @dump_segments: list of segments in the firmware
  * @nb_vdev: number of vdev currently handled by rproc
+ * @recovery_disabled: flag that state if recovery was disabled
+ * @has_iommu: flag to indicate if remote processor is behind an MMU
+ * @auto_boot: flag to indicate if remote processor should be auto-started
  */
 struct rproc {
 	struct list_head node;
@@ -505,15 +505,15 @@ struct rproc {
 	int index;
 	struct work_struct crash_handler;
 	unsigned int crash_cnt;
-	bool recovery_disabled;
 	int max_notifyid;
 	struct resource_table *table_ptr;
 	struct resource_table *cached_table;
 	size_t table_sz;
-	bool has_iommu;
-	bool auto_boot;
 	struct list_head dump_segments;
 	int nb_vdev;
+	u8 recovery_disabled;
+	u8 has_iommu;
+	u8 auto_boot;
 };
 
 /**
-- 
2.7.4

