Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196F1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D642A2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OhJKZ8Hz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfCNGnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:43:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37503 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfCNGnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:43:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id s22so3190438pfh.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 23:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M1KeKtW8OOVXttXpveVwFNNHfJ6vG6L+djJBTEnEfMQ=;
        b=OhJKZ8HzWWRt15fJOKm9vDrXq5pNgxk/2d97kSc8oig307pQ4dcZkd47hI1qZ6pt5z
         v16ywi7oEG6oCruVyYuvu1JUXRudMVjyhDmFWNGW6e5A7cenWOUwpXkI5hpy3YyRE5d5
         ipFkGOXp32rRG2dHIfRrUfGCXvtsUfz0+orK2ZjEX6Wznrhf35QxKxA7amrNMbzG+m8Y
         LlTON707sSV+KWwjX4KEzLJgBjhS5NWrgZYk/eWrY/MpLPKT5uSzXauWt2a3wiFne9O3
         cKbr5eA9ozMiFoKK7v7X08x/mjG7txnmNKEWzzB6t12/qbDn1iHyEGnDzXPJ0QNylBTy
         sZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M1KeKtW8OOVXttXpveVwFNNHfJ6vG6L+djJBTEnEfMQ=;
        b=L30vxdNX+dH6gaB9dG2HTxEFajCBYjn6d9X5au0DJ9d64j/TYZzr4ZxnqXra4L+8wB
         BGX51LslUL4NkGwklKM6mv9DNiHVnzx4JPWk+i9XWCmIZ1xXJFqZSqlQ0zuKQ9qz6Kb/
         G5q5Z/CkHK2aYRgye5ikZjKN666xTrIbvDD6aRNUSR5dpcJryi97KnJ437zgdpkTxa7p
         EXvikKPvz3qsTGdedeQxSMT1P+mZ7tzp9DDtP+o1c6Pyj12Dk1eNRcBFgRQFD1EinCYt
         wtR8uDocLlrfwuogoI+K9/2QGIoxrVnziQzCi0msBIwDZzLAHTIxeR1+pWdyFCuqK62A
         NAQw==
X-Gm-Message-State: APjAAAVVThVDuyDIJxZszV8caGolaK90jbJWTwVlN/46dV6UpF1ecKCN
        rpkaRX3AYE6dQ8acnPc1f8s8EQ==
X-Google-Smtp-Source: APXvYqzgsU3FhJj9RuxQvquxeRllvuxwBkieDM506usxEyliXvho0Rv6+WQuDmM8xfEnMu6FaytRQQ==
X-Received: by 2002:a17:902:20e3:: with SMTP id v32mr49723750plg.213.1552545799616;
        Wed, 13 Mar 2019 23:43:19 -0700 (PDT)
Received: from localhost ([122.166.134.37])
        by smtp.gmail.com with ESMTPSA id 10sm4532975pft.83.2019.03.13.23.43.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 23:43:18 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] cpufreq: Pass policy->related_cpus to transition notifiers
Date:   Thu, 14 Mar 2019 12:12:47 +0530
Message-Id: <3b6663b03fe837615ba608aff50b4b2a27ab2ab3.1552545525.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1552545525.git.viresh.kumar@linaro.org>
References: <cover.1552545525.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we call these notifiers once for each CPU of the policy->cpus
cpumask, which isn't that efficient.

This patch adds a cpumask pointer to struct cpufreq_freqs and copies
policy->related_cpus to it. The notifiers will have information about
all the affected CPUs now with the first call itself and once all the
notifier callbacks are updated to use the new field, we can remove the
"cpu" field from struct cpufreq_freqs and call the notifier only once
per policy.

Some of the transition notifier users use per-cpu data to read and store
their data and they rely on it being correct. With CPU offline/online
sequences we may end up with using stale data for those CPUs (which are
offlined/onlined). In order to avoid such corner cases, this patch uses
policy->related_cpus instead of policy->cpus.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 1 +
 include/linux/cpufreq.h   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0e626b00053b..b1b012169f00 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -311,6 +311,7 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
 	if (cpufreq_disabled())
 		return;
 
+	freqs->cpus = policy->related_cpus;
 	freqs->flags = cpufreq_driver->flags;
 	pr_debug("notification %u of frequency transition to %u kHz\n",
 		 state, freqs->new);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index b160e98076e3..dd318363dfc2 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -43,6 +43,7 @@ enum cpufreq_table_sorting {
 };
 
 struct cpufreq_freqs {
+	struct cpumask *cpus;
 	unsigned int cpu;	/* cpu nr */
 	unsigned int old;
 	unsigned int new;
-- 
2.21.0.rc0.269.g1a574e7a288b

