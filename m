Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AEAC4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 00:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E0820673
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 00:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QlmjQZ7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfJNA6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 20:58:33 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41867 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729180AbfJNA6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 20:58:32 -0400
Received: by mail-qt1-f196.google.com with SMTP id v52so23099312qtb.8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 17:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v7XQBgeFPFA2xqVRlaqSBquWqwtCCnMp9HH9en37v0E=;
        b=QlmjQZ7HKxGaLUk/fj8Q3XI/TMgE8Zspiynbr6H7molbqqHaYYCH21ecEeCaCxfygE
         iQv3D8Ihn2Sq+RlbtVsVSfCBAr+2o3sphD1etCCJifKLgXOczG1SaIp5+70IpI5FMOuT
         L3IPZvzh2J+qBbBTFLno5LYJ+leaaDJrUyNo8z06ztncQQRE1ps0d9kNAtAtYMvQS6zk
         hYaodwXye+WFFbR93obrGVMLMahq42tdXNK+TNtku3wDREgEkNVKZTPqrukiqsKn0YBa
         0fNwvUocRA292ROuxoGwP68cR0694Nwn6XFwjiVB5fPg8GKCXz86McnHYNH1SMiUqj/H
         UBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v7XQBgeFPFA2xqVRlaqSBquWqwtCCnMp9HH9en37v0E=;
        b=nS00n9YXcyf8nWzKfUd5VnihKQcRoTCJInOHsbbPKY5tPcISVuSSOHStSFzlLFR8nx
         ecfjwJU60rXfYvAhAuZc5UpSPv5VOzc3uG34yQSXTuCO2UNa9F36Ieq06vN2pqyYcYzK
         JpY/i0x1LKu3wvQ5jniDx2oGG+jlvCVpYzEvQLfiA22DZf0IfF1J0KCePXkUgjR1Qeld
         2HzD/CVnQjWFaxc+NDCtYSDNJtgfgBowd/Irt/pLfNz9PLVgRfCD4+OcIRuZiA5QS/Cx
         Xte8/o+/O+0OoFpWo6phuVC8Cc3EjSQyED5aYh+pFYGjyedgruywX0ZV1XAMVQwPQP4u
         T05A==
X-Gm-Message-State: APjAAAVmiurjEZlsc1e/9n59CDXM06EJWRyK7KPN6M93w4D1E2O9ah6O
        mOK/zhaWnwOzzxQ25S+fn9mF8g==
X-Google-Smtp-Source: APXvYqwSDQ7ulLV98NqvdhrcnekuCSCaij9Z9MnqdfrYhj15Gm7h9dItr+KABU5Egn9RRVE04uNZdA==
X-Received: by 2002:ac8:7447:: with SMTP id h7mr30179050qtr.11.1571014711319;
        Sun, 13 Oct 2019 17:58:31 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id c185sm7663901qkf.122.2019.10.13.17.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Oct 2019 17:58:30 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: [Patch v3 3/7] sched: Initialize per cpu thermal pressure structure
Date:   Sun, 13 Oct 2019 20:58:21 -0400
Message-Id: <1571014705-19646-4-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1571014705-19646-1-git-send-email-thara.gopinath@linaro.org>
References: <1571014705-19646-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize per cpu max_capacity_info during scheduler init.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/base/arch_topology.c | 1 +
 kernel/sched/core.c          | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1eb81f11..7ac9f2f 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -123,6 +123,7 @@ void topology_normalize_cpu_scale(void)
 		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
 			cpu, topology_get_cpu_scale(cpu));
 	}
+	populate_max_capacity_info();
 }
 
 bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7880f4f..744f026 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6534,6 +6534,8 @@ void __init sched_init_smp(void)
 	init_sched_rt_class();
 	init_sched_dl_class();
 
+	populate_max_capacity_info();
+
 	sched_smp_initialized = true;
 }
 
-- 
2.1.4

