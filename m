Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3277BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF290217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q8ffQgdK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfCSX5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 19:57:02 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:52376 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbfCSX4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 19:56:41 -0400
Received: by mail-qk1-f202.google.com with SMTP id k21so19348384qkg.19
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 16:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/1f+k74gk1272nyZAYvhUzZCD+eEvuFJDJVbOJgy+wk=;
        b=Q8ffQgdK/wkTC+TdacBpBr7s7ZA+ibEdwudd2fRpPvrcaC/Z4LqJTNqtLCyv8fay3Q
         chiHW354Gbcen71ue0RFArhXaTYhUvFlgw847q/e4JvbmuxVF1URZSS4uI5/2AOq95Tg
         EUZGBIm5ffQd2Ig8HQTcV4Ga4AwlViHgtFeDDiCPhfHDPO06IXDNPK9KlA6EzFdtzCZw
         XIpSvnBo/nnTQIl706MCfwLeDFb6UkMXt7TLQ9AlMLikpSRMRfuJ/IfBREdiXgcI3pzN
         Tqwh1wtk3Mfv6veI944tZm831+Y/Nmg0Yiy3lc4aslJlMD8H+RAAp6Z3buACiQNjY+Pi
         ZHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/1f+k74gk1272nyZAYvhUzZCD+eEvuFJDJVbOJgy+wk=;
        b=jB1pb7Kw7DgQRF1N3Jz58Ov21g0uxNZhw0ZdA2wRtQA0RPo/N2woSEl4Ac7DaoeyGz
         P7nu0DHWtEhpwDsCPvPMbEo0Xt1oLfu22PAa5/nTSzEVnia31X/i+50RUqjYwPUEat0v
         ji1rw6T8X8iyTeQF5SnzX32Y0hgdwFCnNButFqaslE+kH3jRU5nu/k2LOM9FJ35Juja1
         IgmYSpweQDicsBjZm7tiCZDS/z2xa0da4irOUmffonb7wfaGF2EyqFfu11/tWaBeGvl6
         ebwVEzrqs6IbgjJ+mwtoPWYxUHEvZsEAV6Api9BKwblfayXprVctufhvGxlsvLZwQP8I
         ZrQA==
X-Gm-Message-State: APjAAAXzMeIRSr+/irIIAuepD2qmWunZSrequ5zeWPMnkkhSPQBrTiV0
        JIYnEfZBNlhOuQhrflgyM+ni2ra85Sg=
X-Google-Smtp-Source: APXvYqw+3rmGmXN+0NOE9KYUNNYevZu09CHWRK5dGTsF91CDis8OUSyXsZ9D4hzjIdVioTkn+fpmgfJUK48=
X-Received: by 2002:ac8:1410:: with SMTP id k16mr13547779qtj.58.1553039800238;
 Tue, 19 Mar 2019 16:56:40 -0700 (PDT)
Date:   Tue, 19 Mar 2019 16:56:17 -0700
In-Reply-To: <20190319235619.260832-1-surenb@google.com>
Message-Id: <20190319235619.260832-6-surenb@google.com>
Mime-Version: 1.0
References: <20190319235619.260832-1-surenb@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [PATCH v6 5/7] psi: track changed states
From:   Suren Baghdasaryan <surenb@google.com>
To:     gregkh@linuxfoundation.org
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        axboe@kernel.dk, dennis@kernel.org, dennisszhou@gmail.com,
        mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce changed_states parameter into collect_percpu_times to track
the states changed since the last update.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 kernel/sched/psi.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index ace5ed97b186..1b99eeffaa25 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -210,7 +210,8 @@ static bool test_state(unsigned int *tasks, enum psi_states state)
 	}
 }
 
-static void get_recent_times(struct psi_group *group, int cpu, u32 *times)
+static void get_recent_times(struct psi_group *group, int cpu, u32 *times,
+			     u32 *pchanged_states)
 {
 	struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
 	u64 now, state_start;
@@ -218,6 +219,8 @@ static void get_recent_times(struct psi_group *group, int cpu, u32 *times)
 	unsigned int seq;
 	u32 state_mask;
 
+	*pchanged_states = 0;
+
 	/* Snapshot a coherent view of the CPU state */
 	do {
 		seq = read_seqcount_begin(&groupc->seq);
@@ -246,6 +249,8 @@ static void get_recent_times(struct psi_group *group, int cpu, u32 *times)
 		groupc->times_prev[s] = times[s];
 
 		times[s] = delta;
+		if (delta)
+			*pchanged_states |= (1 << s);
 	}
 }
 
@@ -269,10 +274,11 @@ static void calc_avgs(unsigned long avg[3], int missed_periods,
 	avg[2] = calc_load(avg[2], EXP_300s, pct);
 }
 
-static bool collect_percpu_times(struct psi_group *group)
+static void collect_percpu_times(struct psi_group *group, u32 *pchanged_states)
 {
 	u64 deltas[NR_PSI_STATES - 1] = { 0, };
 	unsigned long nonidle_total = 0;
+	u32 changed_states = 0;
 	int cpu;
 	int s;
 
@@ -287,8 +293,11 @@ static bool collect_percpu_times(struct psi_group *group)
 	for_each_possible_cpu(cpu) {
 		u32 times[NR_PSI_STATES];
 		u32 nonidle;
+		u32 cpu_changed_states;
 
-		get_recent_times(group, cpu, times);
+		get_recent_times(group, cpu, times,
+				&cpu_changed_states);
+		changed_states |= cpu_changed_states;
 
 		nonidle = nsecs_to_jiffies(times[PSI_NONIDLE]);
 		nonidle_total += nonidle;
@@ -313,7 +322,8 @@ static bool collect_percpu_times(struct psi_group *group)
 	for (s = 0; s < NR_PSI_STATES - 1; s++)
 		group->total[s] += div_u64(deltas[s], max(nonidle_total, 1UL));
 
-	return nonidle_total;
+	if (pchanged_states)
+		*pchanged_states = changed_states;
 }
 
 static u64 update_averages(struct psi_group *group, u64 now)
@@ -373,6 +383,7 @@ static void psi_avgs_work(struct work_struct *work)
 {
 	struct delayed_work *dwork;
 	struct psi_group *group;
+	u32 changed_states;
 	bool nonidle;
 	u64 now;
 
@@ -383,7 +394,8 @@ static void psi_avgs_work(struct work_struct *work)
 
 	now = sched_clock();
 
-	nonidle = collect_percpu_times(group);
+	collect_percpu_times(group, &changed_states);
+	nonidle = changed_states & (1 << PSI_NONIDLE);
 	/*
 	 * If there is task activity, periodically fold the per-cpu
 	 * times and feed samples into the running averages. If things
@@ -719,7 +731,7 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 	/* Update averages before reporting them */
 	mutex_lock(&group->avgs_lock);
 	now = sched_clock();
-	collect_percpu_times(group);
+	collect_percpu_times(group, NULL);
 	if (now >= group->avg_next_update)
 		group->avg_next_update = update_averages(group, now);
 	mutex_unlock(&group->avgs_lock);
-- 
2.21.0.225.g810b269d1ac-goog

