Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCC9C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFB42173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4pks0uQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbfLLVgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 16:36:11 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45701 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731081AbfLLVgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 16:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576186569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iA7ztsSbNlCcDdsPrRY4M9rq9EkGKI95V0pGlAltfQM=;
        b=C4pks0uQJ8OuUp/NfaseF2ZJMVnJf2PGI1/vXu1izg9NA0oDyZbdpgrHrtycyqW0LBk2sP
        bNyb65mOS13H1kZk/GS8XBQEYRWvZ5OKhZ77PpS7VKHQqGLEeqr8op+u7W44aSTSx53X+9
        L6Vsh2qKwT35DVnYKiSMlppYWWjE4yI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-5bAiZPKmOLW6iYNyt5oxMQ-1; Thu, 12 Dec 2019 16:36:07 -0500
X-MC-Unique: 5bAiZPKmOLW6iYNyt5oxMQ-1
Received: by mail-qv1-f72.google.com with SMTP id d38so338419qvc.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 13:36:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iA7ztsSbNlCcDdsPrRY4M9rq9EkGKI95V0pGlAltfQM=;
        b=MtBxSj3EIynjR0Dd6Iy9vNqL9fk6DHzZD66tQg/Aon+uVjjbZwdZwaPF8R2iwdUqT2
         P5bzxETeM5JzokznrEMy5jwWlgWOxVGRxGEtWqYIBVdvuhTclI1efdPYcdELqz40Mmy0
         rqBpgXHYoGpLlRpgIBft27R08xeIsHjJPz/zBv1ZkotOneq7b9PlGG9hnBzBadeY/P5B
         Mg8YAIQSH88pS0OO7sohdCHbVivxcAIL+nUW1ibj2y8k8yClfYX8PbWvgYikY6DozVxk
         L0wIl63/cT1zehVieEHmEQNhW7mmSjIYC1EGA4v0UZv2tbik5km2Z0rb1z9K1Sy3tf39
         nBjQ==
X-Gm-Message-State: APjAAAWM3z8XHUIoalWvqhdj/REKP3KE2ZfpR0n5BBCltcPWJCofCurz
        hdH4GV06T76jIPtbf2CBN5XnW03a5HEhqvxyZcDgs91e63h8WJsx8k6gNg4yiionndJetJh/aFc
        nYidW/jV9BoxMaWNPPjab3Gni
X-Received: by 2002:a37:ac16:: with SMTP id e22mr10539644qkm.186.1576186567301;
        Thu, 12 Dec 2019 13:36:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqzeJTq6XNxmt9i7ijf5+K/wgdrZ9W/NN1+8UgCZfR2DawNq9krbPYAnrdPZZbMfx451jDvh4g==
X-Received: by 2002:a37:ac16:: with SMTP id e22mr10539615qkm.186.1576186566867;
        Thu, 12 Dec 2019 13:36:06 -0800 (PST)
Received: from labbott-redhat.redhat.com (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id 2sm2135906qkv.98.2019.12.12.13.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 13:36:06 -0800 (PST)
From:   Laura Abbott <labbott@redhat.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Jeremi Piotrowski <jeremi.piotrowski@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-kernel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] vfs: Handle file systems without ->parse_params better
Date:   Thu, 12 Dec 2019 16:36:04 -0500
Message-Id: <20191212213604.19525-1-labbott@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new mount API relies on file systems to provide a ->parse_params
function to handle parsing of arguments. If a file system doesn't
have a ->parse_param function, it falls back to parsing the source
option and rejecting all other options. This is a change in behavior
for some file systems which would just quietly ignore extra options
and mount successfully. This was noticed by users as squashfs failing
to mount with extra options after the conversion to the new mount
API.

File systems with a ->parse_params function rely on the top level
to parse the "source" param so we can't easily move that around. To
get around this, introduce a default parsing functions for file
systems that take no arguments. This parses only the "source" option
and only logs an error for other arguments. Update the comment
to reflect this expected behavior for "source" parsing as well.

Fixes: 3e1aeb00e6d1 ("vfs: Implement a filesystem superblock
creation/configuration context")
Link: https://lore.kernel.org/lkml/20191130181548.GA28459@gentoo-tp.home/
Reported-by: Jeremi Piotrowski <jeremi.piotrowski@gmail.com>
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1781863
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
I cleaned up my original suggestion a bit as I realized things would
be easier if we just made this a default option if there's no parsing.
Lightly tested only.
---
 fs/fs_context.c | 69 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 7 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 138b5b4d621d..8c5dc131e29a 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -107,6 +107,55 @@ static int vfs_parse_sb_flag(struct fs_context *fc, const char *key)
 	return -ENOPARAM;
 }
 
+enum {
+        GENERIC_FS_SOURCE,
+};
+
+static const struct fs_parameter_spec generic_fs_param_specs[] = {
+        fsparam_string  ("source",              GENERIC_FS_SOURCE),
+        {}
+};
+
+const struct fs_parameter_description generic_fs_parameters = {
+        .name           = "generic_fs",
+        .specs          = generic_fs_param_specs,
+};
+
+/**
+ * fs_generic_parse_param - ->parse_param function for a file system that
+ * takes no arguments
+ * @fc: The filesystem context
+ * @param: The parameter.
+ */
+static int fs_generic_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+        struct fs_parse_result result;
+        int opt;
+
+        opt = fs_parse(fc, &generic_fs_parameters, param, &result);
+        if (opt < 0) {
+                /* Just log an error for backwards compatibility */
+                errorf(fc, "%s: Unknown parameter '%s'",
+                      fc->fs_type->name, param->key);
+                return 0;
+        }
+
+        switch (opt) {
+        case GENERIC_FS_SOURCE:
+                if (param->type != fs_value_is_string)
+                        return invalf(fc, "%s: Non-string source",
+					fc->fs_type->name);
+                if (fc->source)
+                        return invalf(fc, "%s: Multiple sources specified",
+					fc->fs_type->name);
+                fc->source = param->string;
+                param->string = NULL;
+                break;
+        }
+
+        return 0;
+}
+
 /**
  * vfs_parse_fs_param - Add a single parameter to a superblock config
  * @fc: The filesystem context to modify
@@ -126,6 +175,7 @@ static int vfs_parse_sb_flag(struct fs_context *fc, const char *key)
 int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	int ret;
+	int (*parse_param)(struct fs_context *, struct fs_parameter *);
 
 	if (!param->key)
 		return invalf(fc, "Unnamed parameter\n");
@@ -141,14 +191,19 @@ int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
 		 */
 		return ret;
 
-	if (fc->ops->parse_param) {
-		ret = fc->ops->parse_param(fc, param);
-		if (ret != -ENOPARAM)
-			return ret;
-	}
+	parse_param = fc->ops->parse_param;
+	if (!parse_param)
+		parse_param = fs_generic_parse_param;
+
+	ret = parse_param(fc, param);
+	if (ret != -ENOPARAM)
+		return ret;
 
-	/* If the filesystem doesn't take any arguments, give it the
-	 * default handling of source.
+	/*
+	 * File systems may have a ->parse_param function but rely on
+	 * the top level to parse the source function. File systems
+	 * may have their own source parsing though so this needs
+	 * to come after the call to parse_param above.
 	 */
 	if (strcmp(param->key, "source") == 0) {
 		if (param->type != fs_value_is_string)
-- 
2.21.0

