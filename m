Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201BAC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1542064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DoaGhE8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfDSTEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:04:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42949 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729199AbfDSTD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:03:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JCHkgA265387
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 05:17:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JCHkgA265387
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555676267;
        bh=3lHQyr7OY8VigoK/YL4cHC83L/bIkpKWAHB8JQwF76A=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=DoaGhE8JiY1m11SUSsmJvaYEaFaWq4Wp5Uo+7C/3vA1uygfQgCLul1YJwNv4FxEDu
         XV+LW81sbNYU/nQGoZ2xdroiSD3xxWgtBjvwoX+S8hGjFtcSNVqKkn7dl4DCv0j6wu
         ZYS63zlPJyqAJxmHGbvj5sKaUbaOY5yJ09+yZmMIVjX+QjeskOj69QW4R6gSIZ1e/n
         5KYzXMyNIU28v4gmhsI3hKX5yxo2MZkkxsI8JMPiOVowkNyYvnbELJgLysA31x1N6O
         nv08Xu06v5E5zCcI6o0roO/Q0qSMWjtK0xwfcIzna/Br7hw4dJ6JeWtQqJ6ZRIHixw
         wi0LrqiMiTSqQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JCHj9S265384;
        Fri, 19 Apr 2019 05:17:45 -0700
Date:   Fri, 19 Apr 2019 05:17:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Konstantin Khlebnikov <tipbot@zytor.com>
Message-ID: <tip-1a8b4540db732ca16c9e43ac7c08b1b8f0b252d8@git.kernel.org>
Cc:     hpa@zytor.com, a.p.zijlstra@chello.nl, peterz@infradead.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, khlebnikov@yandex-team.ru
Reply-To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org, khlebnikov@yandex-team.ru, hpa@zytor.com,
          a.p.zijlstra@chello.nl, tglx@linutronix.de, peterz@infradead.org
In-Reply-To: <155125502079.293431.3947497929372138600.stgit@buzz>
References: <155125502079.293431.3947497929372138600.stgit@buzz>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Check quota and period overflow at
 usec to nsec conversion
Git-Commit-ID: 1a8b4540db732ca16c9e43ac7c08b1b8f0b252d8
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

Commit-ID:  1a8b4540db732ca16c9e43ac7c08b1b8f0b252d8
Gitweb:     https://git.kernel.org/tip/1a8b4540db732ca16c9e43ac7c08b1b8f0b252d8
Author:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
AuthorDate: Wed, 27 Feb 2019 11:10:20 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Apr 2019 13:42:10 +0200

sched/core: Check quota and period overflow at usec to nsec conversion

Large values could overflow u64 and pass following sanity checks.

 # echo 18446744073750000 > cpu.cfs_period_us
 # cat cpu.cfs_period_us
 40448

 # echo 18446744073750000 > cpu.cfs_quota_us
 # cat cpu.cfs_quota_us
 40448

After this patch they will fail with -EINVAL.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/155125502079.293431.3947497929372138600.stgit@buzz
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 685b1541ce51..de8ab411826c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6611,8 +6611,10 @@ static int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
 	period = ktime_to_ns(tg->cfs_bandwidth.period);
 	if (cfs_quota_us < 0)
 		quota = RUNTIME_INF;
-	else
+	else if ((u64)cfs_quota_us <= U64_MAX / NSEC_PER_USEC)
 		quota = (u64)cfs_quota_us * NSEC_PER_USEC;
+	else
+		return -EINVAL;
 
 	return tg_set_cfs_bandwidth(tg, period, quota);
 }
@@ -6634,6 +6636,9 @@ static int tg_set_cfs_period(struct task_group *tg, long cfs_period_us)
 {
 	u64 quota, period;
 
+	if ((u64)cfs_period_us > U64_MAX / NSEC_PER_USEC)
+		return -EINVAL;
+
 	period = (u64)cfs_period_us * NSEC_PER_USEC;
 	quota = tg->cfs_bandwidth.quota;
 
