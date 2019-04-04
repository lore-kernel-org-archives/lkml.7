Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02CEC10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1532082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnQYH3Fp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbfDDMHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:07:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37876 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbfDDMH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:07:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id w23so1083760ply.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 05:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NeCXpCQGSR/WJnmc/NCsndys1QMDvR2xvxuQWshOjdo=;
        b=QnQYH3Fpi/3tByGmlnA6IiMF1vW2WjW9WkCguur8lv9NvT9pSj+MHOlAeE4xRRaYC3
         MiCYRBvzbBMABwEwWZstokavSzO3N1fKxe/Zme94bxF5hz8m9Q6x8IR99JVwTQb3VHRH
         ONKgvFP3wpvL5kTCzg1hXRNiKXG92jvdDDx5nPXzUghtV6qakYqaN8Ok/gDZ7rM1Xz6b
         g6wtjWPyRBmsd0HBwWDQLTu9VwQ3YtRn5yK8Ac/k3KpgSyYZRdaDhlkzrdSP8mUwtsi2
         Y7FuUYnzHKqhudtHq8du6BB+J6IMmZVkQdpkGKgbUfVlLQ1dMZi7DWV1z4n7XSDwZxMe
         CyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NeCXpCQGSR/WJnmc/NCsndys1QMDvR2xvxuQWshOjdo=;
        b=V439Lt7pz7CsRis/eq2W1R2w5/Kck5y/B7xA2V1BgXZcQZT8xBqaPmOUSZx3cRBbLm
         9bakYXyLcYZYbs0CUzRTPxQxUXN2+cixBPRnLV44G4WE91+hwwCmbneceQtudKcI2tKO
         VNrsOzsLW7LX22mILuQgkuzVRd/l6ZAs2+vuYEkMxWEoUg0OkIuRBQu6NINEjjFHrPFW
         FKrec5SANgVrc+uCUOt+6isp7yTY2Q5w18lRgM74dH9ENmd+smIWqAtA+mSBJJ4vnnN6
         T5qqTHVAlrJcgesjJHnN9MpzTWpCUZjXNW+JkGSA16I9PHFgnOuid0necNvXH6xUWR1W
         C80g==
X-Gm-Message-State: APjAAAU89f25mqM/5Z2NOAuAoaU7Y8e+0FaoaahxGpoTxy4rAyPS9Kp1
        CZbwnWDKY9/4gXLL92fqu14=
X-Google-Smtp-Source: APXvYqyJy8zaj+nEhCKID5i8/U4z2BANdPurm3OSRkdARg2X5b19+4Ls8zZYTJny+obHfFsNnhhs4w==
X-Received: by 2002:a17:902:8d83:: with SMTP id v3mr5872558plo.283.1554379646791;
        Thu, 04 Apr 2019 05:07:26 -0700 (PDT)
Received: from bobo.local0.net (193-116-89-42.tpgi.com.au. [193.116.89.42])
        by smtp.gmail.com with ESMTPSA id j22sm24720668pfn.129.2019.04.04.05.07.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 05:07:26 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] kernel/sched/isolation: require a present CPU in housekeeping mask
Date:   Thu,  4 Apr 2019 22:07:03 +1000
Message-Id: <20190404120704.18479-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190404120704.18479-1-npiggin@gmail.com>
References: <20190404120704.18479-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During housekeeping mask setup, currently a possible CPU is required.
That does not guarantee a CPU at boot time, so check to ensure that
at least one present CPU is in the mask.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/sched/isolation.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index b02d148e7672..687302051a27 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -65,6 +65,7 @@ void __init housekeeping_init(void)
 static int __init housekeeping_setup(char *str, enum hk_flags flags)
 {
 	cpumask_var_t non_housekeeping_mask;
+	cpumask_var_t tmp;
 	int err;
 
 	alloc_bootmem_cpumask_var(&non_housekeeping_mask);
@@ -75,16 +76,23 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
 		return 0;
 	}
 
+	alloc_bootmem_cpumask_var(&tmp);
 	if (!housekeeping_flags) {
 		alloc_bootmem_cpumask_var(&housekeeping_mask);
 		cpumask_andnot(housekeeping_mask,
 			       cpu_possible_mask, non_housekeeping_mask);
-		if (cpumask_empty(housekeeping_mask))
+
+		cpumask_andnot(tmp, cpu_present_mask, non_housekeeping_mask);
+		if (cpumask_empty(tmp)) {
+			pr_warn("Housekeeping: must include one present CPU, "
+				"using boot CPU:%d\n", smp_processor_id());
 			__cpumask_set_cpu(smp_processor_id(), housekeeping_mask);
+			__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
+		}
 	} else {
-		cpumask_var_t tmp;
-
-		alloc_bootmem_cpumask_var(&tmp);
+		cpumask_andnot(tmp, cpu_present_mask, non_housekeeping_mask);
+		if (cpumask_empty(tmp))
+			__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
 		cpumask_andnot(tmp, cpu_possible_mask, non_housekeeping_mask);
 		if (!cpumask_equal(tmp, housekeeping_mask)) {
 			pr_warn("Housekeeping: nohz_full= must match isolcpus=\n");
@@ -92,8 +100,8 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
 			free_bootmem_cpumask_var(non_housekeeping_mask);
 			return 0;
 		}
-		free_bootmem_cpumask_var(tmp);
 	}
+	free_bootmem_cpumask_var(tmp);
 
 	if ((flags & HK_FLAG_TICK) && !(housekeeping_flags & HK_FLAG_TICK)) {
 		if (IS_ENABLED(CONFIG_NO_HZ_FULL)) {
-- 
2.20.1

