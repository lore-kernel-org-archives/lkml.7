Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856C9C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634A325CB0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfEaGhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 02:37:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41241 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfEaGhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 02:37:06 -0400
Received: by mail-pl1-f196.google.com with SMTP id s24so3455594plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 23:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gcq5pTXKd5GPkXHrNSLItjvEps7n566abKyfwh5JX/g=;
        b=eArVmip76yYR9i9kdjbQALClQBPP8KVf/pxtAYi0xN3t293fghPKvMSnJPyFizeEp4
         nsPY1LV+ucr9S1Nzz0g60lS9j8jCNzu0uH08uIL1uckkfqUeQfeo+MJ0fCgW2dFl2yN8
         XYgbhB4r27wYtiy9IYItvB2LXGFrw9Xs/OgXAN76e832spPaWG23J/3TU5XEFiiGGOxS
         qrHY3TXI4/6BT/8w/Zq2uY6N1u/43I4QhP8siY719lhrWfiz2UR0HQDuNG2DbY4UXJa6
         xD5sezhuxXFA7PjYPaBQFMoD0glb3or7rNdBgnxSbDqXON4UTYQnsut9LYumvN6BcW26
         IJSA==
X-Gm-Message-State: APjAAAXnprFqdR3Oytgq42RRCxNy97Nf3LlCzhzEju3fPYQ6/t26dn1N
        nNiUwzcPty2s3rGmY/ejRCw=
X-Google-Smtp-Source: APXvYqxgV1A36NB9jXQD0UcxagzKzq61d4cioJYw8fIm4cZGf3lh2njH5og5jY/cl7LlKdFCZkp4rg==
X-Received: by 2002:a17:902:1021:: with SMTP id b30mr7601934pla.324.1559284625787;
        Thu, 30 May 2019 23:37:05 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id g17sm9256429pfk.55.2019.05.30.23.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 23:37:04 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [RFC PATCH v2 05/12] x86/mm/tlb: Optimize local TLB flushes
Date:   Thu, 30 May 2019 23:36:38 -0700
Message-Id: <20190531063645.4697-6-namit@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190531063645.4697-1-namit@vmware.com>
References: <20190531063645.4697-1-namit@vmware.com>
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
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/mm/tlb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 73d0d51b0f61..b0c3065aad5d 100644
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

