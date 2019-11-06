Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4349CC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B1220659
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573009784;
	bh=AeyuQDx16SbC4kiHgjnITMVBwHgRfMgTSaw25Q9xYbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U2LxN0X4nU0fFyuhYN0wIuLYhmee0bVVyW/9rktMlqqdCArVsKCmsnuIQE91MjQ59
	 AR1+lrPpGKgdHUn5Uw3+ua2gtvYF2jlOgpbq0BLF7zJq1EpcURhU7uYqUXESWCJIMf
	 w3iBKHHfBvetjJXD1rYkIvAiZ+WQiiZXHoj7gpTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388358AbfKFDIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:08:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388289AbfKFDI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:08:29 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83D7C222CB;
        Wed,  6 Nov 2019 03:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573009708;
        bh=AeyuQDx16SbC4kiHgjnITMVBwHgRfMgTSaw25Q9xYbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LgBI0mperws14tFGgqjJq23DXJf2MXPwBCbflHFPx1gIdG0NEcIkHjBBTfeuDgXzn
         wih4ucL4/vYLeXWjHLK+OujynKBLVwxi4ESsCnek17YI5WjfEKCduXM0Yd9kIXP6AB
         ygbTASVvSPM0CMbQLV6pN0A3L36sJWbQveAojR5o=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Pavel Machek <pavel@ucw.cz>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 4/9] sched/cputime: Support other fields on kcpustat_field()
Date:   Wed,  6 Nov 2019 04:08:02 +0100
Message-Id: <20191106030807.31091-5-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106030807.31091-1-frederic@kernel.org>
References: <20191106030807.31091-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we support nice updates under vtime accounting, we can provide
tickless values for kcpustat readers of user and guest time.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/cputime.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index e09194415c35..bf4b61f71194 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -1042,6 +1042,15 @@ void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
 	} while (read_seqcount_retry(&vtime->seqcount, seq));
 }
 
+static u64 kcpustat_user_vtime(struct vtime *vtime)
+{
+	if (vtime->state == VTIME_USER)
+		return vtime->utime + vtime_delta(vtime);
+	else if (vtime->state == VTIME_GUEST)
+		return vtime->gtime + vtime_delta(vtime);
+	return 0;
+}
+
 static int kcpustat_field_vtime(u64 *cpustat,
 				struct vtime *vtime,
 				enum cpu_usage_stat usage,
@@ -1076,9 +1085,30 @@ static int kcpustat_field_vtime(u64 *cpustat,
 
 		*val = cpustat[usage];
 
-		if (vtime->state == VTIME_SYS)
-			*val += vtime->stime + vtime_delta(vtime);
-
+		switch (usage) {
+		case CPUTIME_SYSTEM:
+			if (vtime->state == VTIME_SYS)
+				*val += vtime->stime + vtime_delta(vtime);
+			break;
+		case CPUTIME_USER:
+			if (!vtime->nice)
+				*val += kcpustat_user_vtime(vtime);
+			break;
+		case CPUTIME_NICE:
+			if (vtime->nice)
+				*val += kcpustat_user_vtime(vtime);
+			break;
+		case CPUTIME_GUEST:
+			if (vtime->state == VTIME_GUEST && !vtime->nice)
+				*val += vtime->gtime + vtime_delta(vtime);
+			break;
+		case CPUTIME_GUEST_NICE:
+			if (vtime->state == VTIME_GUEST && vtime->nice)
+				*val += vtime->gtime + vtime_delta(vtime);
+			break;
+		default:
+			break;
+		}
 	} while (read_seqcount_retry(&vtime->seqcount, seq));
 
 	return 0;
@@ -1095,10 +1125,6 @@ u64 kcpustat_field(struct kernel_cpustat *kcpustat,
 	if (!vtime_accounting_enabled_cpu(cpu))
 		return cpustat[usage];
 
-	/* Only support sys vtime for now */
-	if (usage != CPUTIME_SYSTEM)
-		return cpustat[usage];
-
 	rq = cpu_rq(cpu);
 
 	for (;;) {
-- 
2.23.0

