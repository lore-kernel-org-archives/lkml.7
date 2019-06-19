Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B29C31E5D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E98D208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731884AbfFSMam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:30:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36821 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731859AbfFSMaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:30:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id u8so1658451wmm.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 05:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3XPGarDbNQvdg9HgXJCH37X+Od5kwHmLIcOjFshcWxM=;
        b=au30skSkJw1qr4Lx2VfaQbq9HMgavDhzhhyTbTHigmDZjBHGX74CktnptYFlKzrmjr
         p4CL1QVDDDrkUJwGZqldvvoLVjq/LOaA6PtrAIJEc/vg0mWubMkfnr28F9XfB17sERmI
         Co5vCFCOouQR5GDAyK30geDRxg0P+/au/E+HgMSkdtV8CrUc7iBL+HGklFWqIsjZsj/1
         At/xBcEoz4JlqPLJz3MvjtNTESpOkb6PiDeH3hIZUH/uVhRy07ZUmIVJ/7vvico+95ad
         LvCv9uYdVoBQ+2IOvy/ar1oDLWcG7rKK5obRsXva2R8cto66g8gpTNMAEWXRA1KzDMhU
         /KAA==
X-Gm-Message-State: APjAAAVv7DwPJOZwCn29a9ISgDPrJQNpFVnhAgY2wD9DDEFOKl3CJYh1
        fF46SI1bgAztJcATeKsZ7vDaBA==
X-Google-Smtp-Source: APXvYqxRFzpttWVNpTPiQbdLpMWn0xb6IHJ5FyTailY17pShWafJilfmh1UScZ9oGl2gwVqFz8iRLA==
X-Received: by 2002:a05:600c:214e:: with SMTP id v14mr8496323wml.96.1560947437553;
        Wed, 19 Jun 2019 05:30:37 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 11sm1837513wmd.23.2019.06.19.05.30.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:30:37 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] sysfs: don't ignore options
Date:   Wed, 19 Jun 2019 14:30:14 +0200
Message-Id: <20190619123019.30032-8-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619123019.30032-1-mszeredi@redhat.com>
References: <20190619123019.30032-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The options "sync", "async", "dirsync", "lazytime", "nolazytime", "mand"
and "nomand" make no sense for the sysfs filesystem.  If these options are
supplied to fsconfig(FSCONFIG_SET_FLAG), then return -EINVAL instead of
silently ignoring the option.

Any implementation, such as mount(8) that needs to parse this option
without failing should simply ignore the return value from fsconfig().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/sysfs/mount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/sysfs/mount.c b/fs/sysfs/mount.c
index ba576a976e8c..4797b7952fc5 100644
--- a/fs/sysfs/mount.c
+++ b/fs/sysfs/mount.c
@@ -49,7 +49,7 @@ static void sysfs_fs_context_free(struct fs_context *fc)
 
 static const struct fs_context_operations sysfs_fs_context_ops = {
 	.free		= sysfs_fs_context_free,
-	.parse_param	= vfs_parse_sb_flag,
+	.parse_param	= vfs_parse_ro_rw,
 	.get_tree	= sysfs_get_tree,
 };
 
-- 
2.21.0

