Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4001C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711E52087B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIvXEuVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfD3WjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 18:39:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37874 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfD3WjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 18:39:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id g3so7782205pfi.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 15:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BH4bZIoYFh+BZeuStnVh4oqr1cPMGw3OERKeRDVWU08=;
        b=OIvXEuVL9Uv69bTytaoqWmRftzsJ4wBG0LYBtrjl6WnOblUu05EIVX+NHm/lpilCno
         b8WwUWIF6x5Y5G/SSCjGEMqDKPGlKEZMGXBBBF80JQyvCTKr8gQzEQZB2W+FcfO52KvM
         L+DuKuA9cl2LR6x7m6FHyKYx+V4h8AroJ0Ujg0oTX0Kkw6QS8Xv03E87GIYi+y9oD5IF
         qrmZcI3U9V0KNFOki8GtqaWJf4h9sBQftWmZoOmpXF4xSfBaq13Seoh3hKAvA2fkr4Ok
         nKIqrp/xeB9s/o9e3lQYdu3KJuP3kwAHvJ7sGZnxhUefsNaSl0uKEikSsP5Fnvzs04qy
         PV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BH4bZIoYFh+BZeuStnVh4oqr1cPMGw3OERKeRDVWU08=;
        b=U6sjPLTWxN5FEsrKl3+Zyx4wxGgYgBJCDgyjMIpbjLM+vLOK39+ZKTzCpL62ofBmdJ
         RyLDMeUGmRP1i1IpUwMH+00EJWVE2U462VHGPjRLHTmJJVBxW727dBPrGO7QFmS8iHD1
         JDGY/YK3Wh+SusMQmmObiunemAic8Zf/sSQWHYy5Sjy9xMRwTqAngs9Q5saXdenoGMKL
         gvCwCCM7tqVofAyTWIU5qpNdxrOgVuHh6Q1l8ycIETmMtVNoI+H//GomEIsP07N9U2vo
         YqAEiDVPvytovoTux/iWBJL7jv64tOiPmFy3nI5j119x4Gt6hFILZBGzOJ7NKXOrdZSt
         WHaw==
X-Gm-Message-State: APjAAAVuEWvc8EQXRiYOe+EUjgPgE3gh4Tz/elNuLFQpxAChSBkrK3/M
        TfD9NhbpKxLWFOthvApHqNY=
X-Google-Smtp-Source: APXvYqzWZUGXQC0CYwvVzbYHuPdpj3mWL11+509Lnrq/yd2kilWOvzRF3C9VoPDJB+A8UsYHCaEfIA==
X-Received: by 2002:a63:4c1a:: with SMTP id z26mr53118353pga.324.1556663951853;
        Tue, 30 Apr 2019 15:39:11 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id c28sm27788476pgm.42.2019.04.30.15.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 15:39:10 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     rmk+kernel@armlinux.org.uk,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: Demote boot and shutdown messages to pr_debug
Date:   Tue, 30 Apr 2019 15:38:31 -0700
Message-Id: <20190430223835.23513-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commits c68b0274fb3cf ("ARM: reduce "Booted secondary
processor" message to debug level") and 035e787543de7 ("ARM: 8644/1: Reduce "CPU:
shutdown" message to debug level"), demote the secondary_start_kernel()
and __cpu_die() messages from info, respectively notice to debug. While
we are at it, also do this for cpu_psci_cpu_kill() which is redundant
with __cpu_die().

This helps improve the amount of possible hotplug cycles by around +50%
on ARCH_BRCMSTB.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/kernel/psci.c | 2 +-
 arch/arm64/kernel/smp.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 8cdaf25e99cd..a78581046c80 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -96,7 +96,7 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
 	for (i = 0; i < 10; i++) {
 		err = psci_ops.affinity_info(cpu_logical_map(cpu), 0);
 		if (err == PSCI_0_2_AFFINITY_LEVEL_OFF) {
-			pr_info("CPU%d killed.\n", cpu);
+			pr_debug("CPU%d killed.\n", cpu);
 			return 0;
 		}
 
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 824de7038967..71fd2b5a3f0e 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -259,7 +259,7 @@ asmlinkage notrace void secondary_start_kernel(void)
 	 * the CPU migration code to notice that the CPU is online
 	 * before we continue.
 	 */
-	pr_info("CPU%u: Booted secondary processor 0x%010lx [0x%08x]\n",
+	pr_debug("CPU%u: Booted secondary processor 0x%010lx [0x%08x]\n",
 					 cpu, (unsigned long)mpidr,
 					 read_cpuid_id());
 	update_cpu_boot_status(CPU_BOOT_SUCCESS);
@@ -348,7 +348,7 @@ void __cpu_die(unsigned int cpu)
 		pr_crit("CPU%u: cpu didn't die\n", cpu);
 		return;
 	}
-	pr_notice("CPU%u: shutdown\n", cpu);
+	pr_debug("CPU%u: shutdown\n", cpu);
 
 	/*
 	 * Now that the dying CPU is beyond the point of no return w.r.t.
-- 
2.17.1

