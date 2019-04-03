Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F369C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675D021473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfDCIrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:47:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33264 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbfDCIrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:47:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so20198420wrp.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 01:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L4zmx41iw1KumQPxCRIW2sBgEknaPog+5Lq3b2W35Co=;
        b=bG9Uwj+1FfBsIqpsxmdGk51NbXKd2GTpsSYNsaAdKMnomW1y4zTYZuQW96CYo31uhb
         wgxce7GeR1PZwXRGR2ymtv2kpb5RqKykyNB1BFlexqwhImyqL+AzJIQ03r09biQB7YvF
         pjs2feytpg9K0BwQJq9kcQJ43GMyPKiXxs57JS06KCZ40HWEjeMy2YdQ9C4IrdcfB7I4
         PDjKYbLbSdz1FLXMeARjdCW0rbbmK4gernkfi/uxx2RZA1LI8Gcwn69xf5VgYDMkJ/I8
         98f1w5LjaV95seSoMEDwlvm0DZbAJB7SwIICPXydg3KCPare8gylb7QVGOrMqfpIwTny
         iv1w==
X-Gm-Message-State: APjAAAWpBYcqup/7qhcX018YwQ85Mb6KQ8ZY+DHTYJghGrqP1u9IWuU/
        YgB46449CcdSlnn3ubChadEIpw==
X-Google-Smtp-Source: APXvYqx2sqF1ALjK/4/RFVRSIYr52LB+RLoqBwSCqlpWsa481F6FNXJjbxQhUIq3KclPkg/rx2xVqg==
X-Received: by 2002:adf:b6a4:: with SMTP id j36mr27046494wre.55.1554281231568;
        Wed, 03 Apr 2019 01:47:11 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.174.33])
        by smtp.gmail.com with ESMTPSA id o2sm12258081wrs.89.2019.04.03.01.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 01:47:10 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: [PATCH v7 1/7] sched/topology: Adding function partition_sched_domains_locked()
Date:   Wed,  3 Apr 2019 10:46:44 +0200
Message-Id: <20190403084650.4414-2-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190403084650.4414-1-juri.lelli@redhat.com>
References: <20190403084650.4414-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Introducing function partition_sched_domains_locked() by taking
the mutex locking code out of the original function.  That way
the work done by partition_sched_domains_locked() can be reused
without dropping the mutex lock.

No change of functionality is introduced by this patch.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/topology.h | 10 ++++++++++
 kernel/sched/topology.c        | 17 +++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 57c7ed3fe465..e7db602e898c 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -161,6 +161,10 @@ static inline struct cpumask *sched_domain_span(struct sched_domain *sd)
 	return to_cpumask(sd->span);
 }
 
+extern void partition_sched_domains_locked(int ndoms_new,
+					   cpumask_var_t doms_new[],
+					   struct sched_domain_attr *dattr_new);
+
 extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 				    struct sched_domain_attr *dattr_new);
 
@@ -213,6 +217,12 @@ unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
 
 struct sched_domain_attr;
 
+static inline void
+partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
+			       struct sched_domain_attr *dattr_new)
+{
+}
+
 static inline void
 partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 			struct sched_domain_attr *dattr_new)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index ab7f371a3a17..b63ac11d0831 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2154,16 +2154,16 @@ static int dattrs_equal(struct sched_domain_attr *cur, int idx_cur,
  * ndoms_new == 0 is a special case for destroying existing domains,
  * and it will not create the default domain.
  *
- * Call with hotplug lock held
+ * Call with hotplug lock and sched_domains_mutex held
  */
-void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
-			     struct sched_domain_attr *dattr_new)
+void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
+				    struct sched_domain_attr *dattr_new)
 {
 	bool __maybe_unused has_eas = false;
 	int i, j, n;
 	int new_topology;
 
-	mutex_lock(&sched_domains_mutex);
+	lockdep_assert_held(&sched_domains_mutex);
 
 	/* Always unregister in case we don't destroy any domains: */
 	unregister_sched_domain_sysctl();
@@ -2246,6 +2246,15 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 	ndoms_cur = ndoms_new;
 
 	register_sched_domain_sysctl();
+}
 
+/*
+ * Call with hotplug lock held
+ */
+void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
+			     struct sched_domain_attr *dattr_new)
+{
+	mutex_lock(&sched_domains_mutex);
+	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
 	mutex_unlock(&sched_domains_mutex);
 }
-- 
2.17.2

