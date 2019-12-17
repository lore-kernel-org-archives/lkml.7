Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45613C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 02:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192F62176D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 02:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfLQCr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 21:47:58 -0500
Received: from spam01.hygon.cn ([110.188.70.11]:29065 "EHLO spam1.hygon.cn"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726446AbfLQCr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 21:47:57 -0500
Received: from MK-DB.hygon.cn ([172.23.18.60])
        by spam1.hygon.cn with ESMTP id xBH2geS6075240;
        Tue, 17 Dec 2019 10:42:40 +0800 (GMT-8)
        (envelope-from linjiasen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-DB.hygon.cn with ESMTP id xBH2gQSk004059;
        Tue, 17 Dec 2019 10:42:26 +0800 (GMT-8)
        (envelope-from linjiasen@hygon.cn)
Received: from ubuntu.localdomain (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Tue, 17 Dec
 2019 10:42:32 +0800
From:   Jiasen Lin <linjiasen@hygon.cn>
To:     <linux-kernel@vger.kernel.org>, <linux-ntb@googlegroups.com>,
        <jdmason@kudzu.us>, <logang@deltatee.com>
CC:     <allenbh@gmail.com>, <dave.jiang@intel.com>, <linjiasen@hygon.cn>,
        <sanju.mehta@amd.com>
Subject: [PATCH] NTB: ntb_perf: Add more debugfs entries for ntb_perf
Date:   Mon, 16 Dec 2019 18:42:16 -0800
Message-ID: <1576550536-84697-1-git-send-email-linjiasen@hygon.cn>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex01.Hygon.cn (172.23.18.10) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam1.hygon.cn xBH2geS6075240
X-DNSRBL: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, read input and output buffer is not supported yet in
debugfs of ntb_perf. We can not confirm whether the output data is
transmitted to the input buffer at peer memory through NTB.

This patch add new entries in debugfs which implement interface to read
a part of input and out buffer. User can dump output and input data at
local and peer system by hexdump command, and then compare them manually.

Signed-off-by: Jiasen Lin <linjiasen@hygon.cn>
---
 drivers/ntb/test/ntb_perf.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index e9b7c2d..338c3ec 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -106,6 +106,8 @@ MODULE_DESCRIPTION("PCIe NTB Performance Measurement Tool");
 
 #define PERF_BUF_LEN 1024
 
+#define MAX_STR_LENGTH		16
+
 static unsigned long max_mw_size;
 module_param(max_mw_size, ulong, 0644);
 MODULE_PARM_DESC(max_mw_size, "Upper limit of memory window size");
@@ -1227,6 +1229,46 @@ static const struct file_operations perf_dbgfs_info = {
 	.read = perf_dbgfs_read_info
 };
 
+static ssize_t perf_dbgfs_read_inbuf(struct file *filep,
+				    char __user *ubuf,
+				    size_t size, loff_t *offp)
+{
+	struct perf_peer *peer = filep->private_data;
+	size_t buf_size;
+
+	if (!peer->inbuf)
+		return -ENXIO;
+
+	buf_size = min_t(size_t, size, peer->inbuf_size);
+	return simple_read_from_buffer(ubuf, size, offp,
+					peer->inbuf, buf_size);
+}
+
+static const struct file_operations perf_dbgfs_inbuf = {
+	.open = simple_open,
+	.read = perf_dbgfs_read_inbuf,
+};
+
+static ssize_t perf_dbgfs_read_outbuf(struct file *filep,
+				    char __user *ubuf,
+				    size_t size, loff_t *offp)
+{
+	struct perf_peer *peer = filep->private_data;
+	size_t buf_size;
+
+	if (!peer->outbuf)
+		return -ENXIO;
+
+	buf_size = min_t(size_t, size, peer->outbuf_size);
+	return simple_read_from_buffer(ubuf, size, offp,
+					peer->outbuf, buf_size);
+}
+
+static const struct file_operations perf_dbgfs_outbuf = {
+	.open = simple_open,
+	.read = perf_dbgfs_read_outbuf,
+};
+
 static ssize_t perf_dbgfs_read_run(struct file *filep, char __user *ubuf,
 				   size_t size, loff_t *offp)
 {
@@ -1318,6 +1360,9 @@ static const struct file_operations perf_dbgfs_tcnt = {
 static void perf_setup_dbgfs(struct perf_ctx *perf)
 {
 	struct pci_dev *pdev = perf->ntb->pdev;
+	struct perf_peer *peer;
+	int pidx;
+	char name[MAX_STR_LENGTH];
 
 	perf->dbgfs_dir = debugfs_create_dir(pci_name(pdev), perf_dbgfs_topdir);
 	if (!perf->dbgfs_dir) {
@@ -1334,6 +1379,20 @@ static void perf_setup_dbgfs(struct perf_ctx *perf)
 	debugfs_create_file("threads_count", 0600, perf->dbgfs_dir, perf,
 			    &perf_dbgfs_tcnt);
 
+	for (pidx = 0; pidx < perf->pcnt; pidx++) {
+		peer = &perf->peers[pidx];
+		if (!peer)
+			continue;
+		memset(name, 0, sizeof(name));
+		snprintf(name, sizeof(name), "%s_%u", "inbuf_info", pidx);
+		debugfs_create_file(name, 0600, perf->dbgfs_dir, peer,
+					&perf_dbgfs_inbuf);
+
+		memset(name, 0, sizeof(name));
+		snprintf(name, sizeof(name), "%s_%u", "outbuf_info", pidx);
+		debugfs_create_file(name, 0600, perf->dbgfs_dir, peer,
+					&perf_dbgfs_outbuf);
+	}
 	/* They are made read-only for test exec safety and integrity */
 	debugfs_create_u8("chunk_order", 0500, perf->dbgfs_dir, &chunk_order);
 
-- 
2.7.4

