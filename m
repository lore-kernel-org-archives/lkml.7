Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD5BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2D82075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="zIVtc8vd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfC0O0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:26:02 -0400
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:63613 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726147AbfC0O0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1553696761; x=1585232761;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=APGFYem9Z/+mrl1Cgr1awOzTT4/uhjJN2ut5zsHMZS8=;
  b=zIVtc8vde+AyF38X8v90NtlphmmOQtzbPFHqB8ZaasPgik4c+RePaxsX
   I4zao4O3Lr6nvEnbxCeD4B5jW9PYibJdHVBWWqlwvTaxze9NVs6hOzCF4
   1e4S+vpTH4JzIaqvyXL9Da8kXmTOKuaVRC69PoYPYvWSc3xtpeplnX2Xc
   k=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EUAAAHh5tchyeV50NjHQEBBQEHBQG?=
 =?us-ascii?q?BUQgBCwGCeIEDJ4QOiBxflgqPBIF7DQEBIwuEPoUxIjQJDQEBAwEBCQEDAgE?=
 =?us-ascii?q?BAhABAQEKCwkIKSMMgjopARRNawEBAQEBASMCDWYWEQ8BRjUCGA4CIzwBEiK?=
 =?us-ascii?q?DAAGBXQMVD51cPQJvgQGJBwEBAW+BL4gADYIaBYELJAGGaYRIgVc/hGGCGkc?=
 =?us-ascii?q?EGIRRglcDkkKSMzYHAoJLBIUdiByDPwIYlAsBiyyGCYE8i3UCBAIEBQIVgU2?=
 =?us-ascii?q?CD3CDPIIWDgmIX4VdIgExAY90AQE?=
X-IPAS-Result: =?us-ascii?q?A2EUAAAHh5tchyeV50NjHQEBBQEHBQGBUQgBCwGCeIEDJ?=
 =?us-ascii?q?4QOiBxflgqPBIF7DQEBIwuEPoUxIjQJDQEBAwEBCQEDAgEBAhABAQEKCwkIK?=
 =?us-ascii?q?SMMgjopARRNawEBAQEBASMCDWYWEQ8BRjUCGA4CIzwBEiKDAAGBXQMVD51cP?=
 =?us-ascii?q?QJvgQGJBwEBAW+BL4gADYIaBYELJAGGaYRIgVc/hGGCGkcEGIRRglcDkkKSM?=
 =?us-ascii?q?zYHAoJLBIUdiByDPwIYlAsBiyyGCYE8i3UCBAIEBQIVgU2CD3CDPIIWDgmIX?=
 =?us-ascii?q?4VdIgExAY90AQE?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa4.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Mar 2019 09:26:00 -0500
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2RENFBr189159;
        Wed, 27 Mar 2019 10:26:00 -0400
Received: from esa2.dell-outbound2.iphmx.com (esa2.dell-outbound2.iphmx.com [68.232.153.202])
        by mx0a-00154901.pphosted.com with ESMTP id 2rg8uprx5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Mar 2019 10:26:00 -0400
Received: from ausxippc110.us.dell.com ([143.166.85.200])
  by esa2.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Mar 2019 20:25:57 +0600
X-LoopCount0: from 10.173.37.27
X-IronPort-AV: E=Sophos;i="5.60,277,1549951200"; 
   d="scan'208";a="770865619"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH] platform/x86: dell-laptop: fix rfkill functionality
Date:   Wed, 27 Mar 2019 09:25:34 -0500
Message-Id: <1553696734-31282-1-git-send-email-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-27_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903270101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When converting the driver two arguments were transposed leading
to rfkill not working.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=201427
Reported-by: Pepijn de Vos <pepijndevos@gmail.com>
Fixes: 549b49 ("platform/x86: dell-smbios: Introduce dispatcher for SMM calls")
Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
Acked-by: Pali Rohár <pali.rohar@gmail.com>
---
 drivers/platform/x86/dell-laptop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
index 95e6ca1..a561f65 100644
--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -531,7 +531,7 @@ static void dell_rfkill_query(struct rfkill *rfkill, void *data)
 		return;
 	}
 
-	dell_fill_request(&buffer, 0, 0x2, 0, 0);
+	dell_fill_request(&buffer, 0x2, 0, 0, 0);
 	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_RFKILL);
 	hwswitch = buffer.output[1];
 
@@ -562,7 +562,7 @@ static int dell_debugfs_show(struct seq_file *s, void *data)
 		return ret;
 	status = buffer.output[1];
 
-	dell_fill_request(&buffer, 0, 0x2, 0, 0);
+	dell_fill_request(&buffer, 0x2, 0, 0, 0);
 	hwswitch_ret = dell_send_request(&buffer, CLASS_INFO, SELECT_RFKILL);
 	if (hwswitch_ret)
 		return hwswitch_ret;
@@ -647,7 +647,7 @@ static void dell_update_rfkill(struct work_struct *ignored)
 	if (ret != 0)
 		return;
 
-	dell_fill_request(&buffer, 0, 0x2, 0, 0);
+	dell_fill_request(&buffer, 0x2, 0, 0, 0);
 	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_RFKILL);
 
 	if (ret == 0 && (status & BIT(0)))
-- 
2.7.4

