Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A68FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E9722466
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213475;
	bh=paYbxFJhwWi5rUZFJYNrk3e0i0/3tdHI35nXxRrVAuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QdalrRX0rfRiwpuz6RwUOgf71CisrSrUE+3QTmIYHbZRDgjQ1iws1s3cJeOHbCppi
	 TuxjyrUc1Knac1OA83B1XG/FOhgyilx/hZJ9qDhnTJH9AMx2y84y+xL/L3ySvUw7Dv
	 TWczW1Vzbb/kQs+oT2XV0yP94z58WUjeCK5H4gr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390803AbfKHLoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:44:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:59480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387767AbfKHLoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:44:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71C30222D1;
        Fri,  8 Nov 2019 11:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213471;
        bh=paYbxFJhwWi5rUZFJYNrk3e0i0/3tdHI35nXxRrVAuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LPE+di6q8nVbjsxW7GHXjLeBwJUlhxS2jquUxyvwfvkOCaZhiFNAU19pwlvLNxwBp
         KMBsnojnJBFffZk2WF5hYf++nuTis1lqyb8K8ksJFF2W58PU9PR4HARUl/ocyGWdrW
         f1UeIgObe7tNxRuw2l7fKA4iv2kD0CQ5SFOc+PV0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, kernel@pengutronix.de,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 055/103] sched/debug: Use symbolic names for task state constants
Date:   Fri,  8 Nov 2019 06:42:20 -0500
Message-Id: <20191108114310.14363-55-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114310.14363-1-sashal@kernel.org>
References: <20191108114310.14363-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit ff28915fd31ccafc0d38e6f84b66df280ed9e86a ]

include/trace/events/sched.h includes <linux/sched.h> (via
<linux/sched/numa_balancing.h>) and so knows about the TASK_* constants
used to interpret .prev_state. So instead of duplicating the magic
numbers make use of the defined macros to ease understanding the
mapping from state bits to letters which isn't completely intuitive for
an outsider.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel@pengutronix.de
Link: http://lkml.kernel.org/r/20180905093636.24068-1-u.kleine-koenig@pengutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/sched.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 6e692a52936c7..18197e0bb5108 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -169,9 +169,14 @@ TRACE_EVENT(sched_switch,
 
 		(__entry->prev_state & (TASK_REPORT_MAX - 1)) ?
 		  __print_flags(__entry->prev_state & (TASK_REPORT_MAX - 1), "|",
-				{ 0x01, "S" }, { 0x02, "D" }, { 0x04, "T" },
-				{ 0x08, "t" }, { 0x10, "X" }, { 0x20, "Z" },
-				{ 0x40, "P" }, { 0x80, "I" }) :
+				{ TASK_INTERRUPTIBLE, "S" },
+				{ TASK_UNINTERRUPTIBLE, "D" },
+				{ __TASK_STOPPED, "T" },
+				{ __TASK_TRACED, "t" },
+				{ EXIT_DEAD, "X" },
+				{ EXIT_ZOMBIE, "Z" },
+				{ TASK_PARKED, "P" },
+				{ TASK_DEAD, "I" }) :
 		  "R",
 
 		__entry->prev_state & TASK_REPORT_MAX ? "+" : "",
-- 
2.20.1

