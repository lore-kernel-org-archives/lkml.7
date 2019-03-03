Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D196EC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 22:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B0B20830
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 22:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uyunflv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfCCWjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 17:39:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38396 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfCCWjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 17:39:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id g12so3497826wrm.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 14:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nf4RJJt9xHrCdtSGIJQJsR5t3TD+CHNi4WLkxDUzTcs=;
        b=Uyunflv6mMr8Ning4g2epgLuS5gflT4i4E1nkE2bC3JdwP1RFpdpoecyoFp4oXI10b
         VmOSFh55vyInLpZoVtAc446YJ7O9hYomZZeOO6oTrtbe8MJtLpYm51bzl6dxKbva5++/
         FZGfSGLBiWRwK8qrfrkTc+Kx2EIMsCXRMcJbr+AK6CQnJEgeEjtBw/+ztjT/uTlhZpuK
         0lWLKpnB3yDIhvfKKWcmSaLyX87ID7cU/wA5jDezbCzbsTIC/LSy2tMabExelnlmzXqd
         Oezha0abI94NvDb1kf8CuWcrPvieSTPJQX5qE3ROEi1Ms5TX5L1clC7wO6kfQuJLOjM3
         mN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nf4RJJt9xHrCdtSGIJQJsR5t3TD+CHNi4WLkxDUzTcs=;
        b=W42DAJSHh+W32PzbyAbBwY++Ne0iB58Mxced7qe/Fqts7uGWOw0mPVb1ll1a6T0Ucu
         QsZkpQQkgRPtWZiz/zfnSCMPDesJyIzUL5jf5beJOFXTnMEJ4QKYbKtuphyRRUB7xhhm
         JDbVQZqgBWHVqnyQumq6RqAwFy7h2u+1Ag5DJorHKDmQvNt/FXJjMr2Ji6Xj6+zAV4Zt
         nwfes4XopkBSYNGH4Vl1pFuefbQkwHugKPF0fWEKy7CY8bSCyigkgQ/bptsH4aplz3DR
         KRPN1DoU50iMNhrlLetILASi37t7NqzwCHvcGorYbCnjQJD8mjkkr43u3Bn95s6QmHRr
         aahQ==
X-Gm-Message-State: APjAAAX2Y1iO7ZfjJJzq7nWrslYWgZV2eTewkC5BhrlsJBcTASpR4Spv
        Jicy1tcuwhGw8IBRn2roPno=
X-Google-Smtp-Source: APXvYqyMSSohnY8v8JK6MAYu/pRtlDmPD4vhJq9eu28kM5C6j2nSAsSQPlTALqsSUSukSEGznA5F9Q==
X-Received: by 2002:adf:ed0f:: with SMTP id a15mr10479874wro.249.1551652746905;
        Sun, 03 Mar 2019 14:39:06 -0800 (PST)
Received: from localhost.localdomain ([5.146.133.129])
        by smtp.googlemail.com with ESMTPSA id d24sm14500650wrb.47.2019.03.03.14.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 14:39:06 -0800 (PST)
From:   Dominik Adamski <adamski.dominik@gmail.com>
Cc:     adamski.dominik@gmail.com, Gao Xiang <gaoxiang25@huawei.com>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: erofs: dir.c fix "alignment should match open parenthesis" issues
Date:   Sun,  3 Mar 2019 23:37:18 +0100
Message-Id: <20190303223718.31937-1-adamski.dominik@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch issues: "CHECK: Alignment should match open parenthesis"

Signed-off-by: Dominik Adamski <adamski.dominik@gmail.com>
---
 drivers/staging/erofs/dir.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/erofs/dir.c b/drivers/staging/erofs/dir.c
index 833f052f79d0..e1955703ab8f 100644
--- a/drivers/staging/erofs/dir.c
+++ b/drivers/staging/erofs/dir.c
@@ -24,8 +24,8 @@ static const unsigned char erofs_filetype_table[EROFS_FT_MAX] = {
 };
 
 static int erofs_fill_dentries(struct dir_context *ctx,
-	void *dentry_blk, unsigned int *ofs,
-	unsigned int nameoff, unsigned int maxsize)
+			       void *dentry_blk, unsigned int *ofs,
+			       unsigned int nameoff, unsigned int maxsize)
 {
 	struct erofs_dirent *de = dentry_blk;
 	const struct erofs_dirent *end = dentry_blk + nameoff;
@@ -104,9 +104,9 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 		nameoff = le16_to_cpu(de->nameoff);
 
 		if (unlikely(nameoff < sizeof(struct erofs_dirent) ||
-			nameoff >= PAGE_SIZE)) {
+			     nameoff >= PAGE_SIZE)) {
 			errln("%s, invalid de[0].nameoff %u",
-				__func__, nameoff);
+			      __func__, nameoff);
 
 			err = -EIO;
 			goto skip_this;
-- 
2.19.1

