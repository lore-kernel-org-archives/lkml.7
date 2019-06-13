Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7E3C31E4A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E9B215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbfFMQmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:42:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35092 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730528AbfFMGtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 02:49:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so11194701pfd.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 23:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ljEF1xpBxjd+Vdk++mYXFERmaivJtGEQFNvgYvjH3c=;
        b=M3WZYQRovxc9iFdATmNIjOkZEoUvAEB/efFBYkGXCjYxqpNgOfttBQpYR/ShJW2nQy
         r8FqlgkmbRJffDpbU3B5C/Qybl7r5gaBnsD9iTYysmfDuvAl8AuL5ejyJT+rfX1U6c1E
         2oQVxc0XnEmoUXUXU3qGHQGSqzqWuF22lhKAdTbqN4aqz3DJL8n++pQCcQQEMMy8eN45
         3Hvt9QzJJCA/b/x+jKFtgYaSj0rbMneoc/36SFf27au/vBPPjVt56SnxVrGVGf4OUrO2
         H0ePnN5AmWgUtjAIVxfAOBM3c8XVZQY1pLfi8kfqGXAHfxoqALtJSlCcb87uzOG7qj3q
         Da4A==
X-Gm-Message-State: APjAAAXFWhjaQFYtRhOVUN+uAAOEPdhcvvKZ+iLKUJ4Dvgn+9L/D/44s
        /fru2Z1MR6Ol/etu3lKIiGI=
X-Google-Smtp-Source: APXvYqyItHyxesHsAeDqPEnYRMelAshy/fIqK8fuerVO5yrmemQOXdwfb21xWM0lmybDVPO39mnwOQ==
X-Received: by 2002:a17:90a:6544:: with SMTP id f4mr3612830pjs.17.1560408570742;
        Wed, 12 Jun 2019 23:49:30 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id i3sm1559973pfa.175.2019.06.12.23.49.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 23:49:30 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH 5/9] x86/mm/tlb: Optimize local TLB flushes
Date:   Wed, 12 Jun 2019 23:48:09 -0700
Message-Id: <20190613064813.8102-6-namit@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613064813.8102-1-namit@vmware.com>
References: <20190613064813.8102-1-namit@vmware.com>
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
index db73d5f1dd43..ceb03b8cad32 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -815,8 +815,12 @@ static void flush_tlb_on_cpus(const cpumask_t *cpumask,
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
@@ -828,7 +832,7 @@ static void flush_tlb_on_cpus(const cpumask_t *cpumask,
 		local_irq_enable();
 	}
 
-	if (cpumask_any_but(cpumask, this_cpu) < nr_cpu_ids)
+	if (flush_others)
 		flush_tlb_others(cpumask, info);
 }
 
-- 
2.20.1

