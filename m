Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21B6C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FFE214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cvfVZ2bh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731017AbfLLWls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 17:41:48 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39496 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730707AbfLLWls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 17:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576190506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QTqrX0C+eShgCocrnLwj0jnrcRKihR9p/00TbrrS4kU=;
        b=cvfVZ2bh0x+RS/q90h3CmRUxPa+kxGUwIXKF0gODW4ihpst2BCwm3XJdbN9vAZH4SpfpQk
        hpeFmphrDmC2WxNTY6HpIWfw8PABvHvpxTJ8BY7fGlO2L9evsWSjm2NCU+FpZpZPcG9vHa
        fDw/z+c81Eis5e4KFx4Ds5xr+fK6ZAg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-5KZg-W5PPruxjT1SiMkrig-1; Thu, 12 Dec 2019 17:41:45 -0500
X-MC-Unique: 5KZg-W5PPruxjT1SiMkrig-1
Received: by mail-qv1-f70.google.com with SMTP id a4so438009qvn.14
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 14:41:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QTqrX0C+eShgCocrnLwj0jnrcRKihR9p/00TbrrS4kU=;
        b=DxUCBz51XB/MVEFE77HMm4EQ3F7Qc2c3jFxtm+OeAkT1GTSP3r7mXWQ+M3TIJlg1ue
         eUbOtrt5vhGIjytwgo5Q88Yrj9fpYBePJvoUj02MqAVEvfgtruB17zvTfPKCQWXLVjFu
         fCalUn1UW/F8e0AKrSwQIm8ve/WnXGtuInL2GFd7yIwWTysPbI8F1U4Xa8JDUqE8y5FZ
         CNUDcIu3c4gOvknSk5C7MZYG7WWK+P0e9PwDKI/zitROj2oewVKHAv9O8VvyauYVhlQa
         h2H0FNIKne0Do4q5CLBpRUv0SBo5KE6cS8G5lJzn1uVdhwkFyer4a85jP4a8F1ezBfBA
         ga1g==
X-Gm-Message-State: APjAAAUf6Z7eT3EyG67G2bSWrocnnIYojxj2jYw2ZbWENRcpwV/O5VfU
        FzdUiuRlyUVKo5nRa3yiAdMBY3QfSQsUBnLxXHhn6AR10bp8YpRnUrndoGM2Uc6MOBVKnuKyodi
        hCSEZWRmuM1j8UYMCFA/e06fl
X-Received: by 2002:a05:6214:178f:: with SMTP id ct15mr10290839qvb.95.1576190505101;
        Thu, 12 Dec 2019 14:41:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqxpps50O7sKKAKfqI0+8dAwkmzesR9yvNp5EYD0edwbGeb3d8hizM1fjMLPbyhetx7gE/j4rQ==
X-Received: by 2002:a05:6214:178f:: with SMTP id ct15mr10290820qvb.95.1576190504832;
        Thu, 12 Dec 2019 14:41:44 -0800 (PST)
Received: from labbott-redhat.redhat.com (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id h32sm2734997qth.2.2019.12.12.14.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 14:41:44 -0800 (PST)
From:   Laura Abbott <labbott@redhat.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Jeremi Piotrowski <jeremi.piotrowski@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-kernel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCHv2] vfs: Handle file systems without ->parse_params better
Date:   Thu, 12 Dec 2019 17:41:39 -0500
Message-Id: <20191212224139.15970-1-labbott@redhat.com>
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
v2: Dropped most the boiler plate for parsing and just compared
against "source". Renamed to ignore_unknown_parse_param.
---
 fs/fs_context.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 138b5b4d621d..086ade29b811 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -107,6 +107,22 @@ static int vfs_parse_sb_flag(struct fs_context *fc, const char *key)
 	return -ENOPARAM;
 }
 
+/**
+ * ignore_unknowns_parse_param - ->parse_param function for a file system that
+ * takes no arguments
+ * @fc: The filesystem context
+ * @param: The parameter.
+ */
+static int ignore_unknown_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+
+	if (strcmp(param->key, "source") == 0)
+		return -ENOPARAM;
+	/* Just log an error for backwards compatibility */
+	errorf(fc, "%s: Unknown parameter '%s'", fc->fs_type->name, param->key);
+	return 0;
+}
+
 /**
  * vfs_parse_fs_param - Add a single parameter to a superblock config
  * @fc: The filesystem context to modify
@@ -126,6 +142,7 @@ static int vfs_parse_sb_flag(struct fs_context *fc, const char *key)
 int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	int ret;
+	int (*parse_param)(struct fs_context *, struct fs_parameter *);
 
 	if (!param->key)
 		return invalf(fc, "Unnamed parameter\n");
@@ -141,14 +158,19 @@ int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
 		 */
 		return ret;
 
-	if (fc->ops->parse_param) {
-		ret = fc->ops->parse_param(fc, param);
-		if (ret != -ENOPARAM)
-			return ret;
-	}
+	parse_param = fc->ops->parse_param;
+	if (!parse_param)
+		parse_param = ignore_unknown_parse_param;
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

