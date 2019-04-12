Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED5EC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DA82171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfDLJse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:48:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49429 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfDLJse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 05:48:34 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hEsnN-0005FC-IV; Fri, 12 Apr 2019 09:48:29 +0000
From:   Colin King <colin.king@canonical.com>
To:     QLogic-Storage-Upstream@cavium.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] scsi: qedf: remove memset/memcpy to nfunc and use func instead
Date:   Fri, 12 Apr 2019 10:48:29 +0100
Message-Id: <20190412094829.15868-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the qedf_dbg_* family of functions can overrun the end
of the source string if it is less than the destination buffer
length because of the use of a fixed sized memcpy. Remove the
memset/memcpy calls to nfunc and just use func instead as it
is always a null terminated string.

Addresses-Coverity: ("Out-of-bounds access")
Fixes: 61d8658b4a43 ("scsi: qedf: Add QLogic FastLinQ offload FCoE driver framework.")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: replace the V1 strscpy with just using func since this is always
    going to be a NUL terminated string. Thanks to Rasmus Villemoes for
    noticing that.

---
 drivers/scsi/qedf/qedf_dbg.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/scsi/qedf/qedf_dbg.c b/drivers/scsi/qedf/qedf_dbg.c
index f2397ee9ba69..f7d170bffc82 100644
--- a/drivers/scsi/qedf/qedf_dbg.c
+++ b/drivers/scsi/qedf/qedf_dbg.c
@@ -15,10 +15,6 @@ qedf_dbg_err(struct qedf_dbg_ctx *qedf, const char *func, u32 line,
 {
 	va_list va;
 	struct va_format vaf;
-	char nfunc[32];
-
-	memset(nfunc, 0, sizeof(nfunc));
-	memcpy(nfunc, func, sizeof(nfunc) - 1);
 
 	va_start(va, fmt);
 
@@ -27,9 +23,9 @@ qedf_dbg_err(struct qedf_dbg_ctx *qedf, const char *func, u32 line,
 
 	if (likely(qedf) && likely(qedf->pdev))
 		pr_err("[%s]:[%s:%d]:%d: %pV", dev_name(&(qedf->pdev->dev)),
-			nfunc, line, qedf->host_no, &vaf);
+			func, line, qedf->host_no, &vaf);
 	else
-		pr_err("[0000:00:00.0]:[%s:%d]: %pV", nfunc, line, &vaf);
+		pr_err("[0000:00:00.0]:[%s:%d]: %pV", func, line, &vaf);
 
 	va_end(va);
 }
@@ -40,10 +36,6 @@ qedf_dbg_warn(struct qedf_dbg_ctx *qedf, const char *func, u32 line,
 {
 	va_list va;
 	struct va_format vaf;
-	char nfunc[32];
-
-	memset(nfunc, 0, sizeof(nfunc));
-	memcpy(nfunc, func, sizeof(nfunc) - 1);
 
 	va_start(va, fmt);
 
@@ -55,9 +47,9 @@ qedf_dbg_warn(struct qedf_dbg_ctx *qedf, const char *func, u32 line,
 
 	if (likely(qedf) && likely(qedf->pdev))
 		pr_warn("[%s]:[%s:%d]:%d: %pV", dev_name(&(qedf->pdev->dev)),
-			nfunc, line, qedf->host_no, &vaf);
+			func, line, qedf->host_no, &vaf);
 	else
-		pr_warn("[0000:00:00.0]:[%s:%d]: %pV", nfunc, line, &vaf);
+		pr_warn("[0000:00:00.0]:[%s:%d]: %pV", func, line, &vaf);
 
 ret:
 	va_end(va);
@@ -69,10 +61,6 @@ qedf_dbg_notice(struct qedf_dbg_ctx *qedf, const char *func, u32 line,
 {
 	va_list va;
 	struct va_format vaf;
-	char nfunc[32];
-
-	memset(nfunc, 0, sizeof(nfunc));
-	memcpy(nfunc, func, sizeof(nfunc) - 1);
 
 	va_start(va, fmt);
 
@@ -84,10 +72,10 @@ qedf_dbg_notice(struct qedf_dbg_ctx *qedf, const char *func, u32 line,
 
 	if (likely(qedf) && likely(qedf->pdev))
 		pr_notice("[%s]:[%s:%d]:%d: %pV",
-			  dev_name(&(qedf->pdev->dev)), nfunc, line,
+			  dev_name(&(qedf->pdev->dev)), func, line,
 			  qedf->host_no, &vaf);
 	else
-		pr_notice("[0000:00:00.0]:[%s:%d]: %pV", nfunc, line, &vaf);
+		pr_notice("[0000:00:00.0]:[%s:%d]: %pV", func, line, &vaf);
 
 ret:
 	va_end(va);
@@ -99,10 +87,6 @@ qedf_dbg_info(struct qedf_dbg_ctx *qedf, const char *func, u32 line,
 {
 	va_list va;
 	struct va_format vaf;
-	char nfunc[32];
-
-	memset(nfunc, 0, sizeof(nfunc));
-	memcpy(nfunc, func, sizeof(nfunc) - 1);
 
 	va_start(va, fmt);
 
@@ -114,9 +98,9 @@ qedf_dbg_info(struct qedf_dbg_ctx *qedf, const char *func, u32 line,
 
 	if (likely(qedf) && likely(qedf->pdev))
 		pr_info("[%s]:[%s:%d]:%d: %pV", dev_name(&(qedf->pdev->dev)),
-			nfunc, line, qedf->host_no, &vaf);
+			func, line, qedf->host_no, &vaf);
 	else
-		pr_info("[0000:00:00.0]:[%s:%d]: %pV", nfunc, line, &vaf);
+		pr_info("[0000:00:00.0]:[%s:%d]: %pV", func, line, &vaf);
 
 ret:
 	va_end(va);
-- 
2.20.1

