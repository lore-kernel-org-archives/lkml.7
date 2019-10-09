Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1661C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D6A2133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="GCxTBJV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfJIIaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 04:30:00 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33807 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJIIaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 04:30:00 -0400
Received: by mail-lf1-f65.google.com with SMTP id r22so990557lfm.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 01:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9aF36gaw1IL/nWzuDiTqLh7zzkv/1MrK93P5SQw9amo=;
        b=GCxTBJV2TpfN5yh9793aMppv3nFyV0gP/CEpN0FhqOU0FI3HvIFnrG7SFVPFndQfQ/
         en0lxtP89WPAMPk9DT2k4QLmsY/06k1uBFGbZdUotZ1kLMHjlj1cckoaflNScKeGwaSP
         zH8Mh9H5zvvq0fR8ajjoqoQ65WsgxjdxOhaqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9aF36gaw1IL/nWzuDiTqLh7zzkv/1MrK93P5SQw9amo=;
        b=LYJjcPmklZFkAuihOWZqD6V261hO8oRac4qSFh/oho7zEOC398rnBnPq8hyeP5aWcr
         Jd+T5QWg7Ex5jfrVzlxySG22sLBlVdySncOGd+bT/EpMAnw5R/Va7BqsuIig0l4A/HXi
         PbSYodg4M7x/6G9FN1oUSaNoxw7gF93Npux4L05SRi0RV9JM2MFEs7rGFbdZRmXg9MIi
         KFv6KX2QEmzPAo7gSZ7db+G14nxDX86RJvKrk5p0ja+Ik8hIe8Ta1hpiOyTg/7Ihsadh
         zXv9RC5/FKJlYYa1q6LaL5GK23NDK8fZ2jdMDcyiS1ojOXDiC+O0alfyEuzfgWaz9YMo
         BHEA==
X-Gm-Message-State: APjAAAU5wTBS61WI/q4cktW+HZMrMpHoEt4wrw6Pc0aKbuGtR7TbZuDe
        0SneVSaiibjxLhKAfToLPSd7qw==
X-Google-Smtp-Source: APXvYqwyVvKlZ6JkfpoobL/avlhFPf8iTiuVHztmuz8Xa/Adw/gnkVXMZ4sZyLvmYLarOMoAhzv/og==
X-Received: by 2002:ac2:4345:: with SMTP id o5mr1342574lfl.60.1570609796736;
        Wed, 09 Oct 2019 01:29:56 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id p86sm273799lja.100.2019.10.09.01.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 01:29:56 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     James Morris <jamorris@linux.microsoft.com>,
        Paul Moore <paul@paul-moore.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/cred.c: make init_groups static
Date:   Wed,  9 Oct 2019 10:29:52 +0200
Message-Id: <20191009082953.8864-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_groups is declared in both cred.h and init_task.h, but it is not
actually referenced anywhere outside of cred.c where it is defined. So
make it static and remove the declarations.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/cred.h      | 1 -
 include/linux/init_task.h | 1 -
 kernel/cred.c             | 2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 18639c069263..4f4af62fe8f9 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -53,7 +53,6 @@ do {							\
 		groups_free(group_info);		\
 } while (0)
 
-extern struct group_info init_groups;
 #ifdef CONFIG_MULTIUSER
 extern struct group_info *groups_alloc(int);
 extern void groups_free(struct group_info *);
diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index 2c620d7ac432..6a046030ffad 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -25,7 +25,6 @@
 extern struct files_struct init_files;
 extern struct fs_struct init_fs;
 extern struct nsproxy init_nsproxy;
-extern struct group_info init_groups;
 extern struct cred init_cred;
 
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
diff --git a/kernel/cred.c b/kernel/cred.c
index c0a4c12d38b2..87983c9f82e9 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -33,7 +33,7 @@ do {									\
 static struct kmem_cache *cred_jar;
 
 /* init to 2 - one for init_task, one to ensure it is never freed */
-struct group_info init_groups = { .usage = ATOMIC_INIT(2) };
+static struct group_info init_groups = { .usage = ATOMIC_INIT(2) };
 
 /*
  * The initial credentials for the initial task
-- 
2.20.1

