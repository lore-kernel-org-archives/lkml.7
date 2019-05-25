Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A35C04AB0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 08:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089272168B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 08:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfEYIWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 04:22:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38227 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfEYIWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 04:22:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id v11so6321355pgl.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 01:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KxvDSzvtNEWdEUkc6HpajEPlbrvUmMxVlIB1+bEziXQ=;
        b=uFJvekaGrVV3Oih6yokZ0Vahjn0f+BkXJ8WMAH7eXtTEyh1dHIyRowrXKhW/g4dFsE
         EHi8c3wOrygcjwv2UDDEAKddDSbKL5kS3GCmSRaKEnN3txwiDA3Em5IzGbxQMm0qjvGT
         MZhMUueXUhF43pT7Brb2GP7ifcV/cMdk8+kyh6vF3v40pxpUCDtc8hoEpvjFqSwgqE1S
         ddn3uowYC3jl1WEZlsq6eXbazzt14rTKOtXzrmvAEtcIcjTSXD57eIvo94i4T2s5jHYC
         1yjRUwDNItg7TqvkRzVcNp5wnRG8g9b/Nt8+8cPwlLFdqEu3StmF4L9em2NW8Sh57vZQ
         PgqA==
X-Gm-Message-State: APjAAAWFn6qJwrae5lJSM0nqgg7/chInxUPM1JDpp3z9OfuTB+/tQysX
        ircvAw7Qhn2fLv9YuRxSXh7zlpvpMOMQ/g==
X-Google-Smtp-Source: APXvYqxKb6Mh+oNK5ylPL8+mbwH4ZFU4+ZdjFtOyuShdVeFhg3iWL0LieaGQ7F0JW/7x4+wJXiCUrw==
X-Received: by 2002:a63:5516:: with SMTP id j22mr106600854pgb.370.1558772535770;
        Sat, 25 May 2019 01:22:15 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id e4sm1438505pgi.80.2019.05.25.01.22.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 01:22:14 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: [RFC PATCH 6/6] x86/mm/tlb: Optimize local TLB flushes
Date:   Sat, 25 May 2019 01:22:03 -0700
Message-Id: <20190525082203.6531-7-namit@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525082203.6531-1-namit@vmware.com>
References: <20190525082203.6531-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the updated smp infrastructure is capable of running a function on
a single local core, it is not optimized for this case. The multiple
function calls and the indirect branch introduce some overhead, making
local TLB flushes slower than they were before the recent changes.

Before calling the SMP infrastructure, check if only a local TLB flush
is needed to restore the lost performance in this common case. This
requires to check mm_cpumask() another time, but unless this mask is
updated very frequently, this should impact performance negatively.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/mm/tlb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 0ec2bfca7581..3f3f983e224e 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -823,8 +823,12 @@ static void flush_tlb_on_cpus(const cpumask_t *cpumask,
 			      const struct flush_tlb_info *info)
 {
 	int this_cpu = smp_processor_id();
+	bool flush_others = false;
 
-	if (static_branch_likely(&flush_tlb_multi_enabled)) {
+	if (cpumask_any_but(cpumask, this_cpu) < nr_cpu_ids)
+		flush_others = true;
+
+	if (static_branch_likely(&flush_tlb_multi_enabled) && flush_others) {
 		flush_tlb_multi(cpumask, info);
 		return;
 	}
@@ -836,7 +840,7 @@ static void flush_tlb_on_cpus(const cpumask_t *cpumask,
 		local_irq_enable();
 	}
 
-	if (cpumask_any_but(cpumask, this_cpu) < nr_cpu_ids)
+	if (flush_others)
 		flush_tlb_others(cpumask, info);
 }
 
-- 
2.20.1

