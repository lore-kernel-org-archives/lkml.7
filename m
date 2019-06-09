Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE5BC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99BC520652
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100532;
	bh=BlA6BIO6kERajv4RZYy7/31RqTOwWAKUBuSWOeKpDHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cqGHaAtjA0LKjHVvMgO/RHyuZQQff9tHyk9rnZuo/O2kjs127b1mFgJ0MoLodQf46
	 slqtEykwOrkmBKp7jn1cASK2YMHD+9FnVzgmxoCtD4w81EdLMJbahbNqN6+/Sjtp13
	 8UK2Uh42Ys6bjg9LRVlod+PwHEGGfczkywpqozjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732631AbfFIQye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:54:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732219AbfFIQyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:54:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FAB4204EC;
        Sun,  9 Jun 2019 16:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099270;
        bh=BlA6BIO6kERajv4RZYy7/31RqTOwWAKUBuSWOeKpDHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TDvrbqcJRe7FggNPftECYXRUGfgKpcQ+Zt/P+n71O4kAjn4xUNX+qb/5j/pJadosq
         LdnBZjGA1yim2o37Ev/Bh9pHcIlKMtophqN+CHxHWb4u8LEgh6DYWv+Agf/NnZjVYT
         lCS6f9DpBjNuGufX4JcXemLKrTDPyWVQg04TH5Lo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
        stable@kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 71/83] rcu: locking and unlocking need to always be at least barriers
Date:   Sun,  9 Jun 2019 18:42:41 +0200
Message-Id: <20190609164133.888030297@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.843327870@linuxfoundation.org>
References: <20190609164127.843327870@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 66be4e66a7f422128748e3c3ef6ee72b20a6197b upstream.

Herbert Xu pointed out that commit bb73c52bad36 ("rcu: Don't disable
preemption for Tiny and Tree RCU readers") was incorrect in making the
preempt_disable/enable() be conditional on CONFIG_PREEMPT_COUNT.

If CONFIG_PREEMPT_COUNT isn't enabled, the preemption enable/disable is
a no-op, but still is a compiler barrier.

And RCU locking still _needs_ that compiler barrier.

It is simply fundamentally not true that RCU locking would be a complete
no-op: we still need to guarantee (for example) that things that can
trap and cause preemption cannot migrate into the RCU locked region.

The way we do that is by making it a barrier.

See for example commit 386afc91144b ("spinlocks and preemption points
need to be at least compiler barriers") from back in 2013 that had
similar issues with spinlocks that become no-ops on UP: they must still
constrain the compiler from moving other operations into the critical
region.

Now, it is true that a lot of RCU operations already use READ_ONCE() and
WRITE_ONCE() (which in practice likely would never be re-ordered wrt
anything remotely interesting), but it is also true that that is not
globally the case, and that it's not even necessarily always possible
(ie bitfields etc).

Reported-by: Herbert Xu <herbert@gondor.apana.org.au>
Fixes: bb73c52bad36 ("rcu: Don't disable preemption for Tiny and Tree RCU readers")
Cc: stable@kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/rcupdate.h |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -306,14 +306,12 @@ void synchronize_rcu(void);
 
 static inline void __rcu_read_lock(void)
 {
-	if (IS_ENABLED(CONFIG_PREEMPT_COUNT))
-		preempt_disable();
+	preempt_disable();
 }
 
 static inline void __rcu_read_unlock(void)
 {
-	if (IS_ENABLED(CONFIG_PREEMPT_COUNT))
-		preempt_enable();
+	preempt_enable();
 }
 
 static inline void synchronize_rcu(void)


