Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50990C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C8620838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="FmaqlqM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388314AbfHATG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:06:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44411 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbfHATG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:06:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x71J6HD3071311
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 1 Aug 2019 12:06:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x71J6HD3071311
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564686378;
        bh=ffnPKpbWshFlXVk0JspsRjM0wyLElMQMdF8lzwrmiYo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=FmaqlqM1hs9amGT1jH6xUEM3lDy41gi2xNR5Gl1+JDlCf0yn4hOSK48TD/izCS/RQ
         BuJO8hVz+Cnyy1WnN2Fh0p3GxinsWWYT3DVExEE6/CJKwGc/vb6rGzdP3z+PT11ga8
         UOdnbMBmw6L60aG96MD85rEM5FKn9U5q7AkUTIHQCRpT3xnbcbkJtA0fiOX5h8r/wU
         fcCuU5q8jGfHmvHZBASdPNRWBcGsR/LaEDEI4DeORfAzlBE0An+rdCBJku/oklksTc
         pGKQMvfsSUxO1d2bsRJBl17urz7tGLogG+TL89VAcqUCuaByK4JVhTRzu+V7zn3T6w
         B9TRopJno7b5g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x71J6GwS071308;
        Thu, 1 Aug 2019 12:06:16 -0700
Date:   Thu, 1 Aug 2019 12:06:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Anna-Maria Gleixner <tipbot@zytor.com>
Message-ID: <tip-51ae33092bb8320497ec75ddc5ab383d8fafd55c@git.kernel.org>
Cc:     peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        anna-maria@linutronix.de
Reply-To: mingo@kernel.org, bigeasy@linutronix.de,
          anna-maria@linutronix.de, hpa@zytor.com, tglx@linutronix.de,
          peterz@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190730223828.508744705@linutronix.de>
References: <20190730223828.508744705@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] alarmtimer: Prepare for PREEMPT_RT
Git-Commit-ID: 51ae33092bb8320497ec75ddc5ab383d8fafd55c
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

Commit-ID:  51ae33092bb8320497ec75ddc5ab383d8fafd55c
Gitweb:     https://git.kernel.org/tip/51ae33092bb8320497ec75ddc5ab383d8fafd55c
Author:     Anna-Maria Gleixner <anna-maria@linutronix.de>
AuthorDate: Wed, 31 Jul 2019 00:33:49 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Aug 2019 20:51:23 +0200

alarmtimer: Prepare for PREEMPT_RT

Use the hrtimer_cancel_wait_running() synchronization mechanism to prevent
priority inversion and live locks on PREEMPT_RT.

[ tglx: Split out of combo patch ]

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190730223828.508744705@linutronix.de


---
 kernel/time/alarmtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 57518efc3810..36947449dba2 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -432,7 +432,7 @@ int alarm_cancel(struct alarm *alarm)
 		int ret = alarm_try_to_cancel(alarm);
 		if (ret >= 0)
 			return ret;
-		cpu_relax();
+		hrtimer_cancel_wait_running(&alarm->timer);
 	}
 }
 EXPORT_SYMBOL_GPL(alarm_cancel);
