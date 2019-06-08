Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A71C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 05:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2508C2089E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 05:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oCrefRpU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfFHFI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 01:08:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46890 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfFHFI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 01:08:26 -0400
Received: by mail-pl1-f195.google.com with SMTP id e5so1571724pls.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 22:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Hx17RJnNZ9R6fmHYyRTfv/STbHwrf4Q4k1vwA34kpEQ=;
        b=oCrefRpU+j6VdWLo6+l6rxhteKGGWnzJKromVbDM1qYC2DR4c0URzg78l0RJU2x6Xm
         4Mr2wMGxAOwX7rKgx2RPYuM9r0VSYQRF+jMIDfZaWL9owJRd6x6hre0bMvi+d93nZ3io
         kLfKgRX418AlrVFZFMalki674E1HQLsCzaYzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Hx17RJnNZ9R6fmHYyRTfv/STbHwrf4Q4k1vwA34kpEQ=;
        b=dK+kdKYv+3AOCveIIoodcSVbMX/bvnRZb8e/S/f3KQBBc7cWb26zdQHulLqUgsUNXh
         JacdbF2amRCpEzbbr5BoHvdv8GL1fOMlfBuxGQiJ480DKvq4fiPUBPdnJMFuaX+Oh62P
         fHch+RbLn6XStanNrtvCCzDzTt0yvUJv3w0jQa94yct4XMnwHTQ53H7aB+6kU4moXxcY
         jhmxHfcZXdXsokNQxAXyKCFpCAg3fIz/5zJmnFo+LMMOoMuNgH+r58sSOCkxFWtpaUP1
         KfazmMfjLimGDLQbk57Dy6eDGJqONltkEJmETi1qa9HiMAWMn9+Lh0fJ6LC8amTo1B0C
         DP+Q==
X-Gm-Message-State: APjAAAVdmlpc/q7WI/o1FDTzjTfvV52QQInGYr6qmW1zIlqNj7yZl0mK
        zSUV4xk+B7ZXX2QHRE4hIxr/og==
X-Google-Smtp-Source: APXvYqz6beZb+bZkfMw/VOLBFsKcxd6xlVtk7S04lGbjglBiB+KLdJ5hVm31tPut/qh/A78MDijYFA==
X-Received: by 2002:a17:902:6b03:: with SMTP id o3mr59296701plk.85.1559970505308;
        Fri, 07 Jun 2019 22:08:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m6sm3818549pjl.18.2019.06.07.22.08.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 22:08:24 -0700 (PDT)
Date:   Fri, 7 Jun 2019 22:08:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andreas Christoforou <andreaschristofo@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ipc/mqueue: Only perform resource calculation if user
 valid
Message-ID: <201906072207.ECB65450@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Christoforou reported:

UBSAN: Undefined behaviour in ipc/mqueue.c:414:49 signed integer overflow:
9 * 2305843009213693951 cannot be represented in type 'long int'
...
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x11b/0x1fe lib/dump_stack.c:113
 ubsan_epilogue+0xe/0x81 lib/ubsan.c:159
 handle_overflow+0x193/0x218 lib/ubsan.c:190
 mqueue_evict_inode+0x8e7/0xa10 ipc/mqueue.c:414
 evict+0x472/0x8c0 fs/inode.c:558
 iput_final fs/inode.c:1547 [inline]
 iput+0x51d/0x8c0 fs/inode.c:1573
 mqueue_get_inode+0x8eb/0x1070 ipc/mqueue.c:320
 mqueue_create_attr+0x198/0x440 ipc/mqueue.c:459
 vfs_mkobj+0x39e/0x580 fs/namei.c:2892
 prepare_open ipc/mqueue.c:731 [inline]
 do_mq_open+0x6da/0x8e0 ipc/mqueue.c:771
...

Which could be triggered by:

        struct mq_attr attr = {
                .mq_flags = 0,
                .mq_maxmsg = 9,
                .mq_msgsize = 0x1fffffffffffffff,
                .mq_curmsgs = 0,
        };

        if (mq_open("/testing", 0x40, 3, &attr) == (mqd_t) -1)
                perror("mq_open");

mqueue_get_inode() was correctly rejecting the giant mq_msgsize,
and preparing to return -EINVAL. During the cleanup, it calls
mqueue_evict_inode() which performed resource usage tracking math for
updating "user", before checking if there was a valid "user" at all
(which would indicate that the calculations would be sane). Instead,
delay this check to after seeing a valid "user".

The overflow was real, but the results went unused, so while the flaw
is harmless, it's noisy for kernel fuzzers, so just fix it by moving
the calculation under the non-NULL "user" where it actually gets used.

Reported-by: Andreas Christoforou <andreaschristofo@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: update commit log based on Al's feedback
---
 ipc/mqueue.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 216cad1ff0d0..65c351564ad0 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -438,7 +438,6 @@ static void mqueue_evict_inode(struct inode *inode)
 {
 	struct mqueue_inode_info *info;
 	struct user_struct *user;
-	unsigned long mq_bytes, mq_treesize;
 	struct ipc_namespace *ipc_ns;
 	struct msg_msg *msg, *nmsg;
 	LIST_HEAD(tmp_msg);
@@ -461,16 +460,18 @@ static void mqueue_evict_inode(struct inode *inode)
 		free_msg(msg);
 	}
 
-	/* Total amount of bytes accounted for the mqueue */
-	mq_treesize = info->attr.mq_maxmsg * sizeof(struct msg_msg) +
-		min_t(unsigned int, info->attr.mq_maxmsg, MQ_PRIO_MAX) *
-		sizeof(struct posix_msg_tree_node);
-
-	mq_bytes = mq_treesize + (info->attr.mq_maxmsg *
-				  info->attr.mq_msgsize);
-
 	user = info->user;
 	if (user) {
+		unsigned long mq_bytes, mq_treesize;
+
+		/* Total amount of bytes accounted for the mqueue */
+		mq_treesize = info->attr.mq_maxmsg * sizeof(struct msg_msg) +
+			min_t(unsigned int, info->attr.mq_maxmsg, MQ_PRIO_MAX) *
+			sizeof(struct posix_msg_tree_node);
+
+		mq_bytes = mq_treesize + (info->attr.mq_maxmsg *
+					  info->attr.mq_msgsize);
+
 		spin_lock(&mq_lock);
 		user->mq_bytes -= mq_bytes;
 		/*
-- 
2.17.1


-- 
Kees Cook
