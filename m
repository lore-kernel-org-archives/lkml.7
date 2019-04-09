Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF10C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CEE20663
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIrdR3NJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfDIIn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:43:29 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33341 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfDIIn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:43:28 -0400
Received: by mail-pl1-f193.google.com with SMTP id t16so8990838plo.0;
        Tue, 09 Apr 2019 01:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JIRvX/tNg3dmQDpHkr3vRbGkJ1zGIhKbuPhBn9FkHGw=;
        b=dIrdR3NJF03XMc7UKDod7gjeOB7uIQDI4aRhqEH+Kf34b9u6g/oUPoJplv3+gIt4kW
         oGsPvOe90UU3ZhtQ02SIJbMz4xdtiBxiBzbbyHTP9RzW+KvniNJG0k0R3IVLLcKN7uh2
         jFCjXpjWElUoGRAI05rZzYQtf+30BnCxVvjOw/RfmUedBP1Ug3nnlqCvwICnMAqekQuc
         lkf7Lq2cRNUe1XSEHuS18AqUB17lgFMo/S7sY7SQ7otBt9p0AM9MpDNHpLkvRHf8tHCj
         0MScpxtp/xmP0dgjuu8Gv9HEdvBKSSJNM7d614jIFhz//kL7eYR9OyvgEpSt7+i2dtnG
         kj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JIRvX/tNg3dmQDpHkr3vRbGkJ1zGIhKbuPhBn9FkHGw=;
        b=iiu2XouQt24EJU+hiUEU/0NyzNAUNdsITj+201RlCqF9gmV0xU9An+QM95NGGslqb5
         OeN/XJqRBeuG4wt0juHdp9NOiiVUJy6bdNv/YFxI7WlScK0f4j3K2l3RLEOTD7w/tnpF
         RD4X0O/XmU3aaJf4oHluH6PoI15dZxwpb8k6+doNg+BKCjcQbYvrix1ycW819IOPm0jC
         o0tTOIIKJHyVO+dJYilTRh1UfYzErCJb5Xeg6wKPeQk8CayTGHisADHvlrMXGHPaEEPK
         xu1xHD8XeVGuMRwLYxSesObBfkf79nCDTeBcg34XboPwIbOTrICl3szbfVHe/OHPd57K
         sE8A==
X-Gm-Message-State: APjAAAXFsub1ywVbgA5vup0s9OfP992WHLHfBff3IXp1HVdFD8Oqaurn
        j1ZDDYZdJfOaj3+ElY22Uek=
X-Google-Smtp-Source: APXvYqzoS5NZfY4uzNYMLUwPdRaMGFMs4hno8GGWvZRxmO8uxDQoW1phrCdIatlbAUalPUoE5Z4JMA==
X-Received: by 2002:a17:902:e48f:: with SMTP id cj15mr35428293plb.256.1554799407193;
        Tue, 09 Apr 2019 01:43:27 -0700 (PDT)
Received: from kylelin.ntc.corp.google.com ([2401:fa00:fc:202:1de:dcda:8c06:f21f])
        by smtp.gmail.com with ESMTPSA id 143sm66371507pge.50.2019.04.09.01.43.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 01:43:26 -0700 (PDT)
From:   Kyle Lin <linkyle0915@gmail.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linkyle0915@gmail.com
Subject: [PATCH v2] cpufreq: stats: Use lock by stat to replace global spin lock
Date:   Tue,  9 Apr 2019 16:43:04 +0800
Message-Id: <20190409084304.35855-1-linkyle0915@gmail.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stats is updated by each policy, using the lock by stat can
reduce the contention.

Signed-off-by: Kyle Lin <linkyle0915@gmail.com>
---
Changes in v2:
  - Drop the comment of the lock.

 drivers/cpufreq/cpufreq_stats.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index e2db5581489a..08b192eb22c6 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 
-static DEFINE_SPINLOCK(cpufreq_stats_lock);
 
 struct cpufreq_stats {
 	unsigned int total_trans;
@@ -23,6 +22,7 @@ struct cpufreq_stats {
 	unsigned int state_num;
 	unsigned int last_index;
 	u64 *time_in_state;
+	spinlock_t lock;
 	unsigned int *freq_table;
 	unsigned int *trans_table;
 };
@@ -39,12 +39,12 @@ static void cpufreq_stats_clear_table(struct cpufreq_stats *stats)
 {
 	unsigned int count = stats->max_state;
 
-	spin_lock(&cpufreq_stats_lock);
+	spin_lock(&stats->lock);
 	memset(stats->time_in_state, 0, count * sizeof(u64));
 	memset(stats->trans_table, 0, count * count * sizeof(int));
 	stats->last_time = get_jiffies_64();
 	stats->total_trans = 0;
-	spin_unlock(&cpufreq_stats_lock);
+	spin_unlock(&stats->lock);
 }
 
 static ssize_t show_total_trans(struct cpufreq_policy *policy, char *buf)
@@ -62,9 +62,9 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
 	if (policy->fast_switch_enabled)
 		return 0;
 
-	spin_lock(&cpufreq_stats_lock);
+	spin_lock(&stats->lock);
 	cpufreq_stats_update(stats);
-	spin_unlock(&cpufreq_stats_lock);
+	spin_unlock(&stats->lock);
 
 	for (i = 0; i < stats->state_num; i++) {
 		len += sprintf(buf + len, "%u %llu\n", stats->freq_table[i],
@@ -211,6 +211,7 @@ void cpufreq_stats_create_table(struct cpufreq_policy *policy)
 	stats->state_num = i;
 	stats->last_time = get_jiffies_64();
 	stats->last_index = freq_table_get_index(stats, policy->cur);
+	spin_lock_init(&stats->lock);
 
 	policy->stats = stats;
 	ret = sysfs_create_group(&policy->kobj, &stats_attr_group);
@@ -242,11 +243,11 @@ void cpufreq_stats_record_transition(struct cpufreq_policy *policy,
 	if (old_index == -1 || new_index == -1 || old_index == new_index)
 		return;
 
-	spin_lock(&cpufreq_stats_lock);
+	spin_lock(&stats->lock);
 	cpufreq_stats_update(stats);
 
 	stats->last_index = new_index;
 	stats->trans_table[old_index * stats->max_state + new_index]++;
 	stats->total_trans++;
-	spin_unlock(&cpufreq_stats_lock);
+	spin_unlock(&stats->lock);
 }
-- 
2.21.0.392.gf8f6787159e-goog

