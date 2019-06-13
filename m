Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7F8C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1A920644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731706AbfFMQln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:41:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33571 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730534AbfFMGts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 02:49:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id k187so9860718pga.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 23:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KIxko3bf1UxU3S7PbsaO+3B/NsEEFkIHtCb9Hfmgcyw=;
        b=TOYfETX6F5bKw9lboPakeznri0aHVmlDVHWi091PxJAFTpVR78EnbPAMK7GW0rW5ly
         hmE6NBmsWBMyGoBvEmdNyxqyuiUFXTbC41VO2M+7kGWkmwMsa3WExYTmxu1+Qh7Wbc93
         QnQGuQOZtM/AtuW4vNm7a6DGd6LC9GzNoIlQfkdfoAVeR/BWGKrdOvfKONhnpf1bu1iF
         EFXP0Qe7LEIwqS9WxXLXWxFIWVbIozmeLXioDaUIw/JPs2VIEnsbrA5tubfw+eY/c4GK
         C4Sp7iO/jEhEOwa2flTXzfo2FbzwWMWu1MgICyLvZFCQgG7IQq7n87tWv1o4Zcp6M+Mo
         HTdA==
X-Gm-Message-State: APjAAAW3au5/2evQVJicLjqEPJx3SchPENYjnCKUd1HhTB5/OwH1YzWi
        /ZlJeo2giJXW1TyWaFrIbPggD6GntMR67g==
X-Google-Smtp-Source: APXvYqzDzOtreUY7YRR9V7tGYNGpISPFRAnUuamjop3Z6f3UD2u43890vOAhKh5V2E1tNXkTB5njdQ==
X-Received: by 2002:aa7:9203:: with SMTP id 3mr92952769pfo.123.1560408587399;
        Wed, 12 Jun 2019 23:49:47 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id i3sm1559973pfa.175.2019.06.12.23.49.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 23:49:46 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH 9/9] x86/apic: Use non-atomic operations when possible
Date:   Wed, 12 Jun 2019 23:48:13 -0700
Message-Id: <20190613064813.8102-10-namit@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613064813.8102-1-namit@vmware.com>
References: <20190613064813.8102-1-namit@vmware.com>
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
index bf083c3f1d73..bbdca603f94a 100644
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
index 4693e2f3a03e..96421f97e75c 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -144,7 +144,7 @@ void native_send_call_func_ipi(const struct cpumask *mask)
 	}
 
 	cpumask_copy(allbutself, cpu_online_mask);
-	cpumask_clear_cpu(smp_processor_id(), allbutself);
+	__cpumask_clear_cpu(smp_processor_id(), allbutself);
 
 	if (cpumask_equal(mask, allbutself) &&
 	    cpumask_equal(cpu_online_mask, cpu_callout_mask))
-- 
2.20.1

