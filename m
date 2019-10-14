Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A347C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 00:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621DD2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 00:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sGu/fE49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbfJNA6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 20:58:36 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41868 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729755AbfJNA6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 20:58:34 -0400
Received: by mail-qt1-f194.google.com with SMTP id v52so23099416qtb.8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 17:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O3q+7yGZl2chLLPUpezQ1APj0BawGHMOVtLNFWKxjdQ=;
        b=sGu/fE49gKyoicIdmc+SvTZvUPm5tvfqbr3kTEypxNdupK5o9nrTkoCNKbZyyfDYKD
         7zCSi1Wncjkk90GTtZRvVJWyV2+hHS/r5WCpRoJNKoZhvrBDQlJ392xhw6+Tt4ihP/t+
         i4lILG6nsR9FUK1Pa9QN08bT5xX0ZQJPdWv8MEgNFHqu3W/f4Sky0M6hHjPgtCFqVfOt
         GjtK1h3myOd09NZJGMABRoqhG+0xs0EbeuEUrbpsQ1HwdoZK5ngky8FPVzu/9smWxKPo
         vzghjqJW0GQtgr3InovmLxEzj/PKZrRkra84LnlHq5QIT6xtciefugtgcoO373q0QFKh
         0k/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O3q+7yGZl2chLLPUpezQ1APj0BawGHMOVtLNFWKxjdQ=;
        b=n+xtsdJoAnw39OYiKZE59/wGJmHoxtH9KXdYAwG8b1Iea71dkravcaGfuhH19AIMyJ
         GlnXw9t0zVJvV7dBjUXfQ+nD0r7sXdf9Lg5D5T37CHPv9qOwMnCj2WVNCaQmxbyv6d2E
         DpZ1+CMOhFNhyoPgLSgf7eJiKTuUwtxHJ9NT7xXtvsw7+NqgeOFukuXciHFScrK5a+6J
         ftxVfoFqCy7/4E6g3SSDMLHrTFDZ2sYG3wyfhSsW3sst+UPHLv3prIV4QqasogFpHc1v
         XxghnBMRdOy/3tBPpnwupRs9EDVYO78qt68oK6mznm9bdIfn/n5AGuT1K5ilvss8RgHH
         qwqA==
X-Gm-Message-State: APjAAAVC/OrDUl4+cqbY7hH8ui+W31ydKKPE4RflCaGVQikqF0IXyyax
        4sLiY8+SCjow2BE3NIXx5ireFw==
X-Google-Smtp-Source: APXvYqwkWSqajQMnhIBFOgvFuIfpQ98r7JTVJszABErKmBGiSoN1emoPmZFTqDauc5x1XXgQ1OrtdA==
X-Received: by 2002:ac8:740b:: with SMTP id p11mr29727737qtq.71.1571014713876;
        Sun, 13 Oct 2019 17:58:33 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id c185sm7663901qkf.122.2019.10.13.17.58.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Oct 2019 17:58:33 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: [Patch v3 5/7] sched/fair: update cpu_capcity to reflect thermal pressure
Date:   Sun, 13 Oct 2019 20:58:23 -0400
Message-Id: <1571014705-19646-6-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1571014705-19646-1-git-send-email-thara.gopinath@linaro.org>
References: <1571014705-19646-1-git-send-email-thara.gopinath@linaro.org>
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
index fe7c165..cbc2208 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7719,6 +7719,7 @@ static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
 
 	used = READ_ONCE(rq->avg_rt.util_avg);
 	used += READ_ONCE(rq->avg_dl.util_avg);
+	used += READ_ONCE(rq->avg_thermal.load_avg);
 
 	if (unlikely(used >= max))
 		return 1;
-- 
2.1.4

