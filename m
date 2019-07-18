Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C592FC76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F21321850
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419491;
	bh=GHt8LwMbS7G867sthSZrkRERqZKFD1mhXFEBXgBAL2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Um+DnGAaE7r577YhP/0zazhRBPdD2TNuGyi+eCZcvl3OjVBRJnpTpStglZOMNqnoz
	 9w4cRm1/cPEwXX5+Gqgd7y15EnOmiNdgeLnL/djM2C0eAcjQk/oFMEO1WEvoCEkvmv
	 epqQo2MjMEbcdtoEMZEClQ/ndRzdCLpN4YwgXsho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390106AbfGRDLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:11:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389655AbfGRDLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:11:17 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC2512053B;
        Thu, 18 Jul 2019 03:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419476;
        bh=GHt8LwMbS7G867sthSZrkRERqZKFD1mhXFEBXgBAL2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UY0XwdRgZ/Lk0PiTN+xvaCO6T0Ggw6nUdZRr5aIu31NUvkNTKgkalpY879vipbPy/
         XU2lnFB3RbyhijLgphiLJfefcGj85QNPv2XKqoPSMm6h2HE4uiePol+LyGeZq827Ec
         P+uror5DU+XTh3MM8q21w+tETxRWJPPyOMT0vdps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+182ce46596c3f2e1eb24@syzkaller.appspotmail.com,
        Todd Kjos <tkjos@google.com>
Subject: [PATCH 4.14 58/80] binder: fix memory leak in error path
Date:   Thu, 18 Jul 2019 12:01:49 +0900
Message-Id: <20190718030103.019747614@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030058.615992480@linuxfoundation.org>
References: <20190718030058.615992480@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Kjos <tkjos@android.com>

commit 1909a671dbc3606685b1daf8b22a16f65ea7edda upstream.

syzkallar found a 32-byte memory leak in a rarely executed error
case. The transaction complete work item was not freed if put_user()
failed when writing the BR_TRANSACTION_COMPLETE to the user command
buffer. Fixed by freeing it before put_user() is called.

Reported-by: syzbot+182ce46596c3f2e1eb24@syzkaller.appspotmail.com
Signed-off-by: Todd Kjos <tkjos@google.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/android/binder.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3876,6 +3876,8 @@ retry:
 		case BINDER_WORK_TRANSACTION_COMPLETE: {
 			binder_inner_proc_unlock(proc);
 			cmd = BR_TRANSACTION_COMPLETE;
+			kfree(w);
+			binder_stats_deleted(BINDER_STAT_TRANSACTION_COMPLETE);
 			if (put_user(cmd, (uint32_t __user *)ptr))
 				return -EFAULT;
 			ptr += sizeof(uint32_t);
@@ -3884,8 +3886,6 @@ retry:
 			binder_debug(BINDER_DEBUG_TRANSACTION_COMPLETE,
 				     "%d:%d BR_TRANSACTION_COMPLETE\n",
 				     proc->pid, thread->pid);
-			kfree(w);
-			binder_stats_deleted(BINDER_STAT_TRANSACTION_COMPLETE);
 		} break;
 		case BINDER_WORK_NODE: {
 			struct binder_node *node = container_of(w, struct binder_node, work);


