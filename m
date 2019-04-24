Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3084C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8322218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="P0GKcWNv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbfDXKWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:22:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51935 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbfDXKWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:22:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3OAM6hx2530633
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 24 Apr 2019 03:22:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3OAM6hx2530633
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556101327;
        bh=CThnB17KZek+nJfRny/Q2A0jVLd+g9IuvBRf3erHD2U=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=P0GKcWNvKn95J8L6Na7isSX/rdosZ5rRnaMyihnE9+vnt2XVmWvXp7RZmEgEPwaZx
         TBzAeZkd1PIpE9HNWWpGDNVkcit4cGEMLq/CfpX6nE74DSV6jZVF48Lw64gg03fHUZ
         kRve+3J2y/vgrGF0JXrLEuJBgd6HMu7yqb02PeHlkFEnnjiXveShIZW3dlHLOZ+UUs
         s0skwhDHUiETZetiCIqISFCFdQeQNZKVOOPpZetX7SupYRz+SX+dhtDwIbX9bsyFcc
         5hEbKMYe6WB/oB1OovDT2sfqw8qaN4K1jdaLKr6pqEccUNOgoTP1XgV5J0rih5TW3F
         DvSM9EytbVDgg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3OAM6r62530626;
        Wed, 24 Apr 2019 03:22:06 -0700
Date:   Wed, 24 Apr 2019 03:22:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-d4645d30b50d1691c26ff0f8fa4e718b08f8d3bb@git.kernel.org>
Cc:     paulmck@linux.ibm.com, peterz@infradead.org, mingo@kernel.org,
        torvalds@linux-foundation.org, lkp@intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, bigeasy@linutronix.de,
        tglx@linutronix.de
Reply-To: tglx@linutronix.de, bigeasy@linutronix.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org, lkp@intel.com,
          torvalds@linux-foundation.org, mingo@kernel.org,
          peterz@infradead.org, paulmck@linux.ibm.com
In-Reply-To: <20190424085253.12178-1-bigeasy@linutronix.de>
References: <20190424085253.12178-1-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:smp/hotplug] smpboot: Place the __percpu annotation correctly
Git-Commit-ID: d4645d30b50d1691c26ff0f8fa4e718b08f8d3bb
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

Commit-ID:  d4645d30b50d1691c26ff0f8fa4e718b08f8d3bb
Gitweb:     https://git.kernel.org/tip/d4645d30b50d1691c26ff0f8fa4e718b08f8d3bb
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 24 Apr 2019 10:52:53 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 24 Apr 2019 12:17:08 +0200

smpboot: Place the __percpu annotation correctly

The test robot reported a wrong assignment of a per-CPU variable which
it detected by using sparse and sent a report. The assignment itself is
correct. The annotation for sparse was wrong and hence the report.
The first pointer is a "normal" pointer and points to the per-CPU memory
area. That means that the __percpu annotation has to be moved.

Move the __percpu annotation to pointer which points to the per-CPU
area. This change affects only the sparse tool (and is ignored by the
compiler).

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: f97f8f06a49fe ("smpboot: Provide infrastructure for percpu hotplug threads")
Link: http://lkml.kernel.org/r/20190424085253.12178-1-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/smpboot.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/smpboot.h b/include/linux/smpboot.h
index d0884b525001..9d1bc65d226c 100644
--- a/include/linux/smpboot.h
+++ b/include/linux/smpboot.h
@@ -29,7 +29,7 @@ struct smpboot_thread_data;
  * @thread_comm:	The base name of the thread
  */
 struct smp_hotplug_thread {
-	struct task_struct __percpu	**store;
+	struct task_struct		* __percpu *store;
 	struct list_head		list;
 	int				(*thread_should_run)(unsigned int cpu);
 	void				(*thread_fn)(unsigned int cpu);
