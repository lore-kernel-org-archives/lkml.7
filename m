Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00271C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DC42081B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482628;
	bh=/rzahTB47Q+suoizA3yYb2auJQHO7WTea6i2JGa39i0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XUYirHFTzEv43Jo1RTUNgVJVtJCZ7iYP5JdWZ9g8eLbSPlOKhq63QkuCqLkf6Gkss
	 Zvx6X80xp2MuFzUkhCSqlijHxsSYZS93Dysn7Ytyx4XQO8h4nS2fMm/N1vweDOzVcv
	 l280SQ8AY/0HG48HGnAouX3r2lbHENY1HPWuFqXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbfLDSDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:03:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:47874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730082AbfLDSDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:03:39 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1BA02073B;
        Wed,  4 Dec 2019 18:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482619;
        bh=/rzahTB47Q+suoizA3yYb2auJQHO7WTea6i2JGa39i0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NKx/uXhXUrY/dyhJwgE8XyC+plsueg/afcJas16ZnQPmCQTM/noMP3ajWDqHOoKce
         6cKppxn9p1QMchOLdW6TlrddwpLzLoylL/O/CdGdDaYaZaM31br6Jn+R+S1/p5GzZf
         nP4eP1jSs14A7jg5XJj8qZjgJrgFIUXFmW7GSNJk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 068/209] exofs_mount(): fix leaks on failure exits
Date:   Wed,  4 Dec 2019 18:54:40 +0100
Message-Id: <20191204175325.957586519@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 26cb5a328c6b2bda9e859307ce4cfc60df3a2c28 ]

... and don't abuse mount_nodev(), while we are at it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exofs/super.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/fs/exofs/super.c b/fs/exofs/super.c
index c9ec652e2fcd2..881d5798a1814 100644
--- a/fs/exofs/super.c
+++ b/fs/exofs/super.c
@@ -702,21 +702,18 @@ out:
 /*
  * Read the superblock from the OSD and fill in the fields
  */
-static int exofs_fill_super(struct super_block *sb, void *data, int silent)
+static int exofs_fill_super(struct super_block *sb,
+				struct exofs_mountopt *opts,
+				struct exofs_sb_info *sbi,
+				int silent)
 {
 	struct inode *root;
-	struct exofs_mountopt *opts = data;
-	struct exofs_sb_info *sbi;	/*extended info                  */
 	struct osd_dev *od;		/* Master device                 */
 	struct exofs_fscb fscb;		/*on-disk superblock info        */
 	struct ore_comp comp;
 	unsigned table_count;
 	int ret;
 
-	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
-	if (!sbi)
-		return -ENOMEM;
-
 	/* use mount options to fill superblock */
 	if (opts->is_osdname) {
 		struct osd_dev_info odi = {.systemid_len = 0};
@@ -860,7 +857,9 @@ static struct dentry *exofs_mount(struct file_system_type *type,
 			  int flags, const char *dev_name,
 			  void *data)
 {
+	struct super_block *s;
 	struct exofs_mountopt opts;
+	struct exofs_sb_info *sbi;
 	int ret;
 
 	ret = parse_options(data, &opts);
@@ -869,9 +868,31 @@ static struct dentry *exofs_mount(struct file_system_type *type,
 		return ERR_PTR(ret);
 	}
 
+	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
+	if (!sbi) {
+		kfree(opts.dev_name);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	s = sget(type, NULL, set_anon_super, flags, NULL);
+
+	if (IS_ERR(s)) {
+		kfree(opts.dev_name);
+		kfree(sbi);
+		return ERR_CAST(s);
+	}
+
 	if (!opts.dev_name)
 		opts.dev_name = dev_name;
-	return mount_nodev(type, flags, &opts, exofs_fill_super);
+
+
+	ret = exofs_fill_super(s, &opts, sbi, flags & SB_SILENT ? 1 : 0);
+	if (ret) {
+		deactivate_locked_super(s);
+		return ERR_PTR(ret);
+	}
+	s->s_flags |= SB_ACTIVE;
+	return dget(s->s_root);
 }
 
 /*
-- 
2.20.1



