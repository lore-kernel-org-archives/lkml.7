Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405ACECE58F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185B421848
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571194667;
	bh=DihgHlZEMX3o1zUkM1gf7Grg+nBtfSOlyb+CoUK+JT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M9W5VV0c+JtPkotEZCZ/AArug6GpC5aR+LJyfgNDAqC5fJfwZAqCTesgUB27CcmXK
	 4nWq+TUbdmlp2gCqIzxyvG1mPzy8WYxedW52OsZFNefmPxHDsrOiqk246N1EzSDmS5
	 XK4cZ8vhVwA+iKzx/FbHwtG326kv34i2553qLKWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390800AbfJPC5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 22:57:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390789AbfJPC5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 22:57:42 -0400
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56F5E21835;
        Wed, 16 Oct 2019 02:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571194661;
        bh=DihgHlZEMX3o1zUkM1gf7Grg+nBtfSOlyb+CoUK+JT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uLn5DIcEBu/dZJ4AktKW+T1QQaa85Ia/ASKaiTQb1JfwVnB5Gep0J7NOmhftFyEDx
         wKBhXzL/D1DlpO2I59yMRh8yAIwQmau29/iGE2ofHMk8DD1QvTOP3JcJfasdvgdK06
         p2TMI2zQz41gySU0WX+f3qK6NWSNZIiuXSAl+5sA=
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
Subject: [PATCH 12/14] procfs: Use vtime aware kcpustat accessor to fetch CPUTIME_SYSTEM
Date:   Wed, 16 Oct 2019 04:56:58 +0200
Message-Id: <20191016025700.31277-13-frederic@kernel.org>
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
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 fs/proc/stat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 80c305f206bb..5c6bd0ae3802 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -124,7 +124,7 @@ static int show_stat(struct seq_file *p, void *v)
 
 		user += kcs->cpustat[CPUTIME_USER];
 		nice += kcs->cpustat[CPUTIME_NICE];
-		system += kcs->cpustat[CPUTIME_SYSTEM];
+		system += kcpustat_field(kcs, CPUTIME_SYSTEM, i);
 		idle += get_idle_time(kcs, i);
 		iowait += get_iowait_time(kcs, i);
 		irq += kcs->cpustat[CPUTIME_IRQ];
@@ -162,7 +162,7 @@ static int show_stat(struct seq_file *p, void *v)
 		/* Copy values here to work around gcc-2.95.3, gcc-2.96 */
 		user = kcs->cpustat[CPUTIME_USER];
 		nice = kcs->cpustat[CPUTIME_NICE];
-		system = kcs->cpustat[CPUTIME_SYSTEM];
+		system = kcpustat_field(kcs, CPUTIME_SYSTEM, i);
 		idle = get_idle_time(kcs, i);
 		iowait = get_iowait_time(kcs, i);
 		irq = kcs->cpustat[CPUTIME_IRQ];
-- 
2.23.0

