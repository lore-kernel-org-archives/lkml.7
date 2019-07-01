Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A823BC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFD8216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K49Wiqd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbfGAPjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 11:39:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40033 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbfGAPjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 11:39:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id p11so14384259wre.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 08:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=SIA/BH+2QfVgtLDV+7t8/NDCiCsFsJMI64czIqxEO2w=;
        b=K49Wiqd5PUgHUnpgeJrSUWKnZWne1SYdlv8UTUrB/dHAp/tP9ZRDPLTiM0rq/vGqX6
         VT7cpdX4uIFtrOQ6N3dSZDizmV4o4myEqF0SAaDXy6YFMcNOIuZUCpXs2AuSsDEBc69o
         5Ngr+ZortMt4UwpsJNanskDTGEz7tA4Oy5hUVfKVl/VGrrDbpMdEMUYnutfgfRd9uDUh
         oOp17VPIiAWhKLY+9AenwZxlVB7iDhSU65uffbqAEnG9ccOvuuc59TIohfB/RcoRKCI1
         1G2eaG1B8CWrsw0kKKmToCPLlTBOCpo13aIbNCVsyH8doDCxaRwkgct76G+mawqlSGlS
         lRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SIA/BH+2QfVgtLDV+7t8/NDCiCsFsJMI64czIqxEO2w=;
        b=Wsspw/P/i7Seo0uA/OPbL5DwQ9g6WzkcwX3ZjB+MxlsHjMYZ735VtSLENypW+EtE+q
         CPDV2yMJEkabdNUeHSq6aIxDMeMmCuX8Gb3rdEPIJdTnEWtUyQNig/211NyuxU55cR3X
         ++IlEnedzJx7ogxv8l2xPBYnZX5uQVQbgcIJc9J+wnjN9drXCNHVMZ5alPWN3jfKZ5uY
         joG4JlQhPJs6WF04x4wySNAEry2FpCi49ant7PUqXkwlS16pj51ll6MMyYYbBdUJJQ7g
         nXyyvnWyuBm6+IYeDsLeFXRBkhM5KWB4aQbC8LJ/bWwnfsO/lChlSEzkyPqgn3pAs4Fi
         ivzA==
X-Gm-Message-State: APjAAAWEpSByBrBxkhw2hW6sznXSFFvBhwajLeo/HaSo8icf/0I8GgD8
        6pLsvdRrfs0t4GPHc8hzsomO4/PqA0c=
X-Google-Smtp-Source: APXvYqwxkJwm85fDFcipOSSH+LKug1DleOVsJbVq2T3v5lBgx12YuLy1ymqM4SMYSojs+a2Yuz5W3g==
X-Received: by 2002:adf:dfc4:: with SMTP id q4mr19122183wrn.54.1561995574117;
        Mon, 01 Jul 2019 08:39:34 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:5dbd:30b:8a71:a020])
        by smtp.gmail.com with ESMTPSA id w25sm6292276wmk.18.2019.07.01.08.39.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jul 2019 08:39:33 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: fix imbalance due to CPU affinity
Date:   Mon,  1 Jul 2019 17:39:26 +0200
Message-Id: <1561995566-27200-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The load_balance() has a dedicated mecanism to detect when an imbalance
is due to CPU affinity and must be handled at parent level. In this case,
the imbalance field of the parent's sched_group is set.

The description of sg_imbalanced() gives a typical example of two groups
of 4 CPUs each and 4 tasks each with a cpumask covering 1 CPU of the first
group and 3 CPUs of the second group. Something like:

	{ 0 1 2 3 } { 4 5 6 7 }
	        *     * * *

But the load_balance fails to fix this UC on my octo cores system
made of 2 clusters of quad cores.

Whereas the load_balance is able to detect that the imbalanced is due to
CPU affinity, it fails to fix it because the imbalance field is cleared
before letting parent level a chance to run. In fact, when the imbalance is
detected, the load_balance reruns without the CPU with pinned tasks. But
there is no other running tasks in the situation described above and
everything looks balanced this time so the imbalance field is immediately
cleared.

The imbalance field should not be cleared if there is no other task to move
when the imbalance is detected.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

 kernel/sched/fair.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9f9dcb1..bd94171 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9032,9 +9032,10 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 out_balanced:
 	/*
 	 * We reach balance although we may have faced some affinity
-	 * constraints. Clear the imbalance flag if it was set.
+	 * constraints. Clear the imbalance flag only if other tasks get
+	 * a chance to move and fix the imbalance.
 	 */
-	if (sd_parent) {
+	if (sd_parent && !(env.flags & LBF_ALL_PINNED)) {
 		int *group_imbalance = &sd_parent->groups->sgc->imbalance;
 
 		if (*group_imbalance)
-- 
2.7.4

