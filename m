Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D04BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644EA218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfCVNlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:41:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53057 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbfCVNlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:41:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MDf7xX599447
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 06:41:07 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MDf7KM599444;
        Fri, 22 Mar 2019 06:41:07 -0700
Date:   Fri, 22 Mar 2019 06:41:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-671422b2205b5f2c49948b686306b207a5975dd9@git.kernel.org>
Cc:     herbert@gondor.apana.org.au, steffen.klassert@secunet.com,
        anna-maria@linutronix.de, tglx@linutronix.de, davem@davemloft.net,
        linux-kernel@vger.kernel.org, hpa@zytor.com, bigeasy@linutronix.de,
        mingo@kernel.org
Reply-To: herbert@gondor.apana.org.au, steffen.klassert@secunet.com,
          anna-maria@linutronix.de, tglx@linutronix.de,
          davem@davemloft.net, linux-kernel@vger.kernel.org, hpa@zytor.com,
          bigeasy@linutronix.de, mingo@kernel.org
In-Reply-To: <20190301224821.29843-3-bigeasy@linutronix.de>
References: <20190301224821.29843-3-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] xfrm: Replace hrtimer tasklet with softirq
 hrtimer
Git-Commit-ID: 671422b2205b5f2c49948b686306b207a5975dd9
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  671422b2205b5f2c49948b686306b207a5975dd9
Gitweb:     https://git.kernel.org/tip/671422b2205b5f2c49948b686306b207a5975dd9
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Fri, 1 Mar 2019 23:48:20 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Mar 2019 14:35:31 +0100

xfrm: Replace hrtimer tasklet with softirq hrtimer

Switch the timer to HRTIMER_MODE_SOFT, which executed the timer
callback in softirq context and remove the hrtimer_tasklet.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Link: https://lkml.kernel.org/r/20190301224821.29843-3-bigeasy@linutronix.de

---
 include/net/xfrm.h    |  2 +-
 net/xfrm/xfrm_state.c | 30 ++++++++++++++++++------------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 85386becbaea..bbcf0b650b81 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -219,7 +219,7 @@ struct xfrm_state {
 	struct xfrm_stats	stats;
 
 	struct xfrm_lifetime_cur curlft;
-	struct tasklet_hrtimer	mtimer;
+	struct hrtimer		mtimer;
 
 	struct xfrm_state_offload xso;
 
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 1bb971f46fc6..586b4d656abd 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -434,7 +434,7 @@ EXPORT_SYMBOL(xfrm_state_free);
 
 static void ___xfrm_state_destroy(struct xfrm_state *x)
 {
-	tasklet_hrtimer_cancel(&x->mtimer);
+	hrtimer_cancel(&x->mtimer);
 	del_timer_sync(&x->rtimer);
 	kfree(x->aead);
 	kfree(x->aalg);
@@ -479,8 +479,8 @@ static void xfrm_state_gc_task(struct work_struct *work)
 
 static enum hrtimer_restart xfrm_timer_handler(struct hrtimer *me)
 {
-	struct tasklet_hrtimer *thr = container_of(me, struct tasklet_hrtimer, timer);
-	struct xfrm_state *x = container_of(thr, struct xfrm_state, mtimer);
+	struct xfrm_state *x = container_of(me, struct xfrm_state, mtimer);
+	enum hrtimer_restart ret = HRTIMER_NORESTART;
 	time64_t now = ktime_get_real_seconds();
 	time64_t next = TIME64_MAX;
 	int warn = 0;
@@ -544,7 +544,8 @@ static enum hrtimer_restart xfrm_timer_handler(struct hrtimer *me)
 		km_state_expired(x, 0, 0);
 resched:
 	if (next != TIME64_MAX) {
-		tasklet_hrtimer_start(&x->mtimer, ktime_set(next, 0), HRTIMER_MODE_REL);
+		hrtimer_forward_now(&x->mtimer, ktime_set(next, 0));
+		ret = HRTIMER_RESTART;
 	}
 
 	goto out;
@@ -561,7 +562,7 @@ expired:
 
 out:
 	spin_unlock(&x->lock);
-	return HRTIMER_NORESTART;
+	return ret;
 }
 
 static void xfrm_replay_timer_handler(struct timer_list *t);
@@ -580,8 +581,8 @@ struct xfrm_state *xfrm_state_alloc(struct net *net)
 		INIT_HLIST_NODE(&x->bydst);
 		INIT_HLIST_NODE(&x->bysrc);
 		INIT_HLIST_NODE(&x->byspi);
-		tasklet_hrtimer_init(&x->mtimer, xfrm_timer_handler,
-					CLOCK_BOOTTIME, HRTIMER_MODE_ABS);
+		hrtimer_init(&x->mtimer, CLOCK_BOOTTIME, HRTIMER_MODE_ABS_SOFT);
+		x->mtimer.function = xfrm_timer_handler;
 		timer_setup(&x->rtimer, xfrm_replay_timer_handler, 0);
 		x->curlft.add_time = ktime_get_real_seconds();
 		x->lft.soft_byte_limit = XFRM_INF;
@@ -1047,7 +1048,9 @@ found:
 				hlist_add_head_rcu(&x->byspi, net->xfrm.state_byspi + h);
 			}
 			x->lft.hard_add_expires_seconds = net->xfrm.sysctl_acq_expires;
-			tasklet_hrtimer_start(&x->mtimer, ktime_set(net->xfrm.sysctl_acq_expires, 0), HRTIMER_MODE_REL);
+			hrtimer_start(&x->mtimer,
+				      ktime_set(net->xfrm.sysctl_acq_expires, 0),
+				      HRTIMER_MODE_REL_SOFT);
 			net->xfrm.state_num++;
 			xfrm_hash_grow_check(net, x->bydst.next != NULL);
 			spin_unlock_bh(&net->xfrm.xfrm_state_lock);
@@ -1159,7 +1162,7 @@ static void __xfrm_state_insert(struct xfrm_state *x)
 		hlist_add_head_rcu(&x->byspi, net->xfrm.state_byspi + h);
 	}
 
-	tasklet_hrtimer_start(&x->mtimer, ktime_set(1, 0), HRTIMER_MODE_REL);
+	hrtimer_start(&x->mtimer, ktime_set(1, 0), HRTIMER_MODE_REL_SOFT);
 	if (x->replay_maxage)
 		mod_timer(&x->rtimer, jiffies + x->replay_maxage);
 
@@ -1266,7 +1269,9 @@ static struct xfrm_state *__find_acq_core(struct net *net,
 		x->mark.m = m->m;
 		x->lft.hard_add_expires_seconds = net->xfrm.sysctl_acq_expires;
 		xfrm_state_hold(x);
-		tasklet_hrtimer_start(&x->mtimer, ktime_set(net->xfrm.sysctl_acq_expires, 0), HRTIMER_MODE_REL);
+		hrtimer_start(&x->mtimer,
+			      ktime_set(net->xfrm.sysctl_acq_expires, 0),
+			      HRTIMER_MODE_REL_SOFT);
 		list_add(&x->km.all, &net->xfrm.state_all);
 		hlist_add_head_rcu(&x->bydst, net->xfrm.state_bydst + h);
 		h = xfrm_src_hash(net, daddr, saddr, family);
@@ -1571,7 +1576,8 @@ out:
 		memcpy(&x1->lft, &x->lft, sizeof(x1->lft));
 		x1->km.dying = 0;
 
-		tasklet_hrtimer_start(&x1->mtimer, ktime_set(1, 0), HRTIMER_MODE_REL);
+		hrtimer_start(&x1->mtimer, ktime_set(1, 0),
+			      HRTIMER_MODE_REL_SOFT);
 		if (x1->curlft.use_time)
 			xfrm_state_check_expire(x1);
 
@@ -1610,7 +1616,7 @@ int xfrm_state_check_expire(struct xfrm_state *x)
 	if (x->curlft.bytes >= x->lft.hard_byte_limit ||
 	    x->curlft.packets >= x->lft.hard_packet_limit) {
 		x->km.state = XFRM_STATE_EXPIRED;
-		tasklet_hrtimer_start(&x->mtimer, 0, HRTIMER_MODE_REL);
+		hrtimer_start(&x->mtimer, 0, HRTIMER_MODE_REL_SOFT);
 		return -EINVAL;
 	}
 
