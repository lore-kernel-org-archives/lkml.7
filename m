Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662E9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F395218A2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfCTRDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:03:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbfCTRDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:03:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7240085A07;
        Wed, 20 Mar 2019 17:03:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.34])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4BFD85D9C4;
        Wed, 20 Mar 2019 17:03:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 20 Mar 2019 18:03:44 +0100 (CET)
Date:   Wed, 20 Mar 2019 18:03:42 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steffen Froemer <sfroemer@redhat.com>, linux-kernel@vger.kernel.org
Subject: printk_ratelimited() && proc/sys/kernel/printk_ratelimit*
Message-ID: <20190320170342.GA11770@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 20 Mar 2019 17:03:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for spam, but I simply do not know whom to ask ;)

/proc/sys/kernel/printk_ratelimit and /proc/sys/kernel/printk_ratelimit_burst
affect printk_ratelimit_state which have a single user, printk_ratelimit() which
is "don't use" according to its comment.

At the same time, printk_ratelimited() uses a static ratelimit_state, so user-
space can't override the default DEFAULT_RATELIMIT_.* numbers.

Isn't it strange? Shouldn't printk_ratelimited() use printk_ratelimit_state ?

	--- x/include/linux/printk.h
	+++ x/include/linux/printk.h
	@@ -415,11 +415,7 @@ extern int kptr_restrict;
	 #ifdef CONFIG_PRINTK
	 #define printk_ratelimited(fmt, ...)					\
	 ({									\
	-	static DEFINE_RATELIMIT_STATE(_rs,				\
	-				      DEFAULT_RATELIMIT_INTERVAL,	\
	-				      DEFAULT_RATELIMIT_BURST);		\
	-									\
	-	if (__ratelimit(&_rs))						\
	+	if (__ratelimit(&printk_ratelimit_state))			\
			printk(fmt, ##__VA_ARGS__);				\
	 })
	 #else
	--- x/kernel/printk/printk.c
	+++ x/kernel/printk/printk.c
	@@ -2979,7 +2979,8 @@ int printk_deferred(const char *fmt, ...
	  * This enforces a rate limit: not more than 10 kernel messages
	  * every 5s to make a denial-of-service attack impossible.
	  */
	-DEFINE_RATELIMIT_STATE(printk_ratelimit_state, 5 * HZ, 10);
	+DEFINE_RATELIMIT_STATE(printk_ratelimit_state,
	+		DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
	 
	 int __printk_ratelimit(const char *func)
	 {

------------------------------------------------------------------------------

Another question is spin_trylock() in ___ratelimit(). This means that a message
can be silently dropped "for no reason", without rs->missed++. Doesn't look good.

The changelog for commit edaac8e3167 "ratelimit: Fix/allow use in atomic contexts"
says:

	I'd like to use printk_ratelimit() in NMI context, but it's not
	robust right now due to spinlock usage in lib/ratelimit.c. If an
	NMI is unlucky enough to hit just that spot we might lock up trying
	to take the spinlock again.

if NMI is the the only problem, why can't we do

	if (in_nmi()) {
		if (!raw_spin_trylock_irqsave(&rs->lock, flags))
			return 0;
	} else {
		raw_spin_lock_irqsave(&rs->lock, flags);
	}

?

Oleg.

