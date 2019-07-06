Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C236C0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 16:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1213C2083B
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 16:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562431694;
	bh=cs30vXbt2kXkxwO6GdccBr0iTV2FUZurmVc80D7Ch+s=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=sfOq5Azbo7lsxWEKN8bzpmTYAK1DWmEF+JboBaepTjwOnQ8dZDbbBO/VUUGETfmRO
	 JxpwNAziU/7toDAFAhuigKRjNowq7vPOSCBtymlNg52hhKXwIC1X9XyB3DeawuJitz
	 RPX0NZArrUPur+NQUODW75E27jJDIbEVOx1jG8I0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfGFQsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 12:48:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfGFQsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 12:48:12 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1C4520836;
        Sat,  6 Jul 2019 16:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562431691;
        bh=cs30vXbt2kXkxwO6GdccBr0iTV2FUZurmVc80D7Ch+s=;
        h=From:To:Cc:Subject:Date:From;
        b=X5YoYllIwYejBS3CsNTUly5LvWKKNeTm56SgENCViXWljD6wX1jPVAK4sBaPmJ/oW
         fFCOvGunz4tyWIcdW0rXPKn7/pETiK34sOh14MK/UGCdSPNPQfTSjubxNh3t0Jp49I
         mQRsNP1DdsrC6BAz+fwL3Wf4Fp0fgOeZQvFEH4Kc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/3] mfd: ab3100: no need to check return value of debugfs_create functions
Date:   Sat,  6 Jul 2019 18:47:20 +0200
Message-Id: <20190706164722.18766-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mfd/ab3100-core.c | 45 ++++++---------------------------------
 drivers/mfd/ab3100-otp.c  | 21 ++++++------------
 2 files changed, 13 insertions(+), 53 deletions(-)

diff --git a/drivers/mfd/ab3100-core.c b/drivers/mfd/ab3100-core.c
index e350ab64238e..9f3dbc31d3e9 100644
--- a/drivers/mfd/ab3100-core.c
+++ b/drivers/mfd/ab3100-core.c
@@ -575,58 +575,27 @@ static const struct file_operations ab3100_get_set_reg_fops = {
 	.llseek = noop_llseek,
 };
 
-static struct dentry *ab3100_dir;
-static struct dentry *ab3100_reg_file;
 static struct ab3100_get_set_reg_priv ab3100_get_priv;
-static struct dentry *ab3100_get_reg_file;
 static struct ab3100_get_set_reg_priv ab3100_set_priv;
-static struct dentry *ab3100_set_reg_file;
 
 static void ab3100_setup_debugfs(struct ab3100 *ab3100)
 {
-	int err;
+	struct dentry *ab3100_dir;
 
 	ab3100_dir = debugfs_create_dir("ab3100", NULL);
-	if (!ab3100_dir)
-		goto exit_no_debugfs;
 
-	ab3100_reg_file = debugfs_create_file("registers",
-				S_IRUGO, ab3100_dir, ab3100,
-				&ab3100_registers_fops);
-	if (!ab3100_reg_file) {
-		err = -ENOMEM;
-		goto exit_destroy_dir;
-	}
+	debugfs_create_file("registers", S_IRUGO, ab3100_dir, ab3100,
+			    &ab3100_registers_fops);
 
 	ab3100_get_priv.ab3100 = ab3100;
 	ab3100_get_priv.mode = false;
-	ab3100_get_reg_file = debugfs_create_file("get_reg",
-				S_IWUSR, ab3100_dir, &ab3100_get_priv,
-				&ab3100_get_set_reg_fops);
-	if (!ab3100_get_reg_file) {
-		err = -ENOMEM;
-		goto exit_destroy_reg;
-	}
+	debugfs_create_file("get_reg", S_IWUSR, ab3100_dir, &ab3100_get_priv,
+			    &ab3100_get_set_reg_fops);
 
 	ab3100_set_priv.ab3100 = ab3100;
 	ab3100_set_priv.mode = true;
-	ab3100_set_reg_file = debugfs_create_file("set_reg",
-				S_IWUSR, ab3100_dir, &ab3100_set_priv,
-				&ab3100_get_set_reg_fops);
-	if (!ab3100_set_reg_file) {
-		err = -ENOMEM;
-		goto exit_destroy_get_reg;
-	}
-	return;
-
- exit_destroy_get_reg:
-	debugfs_remove(ab3100_get_reg_file);
- exit_destroy_reg:
-	debugfs_remove(ab3100_reg_file);
- exit_destroy_dir:
-	debugfs_remove(ab3100_dir);
- exit_no_debugfs:
-	return;
+	debugfs_create_file("set_reg", S_IWUSR, ab3100_dir, &ab3100_set_priv,
+			    &ab3100_get_set_reg_fops);
 }
 #else
 static inline void ab3100_setup_debugfs(struct ab3100 *ab3100)
diff --git a/drivers/mfd/ab3100-otp.c b/drivers/mfd/ab3100-otp.c
index b3f8d359f409..c4751fb9bc22 100644
--- a/drivers/mfd/ab3100-otp.c
+++ b/drivers/mfd/ab3100-otp.c
@@ -122,17 +122,11 @@ static const struct file_operations ab3100_otp_operations = {
 	.release	= single_release,
 };
 
-static int __init ab3100_otp_init_debugfs(struct device *dev,
-					  struct ab3100_otp *otp)
+static void __init ab3100_otp_init_debugfs(struct device *dev,
+					   struct ab3100_otp *otp)
 {
 	otp->debugfs = debugfs_create_file("ab3100_otp", S_IFREG | S_IRUGO,
-					   NULL, otp,
-					   &ab3100_otp_operations);
-	if (!otp->debugfs) {
-		dev_err(dev, "AB3100 debugfs OTP file registration failed!\n");
-		return -ENOENT;
-	}
-	return 0;
+					   NULL, otp, &ab3100_otp_operations);
 }
 
 static void __exit ab3100_otp_exit_debugfs(struct ab3100_otp *otp)
@@ -141,10 +135,9 @@ static void __exit ab3100_otp_exit_debugfs(struct ab3100_otp *otp)
 }
 #else
 /* Compile this out if debugfs not selected */
-static inline int __init ab3100_otp_init_debugfs(struct device *dev,
-						 struct ab3100_otp *otp)
+static inline void __init ab3100_otp_init_debugfs(struct device *dev,
+						  struct ab3100_otp *otp)
 {
-	return 0;
 }
 
 static inline void __exit ab3100_otp_exit_debugfs(struct ab3100_otp *otp)
@@ -211,9 +204,7 @@ static int __init ab3100_otp_probe(struct platform_device *pdev)
 	}
 
 	/* debugfs entries */
-	err = ab3100_otp_init_debugfs(&pdev->dev, otp);
-	if (err)
-		goto err;
+	ab3100_otp_init_debugfs(&pdev->dev, otp);
 
 	return 0;
 
-- 
2.22.0

