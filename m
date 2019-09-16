Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D165C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 16:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD1E2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 16:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbfIPQXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 12:23:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44126 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729132AbfIPQXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 12:23:05 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6BA292A09BB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 16:23:05 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id k184so11561wmk.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 09:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DnhcrFhYT0NJ78dPeEqKXN/V1tHyuglzQzoOeMUR4QY=;
        b=deCixatCs3a620fLK2bI88PNHjIOJmhYiQlPuiDTl8votlijRL7TqGfulI7jwQmYNf
         11CJEiCPPPkBD4wuf9NxF866F8Q7b1g3iu6sV17lKYfKtG4RoTLAckPp5/xfOP+m73k5
         JRRxghpGaLWuwAgStyuwcQPhB5MohvCUzeS87m1D92MWqgYIG2qxBy1tHK3r2WDnHZ3l
         kdF5PMqmKeFpNVBqpwafG8eYz3cfDVgxdB9YgCbo4nvT/GOS1AgRS6Jk3aFiXIJ0W6qH
         K9wW6wzjNnkXpvP55rpvBkwrCmUs9CGvvsdAOt/GvduNhSEMe1I2ftOxqTjYXFlOxaS8
         ztUA==
X-Gm-Message-State: APjAAAUF0Gnk4FCPaUivmeo0VMPuSkeClpcCV06QVYaBQqFsiyotZnCS
        kgpy0URDyHqZ5RO2YFvPayp5Q/M/s/sZr65v4QK8o8F5uaEBL9CKeDwO5WyXwNmcIPh9IXAWCQY
        evrgj9AXaiN1UEkDi5PziQOV8
X-Received: by 2002:a1c:2144:: with SMTP id h65mr32641wmh.114.1568650984104;
        Mon, 16 Sep 2019 09:23:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwqBQYTcgo16PkRqlPSOV/k7mPpgorRRib7zPPDxcWoF61Nz7u2WkI+Bq4Zjx3zql/YwldjxQ==
X-Received: by 2002:a1c:2144:: with SMTP id h65mr32612wmh.114.1568650983843;
        Mon, 16 Sep 2019 09:23:03 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q10sm78370575wrd.39.2019.09.16.09.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 09:23:01 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: [PATCH 1/3] cpu/SMT: create and export cpu_smt_possible()
Date:   Mon, 16 Sep 2019 18:22:56 +0200
Message-Id: <20190916162258.6528-2-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916162258.6528-1-vkuznets@redhat.com>
References: <20190916162258.6528-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM needs to know if SMT is theoretically possible, this means it is
supported and not forcefully disabled ('nosmt=force'). Create and
export cpu_smt_possible() answering this question.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 include/linux/cpu.h |  2 ++
 kernel/cpu.c        | 11 +++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index fcb1386bb0d4..6d48fc456d58 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -201,12 +201,14 @@ enum cpuhp_smt_control {
 extern enum cpuhp_smt_control cpu_smt_control;
 extern void cpu_smt_disable(bool force);
 extern void cpu_smt_check_topology(void);
+extern bool cpu_smt_possible(void);
 extern int cpuhp_smt_enable(void);
 extern int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval);
 #else
 # define cpu_smt_control		(CPU_SMT_NOT_IMPLEMENTED)
 static inline void cpu_smt_disable(bool force) { }
 static inline void cpu_smt_check_topology(void) { }
+static inline bool cpu_smt_possible(void) { return false; }
 static inline int cpuhp_smt_enable(void) { return 0; }
 static inline int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval) { return 0; }
 #endif
diff --git a/kernel/cpu.c b/kernel/cpu.c
index e84c0873559e..2f8c2631e641 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -389,8 +389,7 @@ enum cpuhp_smt_control cpu_smt_control __read_mostly = CPU_SMT_ENABLED;
 
 void __init cpu_smt_disable(bool force)
 {
-	if (cpu_smt_control == CPU_SMT_FORCE_DISABLED ||
-		cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
+	if (!cpu_smt_possible())
 		return;
 
 	if (force) {
@@ -435,6 +434,14 @@ static inline bool cpu_smt_allowed(unsigned int cpu)
 	 */
 	return !per_cpu(cpuhp_state, cpu).booted_once;
 }
+
+/* Returns true if SMT is not supported of forcefully (irreversibly) disabled */
+bool cpu_smt_possible(void)
+{
+	return cpu_smt_control != CPU_SMT_FORCE_DISABLED &&
+		cpu_smt_control != CPU_SMT_NOT_SUPPORTED;
+}
+EXPORT_SYMBOL_GPL(cpu_smt_possible);
 #else
 static inline bool cpu_smt_allowed(unsigned int cpu) { return true; }
 #endif
-- 
2.20.1

