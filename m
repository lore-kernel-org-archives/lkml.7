Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E59C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37BE208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbfFSMa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:30:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43931 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731427AbfFSMa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:30:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so3167495wru.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 05:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZQFy3noIgLzCKKvfJTpCDEkL2tduUrGhw500s5XjKOM=;
        b=uEKuINp+dDn1+2aAHjNuOpcrZvmmhXEMyNKHNAYElP/zaPrKDiD9hB7RRlBvbdlZUs
         2r5UuO6ctmhvvYOATAkPM5SR3EcBPIoIDOE7zHvfltBXiCEfcsHDh9b4jv4fjx1srjRV
         J63bacB1MmPDL/FpWzfrnMILmknCEg2l5Ae/kGUrqmEJkALH7lP7/K99FRm1cO4JMNOV
         taPGImXUVh0wOxcBwl0bZe46hNzqOSAE/Wpb7S8dROmVKLo7WDMQJ2jqkO3glkjVNFl3
         j2nsQm4tx2VLp7Kx24G1J45ok4VwQpAWRfo6ddPOW2CXQkNE18j1Q465XenwR0jfoG0N
         +Q0g==
X-Gm-Message-State: APjAAAXALxryFB4vwEWtjzDduRulYGsDxlEhHVw9HfIUGS6HcRJzWqAi
        Vz21IZoqr7XaZOaxmr5mJfr/vw==
X-Google-Smtp-Source: APXvYqyM0eIINJF5V89HnKZUprBMY1GZ2O4C7V7moar/rzzhLkG1oS4KKMtGfJ/P9Up2vnllSLiCCw==
X-Received: by 2002:adf:ec0f:: with SMTP id x15mr87257157wrn.165.1560947425796;
        Wed, 19 Jun 2019 05:30:25 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 11sm1837513wmd.23.2019.06.19.05.30.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:30:24 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] vfs: verify param type in vfs_parse_sb_flag()
Date:   Wed, 19 Jun 2019 14:30:07 +0200
Message-Id: <20190619123019.30032-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vfs_parse_sb_flag() accepted any kind of param with a matching key, not
just a flag.  This is wrong, only allow flag type and return -EINVAL
otherwise.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fs_context.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 103643c68e3f..e56310fd8c75 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -81,30 +81,29 @@ static const char *const forbidden_sb_flag[] = {
 /*
  * Check for a common mount option that manipulates s_flags.
  */
-static int vfs_parse_sb_flag(struct fs_context *fc, const char *key)
+static int vfs_parse_sb_flag(struct fs_context *fc, struct fs_parameter *param)
 {
-	unsigned int token;
+	const char *key = param->key;
+	unsigned int set, clear;
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(forbidden_sb_flag); i++)
 		if (strcmp(key, forbidden_sb_flag[i]) == 0)
 			return -EINVAL;
 
-	token = lookup_constant(common_set_sb_flag, key, 0);
-	if (token) {
-		fc->sb_flags |= token;
-		fc->sb_flags_mask |= token;
-		return 0;
-	}
+	set = lookup_constant(common_set_sb_flag, key, 0);
+	clear = lookup_constant(common_clear_sb_flag, key, 0);
+	if (!set && !clear)
+		return -ENOPARAM;
 
-	token = lookup_constant(common_clear_sb_flag, key, 0);
-	if (token) {
-		fc->sb_flags &= ~token;
-		fc->sb_flags_mask |= token;
-		return 0;
-	}
+	if (param->type != fs_value_is_flag)
+		return invalf(fc, "%s: Unexpected value for '%s'",
+			      fc->fs_type->name, param->key);
 
-	return -ENOPARAM;
+	fc->sb_flags |= set;
+	fc->sb_flags &= ~clear;
+	fc->sb_flags_mask |= set | clear;
+	return 0;
 }
 
 /**
@@ -130,7 +129,7 @@ int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
 	if (!param->key)
 		return invalf(fc, "Unnamed parameter\n");
 
-	ret = vfs_parse_sb_flag(fc, param->key);
+	ret = vfs_parse_sb_flag(fc, param);
 	if (ret != -ENOPARAM)
 		return ret;
 
-- 
2.21.0

