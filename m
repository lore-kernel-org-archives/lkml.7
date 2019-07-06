Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B786EC5B578
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 08:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814AB216B7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 08:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="zpQ9nEJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfGFIBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 04:01:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37625 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfGFIBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 04:01:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x66818fb336848
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 6 Jul 2019 01:01:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x66818fb336848
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562400069;
        bh=cFHFzT7UocHoqkrwuJMvYNu9FuZogXK9pXREeVJIMLg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=zpQ9nEJrafmMAfL/cyZ0DE8+/m8d4qCYC/s2YAoH4c+GU63tdZHHJ0FqynsVG+lJI
         kxoaj5sbqdn3yjARWIdAHn1pfKK3vhl1NysMUNQKz75dB3pc8slQWSwrNhKgkoHkCE
         VgXh2YeLtK2rmff3W+cd6M2E//90TKuTSn2sRKBY0aQS7uWfjmhk0S7UdwYvnRYpMk
         7vnOZP1QM7Sp0unM8WeHciel8ehVmmjuiX7UsPFX9XN4b0yulFs7tyXzdpy6gTEdTm
         gzWRRazSo2o/wzBP4kMbOfchGNVVZMzhvcaWUO/qoQ0StHaNWAY5ry7iSQ8dx4PHof
         7ffiguRN3Ivhw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x66818dg336843;
        Sat, 6 Jul 2019 01:01:08 -0700
Date:   Sat, 6 Jul 2019 01:01:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Xu <tipbot@zytor.com>
Message-ID: <tip-876d00da42ecd4e985e58faa6239f7ee7e01a8b1@git.kernel.org>
Cc:     mtosatti@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        lcapitulino@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, peterx@redhat.com
Reply-To: lcapitulino@redhat.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com, peterx@redhat.com, mtosatti@redhat.com,
          tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <20190628105942.14131-1-peterx@redhat.com>
References: <20190628105942.14131-1-peterx@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] timer: Document TIMER_PINNED
Git-Commit-ID: 876d00da42ecd4e985e58faa6239f7ee7e01a8b1
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

Commit-ID:  876d00da42ecd4e985e58faa6239f7ee7e01a8b1
Gitweb:     https://git.kernel.org/tip/876d00da42ecd4e985e58faa6239f7ee7e01a8b1
Author:     Peter Xu <peterx@redhat.com>
AuthorDate: Fri, 28 Jun 2019 18:59:42 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 6 Jul 2019 09:57:36 +0200

timer: Document TIMER_PINNED

The flag hints the user that the pinned timers will always be run on a
static CPU (because that should be what "pinned" means...) but that's
not the truth, at least with the current implementation.

For example, currently if a pinned timer is set up but later mod_timer()
upon the pinned timer is invoked, mod_timer() will still try to queue the
timer on the current processor and migrate the timer if necessary.

Document it a bit with the definition of TIMER_PINNED so that all future
users will use it correctly.

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Luiz Capitulino <lcapitulino@redhat.com>
Link: https://lkml.kernel.org/r/20190628105942.14131-1-peterx@redhat.com

---
 include/linux/timer.h | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 7b066fd38248..282e4f2a532a 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -36,19 +36,30 @@ struct timer_list {
 #define __TIMER_LOCKDEP_MAP_INITIALIZER(_kn)
 #endif
 
-/*
- * A deferrable timer will work normally when the system is busy, but
- * will not cause a CPU to come out of idle just to service it; instead,
- * the timer will be serviced when the CPU eventually wakes up with a
- * subsequent non-deferrable timer.
+/**
+ * @TIMER_DEFERRABLE: A deferrable timer will work normally when the
+ * system is busy, but will not cause a CPU to come out of idle just
+ * to service it; instead, the timer will be serviced when the CPU
+ * eventually wakes up with a subsequent non-deferrable timer.
  *
- * An irqsafe timer is executed with IRQ disabled and it's safe to wait for
- * the completion of the running instance from IRQ handlers, for example,
- * by calling del_timer_sync().
+ * @TIMER_IRQSAFE: An irqsafe timer is executed with IRQ disabled and
+ * it's safe to wait for the completion of the running instance from
+ * IRQ handlers, for example, by calling del_timer_sync().
  *
  * Note: The irq disabled callback execution is a special case for
  * workqueue locking issues. It's not meant for executing random crap
  * with interrupts disabled. Abuse is monitored!
+ *
+ * @TIMER_PINNED: A pinned timer will not be affected by any timer
+ * placement heuristics (like, NOHZ) and will always expire on the CPU
+ * on which the timer was enqueued.
+ *
+ * Note: Because enqueuing of timers can migrate the timer from one
+ * CPU to another, pinned timers are not guaranteed to stay on the
+ * initialy selected CPU.  They move to the CPU on which the enqueue
+ * function is invoked via mod_timer() or add_timer().  If the timer
+ * should be placed on a particular CPU, then add_timer_on() has to be
+ * used.
  */
 #define TIMER_CPUMASK		0x0003FFFF
 #define TIMER_MIGRATING		0x00040000
