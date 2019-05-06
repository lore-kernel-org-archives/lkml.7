Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C488CC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A7D21479
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557178012;
	bh=fqIg1+4ddXiDWAYjJ+4q42V7rJFwbYFQNg/d4mcv/xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=YeBcp28LfknlgpHsXQFDaOt0hFjdPI58lCJXRaO/fGWyNSOB/Ucn29J6LYLiqcgVi
	 F2QKWSBIin0g1sFpd5awd4o6DtxQDo778/tXbb28V61ncldEl4/6yJfUw9Z2DNU3VH
	 StzVVnANDCkDIn41xA+xSSQEjxcpLqZR4bkF1bLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfEFV0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:26:51 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44761 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfEFV0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:26:48 -0400
Received: by mail-io1-f65.google.com with SMTP id v9so8560037ion.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 14:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=BZvfoMetd7XOqGPD4+QBEFZbIkXgaAiftB+eMxWYjro=;
        b=kQ3llac0UgjHyZ9Ahv7/k2JBk/q++o/dQ0uKOdS1miBtZWs6UWI4u0L54AT6UAJeMq
         DIrd5qCEngzb3BhlEvfqMYS1y7x8dwrVapKZ0Ny6dFECau9XX1fjlcaIWmGVX+NWNiGW
         byaoMEn0Ho6+qRsOxsAL99y/J3tLu6JTKY+cjKhHP8E89uX7jG7WWryCNrt1d5WW70Rv
         RZdEg7KbAr/EehXujB2+ida8yoouWOuIpPYwqrKsW93Z4BP6+ouX+yQ6h+wXVB8R9V88
         zsFas9zHpfniGaqQO0OC2CEaPmdRPBedXRGYY9mRBXIKgOj/LXd8SUU1KE2WT4Nb+jaR
         jJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=BZvfoMetd7XOqGPD4+QBEFZbIkXgaAiftB+eMxWYjro=;
        b=paZQtX9poOqe3UfA0gZ490zsytinLXFjLgH3q4Xk7wQWypU94p0Sx/xlladPtqGYon
         mHULnNJETkBuqZCsySog0CMTLiYCYW9k8/p5ItaGUJeuS+A9CKIIa9ivhZ/9qvkSNw+x
         c48DOHzb23btDMhQyeXiXx+CzkhLLhluVZ0nKCLDpVqA9DcTM8cXyVCMUJ+PcmS3Oazz
         IenTAhk1YPdesOm7QIQZghulE1aqNslluF6Ul1jIWLZLPmEX35GKkuxi7Wq2oIq413Bi
         a8sIglHJe4rMYHlofxq8HTHvyYmgnMhDsqtY1OXVrin/P2nfCO4ve6ATjtFxJblAlAWs
         cViQ==
X-Gm-Message-State: APjAAAVN3FD0e6+vTr82Hk26LXiqMSuA2xaxURcrZ959SMnHaTEBGtiD
        BJDBNvpv1tqkPr83plkLrJQ=
X-Google-Smtp-Source: APXvYqym28vTaYtEHfTlqYh4eUtqNXdmJndS1qXu3qmb27W129PrR5OMT1rQ39Ehiy3dgo39ZqX+uA==
X-Received: by 2002:a6b:760d:: with SMTP id g13mr18361487iom.114.1557178008281;
        Mon, 06 May 2019 14:26:48 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id v25sm4268009ioh.81.2019.05.06.14.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 14:26:47 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 18/22] perf/x86/intel/cstate: Support multi-die/package
Date:   Mon,  6 May 2019 17:26:13 -0400
Message-Id: <ada9f26858dceb7484b51c23cc8028401379b4c8.1557177585.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Some cstate counters becomes die-scope on Xeon Cascade Lake-AP. Perf
cstate driver needs to support die-scope cstate counters.

Use topology_die_cpumask() to replace topology_core_cpumask().
For previous platforms which doesn't have multi-die,
topology_die_cpumask() is identical as topology_core_cpumask().
There is no functional change for previous platforms.

Name the die-scope PMU "cstate_die".

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/events/intel/cstate.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 94a4b7fc75d0..52c5fea29457 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -302,7 +302,7 @@ static int cstate_pmu_event_init(struct perf_event *event)
 			return -EINVAL;
 		event->hw.event_base = pkg_msr[cfg].msr;
 		cpu = cpumask_any_and(&cstate_pkg_cpu_mask,
-				      topology_core_cpumask(event->cpu));
+				      topology_die_cpumask(event->cpu));
 	} else {
 		return -ENOENT;
 	}
@@ -385,7 +385,7 @@ static int cstate_cpu_exit(unsigned int cpu)
 	if (has_cstate_pkg &&
 	    cpumask_test_and_clear_cpu(cpu, &cstate_pkg_cpu_mask)) {
 
-		target = cpumask_any_but(topology_core_cpumask(cpu), cpu);
+		target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
 		/* Migrate events if there is a valid target */
 		if (target < nr_cpu_ids) {
 			cpumask_set_cpu(target, &cstate_pkg_cpu_mask);
@@ -414,7 +414,7 @@ static int cstate_cpu_init(unsigned int cpu)
 	 * in the package cpu mask as the designated reader.
 	 */
 	target = cpumask_any_and(&cstate_pkg_cpu_mask,
-				 topology_core_cpumask(cpu));
+				 topology_die_cpumask(cpu));
 	if (has_cstate_pkg && target >= nr_cpu_ids)
 		cpumask_set_cpu(cpu, &cstate_pkg_cpu_mask);
 
@@ -661,7 +661,13 @@ static int __init cstate_init(void)
 	}
 
 	if (has_cstate_pkg) {
-		err = perf_pmu_register(&cstate_pkg_pmu, cstate_pkg_pmu.name, -1);
+		if (topology_max_die_per_package() > 1) {
+			err = perf_pmu_register(&cstate_pkg_pmu,
+						"cstate_die", -1);
+		} else {
+			err = perf_pmu_register(&cstate_pkg_pmu,
+						cstate_pkg_pmu.name, -1);
+		}
 		if (err) {
 			has_cstate_pkg = false;
 			pr_info("Failed to register cstate pkg pmu\n");
-- 
2.18.0-rc0

