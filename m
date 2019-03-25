Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB74C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9A420854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqZLKAXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbfCYH3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:29:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41134 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729765AbfCYH3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 03:29:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id f6so1747694pgs.8;
        Mon, 25 Mar 2019 00:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mppXYDdo0x8nrhhJCS6a/6sWaeNY8HW6SMBNpCquLy0=;
        b=gqZLKAXklV5Jwh1nkpSO5i8pOE8gb+koUSI3bnZcZq/WFvNR0AAlyE54khM+4KPP5l
         emmOg/jdruBQe3jUj40U822VfLZhzKQfaXOmZn3VaLwPs31FDRqBPz5JpDjvkwoe7dRz
         r4LZ7D1hsR00zVw+Z1YcgFR/WYIb8Zq/02GB2UWi6CFqb2LZm8uEsqswODpcotjLJgQI
         Il+6ophiqVqTdKa7LgTFsY9GlUP8goZ9wK9BGaQchklZhn54mJUZyTa+SXAn6ux8iifV
         OJ6LCruHX0o+XKN2w2N2vKP1F9bxFyQ7IPVuVjaimXRM2KuUCWD38u/yQNp7s7JnvPjF
         1iNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mppXYDdo0x8nrhhJCS6a/6sWaeNY8HW6SMBNpCquLy0=;
        b=LBaCNB1rbg++S5LIfuvRvkC+PIXrEGUy+Pj12+d9olhf08CJgD+9Xa2QkArOJbR5oD
         9pSoMMFMUD5Yi9jNoYuAqJhNYdCML06egYDvZ8jOC8QcbA2zo7M0rrDq3h2IQ5x9frxr
         o9GB6a6QGZxgDQV8TQ64JzCyoDOeByFtbWwDIu+SEjRIH3OZAAuzKPQop7qKP6a9hmMv
         LC+jo5OmDxwv22Dh5RH/Yl63t/aLbaXoej1KeFgl7PddCfUFom2oiwkRN0tDSdbzo6I0
         FzDHDPXFaC3s5LLMXiEkWao4uilDwrBGPB8uplkw9g+ylEwEiMFTX9d240XDkjW2d8Ox
         ZeKQ==
X-Gm-Message-State: APjAAAURtX6kT0CbBCvDdnPjn4dLnYfBC11LUZ+pRITapaD8T+i7XHxX
        6RYbzLPqPCcRjkYCwxr11f5tO7EvDyI=
X-Google-Smtp-Source: APXvYqzY3IFFoVA6a2rXJgWEj55stfB/qPAE6eA3iYwVlnT+jAVKg6xnEPW0g8mmkypPV5Xnej4mJw==
X-Received: by 2002:a65:4344:: with SMTP id k4mr21608938pgq.20.1553498982431;
        Mon, 25 Mar 2019 00:29:42 -0700 (PDT)
Received: from kylelin.ntc.corp.google.com ([2401:fa00:fc:202:1de:dcda:8c06:f21f])
        by smtp.gmail.com with ESMTPSA id e184sm23383211pfc.143.2019.03.25.00.29.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 00:29:41 -0700 (PDT)
From:   Kyle Lin <linkyle0915@gmail.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linkyle0915@gmail.com
Subject: [PATCH] cpufreq: stats: Use lock by stat to replace global spin lock
Date:   Mon, 25 Mar 2019 15:29:33 +0800
Message-Id: <20190325072933.215946-1-linkyle0915@gmail.com>
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
 drivers/cpufreq/cpufreq_stats.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index e2db5581489a..17beb1bc7e16 100644
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
+	spinlock_t lock;        /*spinlock for stats update*/
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

