Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335D5CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092A421925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LxUzoaPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504541AbfJRG4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 02:56:31 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:53680 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504354AbfJRG4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 02:56:30 -0400
Received: by mail-pf1-f202.google.com with SMTP id x10so3844525pfr.20
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 23:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+hsKPqici8eyIvgx8GToH+3aueA0ocUnG9yKN+h0H1M=;
        b=LxUzoaPX3paNCqiXE/0YvBQccH5ed0EWkDanj8GsnmLBBWbmab6RoWYtLwmMjXY4CZ
         ++4BhhGOHwLDs+jbzfvDGq+TlGnqpFOG0Qtl/MNvOHu4QiF/cpW3tMqZWuctGHPBYQuX
         vYXLoWeNOmDmluU36fmo9YhL9jRnS+/CO4Nnu7HHLHAjJVwhIk/l/hgc3k1QUM0jZVmm
         Il0DZi+ZO3VUpxGfUf8hlKNety7xz25oYt8khO8/VTQXWCJnx69RBGXZRUA7EtfRZIZf
         SK1QEtCJe6hgnpVycW/dxEcU1e1pxzdeHgdl45IFr3Z0kQgrg+hIkpSHdcH15+xxqtLg
         kBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+hsKPqici8eyIvgx8GToH+3aueA0ocUnG9yKN+h0H1M=;
        b=TM6YXNmtWMK0jadwE7/7O+Nhro8WzX629YkxlXeur2cEms5u30zcO5WyXSUXptX0s2
         Ge5rBbPeGousMvb1OQq6eYSYii2IDjoNQXfX6txAOeYz0SSE3XUZ6PRMMtVXipUEAfGn
         XEFLQtE3g+G3j3u+GI5CowRYNoYXOI6wjmfn1vIHuAQ1wUzLVSv6CY9GOKSTTkhDZYV2
         9+tVfWJwg8rh0MMyWUhBf1MpzSE1BO388czLITlJ3oWYil23xrR1NT5OXJjZOrWsrqKP
         BX7ZYENIya6+uutEWlnZw9C1ZLQzaw1sFC/4gIdPYabNDEPPenwq0fYHvMmnwXReSpsD
         SPMQ==
X-Gm-Message-State: APjAAAU7B8xHTr4Nb56Jb81X4lsbEvd5jWQQWoH0ncZ2RUDjWwmrWkXU
        jqe6Rlk1VQL+h4He+DhuE0I9kl21xuctpyc/nDU=
X-Google-Smtp-Source: APXvYqxacPck+QvS1cCpIRpnt4Qx7Ru8kfEkf9dhMJu3nG6odMRdImehsxFznI3l8VEtmkAVkr0stp06+uN4fQr/CYE=
X-Received: by 2002:a63:f743:: with SMTP id f3mr8628044pgk.410.1571381787920;
 Thu, 17 Oct 2019 23:56:27 -0700 (PDT)
Date:   Fri, 18 Oct 2019 14:56:22 +0800
In-Reply-To: <efddfbc3-bd31-b9fb-48de-decb01d01001@huawei.com>
Message-Id: <20191018065622.66404-1-huangrandall@google.com>
Mime-Version: 1.0
References: <efddfbc3-bd31-b9fb-48de-decb01d01001@huawei.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v2] f2fs: fix to avoid memory leakage in f2fs_listxattr
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
v2:
relocate sanity check
---
 fs/f2fs/xattr.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 181900af2576..296b3189448a 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -539,8 +539,9 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
 ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 {
 	struct inode *inode = d_inode(dentry);
+	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
 	struct f2fs_xattr_entry *entry;
-	void *base_addr;
+	void *base_addr, *last_base_addr;
 	int error = 0;
 	size_t rest = buffer_size;
 
@@ -550,6 +551,8 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 	if (error)
 		return error;
 
+	last_base_addr = (void *)base_addr + XATTR_SIZE(xnid, inode);
+
 	list_for_each_xattr(entry, base_addr) {
 		const struct xattr_handler *handler =
 			f2fs_xattr_handler(entry->e_name_index);
@@ -557,6 +560,15 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 		size_t prefix_len;
 		size_t size;
 
+		if ((void *)(entry) + sizeof(__u32) > last_base_addr ||
+			(void *)XATTR_NEXT_ENTRY(entry) > last_base_addr) {
+			f2fs_err(F2FS_I_SB(inode), "inode (%lu) has corrupted xattr",
+						inode->i_ino);
+			set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
+			error = -EFSCORRUPTED;
+			goto cleanup;
+		}
+
 		if (!handler || (handler->list && !handler->list(dentry)))
 			continue;
 
-- 
2.23.0.866.gb869b98d4c-goog

