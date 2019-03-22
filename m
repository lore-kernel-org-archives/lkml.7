Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3078C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F50E2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNu8iEd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfCVWK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:10:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35037 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfCVWK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:10:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id g8so2426293pgf.2;
        Fri, 22 Mar 2019 15:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1iKqD1ucN45IcW6wn6xqJB3PQ7tx9hiUKga7iqSy8Fo=;
        b=oNu8iEd3HGy90AG4P3Ha/ryRQ1OHUj2cEnCMAxScR++M7DR97urKTrTt6gTu4JDKzr
         V/kac9zm8buGhGcAk/+hZOJfULhjOB4jM6zAGyqKal/sqWb0t8JozLLbgfG1f9GRpUSP
         /eBSY6J5vKdbdpLHxItqz7cDT2hzM1cFSYE5TGJ4TjBnATC2r++SWLZUeTw1ezI1RzYL
         jPC/dFQkzYRQm0+x2/oQULOj0CdovEvTakhUh1MvtgPIBX6dt6PJCTDbgUTlHGF3S1Q+
         898kMRW3mqZTd6KbqqpBNXu9BpqefeRgYkGkWBIs7tUmGM0KDbJbwHDyRNG2ea0057/I
         Y1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1iKqD1ucN45IcW6wn6xqJB3PQ7tx9hiUKga7iqSy8Fo=;
        b=C7uPW+gx69E1bQrXJhuoe6lqW2s9F7E8Pdkh+Jq8ZsMA8Npu12K7epykwQkmP2nYUy
         D/mXSqfyXyEhpGlFwjYVbiQAxAl1dl2RfBPhUVfuDYrwdmH98GQKQyPdhBHdrrud2o5g
         XFaP5P8b2EbIlRYJkt97nsioDzN8l3ELW+BDt5p8z6Qepy9PpClDr9xfbLmKko2yp14u
         jmPOkcMM9Ba+e8XkcFZeqdbhSm+/+rragJ6olNtiiN08lGZ9M/6Cs2xY5PusEqt3JdPz
         Z05G5mrqI6EKS08n7AXdqu2rpygdyl+FGGF+ZBuSlz2ne9IbeGLQ2ArgaaRzHN+fYX6j
         aWRw==
X-Gm-Message-State: APjAAAXYippdgwq++3a7MnWXSRYhLJSYF/oIH/E8nPzHLSKbDJdJLIp3
        sKL7CGdSvqZE3Y5f/cU7cGQ=
X-Google-Smtp-Source: APXvYqyXQ9geD+0hj3lSdj7CuG/licv3br7cmSOuIvZ9S1W6JJcf4EionWr5CJu1q4oKN4TztTtc6A==
X-Received: by 2002:a63:5541:: with SMTP id f1mr11332970pgm.38.1553292627746;
        Fri, 22 Mar 2019 15:10:27 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.168.123])
        by smtp.gmail.com with ESMTPSA id j6sm13007298pfe.79.2019.03.22.15.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 15:10:27 -0700 (PDT)
Date:   Sat, 23 Mar 2019 03:40:21 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: [PATCH] fs: fix warning about Using plain integer as NULL pointer
Message-ID: <20190322221021.GA24814@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse warning below:

sudo make C=2 CF=-D__CHECK_ENDIAN__ M=fs

CHECK   fs/f2fs/data.c
fs/f2fs/data.c:426:47: warning: Using plain integer as NULL pointer
CHECK   fs/notify/fdinfo.c
fs/notify/fdinfo.c:53:87: warning: Using plain integer as NULL pointer
 CHECK   fs/ubifs/xattr.c
fs/ubifs/xattr.c:615:58: warning: Using plain integer as NULL pointer

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 fs/f2fs/data.c     | 2 +-
 fs/notify/fdinfo.c | 2 +-
 fs/ubifs/xattr.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 97279441..15a2381 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -423,7 +423,7 @@ static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
 
 void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type)
 {
-	__submit_merged_write_cond(sbi, NULL, 0, 0, type, true);
+	__submit_merged_write_cond(sbi, NULL, NULL, 0, type, true);
 }
 
 void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 1e2bfd2..ef83f40 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -50,7 +50,7 @@ static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
 	f.handle.handle_bytes = sizeof(f.pad);
 	size = f.handle.handle_bytes >> 2;
 
-	ret = exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_handle, &size, 0);
+	ret = exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_handle, &size, NULL);
 	if ((ret == FILEID_INVALID) || (ret < 0)) {
 		WARN_ONCE(1, "Can't encode file handler for inotify: %d\n", ret);
 		return;
diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index f5ad1ed..066a566 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -612,7 +612,7 @@ int ubifs_init_security(struct inode *dentry, struct inode *inode,
 	int err;
 
 	err = security_inode_init_security(inode, dentry, qstr,
-					   &init_xattrs, 0);
+					   &init_xattrs, NULL);
 	if (err) {
 		struct ubifs_info *c = dentry->i_sb->s_fs_info;
 		ubifs_err(c, "cannot initialize security for inode %lu, error %d",
-- 
2.7.4

