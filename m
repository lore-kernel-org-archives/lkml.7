Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D100C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7895C24029
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfEaGhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 02:37:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36378 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfEaGhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 02:37:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id a3so3475276pgb.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 23:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/QoKVDR2xWt1lVYOO6x7Ha+8Bm4On1FmMMysZd9Rhz8=;
        b=d6tINhPdvx3bbAqV8ckj/P0vaFGvMcKBL5I2aDfgVvjEjxF0JJFKOYSlqo8J0EUjUX
         PfLZUC/DR9ejqBpscka19OTYol4g1qVYJpjS2nPG53sv0vLphLHdqh/RMwPjWHocv00e
         LhIUScToULpvB49RV2QMoY5XVLcCr/C+c+o8Qv0BVIW0aMfsj1L/UK0vyvkhV+FuRCV+
         0W9w91chyIJK6f+tlVSpDr1T9IHi4X3UUq4SL0GHo+Ml2CWLVb/cS6o50ZXUnfknRzEI
         lB4397yAbUtb8KufUf5Lj/lACB4LNi2nSHE1uYiQEBLF9qfsFXYTUYNBFy7oN0LePd08
         tgIA==
X-Gm-Message-State: APjAAAWsMsEOgFBux6NLOAFdm2MIEzFKI0lfGhHmxY3T0OmxzmPV7fgq
        GGP4dC+bDkXe76o9/qRJkgc=
X-Google-Smtp-Source: APXvYqzUVYhQzPupMPcNpMeq78KF5FNFoY3V2ypDnVXMfkHTxNSZD57gvzFCgBvGEwh+Cs7vgoJEiA==
X-Received: by 2002:a63:2224:: with SMTP id i36mr7458818pgi.70.1559284631209;
        Thu, 30 May 2019 23:37:11 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id g17sm9256429pfk.55.2019.05.30.23.37.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 23:37:10 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [RFC PATCH v2 09/12] x86/apic: Use non-atomic operations when possible
Date:   Thu, 30 May 2019 23:36:42 -0700
Message-Id: <20190531063645.4697-10-namit@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190531063645.4697-1-namit@vmware.com>
References: <20190531063645.4697-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using __clear_bit() and __cpumask_clear_cpu() is more efficient than
using their atomic counterparts. Use them when atomicity is not needed,
such as when manipulating bitmasks that are on the stack.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/kernel/apic/apic_flat_64.c   | 4 ++--
 arch/x86/kernel/apic/x2apic_cluster.c | 2 +-
 arch/x86/kernel/smp.c                 | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index 0005c284a5c5..65072858f553 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -78,7 +78,7 @@ flat_send_IPI_mask_allbutself(const struct cpumask *cpumask, int vector)
 	int cpu = smp_processor_id();
 
 	if (cpu < BITS_PER_LONG)
-		clear_bit(cpu, &mask);
+		__clear_bit(cpu, &mask);
 
 	_flat_send_IPI_mask(mask, vector);
 }
@@ -92,7 +92,7 @@ static void flat_send_IPI_allbutself(int vector)
 			unsigned long mask = cpumask_bits(cpu_online_mask)[0];
 
 			if (cpu < BITS_PER_LONG)
-				clear_bit(cpu, &mask);
+				__clear_bit(cpu, &mask);
 
 			_flat_send_IPI_mask(mask, vector);
 		}
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index 7685444a106b..609e499387a1 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -50,7 +50,7 @@ __x2apic_send_IPI_mask(const struct cpumask *mask, int vector, int apic_dest)
 	cpumask_copy(tmpmsk, mask);
 	/* If IPI should not be sent to self, clear current CPU */
 	if (apic_dest != APIC_DEST_ALLINC)
-		cpumask_clear_cpu(smp_processor_id(), tmpmsk);
+		__cpumask_clear_cpu(smp_processor_id(), tmpmsk);
 
 	/* Collapse cpus in a cluster so a single IPI per cluster is sent */
 	for_each_cpu(cpu, tmpmsk) {
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 04adc8d60aed..acddd988602d 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -146,7 +146,7 @@ void native_send_call_func_ipi(const struct cpumask *mask)
 	}
 
 	cpumask_copy(allbutself, cpu_online_mask);
-	cpumask_clear_cpu(smp_processor_id(), allbutself);
+	__cpumask_clear_cpu(smp_processor_id(), allbutself);
 
 	if (cpumask_equal(mask, allbutself) &&
 	    cpumask_equal(cpu_online_mask, cpu_callout_mask))
-- 
2.20.1

