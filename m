Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF9AC742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4150C216B7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934836;
	bh=6gxEAhsO1HLcQtZavycbTcyuT3ldIhrjwIC4kk7XOas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WpjT283+wLF2OzomYwoHkDkGjYX+015TkCdng3z3uUEp+HvyBC7gKzzNL2b8X6sQ4
	 FpVl0AkiiO7YaNOfPKpHum2itr9XDsGPuTZXKSJBEUOlxvB8KqPGS9gw9LXW5XrfCn
	 kmdcDf/3aCnEuV9eh8mnway12tLJHKso35jqBZkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbfGLMdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:33:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728879AbfGLMdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:33:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4912B216E3;
        Fri, 12 Jul 2019 12:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934829;
        bh=6gxEAhsO1HLcQtZavycbTcyuT3ldIhrjwIC4kk7XOas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TV280/KZEw6edpQP94ONo1kDjs3lcRO70qoAfQ78P0QAjRaimB8Qx5Oo7QSCt2fQ1
         /7EhjU5Xx/yrPA5+iURZ8H42wNEC6+omcULvPW7frcP1lbwZHACw0Va0o/1zJ/B3yp
         2au8grp5QIS2mIdOG+fFySi1JBUr+qK2IP1t0dko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+182ce46596c3f2e1eb24@syzkaller.appspotmail.com,
        Todd Kjos <tkjos@google.com>
Subject: [PATCH 5.2 42/61] binder: fix memory leak in error path
Date:   Fri, 12 Jul 2019 14:19:55 +0200
Message-Id: <20190712121622.886842397@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121620.632595223@linuxfoundation.org>
References: <20190712121620.632595223@linuxfoundation.org>
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
@@ -4268,6 +4268,8 @@ retry:
 		case BINDER_WORK_TRANSACTION_COMPLETE: {
 			binder_inner_proc_unlock(proc);
 			cmd = BR_TRANSACTION_COMPLETE;
+			kfree(w);
+			binder_stats_deleted(BINDER_STAT_TRANSACTION_COMPLETE);
 			if (put_user(cmd, (uint32_t __user *)ptr))
 				return -EFAULT;
 			ptr += sizeof(uint32_t);
@@ -4276,8 +4278,6 @@ retry:
 			binder_debug(BINDER_DEBUG_TRANSACTION_COMPLETE,
 				     "%d:%d BR_TRANSACTION_COMPLETE\n",
 				     proc->pid, thread->pid);
-			kfree(w);
-			binder_stats_deleted(BINDER_STAT_TRANSACTION_COMPLETE);
 		} break;
 		case BINDER_WORK_NODE: {
 			struct binder_node *node = container_of(w, struct binder_node, work);


