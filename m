Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8207CC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CD92176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="wIdnbQAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfLRONE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:13:04 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:38978 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727050AbfLROND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:13:03 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBIE2OSk010271;
        Wed, 18 Dec 2019 15:12:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=4pNlw7ywOUe0A9gsSO2NNL8Rt3wyL8H883y7Btdw/SQ=;
 b=wIdnbQACrXyoXNWT9zPx3Kd07hV/WL2pgrzANcPE07Cs48HWzXxQC60gJod8hBHiLHaD
 z1N3QNgvURql7ZQtkcyKRG+Qmqc80NVTUmAHtIpkr30nJ/El0Ojsj8QsyACikcH//pSO
 lbdO1ka9J1aS+dKOXDdB+b2hKcsPdWZM3Ij0F2piXkq2+wOzNFEtoJQJF5ebQ0MJRPhq
 ewXcvkN8V3coRIiDKM9mvx2LxIFFZM/JyWoS2BRk7bPY7IaVs8AMgRM8Wnj205FeRWBJ
 8yZ50dsjY1EvdJzftRXMEvCXZ6tO24Nl0iPHejtYCrr3bCdUnDV5UjJuGxQ26CFenpOR Vw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wvqgpvgh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Dec 2019 15:12:58 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7C23E100038;
        Wed, 18 Dec 2019 15:12:56 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 732D22BEAC2;
        Wed, 18 Dec 2019 15:12:56 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Dec 2019 15:12:56
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <arnaud.pouliquen@st.com>
Subject: [PATCH] component: fix debugfs.
Date:   Wed, 18 Dec 2019 15:12:07 +0100
Message-ID: <20191218141207.23156-1-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_03:2019-12-17,2019-12-18 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In component_devices_show function, the data field
of the component_match_array structure can not match with the
device structure type. As mentioned in component_match_add_release
description, data field type is undefined. This can result to an
unexpected print or can generate an overflow.
Seems no generic way to get the component name, so this patch
prints the component device name only if registered.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/base/component.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 532a3a5d8f63..3ce4f75a6610 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -102,11 +102,13 @@ static int component_devices_show(struct seq_file *s, void *data)
 	seq_printf(s, "%-40s %20s\n", "device name", "status");
 	seq_puts(s, "-------------------------------------------------------------\n");
 	for (i = 0; i < match->num; i++) {
-		struct device *d = (struct device *)match->compare[i].data;
+		struct component *comp = match->compare[i].component;
 
-		seq_printf(s, "%-40s %20s\n", dev_name(d),
-			   match->compare[i].component ?
-			   "registered" : "not registered");
+		if (comp)
+			seq_printf(s, "%-40s %20s\n", dev_name(comp->dev),
+				   "registered");
+		else
+			seq_printf(s, "%61s\n", "not registered");
 	}
 	mutex_unlock(&component_mutex);
 
-- 
2.17.1

