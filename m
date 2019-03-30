Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA24C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2682217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909952;
	bh=/whm1QkDMsWRIvlgpYbYFQkdHbzOPGlq8lTze7MXfkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ifo0UNdUI/VUuL5c1EHkrVqDpKTPMz1rTpHzx8x8F04df6ooIgDlrtYDGOtZZpr+D
	 vPHEbEtkpDx8OnBo7KE5ZGyC5fbyKx7zGHtzyOixRKyFzQPc3ZpF1bbTfeXZZje8W6
	 c9vc8QlSG9suQK3FLh12RAk2FXRmcU8waD2bLeC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbfC3BjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:39:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730435AbfC3BaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:30:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB35E218A6;
        Sat, 30 Mar 2019 01:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909406;
        bh=/whm1QkDMsWRIvlgpYbYFQkdHbzOPGlq8lTze7MXfkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tbL/JeIfvdiHGB4C7XrqCalAtzidKK4hnSQTKxjhRYYZ/G1AkUrZxAODDOVppUkSW
         L9C4YJDgcimCXsp+ENm0bvoC8jjYpnpqCs2Jekce+EPDzsvVPIzl6vM+W2VnKzbRuU
         1ApjPXAMPZpxNE0Ayk+YRyi1wprqeqdmbnfySU3E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 34/57] xfrm: destroy xfrm_state synchronously on net exit path
Date:   Fri, 29 Mar 2019 21:28:27 -0400
Message-Id: <20190330012854.32212-34-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330012854.32212-1-sashal@kernel.org>
References: <20190330012854.32212-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit f75a2804da391571563c4b6b29e7797787332673 ]

xfrm_state_put() moves struct xfrm_state to the GC list
and schedules the GC work to clean it up. On net exit call
path, xfrm_state_flush() is called to clean up and
xfrm_flush_gc() is called to wait for the GC work to complete
before exit.

However, this doesn't work because one of the ->destructor(),
ipcomp_destroy(), schedules the same GC work again inside
the GC work. It is hard to wait for such a nested async
callback. This is also why syzbot still reports the following
warning:

 WARNING: CPU: 1 PID: 33 at net/ipv6/xfrm6_tunnel.c:351 xfrm6_tunnel_net_exit+0x2cb/0x500 net/ipv6/xfrm6_tunnel.c:351
 ...
  ops_exit_list.isra.0+0xb0/0x160 net/core/net_namespace.c:153
  cleanup_net+0x51d/0xb10 net/core/net_namespace.c:551
  process_one_work+0xd0c/0x1ce0 kernel/workqueue.c:2153
  worker_thread+0x143/0x14a0 kernel/workqueue.c:2296
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

In fact, it is perfectly fine to bypass GC and destroy xfrm_state
synchronously on net exit call path, because it is in process context
and doesn't need a work struct to do any blocking work.

This patch introduces xfrm_state_put_sync() which simply bypasses
GC, and lets its callers to decide whether to use this synchronous
version. On net exit path, xfrm_state_fini() and
xfrm6_tunnel_net_exit() use it. And, as ipcomp_destroy() itself is
blocking, it can use xfrm_state_put_sync() directly too.

Also rename xfrm_state_gc_destroy() to ___xfrm_state_destroy() to
reflect this change.

Fixes: b48c05ab5d32 ("xfrm: Fix warning in xfrm6_tunnel_net_exit.")
Reported-and-tested-by: syzbot+e9aebef558e3ed673934@syzkaller.appspotmail.com
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/xfrm.h      | 12 +++++++++---
 net/ipv6/xfrm6_tunnel.c |  2 +-
 net/key/af_key.c        |  2 +-
 net/xfrm/xfrm_state.c   | 30 +++++++++++++++++++-----------
 net/xfrm/xfrm_user.c    |  2 +-
 5 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index da588def3c61..5e3daf53b3d1 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -850,7 +850,7 @@ static inline void xfrm_pols_put(struct xfrm_policy **pols, int npols)
 		xfrm_pol_put(pols[i]);
 }
 
-void __xfrm_state_destroy(struct xfrm_state *);
+void __xfrm_state_destroy(struct xfrm_state *, bool);
 
 static inline void __xfrm_state_put(struct xfrm_state *x)
 {
@@ -860,7 +860,13 @@ static inline void __xfrm_state_put(struct xfrm_state *x)
 static inline void xfrm_state_put(struct xfrm_state *x)
 {
 	if (refcount_dec_and_test(&x->refcnt))
-		__xfrm_state_destroy(x);
+		__xfrm_state_destroy(x, false);
+}
+
+static inline void xfrm_state_put_sync(struct xfrm_state *x)
+{
+	if (refcount_dec_and_test(&x->refcnt))
+		__xfrm_state_destroy(x, true);
 }
 
 static inline void xfrm_state_hold(struct xfrm_state *x)
@@ -1616,7 +1622,7 @@ struct xfrmk_spdinfo {
 
 struct xfrm_state *xfrm_find_acq_byseq(struct net *net, u32 mark, u32 seq);
 int xfrm_state_delete(struct xfrm_state *x);
-int xfrm_state_flush(struct net *net, u8 proto, bool task_valid);
+int xfrm_state_flush(struct net *net, u8 proto, bool task_valid, bool sync);
 int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_valid);
 void xfrm_sad_getinfo(struct net *net, struct xfrmk_sadinfo *si);
 void xfrm_spd_getinfo(struct net *net, struct xfrmk_spdinfo *si);
diff --git a/net/ipv6/xfrm6_tunnel.c b/net/ipv6/xfrm6_tunnel.c
index f5b4febeaa25..bc65db782bfb 100644
--- a/net/ipv6/xfrm6_tunnel.c
+++ b/net/ipv6/xfrm6_tunnel.c
@@ -344,8 +344,8 @@ static void __net_exit xfrm6_tunnel_net_exit(struct net *net)
 	struct xfrm6_tunnel_net *xfrm6_tn = xfrm6_tunnel_pernet(net);
 	unsigned int i;
 
-	xfrm_state_flush(net, IPSEC_PROTO_ANY, false);
 	xfrm_flush_gc();
+	xfrm_state_flush(net, IPSEC_PROTO_ANY, false, true);
 
 	for (i = 0; i < XFRM6_TUNNEL_SPI_BYADDR_HSIZE; i++)
 		WARN_ON_ONCE(!hlist_empty(&xfrm6_tn->spi_byaddr[i]));
diff --git a/net/key/af_key.c b/net/key/af_key.c
index 7da629d59717..7d4bed955060 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -1773,7 +1773,7 @@ static int pfkey_flush(struct sock *sk, struct sk_buff *skb, const struct sadb_m
 	if (proto == 0)
 		return -EINVAL;
 
-	err = xfrm_state_flush(net, proto, true);
+	err = xfrm_state_flush(net, proto, true, false);
 	err2 = unicast_flush_resp(sk, hdr);
 	if (err || err2) {
 		if (err == -ESRCH) /* empty table - go quietly */
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index cc0203efb584..3f729cd512af 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -432,7 +432,7 @@ void xfrm_state_free(struct xfrm_state *x)
 }
 EXPORT_SYMBOL(xfrm_state_free);
 
-static void xfrm_state_gc_destroy(struct xfrm_state *x)
+static void ___xfrm_state_destroy(struct xfrm_state *x)
 {
 	tasklet_hrtimer_cancel(&x->mtimer);
 	del_timer_sync(&x->rtimer);
@@ -474,7 +474,7 @@ static void xfrm_state_gc_task(struct work_struct *work)
 	synchronize_rcu();
 
 	hlist_for_each_entry_safe(x, tmp, &gc_list, gclist)
-		xfrm_state_gc_destroy(x);
+		___xfrm_state_destroy(x);
 }
 
 static enum hrtimer_restart xfrm_timer_handler(struct hrtimer *me)
@@ -598,14 +598,19 @@ struct xfrm_state *xfrm_state_alloc(struct net *net)
 }
 EXPORT_SYMBOL(xfrm_state_alloc);
 
-void __xfrm_state_destroy(struct xfrm_state *x)
+void __xfrm_state_destroy(struct xfrm_state *x, bool sync)
 {
 	WARN_ON(x->km.state != XFRM_STATE_DEAD);
 
-	spin_lock_bh(&xfrm_state_gc_lock);
-	hlist_add_head(&x->gclist, &xfrm_state_gc_list);
-	spin_unlock_bh(&xfrm_state_gc_lock);
-	schedule_work(&xfrm_state_gc_work);
+	if (sync) {
+		synchronize_rcu();
+		___xfrm_state_destroy(x);
+	} else {
+		spin_lock_bh(&xfrm_state_gc_lock);
+		hlist_add_head(&x->gclist, &xfrm_state_gc_list);
+		spin_unlock_bh(&xfrm_state_gc_lock);
+		schedule_work(&xfrm_state_gc_work);
+	}
 }
 EXPORT_SYMBOL(__xfrm_state_destroy);
 
@@ -708,7 +713,7 @@ xfrm_dev_state_flush_secctx_check(struct net *net, struct net_device *dev, bool
 }
 #endif
 
-int xfrm_state_flush(struct net *net, u8 proto, bool task_valid)
+int xfrm_state_flush(struct net *net, u8 proto, bool task_valid, bool sync)
 {
 	int i, err = 0, cnt = 0;
 
@@ -730,7 +735,10 @@ int xfrm_state_flush(struct net *net, u8 proto, bool task_valid)
 				err = xfrm_state_delete(x);
 				xfrm_audit_state_delete(x, err ? 0 : 1,
 							task_valid);
-				xfrm_state_put(x);
+				if (sync)
+					xfrm_state_put_sync(x);
+				else
+					xfrm_state_put(x);
 				if (!err)
 					cnt++;
 
@@ -2217,7 +2225,7 @@ void xfrm_state_delete_tunnel(struct xfrm_state *x)
 		if (atomic_read(&t->tunnel_users) == 2)
 			xfrm_state_delete(t);
 		atomic_dec(&t->tunnel_users);
-		xfrm_state_put(t);
+		xfrm_state_put_sync(t);
 		x->tunnel = NULL;
 	}
 }
@@ -2377,8 +2385,8 @@ void xfrm_state_fini(struct net *net)
 	unsigned int sz;
 
 	flush_work(&net->xfrm.state_hash_work);
-	xfrm_state_flush(net, IPSEC_PROTO_ANY, false);
 	flush_work(&xfrm_state_gc_work);
+	xfrm_state_flush(net, IPSEC_PROTO_ANY, false, true);
 
 	WARN_ON(!list_empty(&net->xfrm.state_all));
 
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index ab557827aac0..7e4904b93004 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1932,7 +1932,7 @@ static int xfrm_flush_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct xfrm_usersa_flush *p = nlmsg_data(nlh);
 	int err;
 
-	err = xfrm_state_flush(net, p->proto, true);
+	err = xfrm_state_flush(net, p->proto, true, false);
 	if (err) {
 		if (err == -ESRCH) /* empty table */
 			return 0;
-- 
2.19.1

