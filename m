Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D18C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45512206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="gzLaBMGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfCKKCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 06:02:34 -0400
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:58438 "EHLO
        forwardcorp1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725839AbfCKKCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 06:02:33 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1o.cmail.yandex.net (Yandex) with ESMTP id D6ECE205E0;
        Mon, 11 Mar 2019 13:02:29 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id JrUCVOqw5h-2TcC7Ndu;
        Mon, 11 Mar 2019 13:02:29 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1552298549; bh=0Nl5RUqGqBoHR8d4vM2L3KFvc1aFhwpXjS6QTRLHBCw=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=gzLaBMGVH2S4hMIjfpxs0s4dJfOluWysq1Z/CmXT0ufv/lxHkOBjcm1c2fyqm4pzF
         rgypg8HOqlGKkmeuCFQvE8nsLHF9iICM3v7o8B7/mTHuJlu94snOJo6y2CxXyLRD9k
         6arJYhZSL0HPKvBZe0N+N2xybEwCu+ydGEc/BLGg=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:65e1:a124:95f1:7d47])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id fqNSc8UXGO-2T4iVBRW;
        Mon, 11 Mar 2019 13:02:29 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] ipmi: fix sleep-in-atomic in free_user at cleanup SRCU
 user->release_barrier
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Corey Minyard <minyard@acm.org>,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     stable@vger.kernel.org
Date:   Mon, 11 Mar 2019 13:02:29 +0300
Message-ID: <155229854905.2133.15708039732382992559.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

free_user() could be called in atomic context.

This patch uses non-sleeping cleanup_srcu_struct_quiesced(). At this stage
atomic refcount is zero, thus all read-sections should have been ended.

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
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: stable@vger.kernel.org # 4.18
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: Corey Minyard <cminyard@mvista.com>
---
 drivers/char/ipmi/ipmi_msghandler.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index e8ba67834746..c35f2bcbaa23 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -1260,7 +1260,12 @@ EXPORT_SYMBOL(ipmi_get_smi_info);
 static void free_user(struct kref *ref)
 {
 	struct ipmi_user *user = container_of(ref, struct ipmi_user, refcount);
-	cleanup_srcu_struct(&user->release_barrier);
+
+	/*
+	 * Cleanup without waiting. This could be called in atomic context.
+	 * Refcount is zero: all read-sections should have been ended.
+	 */
+	cleanup_srcu_struct_quiesced(&user->release_barrier);
 	kfree(user);
 }
 

