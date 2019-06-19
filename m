Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E01C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C0F208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731867AbfFSMaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:30:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43963 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731845AbfFSMah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:30:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so3168102wru.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 05:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aEJZvAaP0gZ3BGwiRkcb3jZB35A1QSUJKdWyF6hsB/4=;
        b=HS8Nfe5cXr3Pf7qQFn0lT6K9pVlvHDMTQWKWhx5sffNVYl9qAEAcrg1ngyXp3XqsuE
         fGqj9Kv/TU9FvvhBgkW4oMeB5Q3l9QQW4/Wl89D+dKtCXLs53PXNlExAXDNGudRJkGJw
         jqG1357pyG0+OMdJ9IwCs5tlU4Aihu7Dfs+UOS+YVrA1PQ10+BGoFTnvdZUHOXHmYwn3
         8dNf/sS8bnaPmwZyTH1fK0QDBJhVVTB20/v4izxhdrndcGIN+hxKc6OPEplHfmJ9evML
         A6EhP4ZaBcTn0tCrenUY9gyRkQPA+geOqY7NnX0Xy//hBVabnHoaryFNfWk4FzIVwaLH
         T+GA==
X-Gm-Message-State: APjAAAV1j6uzv32Ko9dk70Mltg+Exw13V7M4UjManU4JxfBBu/9oWZty
        S1IaXIOi6yF5Oz/4jkRsG03tGQ==
X-Google-Smtp-Source: APXvYqx+pORYHinPI1RPJLOFGKWiPjDYT7ZAsQ/FYO/zLto8APQKogtIGI+TjNYrCayP0MLlUNfRAg==
X-Received: by 2002:adf:fc85:: with SMTP id g5mr86528327wrr.324.1560947435212;
        Wed, 19 Jun 2019 05:30:35 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 11sm1837513wmd.23.2019.06.19.05.30.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:30:33 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] vfs: new helper: vfs_parse_ro_rw()
Date:   Wed, 19 Jun 2019 14:30:12 +0200
Message-Id: <20190619123019.30032-6-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619123019.30032-1-mszeredi@redhat.com>
References: <20190619123019.30032-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This just parses the "ro" and "rw" options and sets sb_flags accordingly.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fs_context.c            | 18 ++++++++++++++++++
 include/linux/fs_context.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index c26b353aa858..5012ab7650ec 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -77,6 +77,24 @@ int vfs_parse_sb_flag(struct fs_context *fc, struct fs_parameter *param)
 }
 EXPORT_SYMBOL(vfs_parse_sb_flag);
 
+int vfs_parse_ro_rw(struct fs_context *fc, struct fs_parameter *param)
+{
+	if (strcmp(param->key, "ro") == 0)
+		fc->sb_flags |= SB_RDONLY;
+	else if (strcmp(param->key, "rw") == 0)
+		fc->sb_flags &= ~SB_RDONLY;
+	else
+		return -ENOPARAM;
+
+	if (param->type != fs_value_is_flag)
+		return invalf(fc, "%s: Unexpected value for '%s'",
+			      fc->fs_type->name, param->key);
+
+	fc->sb_flags_mask |= SB_RDONLY;
+	return 0;
+}
+EXPORT_SYMBOL(vfs_parse_ro_rw);
+
 /**
  * vfs_parse_fs_param - Add a single parameter to a superblock config
  * @fc: The filesystem context to modify
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 39f4d8b0a390..bff6796a89ef 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -128,6 +128,7 @@ extern struct fs_context *fs_context_for_submount(struct file_system_type *fs_ty
 
 extern struct fs_context *vfs_dup_fs_context(struct fs_context *fc);
 extern int vfs_parse_sb_flag(struct fs_context *fc, struct fs_parameter *param);
+extern int vfs_parse_ro_rw(struct fs_context *fc, struct fs_parameter *param);
 extern int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param);
 extern int vfs_parse_fs_string(struct fs_context *fc, const char *key,
 			       const char *value, size_t v_size);
-- 
2.21.0

