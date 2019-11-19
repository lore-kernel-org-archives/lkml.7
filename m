Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA94C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 23:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CF42245F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 23:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574205770;
	bh=ZnFz+lH+tOpk7R3l2NW9L4pWuZOSXkhyLiTtLd8lH/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=06xVFJN+p1/6nE0w2VZbOZyxUsK4f1V3095NDRsMx5//ckZkmRyoM/hbVJdSZZBXX
	 zGar8rqKP7sQpAjjE0E8Dom6iDgQS/zArrY3vIjAYL2jJO2VhaLwlnI6WwX2bwTOd/
	 Jz46RvKJhxmU0VcYFe2r/apW8+tPc+2aB3Hi4x0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfKSXWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 18:22:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:59934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbfKSXWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 18:22:41 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C93F3222DF;
        Tue, 19 Nov 2019 23:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574205761;
        bh=ZnFz+lH+tOpk7R3l2NW9L4pWuZOSXkhyLiTtLd8lH/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lZYv8T1dYWdmwySaYuV07w6CIr1t3GyFFvVUASx2W0t73uOlGXIpmFElyV8vkQzUO
         6Iy5XlifkNFCGQBZy5NBDJtUApO2Todj2BG0UJPZXAyiBj2h+ciB3DW4JK0IBcnsrb
         5LzHGyWLL1yGcAUjPw120IxqlbApXVorPtCon2EM=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 5/6] leds: Use all-in-one vtime aware kcpustat accessor
Date:   Wed, 20 Nov 2019 00:22:17 +0100
Message-Id: <20191119232218.4206-6-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191119232218.4206-1-frederic@kernel.org>
References: <20191119232218.4206-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can now safely read user kcpustat fields on nohz_full CPUs.
Use the appropriate accessor.

Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 drivers/leds/trigger/ledtrig-activity.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-activity.c b/drivers/leds/trigger/ledtrig-activity.c
index ddfc5edd07c8..20250de1138d 100644
--- a/drivers/leds/trigger/ledtrig-activity.c
+++ b/drivers/leds/trigger/ledtrig-activity.c
@@ -57,9 +57,12 @@ static void led_activity_function(struct timer_list *t)
 	curr_used = 0;
 
 	for_each_possible_cpu(i) {
-		curr_used += kcpustat_cpu(i).cpustat[CPUTIME_USER]
-			  +  kcpustat_cpu(i).cpustat[CPUTIME_NICE]
-			  +  kcpustat_field(&kcpustat_cpu(i), CPUTIME_SYSTEM, i)
+		u64 user, nice, sys, guest, guest_nice;
+
+		kcpustat_cputime(&kcpustat_cpu(i), i, &user, &nice, &sys,
+				 &guest, &guest_nice);
+
+		curr_used += user + nice + sys
 			  +  kcpustat_cpu(i).cpustat[CPUTIME_SOFTIRQ]
 			  +  kcpustat_cpu(i).cpustat[CPUTIME_IRQ];
 		cpus++;
-- 
2.23.0

