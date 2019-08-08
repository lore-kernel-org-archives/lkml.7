Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465B7C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF3E2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565291395;
	bh=NImqE0H43sXb6ouffQcKmdoWHv9do+cIG5A2IeP2Eu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BYm8XvAeR2fFacdVDAxPSrobH8MKH4P2SJ6zRT0KgHG2Hg6ZvKoiivIEQM/MezNWE
	 gO4mCV8OB2Hy+x21oaZyRd6m8/swfJAsh1OYMJLVDhBqL6buotXQnMEjYA9tGriw5A
	 8daiYR2jWyWzNEV1llPIX+lU3NvLRvyOwAfDFCWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405188AbfHHTJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:09:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405171AbfHHTJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:09:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 977A521743;
        Thu,  8 Aug 2019 19:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565291388;
        bh=NImqE0H43sXb6ouffQcKmdoWHv9do+cIG5A2IeP2Eu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QRfNW0V/S0JbQg7WmD1JmE0F8oV/1tvcByP5RAne3P8MM9h9SSeLHEqK/7XnIOFxn
         YdtGK3GC5iz2tjMklHj2HUJIOI9G6MOdpWjzVz7arLxMV7WSMVZm4TfD8ToROzI7hN
         5adwrWF42+/KCFpd+Be/Y0mD2t2YFnabTgdgzOUo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 4.19 40/45] cgroup: Call cgroup_release() before __exit_signal()
Date:   Thu,  8 Aug 2019 21:05:26 +0200
Message-Id: <20190808190456.128759505@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808190453.827571908@linuxfoundation.org>
References: <20190808190453.827571908@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejun Heo <tj@kernel.org>

commit 6b115bf58e6f013ca75e7115aabcbd56c20ff31d upstream.

cgroup_release() calls cgroup_subsys->release() which is used by the
pids controller to uncharge its pid.  We want to use it to manage
iteration of dying tasks which requires putting it before
__unhash_process().  Move cgroup_release() above __exit_signal().
While this makes it uncharge before the pid is freed, pid is RCU freed
anyway and the window is very narrow.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/exit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -194,6 +194,7 @@ repeat:
 	rcu_read_unlock();
 
 	proc_flush_task(p);
+	cgroup_release(p);
 
 	write_lock_irq(&tasklist_lock);
 	ptrace_release_task(p);
@@ -219,7 +220,6 @@ repeat:
 	}
 
 	write_unlock_irq(&tasklist_lock);
-	cgroup_release(p);
 	release_thread(p);
 	call_rcu(&p->rcu, delayed_put_task_struct);
 


