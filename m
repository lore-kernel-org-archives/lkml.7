Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48EAC4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 19:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF174207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 19:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+sYO+O2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389585AbfFJTPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 15:15:21 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45774 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389243AbfFJTOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 15:14:37 -0400
Received: by mail-ua1-f66.google.com with SMTP id v18so3525024uad.12;
        Mon, 10 Jun 2019 12:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=03qXnIOs+9PMTRKALHPhtOzBUbY1LuDMI7042jLkIEM=;
        b=q+sYO+O25PAkVKSZpsKj1OfUzWZuizGq05GqQ//teUbVxoI0Gr+pudBTbJsrXVk0AK
         vp9lmmAuSKZtW2KfBHrQdTcGHhPT6OanBLFG/Fjd5/lE/G9PII8873awfmqFC8hpUhKg
         D2lY8xWKov4H/ovzgv+Jv2wNaGfUt7YJ8CYpYq9qiNNnHLFd3fNSRufWtnU8eWjDdDb/
         fCCA0wei/JLshPe69z+yTS6HSU/mvkyKX2STQoHQVppctfDRW0SerJGmD7CdGkSc0YcH
         5pFfkr/PmUXYwOdYEv0vwj5hTCy0OfvyRWzeApHLZaSmJjgBnkb23Rlz0i+dWupO6BEP
         JUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=03qXnIOs+9PMTRKALHPhtOzBUbY1LuDMI7042jLkIEM=;
        b=jCu5XUgdOttHzL/7y+8mX5nWcKMClGE30JcXVsVO5yvd26X3cE9DR5O3y79IpQJjTm
         QWSSeEE3N471m1FZSDvuM8ldYa2FYwKobpAYexKZwaWVUfc4xEKMZaSCd8PkHqQEpFPZ
         6g8RNdxMW17vDlqdP10G4ap82ehm4he29qvq5wdzJwZD09Rd1qf5iWOZuymnvbu3aarY
         9MXtqqZKlT9Auh2hRE5xTXj4Ntlhdu4LT9xQn1glC3Vkb6LzfBMctVG+mwLU/JmMd295
         G7UzXwZk5vIOsBhRbUZULMK4Vc8aByVQ793lsSG5cB2+8Kx72paneoYY2p86Z9h2vCho
         pcxw==
X-Gm-Message-State: APjAAAU/50qk3yIzt/JoJcmQM9gj215yvl1SNGkF1bhC9KYW2cbnTymH
        DDJaSTcA9PHxqA02SQGwuYntaDKOHw==
X-Google-Smtp-Source: APXvYqx0V5Lkfup6ZBapoJxNQzzjDcvcm9S6eEe2y+rfZAijhO/uAxre2kPXwhD/J/e4Lkqp0KgekA==
X-Received: by 2002:ab0:1590:: with SMTP id i16mr9163111uae.141.1560194076068;
        Mon, 10 Jun 2019 12:14:36 -0700 (PDT)
Received: from kmo-pixel.hsd1.vt.comcast.net (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id t20sm4834014vkd.53.2019.06.10.12.14.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 12:14:35 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcache@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 06/12] fs: factor out d_mark_tmpfile()
Date:   Mon, 10 Jun 2019 15:14:14 -0400
Message-Id: <20190610191420.27007-7-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610191420.27007-1-kent.overstreet@gmail.com>
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New helper for bcachefs - bcachefs doesn't want the
inode_dec_link_count() call that d_tmpfile does, it handles i_nlink on
its own atomically with other btree updates

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 fs/dcache.c            | 10 ++++++++--
 include/linux/dcache.h |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index aac41adf47..18edb4e5bc 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3042,9 +3042,8 @@ void d_genocide(struct dentry *parent)
 
 EXPORT_SYMBOL(d_genocide);
 
-void d_tmpfile(struct dentry *dentry, struct inode *inode)
+void d_mark_tmpfile(struct dentry *dentry, struct inode *inode)
 {
-	inode_dec_link_count(inode);
 	BUG_ON(dentry->d_name.name != dentry->d_iname ||
 		!hlist_unhashed(&dentry->d_u.d_alias) ||
 		!d_unlinked(dentry));
@@ -3054,6 +3053,13 @@ void d_tmpfile(struct dentry *dentry, struct inode *inode)
 				(unsigned long long)inode->i_ino);
 	spin_unlock(&dentry->d_lock);
 	spin_unlock(&dentry->d_parent->d_lock);
+}
+EXPORT_SYMBOL(d_mark_tmpfile);
+
+void d_tmpfile(struct dentry *dentry, struct inode *inode)
+{
+	inode_dec_link_count(inode);
+	d_mark_tmpfile(dentry, inode);
 	d_instantiate(dentry, inode);
 }
 EXPORT_SYMBOL(d_tmpfile);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 60996e64c5..e0fe330162 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -255,6 +255,7 @@ extern struct dentry * d_make_root(struct inode *);
 /* <clickety>-<click> the ramfs-type tree */
 extern void d_genocide(struct dentry *);
 
+extern void d_mark_tmpfile(struct dentry *, struct inode *);
 extern void d_tmpfile(struct dentry *, struct inode *);
 
 extern struct dentry *d_find_alias(struct inode *);
-- 
2.20.1

