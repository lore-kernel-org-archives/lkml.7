Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F130C06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 05:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E42821871
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 05:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="srbeKWsd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfGCFHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 01:07:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33650 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfGCFHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 01:07:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id m4so565525pgk.0;
        Tue, 02 Jul 2019 22:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KC7vgfyqe3Eg8Fe1+cMp4HakvNx6nu/Qukkr/Zk8t/0=;
        b=srbeKWsd0T/FmFJeZxZX7XrU5K3lDCf5qczxFm+i5RUqeXG+OCfkkW8149MtSQhKj6
         fGwbnqWrgmJBZAwS3AApMwK4kUnwtbbSqz+TmPLM8OqtnnGEpoboCbl11ftNyPRqtbrt
         bGa2KdPXks6Erg/8ptcXNZ4juObXOCcoOC/UyzTUO3Y3oH10eD4NzKWsKHpB6bdPSoeb
         S3yBjKhYISR5UqcCEVzYfkDcKqoZvtiodtB6SNlE0bgk+S4+AjPVoZuyfbSl5wRvevKs
         QscFbuAeKVUlK0eFhG1hplIswYg2zzIrOYcjT31zSA4Qwc2453gf/MCKild1aDXyYq13
         gLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KC7vgfyqe3Eg8Fe1+cMp4HakvNx6nu/Qukkr/Zk8t/0=;
        b=uFgaTTku+7otAnaT306kTE9Q5qzldMdlSMXhgO07jvsdaDrKkBYyMu46PrD1Xf9+71
         P5GicNWHyPGEtVbYiUcIxbqR59y5pnIlO7V8qTo59ReiOqMyolzzm7W3/aMLgfdiJm7N
         qfQAQWqqx5CRaMkZ0ofAvmgZqVue+JPJgKSkdQokeaHTp6ODDVrg1ymrUCkiXkauPGg0
         MxZlTi+7IJBbAuUFUnm+XLd/a16Otw3FW/rGnGmjjVcHp9IRhFHVhpC3l6wKiRrzKqJT
         W8TGY0Fb+7sYUxwB2vDYDOAFkQwpBMJBjQ0GPXZoW4gv2v4QgeRYPfIq4fuHAJjcMFFI
         NCeg==
X-Gm-Message-State: APjAAAXCKPZHNYPh/xc5vxis/TyaMSbxtj3Q1bY4HnNphC3UPiHiRzJC
        NhBes6cywukpp9SoBoEEl7yThfnf
X-Google-Smtp-Source: APXvYqzaXU3faS5JxOfTe2eOA7XoPTCkRS8vgP7gCgNPRUQr40ZbYSPxaM3Z7U4pYHyaX7bZGuIuwQ==
X-Received: by 2002:a17:90a:30e4:: with SMTP id h91mr9819718pjb.37.1562130466964;
        Tue, 02 Jul 2019 22:07:46 -0700 (PDT)
Received: from localhost.localdomain ([175.223.36.210])
        by smtp.gmail.com with ESMTPSA id v184sm831351pgd.34.2019.07.02.22.07.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 22:07:46 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] posix_acl: fix stale posix_acl_update_mode() comment
Date:   Wed,  3 Jul 2019 14:07:40 +0900
Message-Id: <20190703050740.13730-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

inode_change_ok() was renamed to setattr_prepare() in 4.8-rc1.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 fs/posix_acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 84ad1c90d535..a76aa995a95d 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -637,7 +637,7 @@ EXPORT_SYMBOL_GPL(posix_acl_create);
  * file mode, set *acl to NULL to indicate that no ACL should be set.
  *
  * As with chmod, clear the setgit bit if the caller is not in the owning group
- * or capable of CAP_FSETID (see inode_change_ok).
+ * or capable of CAP_FSETID (see setattr_prepare).
  *
  * Called from set_acl inode operations.
  */
-- 
2.22.0

