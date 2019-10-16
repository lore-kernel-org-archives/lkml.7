Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFA7ECE59E
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7E920663
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571194672;
	bh=Wpce9udaw5lqxb8qndTEni/7j4Wvb9sSHAxCu/D1goI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fV0G8UNKdeY5LRI4wOfjQrnIsiwyKLKUfGmGEuWqE13m8HLVw3FidagnQCAsoFBxM
	 i4Q6Q4LB6RQTWA5riRRx3k2RlFOZsmljWk2lBIwyLx1V6tYTZYupPc4ArYRvG+kLf+
	 g/BRJyIAgxp2Q2zkZIcBBzRCPF9G9Ks45IOS9p38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390823AbfJPC5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 22:57:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390806AbfJPC5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 22:57:48 -0400
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B429217D6;
        Wed, 16 Oct 2019 02:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571194667;
        bh=Wpce9udaw5lqxb8qndTEni/7j4Wvb9sSHAxCu/D1goI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pb26N5+KY7ykJCza9xsXU/tVLP0iceei6SxEUxG+wf0FphmiiVPzY2F07/4+LDCeP
         SCySMffDZZPzBrbmZLOAv/Uinv+vSeFa2q8g7l4eJaKqLfBhyzwMpQfAITXPiYVuG4
         1M045mlqy4dGdPr9cwHvXMBHB+zqz2484D57sUwk=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 14/14] leds: Use vtime aware kcpustat accessor to fetch CPUTIME_SYSTEM
Date:   Wed, 16 Oct 2019 04:57:00 +0200
Message-Id: <20191016025700.31277-15-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016025700.31277-1-frederic@kernel.org>
References: <20191016025700.31277-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a vtime safe kcpustat accessor for CPUTIME_SYSTEM, use
it to start fixing frozen kcpustat values on nohz_full CPUs.

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
 drivers/leds/trigger/ledtrig-activity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/trigger/ledtrig-activity.c b/drivers/leds/trigger/ledtrig-activity.c
index 6a72b7e13719..ddfc5edd07c8 100644
--- a/drivers/leds/trigger/ledtrig-activity.c
+++ b/drivers/leds/trigger/ledtrig-activity.c
@@ -59,7 +59,7 @@ static void led_activity_function(struct timer_list *t)
 	for_each_possible_cpu(i) {
 		curr_used += kcpustat_cpu(i).cpustat[CPUTIME_USER]
 			  +  kcpustat_cpu(i).cpustat[CPUTIME_NICE]
-			  +  kcpustat_cpu(i).cpustat[CPUTIME_SYSTEM]
+			  +  kcpustat_field(&kcpustat_cpu(i), CPUTIME_SYSTEM, i)
 			  +  kcpustat_cpu(i).cpustat[CPUTIME_SOFTIRQ]
 			  +  kcpustat_cpu(i).cpustat[CPUTIME_IRQ];
 		cpus++;
-- 
2.23.0

