Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F83C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9738E20693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="t8YLoxAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732692AbfG3Pwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:52:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41617 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732290AbfG3Pwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:52:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so19932641pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 08:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DxnrGcc7AvHyymca2iRUY2VmSq5SsDzU7A81wj1Q1kA=;
        b=t8YLoxAiwt9jLs0ltmXYLe3szj3BRw96GfuO3Lx/RnRQ2Lz5lRMwbvQ2VV00AMt+Y+
         +b5TktFWW0nxyXxUNu24uk/+b/3ZiiWNGYiVSmjYyhe5tVHDjRX4Y3ReyQlTmPnZvr58
         Mtq+0muwjKy/QlbNwoxnzugtsxt6iulWLPv8vtEPnlEzgOfUHvNGS97UUntOy/XiHjAo
         fTsKZC/4VkWCoIe0oSTpq7ar3Lr1J4xGcO6GaEn7hjzeXVkWY1rAO/1sPx2Jg7byTpHh
         /0/N/9TKyXfV11rGD6zLSJIoXXKMWZHMuMjvr0hfkVGP3Jl5E/VbFEtJJdm9FjqChcht
         kKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DxnrGcc7AvHyymca2iRUY2VmSq5SsDzU7A81wj1Q1kA=;
        b=iCVhKBjE6WcMrpRtG7Ig+srFqpQJL3yRVrXrUWrQ4aUIvJ73BB8JVeIXFgzFcL5kEe
         aPV6KqMPI1UxWdbIJdojZXmOlkckEfp3iCNPw70/UvWxtrSv7AaF0G+ApAAPPyhANwEf
         jhMR2l9e+WXCqOKp1e9sGSibvNI7wwGrAR1NT+WsgrFAsxtkAe5JM8K25JNUPd3WgKCi
         FpVP4H4zDyj+WEU89XofuIdYyKIVNUUHpTRnvSgxOTpXnxrbZhnzXEHarafBxP4q+5/g
         8g+yryMbJ8/Yy/D5wbd4b2wqOewYLj8Szq7iUAtEfUhRJUAv0YRtCOS6LfeR0fg0E7gF
         fP8g==
X-Gm-Message-State: APjAAAWnUFmBknvLQhBrUy7BZocnetvouy9SLqnSiIn8oIgc8oDCus5u
        K22OZyjwD3H+zcso3zk2gA7xa54fIWA=
X-Google-Smtp-Source: APXvYqzjccGSoIbwh+qDMtePKn3NyCOzg8XVKEr0dLFzjciRcbnNV0p4LA9QlqryZRQ5bhT0e+rYvA==
X-Received: by 2002:a63:b919:: with SMTP id z25mr108579853pge.201.1564501962876;
        Tue, 30 Jul 2019 08:52:42 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id q1sm76758814pfg.84.2019.07.30.08.52.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 08:52:42 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-unionfs@vger.kernel.org, linux-doc@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v11 2/4] fs: __vfs_getxattr nesting paradigm
Date:   Tue, 30 Jul 2019 08:52:23 -0700
Message-Id: <20190730155227.41468-3-salyzyn@android.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190730155227.41468-1-salyzyn@android.com>
References: <20190730155227.41468-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a per-thread PF_NO_SECURITY flag that ensures that nested calls
that result in vfs_getxattr do not fall under security framework
scrutiny.  Use cases include selinux when acquiring the xattr data
to evaluate security, and internal trusted xattr data soleley managed
by the filesystem drivers.

This handles the case of a union filesystem driver that is being
requested by the security layer to report back the data that is the
target label or context embedded into wrapped filesystem's xattr.

For the use case where access is to be blocked by the security layer.

The path then could be security(dentry) -> __vfs_getxattr(dentry) ->
handler->get(dentry) -> __vfs_getxattr(lower_dentry) ->
lower_handler->get(lower_dentry) which would report back through the
chain data and success as expected, but the logging security layer at
the top would have the data to determine the access permissions and
report back the target context that was blocked.

Without the nesting check, the path on a union filesystem would be
the errant security(dentry) -> __vfs_getxattr(dentry) ->
handler->get(dentry) -> vfs_getxattr(lower_dentry) -> *nested*
security(lower_dentry, log off) -> lower_handler->get(lower_dentry)
which would report back through the chain no data, and -EACCES.

For selinux for both cases, this would translate to a correctly
determined blocked access. In the first corrected case a correct avc
log would be reported, in the second legacy case an incorrect avc log
would be reported against an uninitialized u:object_r:unlabeled:s0
context making the logs cosmetically useless for audit2allow.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-unionfs@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com
---
v11 - squish out v10 introduced patch 2 and 3 in the series,
      then use per-thread flag instead for nesting.
---
 fs/xattr.c            | 10 +++++++++-
 include/linux/sched.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 90dd78f0eb27..46ebd5014e01 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -302,13 +302,19 @@ __vfs_getxattr(struct dentry *dentry, struct inode *inode, const char *name,
 	       void *value, size_t size)
 {
 	const struct xattr_handler *handler;
+	ssize_t ret;
+	unsigned int flags;
 
 	handler = xattr_resolve_name(inode, &name);
 	if (IS_ERR(handler))
 		return PTR_ERR(handler);
 	if (!handler->get)
 		return -EOPNOTSUPP;
-	return handler->get(handler, dentry, inode, name, value, size);
+	flags = current->flags;
+	current->flags |= PF_NO_SECURITY;
+	ret = handler->get(handler, dentry, inode, name, value, size);
+	current_restore_flags(flags, PF_NO_SECURITY);
+	return ret;
 }
 EXPORT_SYMBOL(__vfs_getxattr);
 
@@ -318,6 +324,8 @@ vfs_getxattr(struct dentry *dentry, const char *name, void *value, size_t size)
 	struct inode *inode = dentry->d_inode;
 	int error;
 
+	if (unlikely(current->flags & PF_NO_SECURITY))
+		goto nolsm;
 	error = xattr_permission(inode, name, MAY_READ);
 	if (error)
 		return error;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8dc1811487f5..5cda3ff89d4e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1468,6 +1468,7 @@ extern struct pid *cad_pid;
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_NOCMA	0x10000000	/* All allocation request will have _GFP_MOVABLE cleared */
+#define PF_NO_SECURITY		0x20000000	/* nested security context */
 #define PF_FREEZER_SKIP		0x40000000	/* Freezer should not count it as freezable */
 #define PF_SUSPEND_TASK		0x80000000      /* This thread called freeze_processes() and should not be frozen */
 
-- 
2.22.0.770.g0f2c4a37fd-goog

