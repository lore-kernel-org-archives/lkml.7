Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB07CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF79821848
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LOTbe5dQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389456AbfJVUej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 16:34:39 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36324 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389421AbfJVUef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 16:34:35 -0400
Received: by mail-qt1-f194.google.com with SMTP id d17so14263884qto.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 13:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=701bwJkgXICGE6R4e0XJPVYqMBI43tK0euoxsDFO4As=;
        b=LOTbe5dQz9HElq6SSgUYDkeqOyhYlUEiZ3yK9hgo3Hg7ydcyVa1JFpNTOmE5UWnMM/
         98edzR1GiBVZGxYZEWj5XIcdz6Oz2zipi3YWH95sZZcJFoBcomKv74qT8P7vTiLnt4uU
         oTiGKRusAka7VAY2NosSr1SKyC6rmtpEHAEBlDLNSd47Q5laK7aJXxg1M/l3jm51Aw4b
         RcvajLgnaHQqN76OJWTuIL+DUP7arPj1p3BZJpUOSUBWJVvEC/4YoFo5OYcJFn8UbJVm
         rNOdg0CV8CjuI5PRvNg6jUcQXcWPHOvpjXUT+i12cKTzKbkLMQ/S6dDXPDGURzU6zzk0
         snnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=701bwJkgXICGE6R4e0XJPVYqMBI43tK0euoxsDFO4As=;
        b=Q6yxIpWViLTEsXB36nGFGGuFVs+DVc9aNlYzGelN4GT8jM5G8YV4JxoM542VmWwM9s
         9p3FthBdQvXWBXPh+FV3A6izUJF19fy3Z+fIsxKpPOK8zShSrLiqZF5YAQDpBfVCtehy
         60D6NHZ2FRoICOmalk7aPAS5PuN+aSwG15l/6xwqHxItjXJbcn7H57glkM97rwhhdQ6a
         s3wrjaVkbpHfAlu4391a9EwkLxCfhQKLgmTU3/1IEvyj3U+z/6HK8cpPdNsxPCrQM/XP
         dqudXI4Is/qmpqCpq1+QLNmRKqq0GBgXsz8Td8liUQ1dWDiXXPMML975YKgoOmE/Dhkp
         KYJQ==
X-Gm-Message-State: APjAAAXcrn5yAVFTAM+qMpQw4hjZj1GqxxDXRzjwzkCMnNqRAzoolBH+
        nUGXLgIG6UkhJQkQV2V0ssQ7dw==
X-Google-Smtp-Source: APXvYqzrHS5+s1s6grnuJFaCPRRlYr11mb6Qdyx1esnaPCgUqVAcc1LI8Hf98NQdDpcPN0DR3BGxQA==
X-Received: by 2002:a0c:e6e5:: with SMTP id m5mr5091013qvn.170.1571776474076;
        Tue, 22 Oct 2019 13:34:34 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id r126sm8895038qke.98.2019.10.22.13.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Oct 2019 13:34:33 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: [Patch v4 4/6] sched/fair: update cpu_capcity to reflect thermal pressure
Date:   Tue, 22 Oct 2019 16:34:23 -0400
Message-Id: <1571776465-29763-5-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_capacity relflects the maximum available capacity of a cpu. Thermal
pressure on a cpu means this maximum available capacity is reduced. This
patch reduces the average thermal pressure for a cpu from its maximum
available capacity so that cpu_capacity reflects the actual
available capacity.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 kernel/sched/fair.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4f9c2cb..be3e802 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7727,6 +7727,7 @@ static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
 
 	used = READ_ONCE(rq->avg_rt.util_avg);
 	used += READ_ONCE(rq->avg_dl.util_avg);
+	used += READ_ONCE(rq->avg_thermal.load_avg);
 
 	if (unlikely(used >= max))
 		return 1;
-- 
2.1.4

