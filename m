Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AE2C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D4520815
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558022726;
	bh=88gr+s6aDLZfVvSQFoNgzISrC6lvpe3dfXKTUnY3GPw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=NqHeYRCYnf9Ndppp+uhKtgjgrM/oVhdO3T5o+0bj0QaEu8l/t+GF64oEDgIpzdYzo
	 yK4FGHlOto6uxBPqU7hojhHAOr/dxRS/na0A7evm8utXQYmtJMzHIiq4SXsd+X7dS5
	 TmbZtx9C4KzpOwbvJzo7KLJjVS6eJlcgPCJ82H38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfEPQFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:05:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32819 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfEPQFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:05:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id d9so4080724wrx.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=q7pWT8kXPJxxR3x79I4/QO1kRi8GWpc3amVbJRsudng=;
        b=busAmoMTBtuvy6voqADUSj2mY/HAEvbOK42BVdDK5fnPrw9eYgS1O6RmIggdX7G51I
         CMQISWg0adYPGuNRM7J0lNX50hNIUZ2Nx+JTS4T5Pl3IiyPdKrjWxFOaMTBsaImr+8Q7
         AXUzineg14N4RcAgFI3kdBOjbmXiZyLPNL9sbjqOn+V/e5FvXi9hnOow+URcAYcEY9RD
         pn7Fmuz2mDPqtmgaI7NWbFts85oC475LMFhez03shoYUx0TjtJ+27eGNY29KRaMPp6dp
         /AYJG5AB+aamT+AciRc4RfGqO4EJawat/CuPjJn+vBruYigej5QU3BDatyNFEUiPQNHm
         MXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=q7pWT8kXPJxxR3x79I4/QO1kRi8GWpc3amVbJRsudng=;
        b=cVFMUQLEBBEVScsXAjqv1rqAj6e/JLRLENtzSg1/oFQoHWU3YYMYhJXccZYLYUl+Fn
         QSSulUY2kgErtbz9t/0uDNcGKkRSx3HxwL98J2yEf7L69G8LSkVHZQwor5QQSHOkqnY+
         YTU0pmpZ1PerBwXkVP2JnfEGnznL7DCCvyBHkSmjMwdfiXQa4HtfkiIRzuxzIND2UJ46
         IuIYBTpbMEt6fNeR/duHXQZHzgGQU0RbBSLLb6CYaLRBpzHBrgJcIUB3ixi4iAC6kV7E
         TJhqvDv4fZL9/4NvV9351OgJePOAH0SWZaaVQrYfylCSs3sBoyvAgv8FRXgFn8Q34Fc7
         7NSA==
X-Gm-Message-State: APjAAAWFabiAycY6FJfPw/KBqeIBOGRAobztu5wZzf444S5+H8sZxIn2
        Guh4RNJsxB/lm7dGpeGvLuKUPQZf
X-Google-Smtp-Source: APXvYqyz44gy7xXFf1s5NsimX2MXHADA8biKwP7LwCUZtB0bnz3lS/XK9wRx9dc6bvvaJPkREN1NbA==
X-Received: by 2002:adf:e404:: with SMTP id g4mr30309133wrm.161.1558022721273;
        Thu, 16 May 2019 09:05:21 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g2sm6917655wru.37.2019.05.16.09.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 09:05:20 -0700 (PDT)
Date:   Thu, 16 May 2019 18:05:18 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <20190516160518.GA46645@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: c7a286577d7592720c2f179aadfb325a1ff48c95 perf/x86/intel: Allow PEBS multi-entry in watermark mode

An x86 PMU constraint fix, an interface fix, and a Sparse fix.

 Thanks,

	Ingo

------------------>
Stephane Eranian (2):
      perf/x86/intel: Fix INTEL_FLAGS_EVENT_CONSTRAINT* masking
      perf/x86/intel: Allow PEBS multi-entry in watermark mode

Wang Hai (1):
      perf/x86/amd/iommu: Make the 'amd_iommu_attr_groups' symbol static


 arch/x86/events/amd/iommu.c  | 2 +-
 arch/x86/events/intel/core.c | 2 +-
 arch/x86/events/perf_event.h | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index 7635c23f7d82..58a6993d7eb3 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -393,7 +393,7 @@ static __init int _init_events_attrs(void)
 	return 0;
 }
 
-const struct attribute_group *amd_iommu_attr_groups[] = {
+static const struct attribute_group *amd_iommu_attr_groups[] = {
 	&amd_iommu_format_group,
 	&amd_iommu_cpumask_group,
 	&amd_iommu_events_group,
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ef763f535e3a..12ec402f4114 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3265,7 +3265,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		return ret;
 
 	if (event->attr.precise_ip) {
-		if (!(event->attr.freq || event->attr.wakeup_events)) {
+		if (!(event->attr.freq || (event->attr.wakeup_events && !event->attr.watermark))) {
 			event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
 			if (!(event->attr.sample_type &
 			      ~intel_pmu_large_pebs_flags(event)))
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 07fc84bb85c1..a6ac2f4f76fc 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -394,10 +394,10 @@ struct cpu_hw_events {
 
 /* Event constraint, but match on all event flags too. */
 #define INTEL_FLAGS_EVENT_CONSTRAINT(c, n) \
-	EVENT_CONSTRAINT(c, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS)
+	EVENT_CONSTRAINT(c, n, ARCH_PERFMON_EVENTSEL_EVENT|X86_ALL_EVENT_FLAGS)
 
 #define INTEL_FLAGS_EVENT_CONSTRAINT_RANGE(c, e, n)			\
-	EVENT_CONSTRAINT_RANGE(c, e, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS)
+	EVENT_CONSTRAINT_RANGE(c, e, n, ARCH_PERFMON_EVENTSEL_EVENT|X86_ALL_EVENT_FLAGS)
 
 /* Check only flags, but allow all event/umask */
 #define INTEL_ALL_EVENT_CONSTRAINT(code, n)	\
