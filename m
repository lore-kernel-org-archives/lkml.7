Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB751C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CA52082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557137700;
	bh=hdVdFPdytmEco7J6mICv295rfh8jIBlxxXnSU3ATdps=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=NUjjrkn21KcxF9puEWSgbecZ4w7xxYvEkpYOsV+caUQOnh5+RV3ArtbFaTgLgF5CA
	 EaASZ1fqrVwGlRy4v3H5+o0WhhHzDFPoGkSKyJLrAPWH1ZO/rcfuVRjs8yb+2mu2ar
	 8MzUQ9BeDsNFR+4G7HVAX4AHkGffpe3gkeaiEprw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfEFKO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 06:14:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38683 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfEFKO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 06:14:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id k16so16509711wrn.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 03:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=UpWz8cK1VZflUI7ueSNhKDwvxR/Edbnus46OmpbIj94=;
        b=RiCKzKaeTBX8Tk5qiYBGghpeQBZpiypdI34Yu6+r8pq+EqSyNRabeMC9ZjENXy+ZR1
         pxAx0O1FoaI3ocXKT4AopvbiLyLYjYTC+eXGKl3RU6fZFKVR86TUKTnJkpv/VFMl3EG7
         WlInE93RYa/KMoaYynD7crqsrnkPgaUB/KGg8GfwsSd3O3N00v7ymOfrj+yOAFOJMAJZ
         DKM8y27YgooJb+1DVE8Lft8hpPdWCjstgdi5n/3bSuPIW9Brkg2AzPrtk/wfk9LkgMEv
         ZbhCaNT1G85jRMszuTRTp0EElhVQcx99xEiWPIGge2L0lf2Omz35t9Zy8rAx8AjSa4rp
         LCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=UpWz8cK1VZflUI7ueSNhKDwvxR/Edbnus46OmpbIj94=;
        b=Ns1CWzKYJ3PeIfUJMNl9Y3EF82WDHORKOQYZpyPdSr2IPa+EPsWb8v+ZsiOUjfHzui
         Z5AhVspGCOx2k6TVsbF1zyuTHIGRsiGdLBO0jXtpwDMtSQXn3juUoazKlxYeFiBmnFkb
         uUWpgaYaVEpm4eD1fWy/buoY3Wm0lLF8oTRYCoikuzAa8zYCREndZo7bX9bDFa8464EQ
         BXe+qScIYBSR1C+IOEeh5lqvlKHVbhAgroADv29YUYhE2yRzCFWrAno5R5GOYZkhfFV3
         5jVDDCrjjtOL3RQpTy9qobQ4iyiQZEeYJXpUttGb1xzcNxy2ir76Vw7CEbdxKlWFc9RJ
         etAQ==
X-Gm-Message-State: APjAAAWl8ta5sUMwP2X9qMlWmjhAu1/n/JZ9GsVxXMWDkphJ3wIR4lW+
        QM80r2dGeEc2m9+KOKq7syqeI22w
X-Google-Smtp-Source: APXvYqywO/nFUDKjTT5kTGGRgtJTjvg2cLbEBI1SIU6oNfJUbXRa9WibxcYm+N5CnfKped3AF4njnA==
X-Received: by 2002:a5d:4f88:: with SMTP id d8mr1958017wru.34.1557137697176;
        Mon, 06 May 2019 03:14:57 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x17sm8371996wru.27.2019.05.06.03.14.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 03:14:56 -0700 (PDT)
Date:   Mon, 6 May 2019 12:14:54 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/cpu changes for v5.2
Message-ID: <20190506101454.GA38212@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-cpu-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-for-linus

   # HEAD: 987ddbe4870b53623d76ac64044c55a13e368113 x86/power: Optimize C3 entry on Centaur CPUs

Two changes: a Hygon CPU fix, and an optimization Centaur CPUs.

 Thanks,

	Ingo

------------------>
David Wang (1):
      x86/power: Optimize C3 entry on Centaur CPUs

Pu Wen (1):
      x86/CPU/hygon: Fix phys_proc_id calculation logic for multi-die processors


 arch/x86/kernel/acpi/cstate.c | 12 ++++++++++++
 arch/x86/kernel/cpu/hygon.c   |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 158ad1483c43..cb6e076a6d39 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -51,6 +51,18 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
 	if (c->x86_vendor == X86_VENDOR_INTEL &&
 	    (c->x86 > 0xf || (c->x86 == 6 && c->x86_model >= 0x0f)))
 			flags->bm_control = 0;
+	/*
+	 * For all recent Centaur CPUs, the ucode will make sure that each
+	 * core can keep cache coherence with each other while entering C3
+	 * type state. So, set bm_check to 1 to indicate that the kernel
+	 * doesn't need to execute a cache flush operation (WBINVD) when
+	 * entering C3 type state.
+	 */
+	if (c->x86_vendor == X86_VENDOR_CENTAUR) {
+		if (c->x86 > 6 || (c->x86 == 6 && c->x86_model == 0x0f &&
+		    c->x86_stepping >= 0x0e))
+			flags->bm_check = 1;
+	}
 }
 EXPORT_SYMBOL(acpi_processor_power_init_bm_check);
 
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index cf25405444ab..415621ddb8a2 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -19,6 +19,8 @@
 
 #include "cpu.h"
 
+#define APICID_SOCKET_ID_BIT 6
+
 /*
  * nodes_per_socket: Stores the number of nodes per socket.
  * Refer to CPUID Fn8000_001E_ECX Node Identifiers[10:8]
@@ -87,6 +89,9 @@ static void hygon_get_topology(struct cpuinfo_x86 *c)
 		if (!err)
 			c->x86_coreid_bits = get_count_order(c->x86_max_cores);
 
+		/* Socket ID is ApicId[6] for these processors. */
+		c->phys_proc_id = c->apicid >> APICID_SOCKET_ID_BIT;
+
 		cacheinfo_hygon_init_llc_id(c, cpu, node_id);
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
 		u64 value;
