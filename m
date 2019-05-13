Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660F3C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB4921019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557770449;
	bh=csfnspCqoGzSP36jG7KCsh/m3A3oYOGYQgo1X3YlEhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=Op9SaBX2e1J5EAaWAQsjtuqqAuJcAODQ6z/+3QMKHXwsJaaeYAViDANWpnhYhpu81
	 FxStmVuSbM8dVT6C9hs9kA5fis21P4+xcS24GuxsAvyP1HVH/6xmE+gbFayp6EyUmy
	 wcQvGzhU6b5nC0dJ4Q4ux8P8iBFj5Qr/fSDoio6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbfEMSAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 14:00:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45861 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732008AbfEMR7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:59:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id s11so7582122pfm.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 10:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=BllNv+GUuWAJ1ipV1p7Njrwna0Z9LQ0p08C6J8/Y2H0=;
        b=jcbgy/DudN6raLsl0pJOcbUgofvULms0tUfHAJB5NUpQJubyre75w9QU+7YA6vlj6v
         oegmgRCR20GxwKNvkigSX9jmJf3p0iiw1EQgaAxo2CErgYKHjpS+CEBJLIAbsd1/QvRt
         qz939gOLs3dfpghiwlOqU4Vd91X62NfdU850jcl1fKfvyoX+rz6MTF6OyRVvqW0w7bHH
         E4+r5JR8Jdxcxc2oq6yLrNOgTeABhr8oXoj874L3mqcTY6RRFAQb75u3NdpxWLrwmZgr
         KLEY3ko0+kyNP+sCgNJ22A6FQTjdRRyJdByXQ5z15Q/oF3sHNn/TqsQlWvQhpYGc0/bB
         giFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=BllNv+GUuWAJ1ipV1p7Njrwna0Z9LQ0p08C6J8/Y2H0=;
        b=oo4x3ty7ifEAt1yg0dHXlwaM6agORxLhpQTF/ly3Sf/17eK3kB0CdpZwcO7xsY/Fp4
         A8makp5xY5AeWPQ4lm/4oPFy7ouzwY1lvGMAXBPajq6PYU42xggcswdzFWYxnXYJaUZj
         7zn16s8HyrBNJtVZwGFaQ/LdJYlJrGHIWLG/SQfJ/83Hbz6GEEdtmsp4U5oYXSl8JT6H
         3flnhZg96iH6irIaNsso9mXT7ZycRRbSCvZ/UT7Vp/UT+yixkSE/jJCDZfgbblMaHKv1
         X0Dxbnjm6untsGTPjRoAxskQyx+BEv5bdxwnbeiSvPJJG8vGKdQD7iwwqegtxU1yvh2I
         y+Wg==
X-Gm-Message-State: APjAAAWZXOjekRK2t7kRDoXIWmEIKNNSnPpD+2YAMSxmfxcRHchBfA+D
        XKLwBcaD4dCJKrzfXGnWRLpoSdaM
X-Google-Smtp-Source: APXvYqxwWhsHe/BxaHcOiZVhVn3Ikm6xcti2qgMVXbgLUUoQlMVXe6KlhGEaymRWi6EIKVySqY9dTg==
X-Received: by 2002:a62:1a51:: with SMTP id a78mr34412637pfa.133.1557770358140;
        Mon, 13 May 2019 10:59:18 -0700 (PDT)
Received: from localhost.localdomain ([96.79.124.202])
        by smtp.gmail.com with ESMTPSA id s12sm9536266pfd.152.2019.05.13.10.59.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:59:17 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: [PATCH 02/19] x86 topology: Create topology_max_die_per_package()
Date:   Mon, 13 May 2019 13:58:46 -0400
Message-Id: <e6eaf384571ae52ac7d0ca41510b7fb7d2fda0e4.1557769318.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <7b23d2d26d717b8e14ba137c94b70943f1ae4b5c.1557769318.git.len.brown@intel.com>
References: <7b23d2d26d717b8e14ba137c94b70943f1ae4b5c.1557769318.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

topology_max_packages() is available to size resources to
cover all packages in the system.

But now we have multi-die/package systems, and some
resources are per-die.

Create topology_max_die_per_package(), for detecting
multi-die/package systems, and sizing any per-die resources.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/asm/processor.h |  1 -
 arch/x86/include/asm/topology.h  | 10 ++++++++++
 arch/x86/kernel/cpu/topology.c   |  5 ++++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 00fc03a8da59..87d42c0c6ccc 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -106,7 +106,6 @@ struct cpuinfo_x86 {
 	unsigned long		loops_per_jiffy;
 	/* cpuid returned max cores value: */
 	u16			x86_max_cores;
-	u16			x86_max_dies;
 	u16			apicid;
 	u16			initial_apicid;
 	u16			x86_clflush_size;
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 453cf38a1c33..e0232f7042c3 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -115,6 +115,13 @@ extern const struct cpumask *cpu_coregroup_mask(int cpu);
 extern unsigned int __max_logical_packages;
 #define topology_max_packages()			(__max_logical_packages)
 
+extern unsigned int __max_die_per_package;
+
+static inline int topology_max_die_per_package(void)
+{
+	return __max_die_per_package;
+}
+
 extern int __max_smt_threads;
 
 static inline int topology_max_smt_threads(void)
@@ -131,6 +138,9 @@ bool topology_smt_supported(void);
 static inline int
 topology_update_package_map(unsigned int apicid, unsigned int cpu) { return 0; }
 static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0; }
+static inline int topology_phys_to_logical_die(unsigned int die,
+		unsigned int cpu) { return 0; }
+static inline int topology_max_die_per_package(void) { return 1; }
 static inline int topology_max_smt_threads(void) { return 1; }
 static inline bool topology_is_primary_thread(unsigned int cpu) { return true; }
 static inline bool topology_smt_supported(void) { return false; }
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 4d17e699657d..ee48c3fc8a65 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -26,6 +26,9 @@
 #define LEVEL_MAX_SIBLINGS(ebx)		((ebx) & 0xffff)
 
 #ifdef CONFIG_SMP
+unsigned int __max_die_per_package __read_mostly = 1;
+EXPORT_SYMBOL(__max_die_per_package);
+
 /*
  * Check if given CPUID extended toplogy "leaf" is implemented
  */
@@ -146,7 +149,7 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 	c->apicid = apic->phys_pkg_id(c->initial_apicid, 0);
 
 	c->x86_max_cores = (core_level_siblings / smp_num_siblings);
-	c->x86_max_dies = (die_level_siblings / core_level_siblings);
+	__max_die_per_package = (die_level_siblings / core_level_siblings);
 #endif
 	return 0;
 }
-- 
2.18.0-rc0

