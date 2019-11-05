Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22689C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 18:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE89621882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 18:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fy5bE7t9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390829AbfKESt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 13:49:56 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38411 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390813AbfKESty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 13:49:54 -0500
Received: by mail-qk1-f194.google.com with SMTP id e2so22138244qkn.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 10:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CdRdyYtCwsA++AMEix7betRB8SrDMfU5EHHNK7KWNOQ=;
        b=fy5bE7t9ATgU8+i9GK9xokBHTF6uuDjJlM/lV6EfNTFyMxa3Uq2ybhKNeWFBvr+Wah
         7FDsjBEMqE2RhsL08x7wrmIeAVYlhp9MBctEW93FbdU2hPIvL27CMWE6Q5tjq1uwUPF+
         REzgCZ1kmRLRxjB/z2Bn9HHYThkP5adqWMYfnakhGXSnzfl40swpthivf3y3cp+X6jIq
         ffbMdRSUzIsLm0IYqCAr9aoa36mBtr9p+/lWWiLX6DjMCw6eRHcj+5dpnuDSONP2Lyhy
         g6aICWCCkW1otiiQ4H4DyhnCaaHsDNOwND3HfFj/gLfymWcSBrt+BYfIwmSDdzkabY8H
         AoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CdRdyYtCwsA++AMEix7betRB8SrDMfU5EHHNK7KWNOQ=;
        b=DBBJCY78qYhUEDzd+4iTt9QMZc9re4Q42r/CJW5ppKnwKv1eEiIknI1Hl5gJAtP7lF
         jxHgAcJfLqg1PwFtWqsKb0Mp1+3xOnlcHl4gHlVA2ec/avqpsDF9vTQJIfi5yqrBO0sF
         296U+iRL9CfhKy3D+fM36Cv1zLgpEx3vK5pPZ0qdh7AglKheZWX6dW1+absg1tdU0YgQ
         UJTMP6Kxi1vybxQVJb/bRo5WNCTQZPtZlsxMqKBxk8VCdTIGA9q+EH7v+YsDcnkMV2cV
         vBUZIG21SwxCAaTXbsz2JhxnA8jFa3qXn2vJK/x6toW7XwawKbIl95S+NZuH4V0uKonM
         eutw==
X-Gm-Message-State: APjAAAU7SeRPmfowV2U94OQYeJ/RqhpFf52SFBdOdo0IFZgxzm5sOQxY
        xI+O8RD00DV4cAt5iw1TcD3tPQ==
X-Google-Smtp-Source: APXvYqwru4wXDG62DF3qjZ0KdLIchP3NC6xSP20Tev4TIEbgWuZCo9IiUwCNoULUKCCrHtug44uwBw==
X-Received: by 2002:a37:6704:: with SMTP id b4mr22831264qkc.23.1572979793405;
        Tue, 05 Nov 2019 10:49:53 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id j7sm6832565qkd.46.2019.11.05.10.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Nov 2019 10:49:52 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: [Patch v5 4/6] sched/fair: update cpu_capcity to reflect thermal pressure
Date:   Tue,  5 Nov 2019 13:49:44 -0500
Message-Id: <1572979786-20361-5-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_capacity relflects the maximum available capacity of a cpu. Thermal
pressure on a cpu means this maximum available capacity is reduced. This
patch reduces the average thermal pressure for a cpu from its maximum
available capacity so that cpu_capacity reflects the actual
available capacity.

Other signals that are deducted from cpu_capacity to reflect the actual
capacity available are rt and dl util_avg. util_avg tracks a binary signal
and uses the weights 1024 and 0. Whereas thermal pressure is tracked
using load_avg. load_avg uses the actual "delta" capacity as the weight.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 kernel/sched/fair.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9fb0494..5f6c371 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7738,6 +7738,7 @@ static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
 
 	used = READ_ONCE(rq->avg_rt.util_avg);
 	used += READ_ONCE(rq->avg_dl.util_avg);
+	used += READ_ONCE(rq->avg_thermal.load_avg);
 
 	if (unlikely(used >= max))
 		return 1;
-- 
2.1.4

