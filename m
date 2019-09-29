Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AA9C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 01:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8BC2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 01:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C1tfZGnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbfI3BKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 21:10:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56366 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfI3BKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 21:10:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8U19EDc076388;
        Mon, 30 Sep 2019 01:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=uwCXFHlJd2B1/PKbzywBNpvjq5UhBT1+c5P8jSdWQuM=;
 b=C1tfZGnVDQgP44dlc/8P8uDKTzOM3fvfy0DG0mMlPpj2O7eIlif6vjWBCDXR29p9/02A
 SM4xxWk7p7wtyCb8erS0B/BurDdnMwrNOkuYR2qmXPhve6aDhLDPb42kAz/GzDGntPAr
 lcJVaJypUhiIWZpIqyE0Qof9dsRGma36UBMB5pdQrbzBY+/z7lS+UDYl2tGlkBLNIzEg
 JeoHzQcb9BLYQXCoAY1qBbdPmFI/ciAFEfR7qByZnsY9W8X+YTD3ID2v8k6MrNVt6ExY
 9WmYrI1mJU9JG0dxgkIysr5vVmM7CsCpp14dU7HtDUwwqiizLaCLv2DTQpIHOgG5lFT0 HQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2va05rbnt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Sep 2019 01:09:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8U18gpE094648;
        Mon, 30 Sep 2019 01:09:25 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2vah1gw30n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Sep 2019 01:09:25 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8U19Faf032183;
        Mon, 30 Sep 2019 01:09:15 GMT
Received: from z2.cn.oracle.com (/10.182.71.205)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 29 Sep 2019 18:09:15 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Josh Boyer <jwboyer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH] acpi: Mute gcc warning
Date:   Sun, 29 Sep 2019 09:13:52 +0800
Message-Id: <1569719633-32164-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9395 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909300010
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9395 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909300011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When build with "EXTRA_CFLAGS=-Wall" gcc warns:

arch/x86/boot/compressed/acpi.c:29:30: warning: get_cmdline_acpi_rsdp defined but not used [-Wunused-function]

Fixes: 41fa1ee9c6d6 ("acpi: Ignore acpi_rsdp kernel param when the kernel has been locked down")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Josh Boyer <jwboyer@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 arch/x86/boot/compressed/acpi.c | 48 ++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 149795c..25019d4 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -21,30 +21,6 @@
 struct mem_vector immovable_mem[MAX_NUMNODES*2];
 
 /*
- * Max length of 64-bit hex address string is 19, prefix "0x" + 16 hex
- * digits, and '\0' for termination.
- */
-#define MAX_ADDR_LEN 19
-
-static acpi_physical_address get_cmdline_acpi_rsdp(void)
-{
-	acpi_physical_address addr = 0;
-
-#ifdef CONFIG_KEXEC
-	char val[MAX_ADDR_LEN] = { };
-	int ret;
-
-	ret = cmdline_find_option("acpi_rsdp", val, MAX_ADDR_LEN);
-	if (ret < 0)
-		return 0;
-
-	if (kstrtoull(val, 16, &addr))
-		return 0;
-#endif
-	return addr;
-}
-
-/*
  * Search EFI system tables for RSDP.  If both ACPI_20_TABLE_GUID and
  * ACPI_TABLE_GUID are found, take the former, which has more features.
  */
@@ -298,6 +274,30 @@ acpi_physical_address get_rsdp_addr(void)
 }
 
 #if defined(CONFIG_RANDOMIZE_BASE) && defined(CONFIG_MEMORY_HOTREMOVE)
+/*
+ * Max length of 64-bit hex address string is 19, prefix "0x" + 16 hex
+ * digits, and '\0' for termination.
+ */
+#define MAX_ADDR_LEN 19
+
+static acpi_physical_address get_cmdline_acpi_rsdp(void)
+{
+	acpi_physical_address addr = 0;
+
+#ifdef CONFIG_KEXEC
+	char val[MAX_ADDR_LEN] = { };
+	int ret;
+
+	ret = cmdline_find_option("acpi_rsdp", val, MAX_ADDR_LEN);
+	if (ret < 0)
+		return 0;
+
+	if (kstrtoull(val, 16, &addr))
+		return 0;
+#endif
+	return addr;
+}
+
 /* Compute SRAT address from RSDP. */
 static unsigned long get_acpi_srat_table(void)
 {
-- 
1.8.3.1

