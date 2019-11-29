Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9ECFC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 03:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE62220640
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 03:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfK2DZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 22:25:17 -0500
Received: from ozlabs.org ([203.11.71.1]:41571 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbfK2DZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 22:25:17 -0500
Received: by ozlabs.org (Postfix, from userid 1023)
        id 47PKdQ1fhNz9sR7; Fri, 29 Nov 2019 14:25:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1574997914; bh=blTqbfE3FxGoWLMQlFpaeUlzOWBLlqs1Oq3G4TVbtd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tSy86PbcQQzQzfQOWn2CM+iRgGqTHakwsSKZY1Bw2oTgLLE3ga7ogZs2I5UoD70x+
         1DwJH09EKGSYT2dwClPysTJJkRFbJalUYnY8P59FQet3mG5SnVo9Kcv88tgqhqdSPo
         OO4wxDaYtiWwm6xMqcTkqqBjeJQeSSm/2tD1/T7XIIJI9mu3T5Ra4y2Gb6lm10SOmV
         vpcPyI6HK07XwAKxlltc3T1EnAQb1Nxwkt02css7WZRlxze6/qYFnHuPygGK0s5lol
         n2MxTB+9G7+1qgoLjklw4JW3krc+PzEj6lV+lM8vV6xngzY6CgE2ZfRztVrWMynQLi
         R9nji/g1PA4aA==
From:   Jeremy Kerr <jk@ozlabs.org>
To:     Joel Stanley <joel@jms.id.au>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Colin King <colin.king@canonical.com>,
        linux-fsi@lists.ozlabs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [PATCH v2] fsi: fix bogus error returns from cfam_read and cfam_write
Date:   Fri, 29 Nov 2019 11:24:29 +0800
Message-Id: <20191129032429.817-1-jk@ozlabs.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122233120.110344-1-colin.king@canonical.com>
References: <20191122233120.110344-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on a static analysis report and original patch from Colin Ian King
<colin.king@canonical.com>.

Currently, we may drop error values from cfam_read and cfam_write. This
change returns the actual error on failure, but a partial read/write will
take precedence.

Addresses-Coverity: ("Unused value")
Fixes: d1dcd6782576 ("fsi: Add cfam char devices")
Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
Colin: thanks for the report and patch. I think this is a more complete
fix, as we want to preseve any partial read/write status if a failure
happens mid-way through an operation. Let me know if you (or the
coverity analysis) have any feedback.

---

 drivers/fsi/fsi-core.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 71c6f9fef648..3158a78c2e94 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -699,6 +699,8 @@ static ssize_t cfam_read(struct file *filep, char __user *buf, size_t count,
 	if (off > 0xffffffff || count > 0xffffffff || off + count > 0xffffffff)
 		return -EINVAL;
 
+	rc = 0;
+
 	for (total_len = 0; total_len < count; total_len += read_len) {
 		__be32 data;
 
@@ -707,18 +709,22 @@ static ssize_t cfam_read(struct file *filep, char __user *buf, size_t count,
 
 		rc = fsi_slave_read(slave, off, &data, read_len);
 		if (rc)
-			goto fail;
+			break;
 		rc = copy_to_user(buf + total_len, &data, read_len);
 		if (rc) {
 			rc = -EFAULT;
-			goto fail;
+			break;
 		}
 		off += read_len;
 	}
-	rc = count;
- fail:
+
+	/* if we've read any data, we want that to be returned in
+	 * preference to an error state */
+	if (total_len)
+		rc = total_len;
+
 	*offset = off;
-	return count;
+	return rc;
 }
 
 static ssize_t cfam_write(struct file *filep, const char __user *buf,
@@ -736,6 +742,8 @@ static ssize_t cfam_write(struct file *filep, const char __user *buf,
 	if (off > 0xffffffff || count > 0xffffffff || off + count > 0xffffffff)
 		return -EINVAL;
 
+	rc = 0;
+
 	for (total_len = 0; total_len < count; total_len += write_len) {
 		__be32 data;
 
@@ -745,17 +753,21 @@ static ssize_t cfam_write(struct file *filep, const char __user *buf,
 		rc = copy_from_user(&data, buf + total_len, write_len);
 		if (rc) {
 			rc = -EFAULT;
-			goto fail;
+			break;
 		}
 		rc = fsi_slave_write(slave, off, &data, write_len);
 		if (rc)
-			goto fail;
+			break;
 		off += write_len;
 	}
-	rc = count;
- fail:
+
+	/* if we've written any data, we want to indicate that partial write
+	 * instead of any mid-stream error */
+	if (total_len)
+		rc = total_len;
+
 	*offset = off;
-	return count;
+	return rc;
 }
 
 static loff_t cfam_llseek(struct file *file, loff_t offset, int whence)
-- 
2.20.1

