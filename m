Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289F8C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF7F208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="tWV5ZBLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfFNJzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 05:55:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56083 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfFNJzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:55:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5E9tEhd1635965
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 14 Jun 2019 02:55:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5E9tEhd1635965
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560506115;
        bh=Ii1lnuXsbNNNZaFdngiuQTb/j33VkDEjlkzInVWyVsM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=tWV5ZBLtSM9qwATy3OcQNR2oq2UHjvbZ34885IxR48LmEHb44NbaYsAW/9YUbESsQ
         H9608C0PhpV/Uueh80NZhEbAnWgI/bo45HpPAYmnbovGqDEJfbQO43RQXgrzlpIx4R
         C/vhyNmNG9kOeQeVJpmV7acTIm5xpeyMyZOO3UlR9mT+qYEuJevV2jRrD8nAxpQtHc
         c+H1LQjak4LJWjS2tnRqVVbUxHLaZZvf0AZw1HFQS7ChHfVw7T4tnF2JV08nxyDDoq
         QF29yZLABbs9IT8pTQZDj66gD4jYfqw1DqOS7NAlxU+Xyl5hrM5iSB8dAAq7PtQs43
         neWqS5bv/mGOQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5E9tEBb1635962;
        Fri, 14 Jun 2019 02:55:14 -0700
Date:   Fri, 14 Jun 2019 02:55:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-e3ff9c3678b4d80e22d2557b68726174578eaf52@git.kernel.org>
Cc:     sultan@kerneltoast.com, longman@redhat.com,
        linux-kernel@vger.kernel.org, arnd@arndb.de, clemens@ladisch.de,
        tglx@linutronix.de, hpa@zytor.com, Jason@zx2c4.com,
        mingo@kernel.org, peterz@infradead.org
Reply-To: Jason@zx2c4.com, hpa@zytor.com, mingo@kernel.org,
          peterz@infradead.org, tglx@linutronix.de, arnd@arndb.de,
          clemens@ladisch.de, longman@redhat.com, sultan@kerneltoast.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.1906132136280.1791@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1906132136280.1791@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] timekeeping: Repair ktime_get_coarse*()
 granularity
Git-Commit-ID: e3ff9c3678b4d80e22d2557b68726174578eaf52
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

Commit-ID:  e3ff9c3678b4d80e22d2557b68726174578eaf52
Gitweb:     https://git.kernel.org/tip/e3ff9c3678b4d80e22d2557b68726174578eaf52
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 13 Jun 2019 21:40:45 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 14 Jun 2019 11:51:44 +0200

timekeeping: Repair ktime_get_coarse*() granularity

Jason reported that the coarse ktime based time getters advance only once
per second and not once per tick as advertised.

The code reads only the monotonic base time, which advances once per
second. The nanoseconds are accumulated on every tick in xtime_nsec up to
a second and the regular time getters take this nanoseconds offset into
account, but the ktime_get_coarse*() implementation fails to do so.

Add the accumulated xtime_nsec value to the monotonic base time to get the
proper per tick advancing coarse tinme.

Fixes: b9ff604cff11 ("timekeeping: Add ktime_get_coarse_with_offset")
Reported-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: Waiman Long <longman@redhat.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1906132136280.1791@nanos.tec.linutronix.de

---
 kernel/time/timekeeping.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 85f5912d8f70..44b726bab4bd 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -808,17 +808,18 @@ ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs)
 	struct timekeeper *tk = &tk_core.timekeeper;
 	unsigned int seq;
 	ktime_t base, *offset = offsets[offs];
+	u64 nsecs;
 
 	WARN_ON(timekeeping_suspended);
 
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
 		base = ktime_add(tk->tkr_mono.base, *offset);
+		nsecs = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
 
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
-	return base;
-
+	return base + nsecs;
 }
 EXPORT_SYMBOL_GPL(ktime_get_coarse_with_offset);
 
