Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF78C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E402147A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731826AbfFSMad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:30:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36358 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731787AbfFSMab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:30:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so3221742wrs.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 05:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=syOsz+pCnNIc/qrQgZM4/GIrteB9uldeCUT6WZA8hVM=;
        b=b5lpZC9Xdhpftq9INpELDdYeJClYMW5tZ0M8h5BdJUIgzjlgMRNDVLDKk0i9FYQibf
         zizxdYEJUWqBaI+59dpxwml10BEEq+Dt+Z1TySKlLK9oA6d1YNejnux3frw/uDH1BiPR
         aHcRvQgeh0tYyuYmJT73m4WBZD/tizuEPHtPdZpl+OcmN54TADP3KTTi/JGCxvIdRiho
         faUNBYMJZjKQDBQhPIciHFeKD4sUInas8ezljvYPgJHIJXbuF7mMTrWFLRpaCK378mCd
         F+PImVj0apJy+J8z8bvi8zqnZRqbsn2xVYFya9cEA5pHfsLkF5N7OGdczk8dft+IWjDp
         VrOg==
X-Gm-Message-State: APjAAAXHShRXsSKZEeHMA35jrVGEtvJlwHQxGQyoZhEiuwQ/hx+WuoSZ
        iEMfgSVvJZknpVW3LNoaIF26XQ==
X-Google-Smtp-Source: APXvYqyjzkTgS7F88coETlRjgqd7E9iaHcb9QaeY+SJUGxkfZmk3cECPjwg/IA9yNUyKVxPD4Cdb2g==
X-Received: by 2002:a5d:56c1:: with SMTP id m1mr3035374wrw.26.1560947429205;
        Wed, 19 Jun 2019 05:30:29 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 11sm1837513wmd.23.2019.06.19.05.30.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:30:28 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] vfs: don't parse forbidden flags
Date:   Wed, 19 Jun 2019 14:30:09 +0200
Message-Id: <20190619123019.30032-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619123019.30032-1-mszeredi@redhat.com>
References: <20190619123019.30032-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Impossible to keep this blacklist properly synced with what mount(8) parses
and what it doesn't.  E.g. it has various forms of "*atime" options, but
not "atime"...

Other than being impossible to maintain, it also makes little sense.  So
just get rid of it.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fs_context.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index a9f314390b99..cbf89117a507 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -55,29 +55,6 @@ static const struct constant_table common_clear_sb_flag[] = {
 	{ "silent",	SB_SILENT },
 };
 
-static const char *const forbidden_sb_flag[] = {
-	"bind",
-	"dev",
-	"exec",
-	"move",
-	"noatime",
-	"nodev",
-	"nodiratime",
-	"noexec",
-	"norelatime",
-	"nostrictatime",
-	"nosuid",
-	"private",
-	"rec",
-	"relatime",
-	"remount",
-	"shared",
-	"slave",
-	"strictatime",
-	"suid",
-	"unbindable",
-};
-
 /*
  * Check for a common mount option that manipulates s_flags.
  */
@@ -85,11 +62,6 @@ int vfs_parse_sb_flag(struct fs_context *fc, struct fs_parameter *param)
 {
 	const char *key = param->key;
 	unsigned int set, clear;
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(forbidden_sb_flag); i++)
-		if (strcmp(key, forbidden_sb_flag[i]) == 0)
-			return -EINVAL;
 
 	set = lookup_constant(common_set_sb_flag, key, 0);
 	clear = lookup_constant(common_clear_sb_flag, key, 0);
-- 
2.21.0

