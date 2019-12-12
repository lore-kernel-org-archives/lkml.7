Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE64C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 04:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413B2222C4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 04:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ygf5rZfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfLLEMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 23:12:03 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44410 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbfLLEL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 23:11:58 -0500
Received: by mail-qk1-f193.google.com with SMTP id w127so505950qkb.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 20:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tCcvIBy4MWkmlTDlVDEp03XcYYwKUTHVbYQuzgTBX4Q=;
        b=Ygf5rZfKVmn/YQ2uNC2loIbKbXNMF6frWitGn6qeyZ917m19A5o1WHD6CnSKJhwXVt
         8vJSDHkWzbBLzSUKqGeWG/6Aj2oHGDxefkxkXVkehkoVlB450eAHBTvOpea/2kPVy+GZ
         DYZ/+YzXpJ9dkZrto/jov76v5xlJmHVFq3V8gL4JEmDItuwGbp6ciUpPbEYmKv5ClIEW
         VZxIaaIMoGHDL3ggjAp8iBjSDL1voIUDTrRtLWBZltJja++P/tdMancPKhXQuvsrmZNK
         bVKm6TGcLsB+E0qVJPb6q48wLx3VFmMq3ymvTXwDvSp6Upz7caAfnpiWP/pJgoCsxZG6
         MXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tCcvIBy4MWkmlTDlVDEp03XcYYwKUTHVbYQuzgTBX4Q=;
        b=GtrLTIj26qxOV0duR5HXYtZiKQJu9tqWit6tZoo4guzOxafzmRRW5/Dkg37Oe3gjIF
         pCzpcPoOfYfk/jWpDbyhOeQkADHmFhS9oMcw8/HcJCoxGp9/hr9VsjmmWVrhqi3zywyr
         jPMTjIggvN0h+H/R2DRySTKVMJ4ZClqGXwr+dQQyerAi43WmjpTloNhYA2eiWwZboGdM
         scJEMZ8A10Z4TWL2bNmTS1wEbdwe2N59sQ+ufPUJGRylbWtsm1LETZzvYxnZ7fSGBARO
         hlvaomVSVi6O/rQ3GlZ/scS9qEZKIkjBM0uIriyBmIJOBAFrUevVJg3JSsdj9zoCwv8A
         Nyzw==
X-Gm-Message-State: APjAAAV+J0btvFecqzLB9Unqk7nT0P+CWbRZrDJ3+vlPO7GOdXakvChl
        IlUXjcMEFE/IsS7bk519nkalp0hjmnA=
X-Google-Smtp-Source: APXvYqy7dZb/ZHuENAoqdmfRKmOOtntFi5k9iHEDmKl54XBVfW4LoOmjLAVHwybNQbY0vVP/HjkueA==
X-Received: by 2002:a37:5d0:: with SMTP id 199mr6226995qkf.131.1576123917716;
        Wed, 11 Dec 2019 20:11:57 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id s11sm1364126qkg.99.2019.12.11.20.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Dec 2019 20:11:56 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v6 5/7] sched/fair: update cpu_capacity to reflect thermal pressure
Date:   Wed, 11 Dec 2019 23:11:46 -0500
Message-Id: <1576123908-12105-6-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
References: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
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
 kernel/sched/fair.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e12a375..4840655 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7725,8 +7725,15 @@ static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
 	if (unlikely(irq >= max))
 		return 1;
 
+	/*
+	 * avg_rt.util avg and avg_dl.util track binary signals
+	 * (running and not running) with weights 0 and 1024 respectively.
+	 * avg_thermal.load_avg tracks thermal pressure and the weighted
+	 * average uses the actual delta max capacity.
+	 */
 	used = READ_ONCE(rq->avg_rt.util_avg);
 	used += READ_ONCE(rq->avg_dl.util_avg);
+	used += READ_ONCE(rq->avg_thermal.load_avg);
 
 	if (unlikely(used >= max))
 		return 1;
-- 
2.1.4

