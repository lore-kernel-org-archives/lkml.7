Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978AEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CF920850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfCTQhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:37:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49745 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfCTQhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:37:11 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1h6eDF-00028h-MH; Wed, 20 Mar 2019 16:37:09 +0000
From:   Colin King <colin.king@canonical.com>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] scsi: target: fix unsigned comparision with less than zero
Date:   Wed, 20 Mar 2019 16:37:09 +0000
Message-Id: <20190320163709.28767-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently an error return is being assigned to an unsigned
size_t varianle and then checked if the result is less than
zero which will always be false.  Fix this by making ret
ssize_t rather than a size_t.

Fixes: 0322913cab79 ("scsi: target: Add device product id and revision configfs attributes")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/target/target_core_configfs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index 8f3faef235b5..3fe79875b3ac 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -1267,7 +1267,8 @@ static ssize_t target_wwn_vendor_id_store(struct config_item *item,
 	/* +2 to allow for a trailing (stripped) '\n' and null-terminator */
 	unsigned char buf[INQUIRY_VENDOR_LEN + 2];
 	char *stripped = NULL;
-	size_t len, ret;
+	size_t len;
+	ssize_t ret;
 
 	len = strlcpy(buf, page, sizeof(buf));
 	if (len < sizeof(buf)) {
@@ -1322,7 +1323,8 @@ static ssize_t target_wwn_product_id_store(struct config_item *item,
 	/* +2 to allow for a trailing (stripped) '\n' and null-terminator */
 	unsigned char buf[INQUIRY_MODEL_LEN + 2];
 	char *stripped = NULL;
-	size_t len, ret;
+	size_t len;
+	ssize_t ret;
 
 	len = strlcpy(buf, page, sizeof(buf));
 	if (len < sizeof(buf)) {
@@ -1377,7 +1379,8 @@ static ssize_t target_wwn_revision_store(struct config_item *item,
 	/* +2 to allow for a trailing (stripped) '\n' and null-terminator */
 	unsigned char buf[INQUIRY_REVISION_LEN + 2];
 	char *stripped = NULL;
-	size_t len, ret;
+	size_t len;
+	ssize_t ret;
 
 	len = strlcpy(buf, page, sizeof(buf));
 	if (len < sizeof(buf)) {
-- 
2.20.1

