Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FF7C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC86D2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="TNki1vF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfDSTD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:03:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42949 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729199AbfDSTD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:03:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JCGxQE265334
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 05:16:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JCGxQE265334
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555676220;
        bh=oMquC4Hqs+4PBwEW4SZwEz0ab5O6GnBFepmZPk2AUlg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=TNki1vF/ryTh4tmJQ//3b7q+C5MblTGg7f8crbLPJMcyGfuTxgQ9XT/OAOusCTJma
         G5vxOpXqdFr9ocAZhR7hlQZOg1wYR9Lps9BKY2M2DlRSQUS5Aptz6CqgrrcKdhwfbW
         Mrmzwp/5DMYw8V+DXY4WTvDjiNvfcP/BWtfHygq+CauH9wxNMUEwJMeSq6cbix6E3D
         bFKnxoAx3/hZRmzCE9aFFjT7pOt4bCrwqbW//XXp38oa/TDK9VNUWwrOl358SX+efV
         6LKOtdIQ+c+qA+BU77Tl2Vo9JiTqLOHfYdjTM7LDY56Q1lW72GruKtmBCrhQo1bdLo
         0HDMgg3dYQiJg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JCGwqr265331;
        Fri, 19 Apr 2019 05:16:58 -0700
Date:   Fri, 19 Apr 2019 05:16:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Konstantin Khlebnikov <tipbot@zytor.com>
Message-ID: <tip-5b61d50ab4ef590f5e1d4df15cd2cea5f5715308@git.kernel.org>
Cc:     tglx@linutronix.de, a.p.zijlstra@chello.nl, hpa@zytor.com,
        khlebnikov@yandex-team.ru, peterz@infradead.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        mingo@kernel.org
Reply-To: khlebnikov@yandex-team.ru, hpa@zytor.com, a.p.zijlstra@chello.nl,
          tglx@linutronix.de, mingo@kernel.org,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          peterz@infradead.org
In-Reply-To: <155125501891.293431.3345233332801109696.stgit@buzz>
References: <155125501891.293431.3345233332801109696.stgit@buzz>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Handle overflow in
 cpu_shares_write_u64
Git-Commit-ID: 5b61d50ab4ef590f5e1d4df15cd2cea5f5715308
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

Commit-ID:  5b61d50ab4ef590f5e1d4df15cd2cea5f5715308
Gitweb:     https://git.kernel.org/tip/5b61d50ab4ef590f5e1d4df15cd2cea5f5715308
Author:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
AuthorDate: Wed, 27 Feb 2019 11:10:18 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Apr 2019 13:42:10 +0200

sched/core: Handle overflow in cpu_shares_write_u64

Bit shift in scale_load() could overflow shares. This patch saturates
it to MAX_SHARES like following sched_group_set_shares().

Example:

 # echo 9223372036854776832 > cpu.shares
 # cat cpu.shares

Before patch: 1024
After pattch: 262144

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/155125501891.293431.3345233332801109696.stgit@buzz
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fb09eaad1d3a..685b1541ce51 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6507,6 +6507,8 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 static int cpu_shares_write_u64(struct cgroup_subsys_state *css,
 				struct cftype *cftype, u64 shareval)
 {
+	if (shareval > scale_load_down(ULONG_MAX))
+		shareval = MAX_SHARES;
 	return sched_group_set_shares(css_tg(css), scale_load(shareval));
 }
 
