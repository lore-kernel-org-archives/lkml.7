Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC292C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932D020643
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="YM5f8UsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbfDSTEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:04:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42949 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727563AbfDSTD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:03:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JCGB0r265309
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 05:16:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JCGB0r265309
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555676172;
        bh=7hiolzGf487F26cDIqDSUbik3LIDPjXaDCcXWL4cAFc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=YM5f8UsKxey39KErg5bh8d5+VgKWBEQTDjvN2FvUTY4AygVmZrS/R3M9XjCO1mdFX
         KVhQul0YZ+TxuHHu5YdJcmG3DaAGEeUByCkjgzcnJ/R9apMouOTIPW12So8XrLLANx
         gdpjfkgQhLG8UZCc602Mgo8gzwZD8PKFdGkvgHpa0LzHREGHb4D/JUVBDz5kN3k46K
         01bTQyu0g9iPVefXobCCKRv8WlwF3nkGLL3S3aPlHg+tUiwqZlYsFw18sJ6l7Db7Tz
         GAPNe/Vw8OiqLNKw4PUSUpdj1lS1odWR/RvnJvUgiEyA0JLHawK9BJARrlMIMmFNpD
         dTkK0F8rS+rFQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JCG92B265306;
        Fri, 19 Apr 2019 05:16:09 -0700
Date:   Fri, 19 Apr 2019 05:16:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Konstantin Khlebnikov <tipbot@zytor.com>
Message-ID: <tip-1a010e29cfa00fee2888fd2fd4983f848cbafb58@git.kernel.org>
Cc:     peterz@infradead.org, a.p.zijlstra@chello.nl, hpa@zytor.com,
        linux-kernel@vger.kernel.org, khlebnikov@yandex-team.ru,
        mingo@kernel.org, torvalds@linux-foundation.org, tglx@linutronix.de
Reply-To: mingo@kernel.org, torvalds@linux-foundation.org,
          tglx@linutronix.de, a.p.zijlstra@chello.nl, peterz@infradead.org,
          hpa@zytor.com, linux-kernel@vger.kernel.org,
          khlebnikov@yandex-team.ru
In-Reply-To: <155125501739.293431.5252197504404771496.stgit@buzz>
References: <155125501739.293431.5252197504404771496.stgit@buzz>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/rt: Check integer overflow at usec to nsec
 conversion
Git-Commit-ID: 1a010e29cfa00fee2888fd2fd4983f848cbafb58
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

Commit-ID:  1a010e29cfa00fee2888fd2fd4983f848cbafb58
Gitweb:     https://git.kernel.org/tip/1a010e29cfa00fee2888fd2fd4983f848cbafb58
Author:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
AuthorDate: Wed, 27 Feb 2019 11:10:17 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Apr 2019 13:42:09 +0200

sched/rt: Check integer overflow at usec to nsec conversion

Example of unhandled overflows:

 # echo 18446744073709651 > cpu.rt_runtime_us
 # cat cpu.rt_runtime_us
 99

 # echo 18446744073709900 > cpu.rt_period_us
 # cat cpu.rt_period_us
 348

After this patch they will fail with -EINVAL.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/155125501739.293431.5252197504404771496.stgit@buzz
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/rt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 90fa23d36565..1e6b909dca36 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2555,6 +2555,8 @@ int sched_group_set_rt_runtime(struct task_group *tg, long rt_runtime_us)
 	rt_runtime = (u64)rt_runtime_us * NSEC_PER_USEC;
 	if (rt_runtime_us < 0)
 		rt_runtime = RUNTIME_INF;
+	else if ((u64)rt_runtime_us > U64_MAX / NSEC_PER_USEC)
+		return -EINVAL;
 
 	return tg_set_rt_bandwidth(tg, rt_period, rt_runtime);
 }
@@ -2575,6 +2577,9 @@ int sched_group_set_rt_period(struct task_group *tg, u64 rt_period_us)
 {
 	u64 rt_runtime, rt_period;
 
+	if (rt_period_us > U64_MAX / NSEC_PER_USEC)
+		return -EINVAL;
+
 	rt_period = rt_period_us * NSEC_PER_USEC;
 	rt_runtime = tg->rt_bandwidth.rt_runtime;
 
