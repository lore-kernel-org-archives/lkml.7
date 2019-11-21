Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF70C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F2220878
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574304299;
	bh=i4obWope5dspr37u0BwSnAO/HPhDR9eR2CY62eRdxsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xll/qLYGAUWs0MUDcJYywsPaYX5goLLk6mrzWKvasqd9pZtm7LibtNiGrndvTQeJ0
	 zjk8FDIb+lBijPnywCE/wpnsCTec0/h4w08VIijEhUPXwjPlsz/NQVSagzANVPiKvw
	 OoKLml5nJ7uFEfN89xXBP8+/qU+yKpHtCuUYiTVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfKUCoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 21:44:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:54456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbfKUCov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 21:44:51 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 835A02075A;
        Thu, 21 Nov 2019 02:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574304291;
        bh=i4obWope5dspr37u0BwSnAO/HPhDR9eR2CY62eRdxsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A3mtw2Ha+hqhuGCHMaKN2TebyLd8AMrHnItvBl4dgBCj5ZTfOLahVf0/VptX9nIr/
         3Di4nir4K2vzOplc6FLLAwBXvR/bkE+JczST0j4YA45tZTYymesQj4geaPFpjduFKb
         fk6BL56/RC/7EasPoK1KIs76w4T+CPjOKJk1Ps3s=
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
Date:   Thu, 21 Nov 2019 03:44:29 +0100
Message-Id: <20191121024430.19938-6-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121024430.19938-1-frederic@kernel.org>
References: <20191121024430.19938-1-frederic@kernel.org>
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
 drivers/leds/trigger/ledtrig-activity.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-activity.c b/drivers/leds/trigger/ledtrig-activity.c
index ddfc5edd07c8..6901e3631c22 100644
--- a/drivers/leds/trigger/ledtrig-activity.c
+++ b/drivers/leds/trigger/ledtrig-activity.c
@@ -57,11 +57,15 @@ static void led_activity_function(struct timer_list *t)
 	curr_used = 0;
 
 	for_each_possible_cpu(i) {
-		curr_used += kcpustat_cpu(i).cpustat[CPUTIME_USER]
-			  +  kcpustat_cpu(i).cpustat[CPUTIME_NICE]
-			  +  kcpustat_field(&kcpustat_cpu(i), CPUTIME_SYSTEM, i)
-			  +  kcpustat_cpu(i).cpustat[CPUTIME_SOFTIRQ]
-			  +  kcpustat_cpu(i).cpustat[CPUTIME_IRQ];
+		struct kernel_cpustat kcpustat;
+
+		kcpustat_fetch_cpu(&kcpustat, i);
+
+		curr_used += kcpustat.cpustat[CPUTIME_USER]
+			  +  kcpustat.cpustat[CPUTIME_NICE]
+			  +  kcpustat.cpustat[CPUTIME_SYSTEM]
+			  +  kcpustat.cpustat[CPUTIME_SOFTIRQ]
+			  +  kcpustat.cpustat[CPUTIME_IRQ];
 		cpus++;
 	}
 
-- 
2.23.0

