Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4BFC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F3EA214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731769AbfFSMzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:55:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35556 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfFSMzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:55:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id c6so1743173wml.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 05:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oUKHb/HhBZ0gnG9oANdx2Pjudz3ATWiOMMw4XgDgVpU=;
        b=JvQfrphQXkVWSfIagw/eBDh5vH/gwWNHVDnQS2v6akb5SoGE2fQ3UVb1sSazTnndY/
         qrtwpDkv/FLSG44A3/cs9jCzlsHNg0JBCziwhiOvgKyma0R6ELEDp2I2yHAtsfC4Y2oT
         SQxGvvHcpD0hhJ1SMYbeorXpO/aF2caQ+EVnVuXGCpoDF7Ghyk/YvdL3QuCtCAx4GC7Z
         BGPvdbSRwAIaMujOlZppnbxlUkDX851Wqou/2VKpwzHhK5sHq013fnBa0Qdjg2LnDI7j
         PLynTKeGEzs+ptB4IuVLPW7eZpy0bx6ek7fWT+m9UFMSIlZ7LlAC25bPdICzqa8BkG/6
         NSHg==
X-Gm-Message-State: APjAAAWWig+5G2fleSxo856a3ZHU7JcB8sPKBqqEmXLRGmu2NN9qW4Y4
        0hdbbPNB3OfDDV018bmxrulS3Q==
X-Google-Smtp-Source: APXvYqw3i0VpSjIBS+93VI0Apn4ELLqPvHfMOQQF7nzI3bFhxPrXEygph6zjfl8uXvwK80wNW3qTeA==
X-Received: by 2002:a1c:4956:: with SMTP id w83mr8147505wma.67.1560948898067;
        Wed, 19 Jun 2019 05:54:58 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id l12sm42800918wrb.81.2019.06.19.05.54.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:54:57 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/13] vfs: don't parse "silent" option
Date:   Wed, 19 Jun 2019 14:54:52 +0200
Message-Id: <20190619125452.28303-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While this is a standard option as documented in mount(8), it is ignored by
most filesystems.  So reject, unless filesystem explicitly wants to handle
it.

The exception is unconverted filesystems, where it is unknown if the
filesystem handles this or not.

Any implementation, such as mount(8) that needs to parse this option
without failing should simply ignore the return value from fsconfig().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
Changes:
 - v1 didn't return on matching option in legacy_parse_param()
 
 fs/fs_context.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 49636e541293..bd8f8ab8358b 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -51,7 +51,6 @@ static const struct constant_table common_clear_sb_flag[] = {
 	{ "nolazytime",	SB_LAZYTIME },
 	{ "nomand",	SB_MANDLOCK },
 	{ "rw",		SB_RDONLY },
-	{ "silent",	SB_SILENT },
 };
 
 /*
@@ -535,6 +534,15 @@ static int legacy_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	if (ret != -ENOPARAM)
 		return ret;
 
+	if (strcmp(param->key, "silent") == 0) {
+		if (param->type != fs_value_is_flag)
+			return invalf(fc, "%s: Unexpected value for '%s'",
+				      fc->fs_type->name, param->key);
+
+		fc->sb_flags |= SB_SILENT;
+		return 0;
+	}
+
 	if (strcmp(param->key, "source") == 0) {
 		if (param->type != fs_value_is_string)
 			return invalf(fc, "VFS: Legacy: Non-string source");
-- 
2.21.0

