Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15B5C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7492925C0B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="lhaWEFoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfFCNU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:20:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42291 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfFCNU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:20:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DKEnA606748
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:20:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DKEnA606748
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559568015;
        bh=w+97sUoxh7aXFSaM+YX5AeARnMCTvJK9stemRThqBvo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=lhaWEFoPNh4OPdihfbJlkXIDCp5Zcwa1ZCVs6GcOpJ0LCgt+UJjUhwisUQVc7GD3v
         BoFxyIFKaN9zhcC62mavNdyAXsP92rHDh99I6OVfgxMiB6TIzOYTime/z344QtNSF+
         DHasEl4rDW62oGYcddTVm9fFCGSM6JgnPSitP2O1YGgEquTLhYr75Nr2pK7GDuwJ0g
         3eDLXf6Gtt9l4G12ZHfT+c6FRseyMvwrBF7DYV/nn1sH3c1/oFNygYhWLhcy2189Et
         vL2if/YFemiW4Y+4G9I+KF5UrCZedr+esfc8e2gpPO94uu7NznJqMMWS4FT/F5MRZT
         VpiXn2N0VXHjg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DKEhP606745;
        Mon, 3 Jun 2019 06:20:14 -0700
Date:   Mon, 3 Jun 2019 06:20:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yuyang Du <tipbot@zytor.com>
Message-ID: <tip-68e9dc29f8f42c79d2a3755223ed910ce36b4ae2@git.kernel.org>
Cc:     hpa@zytor.com, torvalds@linux-foundation.org, peterz@infradead.org,
        duyuyang@gmail.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          peterz@infradead.org, torvalds@linux-foundation.org,
          duyuyang@gmail.com
In-Reply-To: <20190506081939.74287-21-duyuyang@gmail.com>
References: <20190506081939.74287-21-duyuyang@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Check redundant dependency only
 when CONFIG_LOCKDEP_SMALL
Git-Commit-ID: 68e9dc29f8f42c79d2a3755223ed910ce36b4ae2
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

Commit-ID:  68e9dc29f8f42c79d2a3755223ed910ce36b4ae2
Gitweb:     https://git.kernel.org/tip/68e9dc29f8f42c79d2a3755223ed910ce36b4ae2
Author:     Yuyang Du <duyuyang@gmail.com>
AuthorDate: Mon, 6 May 2019 16:19:36 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:55:50 +0200

locking/lockdep: Check redundant dependency only when CONFIG_LOCKDEP_SMALL

As Peter has put it all sound and complete for the cause, I simply quote:

"It (check_redundant) was added for cross-release (which has since been
reverted) which would generate a lot of redundant links (IIRC) but
having it makes the reports more convoluted -- basically, if we had an
A-B-C relation, then A-C will not be added to the graph because it is
already covered. This then means any report will include B, even though
a shorter cycle might have been possible."

This would increase the number of direct dependencies. For a simple workload
(make clean; reboot; make vmlinux -j8), the data looks like this:

 CONFIG_LOCKDEP_SMALL: direct dependencies:                  6926

!CONFIG_LOCKDEP_SMALL: direct dependencies:                  9052    (+30.7%)

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Yuyang Du <duyuyang@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bvanassche@acm.org
Cc: frederic@kernel.org
Cc: ming.lei@redhat.com
Cc: will.deacon@arm.com
Link: https://lkml.kernel.org/r/20190506081939.74287-21-duyuyang@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 30a1c0e32573..63b82921698d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1739,6 +1739,7 @@ check_noncircular(struct held_lock *src, struct held_lock *target,
 	return ret;
 }
 
+#ifdef CONFIG_LOCKDEP_SMALL
 /*
  * Check that the dependency graph starting at <src> can lead to
  * <target> or not. If it can, <src> -> <target> dependency is already
@@ -1768,6 +1769,7 @@ check_redundant(struct held_lock *src, struct held_lock *target)
 
 	return ret;
 }
+#endif
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 
@@ -2428,12 +2430,14 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 		}
 	}
 
+#ifdef CONFIG_LOCKDEP_SMALL
 	/*
 	 * Is the <prev> -> <next> link redundant?
 	 */
 	ret = check_redundant(prev, next);
 	if (ret != 1)
 		return ret;
+#endif
 
 	if (!trace->nr_entries && !save_trace(trace))
 		return 0;
