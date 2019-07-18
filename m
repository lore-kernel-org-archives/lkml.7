Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E967C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4814420873
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2jcOh1bP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732718AbfGRSDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 14:03:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60360 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfGRSDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 14:03:19 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6IHx7EU122228;
        Thu, 18 Jul 2019 18:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=nGM+TFa+P/Arh/z0uyq1lS3KstmUHzzsTf+kS9cTjgw=;
 b=2jcOh1bP4oMsf+o5Nsm6lFPpxuU9ZFtzXXe2uHDj+l0jawSetIxSJOpl05ENnI8Xrlm1
 jwnzWcqdfppKEzDeh6ryh+5TBDtDJx1dJvMEVtgBYBlq3JOjGsNTiEmEkEseanVBSA0h
 Q0mD8kUEih2GedLWzWV2FduxdZ6PzgrosqTZBTK/mFRlimSi8mH8ZemIk4N/P5IBXdQP
 iYjtRVHdffxu7TlGLWR54EVNFzMYbT8OeRzD4Bletwxa9VNLdfvpGrDHKY2hS8Sg/Q/j
 WnygGSg7xpqWZizPRRUqB1k9IqXt18E6x/ehH84BrlPVSxzsE2XHdQmgUtnGrr+GBxbG xQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2tq78q2e5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 18:03:11 +0000
Received: from localhost.us.oracle.com ([10.129.136.207])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x6II3562031079;
        Thu, 18 Jul 2019 18:03:05 GMT
From:   Thomas Tai <thomas.tai@oracle.com>
To:     thomas.tai@oracle.com, pjones@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     konrad@kernel.org
Subject: iscsi_ibft: change ISCSI_IBFT depends on ACPI instead of ISCSI_IBFT_FIND
Date:   Thu, 18 Jul 2019 18:37:34 +0000
Message-Id: <1563475054-10680-1-git-send-email-thomas.tai@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9322 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=907 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907180187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iscsi_ibft can use ACPI to find the iBFT entry during bootup,
currently, ISCSI_IBFT depends on ISCSI_IBFT_FIND which is
a X86 legacy way to find the iBFT by searching through the
low memory. This patch changes the dependency so that other
arch like ARM64 can use ISCSI_IBFT as long as the arch supports
ACPI.

ibft_init() needs to use the global variable ibft_addr declared
in iscsi_ibft_find.c. A #ifndef CONFIG_ISCSI_IBFT_FIND is needed
to declare the variable if CONFIG_ISCSI_IBFT_FIND is not selected.
Moving ibft_addr into the iscsi_ibft.c does not work because if
ISCSI_IBFT is selected as a module, the arch/x86/kernel/setup.c won't
be able to find the variable at compile time.

Signed-off-by: Thomas Tai <thomas.tai@oracle.com>

---
 drivers/firmware/Kconfig      | 5 +++--
 drivers/firmware/iscsi_ibft.c | 4 ++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 1f6633b..8237863 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -164,7 +164,7 @@ config DMI_SCAN_MACHINE_NON_EFI_FALLBACK
 
 config ISCSI_IBFT_FIND
 	bool "iSCSI Boot Firmware Table Attributes"
-	depends on X86 && ACPI
+	depends on X86 && ISCSI_IBFT
 	default n
 	help
 	  This option enables the kernel to find the region of memory
@@ -175,7 +175,8 @@ config ISCSI_IBFT_FIND
 config ISCSI_IBFT
 	tristate "iSCSI Boot Firmware Table Attributes module"
 	select ISCSI_BOOT_SYSFS
-	depends on ISCSI_IBFT_FIND && SCSI && SCSI_LOWLEVEL
+	select ISCSI_IBFT_FIND if X86
+	depends on ACPI && SCSI && SCSI_LOWLEVEL
 	default	n
 	help
 	  This option enables support for detection and exposing of iSCSI
diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
index 132b9ba..220bbc9 100644
--- a/drivers/firmware/iscsi_ibft.c
+++ b/drivers/firmware/iscsi_ibft.c
@@ -93,6 +93,10 @@
 MODULE_LICENSE("GPL");
 MODULE_VERSION(IBFT_ISCSI_VERSION);
 
+#ifndef CONFIG_ISCSI_IBFT_FIND
+struct acpi_table_ibft *ibft_addr;
+#endif
+
 struct ibft_hdr {
 	u8 id;
 	u8 version;
-- 
1.8.3.1

