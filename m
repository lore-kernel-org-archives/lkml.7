Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CA2C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CC02133F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfHXGC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 02:02:59 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43577 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbfHXGCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 02:02:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so6865066pld.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 23:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3G8HEOe7eXPD1fWB/xFr4j8ciVKkGakI4AxhAmUtJ1c=;
        b=alfhXhYqB/pnb7GEQ9TeRF6Ky+DxvZIJ5G0ke3e2fBOL/DmaSTi3xj3d6O4aKuz7TR
         w8JgYt826IeXM6B4kJJEV9aew/zKi64eeMq2JKThQDVOCKNQ2extSL9K0eeqdZDNkqDt
         ZSumrL0EkLm3njoYcoFcPlrO3IBwgJkonRO/zdg//uowFQ/IPw38farQAVXIQQWWBX+Z
         lvGYwCoaW6fZ/8FZrsjpo4NRD29rRPvTpoqn1FCiU6IwiDWmTqYQ0G3WD7W3QbpjeAyG
         QW3cDOrdemf6tXEdhuIE1exw1uERUrDkJHjMvJljI6FTsr+hehqDg99vWJhgnw6SPjIn
         JcAQ==
X-Gm-Message-State: APjAAAVMwfEl9P0IPZB5/mtwkcw493q/pcXm+Ncj0WFlj9B2u0I+ONwH
        ay2GOhapkJOhd0Il+3k9ePk=
X-Google-Smtp-Source: APXvYqz3Y9sBPV5GIYAbTLsPLvCLDfW2AfGPZdC4UxumljHytMHRB3nvaozEoa4LV1pjeHvFyGFWhA==
X-Received: by 2002:a17:902:d70e:: with SMTP id w14mr8346097ply.339.1566626572203;
        Fri, 23 Aug 2019 23:02:52 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id i11sm6505645pfk.34.2019.08.23.23.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 23:02:51 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [PATCH v4 6/9] x86/mm/tlb: Do not make is_lazy dirty for no reason
Date:   Fri, 23 Aug 2019 15:41:50 -0700
Message-Id: <20190823224153.15223-7-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823224153.15223-1-namit@vmware.com>
References: <20190823224153.15223-1-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Blindly writing to is_lazy for no reason, when the written value is
identical to the old value, makes the cacheline dirty for no reason.
Avoid making such writes to prevent cache coherency traffic for no
reason.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/mm/tlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 24c9839e3d9b..1393b3cd3697 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -322,7 +322,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		__flush_tlb_all();
 	}
 #endif
-	this_cpu_write(cpu_tlbstate_shared.is_lazy, false);
+	if (was_lazy)
+		this_cpu_write(cpu_tlbstate_shared.is_lazy, false);
 
 	/*
 	 * The membarrier system call requires a full memory barrier and
-- 
2.17.1

