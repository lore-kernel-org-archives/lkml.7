Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C21C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B75521655
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ryvHKwkT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbfFYIZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:25:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47759 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbfFYIZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:25:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8P0M33529638
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:25:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8P0M33529638
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561451101;
        bh=KxDixTeQny4IcqBw/DWyVQaGBJWQiYYmdKTsR65r9j0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ryvHKwkT6JEc/Nat/dYwXa8I95uGVJIVWshFcQIMcs7/F8ZUK2ZtAEB2nBzKdwl6R
         p3XaVcHyAxEAw+8V4PyQV/YJ8ukeXPybOtkdNrk3HyoYRFy/x3fuPJeubhODOl/Usa
         gsD/d+WPeejNSDmMvEI4JVgOtbsPOJigrp+eDctdjnZYitjP8WQ7v+aVBcE7se/kiC
         9lSUaS5W2CWnhNVR4fgHQXdVCRoyUxxJeDqSakE+WXjfKlWabKwXDBGvQCwl0nuG8H
         R9IaIYzmeU8sXtvRzhq1uNEygAaxp3sz9GVqVhIm+9maK7hvUaGqi2RZ/5aTbaiCwf
         h7tZQaj/ND0qg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8OxZT3529635;
        Tue, 25 Jun 2019 01:24:59 -0700
Date:   Tue, 25 Jun 2019 01:24:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qais Yousef <tipbot@zytor.com>
Message-ID: <tip-9ba5090aecac08ff3ae54ac3bd94b61db7708ffc@git.kernel.org>
Cc:     hpa@zytor.com, quentin.perret@arm.com, qais.yousef@arm.com,
        rostedt@goodmis.org, pkondeti@codeaurora.org, mingo@kernel.org,
        u.kleine-koenig@pengutronix.de, torvalds@linux-foundation.org,
        dietmar.eggemann@arm.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        bigeasy@linutronix.de
Reply-To: pkondeti@codeaurora.org, rostedt@goodmis.org,
          qais.yousef@arm.com, quentin.perret@arm.com, hpa@zytor.com,
          peterz@infradead.org, bigeasy@linutronix.de,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          dietmar.eggemann@arm.com, torvalds@linux-foundation.org,
          u.kleine-koenig@pengutronix.de, mingo@kernel.org
In-Reply-To: <20190604111459.2862-2-qais.yousef@arm.com>
References: <20190604111459.2862-2-qais.yousef@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/autogroup: Make autogroup_path() always
 available
Git-Commit-ID: 9ba5090aecac08ff3ae54ac3bd94b61db7708ffc
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

Commit-ID:  9ba5090aecac08ff3ae54ac3bd94b61db7708ffc
Gitweb:     https://git.kernel.org/tip/9ba5090aecac08ff3ae54ac3bd94b61db7708ffc
Author:     Qais Yousef <qais.yousef@arm.com>
AuthorDate: Tue, 4 Jun 2019 12:14:54 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:23:40 +0200

sched/autogroup: Make autogroup_path() always available

Remove the #ifdef CONFIG_SCHED_DEBUG.

Some of the tracepoints to be introduced in later patches need to access
this function. Hence make it always available since the tracepoints are
not protected by CONFIG_SCHED_DEBUG.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pavankumar Kondeti <pkondeti@codeaurora.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
Link: https://lkml.kernel.org/r/20190604111459.2862-2-qais.yousef@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/autogroup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index 2d4ff5353ded..2067080bb235 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -259,7 +259,6 @@ out:
 }
 #endif /* CONFIG_PROC_FS */
 
-#ifdef CONFIG_SCHED_DEBUG
 int autogroup_path(struct task_group *tg, char *buf, int buflen)
 {
 	if (!task_group_is_autogroup(tg))
@@ -267,4 +266,3 @@ int autogroup_path(struct task_group *tg, char *buf, int buflen)
 
 	return snprintf(buf, buflen, "%s-%ld", "/autogroup", tg->autogroup->id);
 }
-#endif
