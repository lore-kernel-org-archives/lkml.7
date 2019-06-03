Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98494C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A45925D85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gYR8AN/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfFCNrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:47:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60195 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfFCNrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:47:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DksWe614413
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:46:54 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DksWe614413
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559569615;
        bh=KaxlY8gRkqYFbl8qJuKzVYECIMo+aVoMr4I+uFZNfIs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=gYR8AN/vMe8byeKzHmXO/o67z9VRyx1WknTy36v7dOXviJphQNVIpYtrZkn/NWZJ4
         75Js9BN/El5Vo8qam6Kn3Zj3wLO6k7Fl23VIrBStY3egX8bO3AAIoUd+qARWlJ0Lkq
         oOJYq1N1KkpSN2yL/Bt+nAZz34Mfr4v6y6mWzRRc9F9A0PnqlFRRRpzB3o2e+ztN0U
         Y3T4DPfEwPOfNQEQWjj884qWHhCzJlwBqMDLnNcaId0rKbQavS5Tw1tGRdznD9E/Js
         v2Bmx2Qt+x/yUUBm5KDbDZ1oSRYxEFKVqTJnFwHfT6VM50VEhAbFb2tWbgsHdcc1BS
         /Wk3rbD9hSyUw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53Dksqb614410;
        Mon, 3 Jun 2019 06:46:54 -0700
Date:   Mon, 3 Jun 2019 06:46:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-fff9b6c7d26943a8eb32b58364b7ec6b9369746a@git.kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de, hpa@zytor.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com
Reply-To: torvalds@linux-foundation.org, mingo@kernel.org,
          gregkh@linuxfoundation.org, tglx@linutronix.de, hpa@zytor.com,
          peterz@infradead.org, will.deacon@arm.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190524115231.GN2623@hirez.programming.kicks-ass.net>
References: <20190524115231.GN2623@hirez.programming.kicks-ass.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] Documentation/atomic_t.txt: Clarify pure non-rmw
 usage
Git-Commit-ID: fff9b6c7d26943a8eb32b58364b7ec6b9369746a
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

Commit-ID:  fff9b6c7d26943a8eb32b58364b7ec6b9369746a
Gitweb:     https://git.kernel.org/tip/fff9b6c7d26943a8eb32b58364b7ec6b9369746a
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Fri, 24 May 2019 13:52:31 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 12:32:57 +0200

Documentation/atomic_t.txt: Clarify pure non-rmw usage

Clarify that pure non-RMW usage of atomic_t is pointless, there is
nothing 'magical' about atomic_set() / atomic_read().

This is something that seems to confuse people, because I happen upon it
semi-regularly.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190524115231.GN2623@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/atomic_t.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
index dca3fb0554db..89eae7f6b360 100644
--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -81,9 +81,11 @@ Non-RMW ops:
 
 The non-RMW ops are (typically) regular LOADs and STOREs and are canonically
 implemented using READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and
-smp_store_release() respectively.
+smp_store_release() respectively. Therefore, if you find yourself only using
+the Non-RMW operations of atomic_t, you do not in fact need atomic_t at all
+and are doing it wrong.
 
-The one detail to this is that atomic_set{}() should be observable to the RMW
+A subtle detail of atomic_set{}() is that it should be observable to the RMW
 ops. That is:
 
   C atomic-set
