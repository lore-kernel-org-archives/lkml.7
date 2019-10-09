Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9429FC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 03:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687CE206C2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 03:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o54gf+5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbfJIDU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 23:20:28 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:38339 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfJIDU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 23:20:27 -0400
Received: by mail-pg1-f202.google.com with SMTP id j7so690080pgj.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 20:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=//5Om/XvJWZ+udEKS9YxOJkf+X7Db3sKLHkQ/lC+RWM=;
        b=o54gf+5aWdKfvI+AHUNpNBXeNjtTe200eLPmyr6FlwG3dJE2vLTfRwjsOBV8E1/65K
         IwO6CN5sWE3V73+pnV123sFvgITRCD26mt+DHCXnWKuj5heDgJDIHnjBAv6AL+z9Py3X
         4OMQvnkpWMPCLzbKKyoxRJLLWMrjZ9UjGJCPMyugBqfTDjS0hQ89G7O+474TB+UAA2NZ
         3soNbJs2d7npdXHKIhj93Qugh9DEbg7pdjH99OWrgaJY+GGkRDRKfAnWnlZVsmgeMne8
         cIDHvfZPbuyO+MhUyOrCSJLwv6MA1yJZXyy9SiyZUsqUPb3/m/srQcmTAYb1/xoSGuPq
         mytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=//5Om/XvJWZ+udEKS9YxOJkf+X7Db3sKLHkQ/lC+RWM=;
        b=WoLlPa3eMwobssbd09ujtQfchI2VqaANBrdVkf385IPFpmv3va41UYbvggkb+rSohg
         IWZ2CTOsSP2PTQV1Vu6dvxcXLpjULfWNjTMzR+fLG4Oain3bBCFWLUksqtMOJ7xMt76R
         AFhyNPnn6gaArNKIZbeHATDUgGx0B1FXnRjv3PlRVsFjeVtqXyROv3EWyP9eCpzsTCPv
         fmx2WdRE1jLbqewWUYdzp6YRpahY62Kj1TEh4+Ui+8LDl9o4aQNGWLv5gbxXllWkJf3i
         ClijY0g88/cq5razaSrbNsku9uP+m8wnSA2XOLmSM+4qtSYUh9kYvgk0hmO9GzOshw91
         Qirg==
X-Gm-Message-State: APjAAAXBSisB7qr5jSwp6HYs2OpzkwnizMFQdr2GVOB2q8KWM0Dh6/Cy
        i6TOb6COXrNltlIYcVkqMjJC/5rOju+BBv5Ms6Y=
X-Google-Smtp-Source: APXvYqxX6Bw7jJd8SeEqXgmezuewciPrpKwID/S4IXEyDLLyKeZpW5yRhwJ1SU2B+wrojPsFSueCrn1hxoyFqMenH/o=
X-Received: by 2002:a63:495b:: with SMTP id y27mr1959951pgk.438.1570591225171;
 Tue, 08 Oct 2019 20:20:25 -0700 (PDT)
Date:   Wed,  9 Oct 2019 11:20:19 +0800
Message-Id: <20191009032019.6954-1-huangrandall@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH] f2fs: fix to avoid memory leakage in f2fs_listxattr
From:   Randall Huang <huangrandall@google.com>
To:     jaegeuk@kernel.org, yuchao0@huawei.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     huangrandall@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In f2fs_listxattr, there is no boundary check before
memcpy e_name to buffer.
If the e_name_len is corrupted,
unexpected memory contents may be returned to the buffer.

Signed-off-by: Randall Huang <huangrandall@google.com>
---
 fs/f2fs/xattr.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index b32c45621679..acc3663970cd 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -538,8 +538,9 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
 ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 {
 	struct inode *inode = d_inode(dentry);
+	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
 	struct f2fs_xattr_entry *entry;
-	void *base_addr;
+	void *base_addr, *last_base_addr;
 	int error = 0;
 	size_t rest = buffer_size;
 
@@ -549,6 +550,8 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 	if (error)
 		return error;
 
+	last_base_addr = (void *)base_addr + XATTR_SIZE(xnid, inode);
+
 	list_for_each_xattr(entry, base_addr) {
 		const struct xattr_handler *handler =
 			f2fs_xattr_handler(entry->e_name_index);
@@ -559,6 +562,15 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 		if (!handler || (handler->list && !handler->list(dentry)))
 			continue;
 
+		if ((void *)(entry) + sizeof(__u32) > last_base_addr ||
+			(void *)XATTR_NEXT_ENTRY(entry) > last_base_addr) {
+			f2fs_err(F2FS_I_SB(inode), "inode (%lu) has corrupted xattr",
+						inode->i_ino);
+			set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
+			error = -EFSCORRUPTED;
+			goto cleanup;
+		}
+
 		prefix = xattr_prefix(handler);
 		prefix_len = strlen(prefix);
 		size = prefix_len + entry->e_name_len + 1;
-- 
2.23.0.581.g78d2f28ef7-goog

