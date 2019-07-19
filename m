Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC292C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 23:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1D821849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 23:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvYPxMG7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732878AbfGSXaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 19:30:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43130 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbfGSXaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 19:30:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so14799664pfg.10;
        Fri, 19 Jul 2019 16:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=66rTuFgUuVjzdvwr5vssBmJQ5naQ4mmWCVou0nSVcyk=;
        b=VvYPxMG7i8Or1RYsycw7x+7Nzy9pylALB6piQ4ROpqGWdyyYPZkQfdlP0kvlmlw/Fy
         HtaSHcZ3k39vSEu3N3s/cl4CcYdSzGd0XOZHMLi9VzjxgCJMqB4nSSSIFK9YC1dF7NLN
         9nQ6I+pDxVUaP5dZG0fQGSiM5YMbuWLeK8EXSi8iUI9NjNFRtoeDm6Y/W1ue1GAnBRVq
         lyNASCqsl6iQsholhARWqzqQ+ooA/XyRFiQme2izQcqhT4kawD2J2tRACaKOaqG5AgUC
         uS5DJjJR4rt1chrbuq6D9qLllsCuHWq0SoErn0Z151pq2CL76MaoomTjJK75HpGSw2vw
         cS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=66rTuFgUuVjzdvwr5vssBmJQ5naQ4mmWCVou0nSVcyk=;
        b=WozMv99M+ttuida9Alo/bqLZ1DohXcSxfMmcG6s6xesNytDUC/+9lP8GcE8S3/MAhs
         O+MgeYy1x3XjypPr2rVX5v4UglcMsis0/MqlpdkArq9Xhna6pikUQRTrmbReSEDg4xKz
         MbRrvxXM+FYm6kn440iWnh5cjb4vrAO1HPaWGaiwcC3JE8J3XLtDErzaox2gizkmDEKk
         jBFOsrHzHKs74NoWyMJ/5dD8+vmXujYzEwOfsJsiFZr66jivIbhPCNAqBs4G0Od1iIXs
         LgurtpAMP1qeu+17fqTJfHpqvOPGPBSwG2n6DypsofRige/BhL7Z0WJ58iZmwAUisLw6
         rQ9Q==
X-Gm-Message-State: APjAAAUM1Ptd7ygBA5fTt0JAvtLfmU2i9lkS7GFRt7FwkVFAdz8hBO4c
        QQGpHkb/4yCkSoU5Iwy6FnI=
X-Google-Smtp-Source: APXvYqw2ukK3dKMvJT/3xQKKw/gOo9AaAFKu2BvlscxjpBz+CwcQSkBAvWRjSd4pUDjGe2EERdsLDA==
X-Received: by 2002:a65:5144:: with SMTP id g4mr4270369pgq.202.1563579015384;
        Fri, 19 Jul 2019 16:30:15 -0700 (PDT)
Received: from localhost.localdomain ([103.121.208.202])
        by smtp.gmail.com with ESMTPSA id v13sm39150670pfn.109.2019.07.19.16.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 16:30:14 -0700 (PDT)
From:   Yin Fengwei <nh26223.lmm@gmail.com>
To:     dhowells@redhat.com, gregkh@linuxfoundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, miklos@szeredi.hu,
        viro@zeniv.linux.org.uk, tglx@linutronix.de,
        kstewart@linuxfoundation.org
Subject: [PATCH v2] fs: fs_parser: avoid NULL param->string to kstrtouint
Date:   Sat, 20 Jul 2019 07:29:49 +0800
Message-Id: <20190719232949.27978-1-nh26223.lmm@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported general protection fault in kstrtouint:
https://lkml.org/lkml/2019/7/18/328

From the log, if the mount option is something like:
   fd,XXXXXXXXXXXXXXXXXXXX

The default parameter (which has NULL param->string) will be
passed to vfs_parse_fs_param. Finally, this NULL param->string
is passed to kstrtouint and trigger NULL pointer access.

Reported-by: syzbot+398343b7c1b1b989228d@syzkaller.appspotmail.com
Fixes: 71cbb7570a9a ("vfs: Move the subtype parameter into fuse")

Signed-off-by: Yin Fengwei <nh26223.lmm@gmail.com>
---
ChangeLog:
 v1 -> v2:
   - Fix typo in v1
   - Remove braces {} from single statement blocks

 fs/fs_parser.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index 83b66c9e9a24..7498a44f18c0 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -206,6 +206,9 @@ int fs_parse(struct fs_context *fc,
 	case fs_param_is_fd: {
 		switch (param->type) {
 		case fs_value_is_string:
+			if (!result->has_value)
+				goto bad_value;
+
 			ret = kstrtouint(param->string, 0, &result->uint_32);
 			break;
 		case fs_value_is_file:
-- 
2.17.1

