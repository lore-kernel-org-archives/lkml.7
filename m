Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D775FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A93207FA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573241094;
	bh=WdMTwF1tMvTKaGQ2zKNu14ZCzIA4ENht4XBnlGbzRDE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=qMeXNXDUPNmcXJw441DOop1OyCI3YFbUz7kz91e1u25UYxW5KDivIjE76iIzKsFJT
	 O3cwYbO1DIxHrYrhOv7JidNb9XeFfmdFH7KDVQpsrLk/B/bVJ3022Cn5y0ZbyGXtNa
	 UT2ki48pqwUz13yv+lZzxgcMRD6JKUmw0KSbZ3lo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731463AbfKHTYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:24:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:54712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730461AbfKHTYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:24:53 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [213.233.149.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45C2A2067B;
        Fri,  8 Nov 2019 19:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573241091;
        bh=WdMTwF1tMvTKaGQ2zKNu14ZCzIA4ENht4XBnlGbzRDE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=f2lwSIApoACkQCh24xuonVotpzuhxyurrnHhDAs33TFpEI4qWWDPf2fNyytYr5jCP
         QMTAXF1UmkK5GhLPP6SbK/Kp127Im9UvPIzvQwnVagvsyOCVfrJ2RJKS8nyvy+pWwO
         sF9cNTFa78XoMmBWD8XeNAn4BtdnpMsVA9N9QzVg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 02A4F35204A1; Fri,  8 Nov 2019 11:24:49 -0800 (PST)
Date:   Fri, 8 Nov 2019 11:24:48 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH 1/2] list: add hlist_unhashed_lockless()
Message-ID: <20191108192448.GB20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191107193738.195914-1-edumazet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107193738.195914-1-edumazet@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 11:37:37AM -0800, Eric Dumazet wrote:
> We would like to use hlist_unhashed() from timer_pending(),
> which runs without protection of a lock.
> 
> Note that other callers might also want to use this variant.
> 
> Instead of forcing a READ_ONCE() for all hlist_unhashed()
> callers, add a new helper with an explicit _lockless suffix
> in the name to better document what is going on.
> 
> Also add various WRITE_ONCE() in __hlist_del(), hlist_add_head()
> and hlist_add_before()/hlist_add_behind() to pair with
> the READ_ONCE().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>

I have queued this, but if you prefer it go some other way:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

But shouldn't the uses in include/linux/rculist.h also be converted
into the patch below?  If so, I will squash the following into your
patch.

						Thanx, Paul

------------------------------------------------------------------------

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 61c6728a..4b7ae1b 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -173,7 +173,7 @@ static inline void hlist_del_init_rcu(struct hlist_node *n)
 {
 	if (!hlist_unhashed(n)) {
 		__hlist_del(n);
-		n->pprev = NULL;
+		WRITE_ONCE(n->pprev, NULL);
 	}
 }
 
@@ -473,7 +473,7 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
 static inline void hlist_del_rcu(struct hlist_node *n)
 {
 	__hlist_del(n);
-	n->pprev = LIST_POISON2;
+	WRITE_ONCE(n->pprev, LIST_POISON2);
 }
 
 /**
@@ -489,11 +489,11 @@ static inline void hlist_replace_rcu(struct hlist_node *old,
 	struct hlist_node *next = old->next;
 
 	new->next = next;
-	new->pprev = old->pprev;
+	WRITE_ONCE(new->pprev, old->pprev);
 	rcu_assign_pointer(*(struct hlist_node __rcu **)new->pprev, new);
 	if (next)
-		new->next->pprev = &new->next;
-	old->pprev = LIST_POISON2;
+		WRITE_ONCE(new->next->pprev, &new->next);
+	WRITE_ONCE(old->pprev, LIST_POISON2);
 }
 
 /*
@@ -528,10 +528,10 @@ static inline void hlist_add_head_rcu(struct hlist_node *n,
 	struct hlist_node *first = h->first;
 
 	n->next = first;
-	n->pprev = &h->first;
+	WRITE_ONCE(n->pprev, &h->first);
 	rcu_assign_pointer(hlist_first_rcu(h), n);
 	if (first)
-		first->pprev = &n->next;
+		WRITE_ONCE(first->pprev, &n->next);
 }
 
 /**
@@ -564,7 +564,7 @@ static inline void hlist_add_tail_rcu(struct hlist_node *n,
 
 	if (last) {
 		n->next = last->next;
-		n->pprev = &last->next;
+		WRITE_ONCE(n->pprev, &last->next);
 		rcu_assign_pointer(hlist_next_rcu(last), n);
 	} else {
 		hlist_add_head_rcu(n, h);
@@ -592,10 +592,10 @@ static inline void hlist_add_tail_rcu(struct hlist_node *n,
 static inline void hlist_add_before_rcu(struct hlist_node *n,
 					struct hlist_node *next)
 {
-	n->pprev = next->pprev;
+	WRITE_ONCE(n->pprev, next->pprev);
 	n->next = next;
 	rcu_assign_pointer(hlist_pprev_rcu(n), n);
-	next->pprev = &n->next;
+	WRITE_ONCE(next->pprev, &n->next);
 }
 
 /**
@@ -620,10 +620,10 @@ static inline void hlist_add_behind_rcu(struct hlist_node *n,
 					struct hlist_node *prev)
 {
 	n->next = prev->next;
-	n->pprev = &prev->next;
+	WRITE_ONCE(n->pprev, &prev->next);
 	rcu_assign_pointer(hlist_next_rcu(prev), n);
 	if (n->next)
-		n->next->pprev = &n->next;
+		WRITE_ONCE(n->next->pprev, &n->next);
 }
 
 #define __hlist_for_each_rcu(pos, head)				\
