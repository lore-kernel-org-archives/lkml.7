Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A933C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9EB21904
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127420;
	bh=Dq7ld1LdbcEflohjCoyQ7jz+RRaPMZc7jZJTC+2y9bI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h+5BINYxI4Q+sSRn19vRe5SQwbvtr2ul4x3uFtfazFlNzThLjJEiyvBfnv8AXoi6P
	 EYnwJ0OfcuDOd/QdfE0a3bFtt7R9ht1DrA4p2Mjqo8oWAF/prxS0JXpO5SImSERf+0
	 zB5WDf0d69QO801CU+vvv3vyDLqo1vEImXZYtgdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403937AbfDXRg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:36:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391535AbfDXRgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:36:54 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1F3521907;
        Wed, 24 Apr 2019 17:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127413;
        bh=Dq7ld1LdbcEflohjCoyQ7jz+RRaPMZc7jZJTC+2y9bI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pEiLGcn4LIdj6Ap+Qoz1llqSSajFbC+8wyGjxhjEUeZTV2lUILiIE3oA0MyhxgaAO
         slM+8Nqvl/gKPHMXxGQOPS6l8cJXc3QbU/Wwq4dGj7ESdQ/oFHSEIb131MtHXU4Vlg
         44OdR6poGAPbN99B20DPN2mLlThw+rlbNUZyybRs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Corey Minyard <cminyard@mvista.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH 5.0 083/115] ipmi: fix sleep-in-atomic in free_user at cleanup SRCU user->release_barrier
Date:   Wed, 24 Apr 2019 19:10:19 +0200
Message-Id: <20190424170929.794865018@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

commit 3b9a907223d7f6b9d1dadea29436842ae9bcd76d upstream.

free_user() could be called in atomic context.

This patch pushed the free operation off into a workqueue.

Example:

 BUG: sleeping function called from invalid context at kernel/workqueue.c:2856
 in_atomic(): 1, irqs_disabled(): 0, pid: 177, name: ksoftirqd/27
 CPU: 27 PID: 177 Comm: ksoftirqd/27 Not tainted 4.19.25-3 #1
 Hardware name: AIC 1S-HV26-08/MB-DPSB04-06, BIOS IVYBV060 10/21/2015
 Call Trace:
  dump_stack+0x5c/0x7b
  ___might_sleep+0xec/0x110
  __flush_work+0x48/0x1f0
  ? try_to_del_timer_sync+0x4d/0x80
  _cleanup_srcu_struct+0x104/0x140
  free_user+0x18/0x30 [ipmi_msghandler]
  ipmi_free_recv_msg+0x3a/0x50 [ipmi_msghandler]
  deliver_response+0xbd/0xd0 [ipmi_msghandler]
  deliver_local_response+0xe/0x30 [ipmi_msghandler]
  handle_one_recv_msg+0x163/0xc80 [ipmi_msghandler]
  ? dequeue_entity+0xa0/0x960
  handle_new_recv_msgs+0x15c/0x1f0 [ipmi_msghandler]
  tasklet_action_common.isra.22+0x103/0x120
  __do_softirq+0xf8/0x2d7
  run_ksoftirqd+0x26/0x50
  smpboot_thread_fn+0x11d/0x1e0
  kthread+0x103/0x140
  ? sort_range+0x20/0x20
  ? kthread_destroy_worker+0x40/0x40
  ret_from_fork+0x1f/0x40

Fixes: 77f8269606bf ("ipmi: fix use-after-free of user->release_barrier.rda")

Reported-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: stable@vger.kernel.org # 5.0
Cc: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/ipmi/ipmi_msghandler.c |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -214,6 +214,9 @@ struct ipmi_user {
 
 	/* Does this interface receive IPMI events? */
 	bool gets_events;
+
+	/* Free must run in process context for RCU cleanup. */
+	struct work_struct remove_work;
 };
 
 static struct ipmi_user *acquire_ipmi_user(struct ipmi_user *user, int *index)
@@ -1079,6 +1082,15 @@ static int intf_err_seq(struct ipmi_smi
 }
 
 
+static void free_user_work(struct work_struct *work)
+{
+	struct ipmi_user *user = container_of(work, struct ipmi_user,
+					      remove_work);
+
+	cleanup_srcu_struct(&user->release_barrier);
+	kfree(user);
+}
+
 int ipmi_create_user(unsigned int          if_num,
 		     const struct ipmi_user_hndl *handler,
 		     void                  *handler_data,
@@ -1122,6 +1134,8 @@ int ipmi_create_user(unsigned int
 	goto out_kfree;
 
  found:
+	INIT_WORK(&new_user->remove_work, free_user_work);
+
 	rv = init_srcu_struct(&new_user->release_barrier);
 	if (rv)
 		goto out_kfree;
@@ -1184,8 +1198,9 @@ EXPORT_SYMBOL(ipmi_get_smi_info);
 static void free_user(struct kref *ref)
 {
 	struct ipmi_user *user = container_of(ref, struct ipmi_user, refcount);
-	cleanup_srcu_struct(&user->release_barrier);
-	kfree(user);
+
+	/* SRCU cleanup must happen in task context. */
+	schedule_work(&user->remove_work);
 }
 
 static void _ipmi_destroy_user(struct ipmi_user *user)


