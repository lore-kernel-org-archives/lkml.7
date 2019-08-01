Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D101C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F314206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="iIcsdSOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbfHAQET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:04:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51525 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732617AbfHAQES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:04:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x71G48xv009346
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 1 Aug 2019 09:04:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x71G48xv009346
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564675449;
        bh=5UF6CQYe7Aj+bpxxaPuL9ABy/M0hWDaQ+7GVKUDRbQk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=iIcsdSOsl0y7B0uEJ6ziRx0zpFOMHh+ZAuTrQRLGeWQ3VKMTO3k4+OTMuifBC+I8C
         x6fLT242CUT3u+aXsSVpVBkoAXEiQl5/Cuf73vrCQfN2K/ygckj7O9tT24DhHaLlAH
         b9NY/KZFv6ylG8tDEdUsEJ6UE4jDN/ogkCPUgFI7qSwvztWK3h8RH1MId6AKd75Va1
         O0ywV9/mA/PopszANWrZpseSAIp5xsnLcN2hLihF8mox/aw2ddHKgsTqC4XGYxgKDm
         5Iz7ZjXGljFs63ncqFUnXZwGBqTmwDHNn8CurAQAyHC800gVj2ZMZybR1/0QcFS9Rz
         q8vjI9JWPbdYw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x71G48xf009343;
        Thu, 1 Aug 2019 09:04:08 -0700
Date:   Thu, 1 Aug 2019 09:04:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Anna-Maria Gleixner <tipbot@zytor.com>
Message-ID: <tip-1f8e8bd8b74c8089a43bc5f1f24e4bf0f855d760@git.kernel.org>
Cc:     bigeasy@linutronix.de, anna-maria@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        peterz@infradead.org, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
          anna-maria@linutronix.de, peterz@infradead.org,
          tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20190730223828.508744705@linutronix.de>
References: <20190730223828.508744705@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] alarmtimer: Prepare for PREEMPT_RT
Git-Commit-ID: 1f8e8bd8b74c8089a43bc5f1f24e4bf0f855d760
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

Commit-ID:  1f8e8bd8b74c8089a43bc5f1f24e4bf0f855d760
Gitweb:     https://git.kernel.org/tip/1f8e8bd8b74c8089a43bc5f1f24e4bf0f855d760
Author:     Anna-Maria Gleixner <anna-maria@linutronix.de>
AuthorDate: Wed, 31 Jul 2019 00:33:49 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Aug 2019 17:46:41 +0200

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
