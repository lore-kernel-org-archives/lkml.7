Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD18C06513
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363942187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfGCHOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 03:14:33 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37223 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfGCHOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 03:14:11 -0400
Received: by mail-pl1-f196.google.com with SMTP id bh12so713903plb.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 00:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tbMmzT4xwZYMYEeTP8HwE5JwMVGn4vH5RiiY9Z0KVlQ=;
        b=U7mecXGRjSJtOUXuRdvBvhCV8PW8nqL7qBFsitbJWhVv/l/DxmM2ZNcsO28EFGtkkd
         cRahKoP3OfFRWzUC3Nq4GdmxuvtZYBKwpNh3TCdYyLE2qnwTJ+nOAUzjHxHlz/3EaDQt
         aj0U4T7/oyXPQgvOcABokxdU9HKleYd84oX+qKn5Kg77kYf99tvf/k2VDqegyMMci3Xo
         Zjmag19qvaCaThZpVB1DK01NwO3aInkDarE5dZ3DKFizL75gUeoV9Mx2Olv0J1oYSKO2
         ZvcQjP+uZxjPvxwPcmcIbvrK8Rg0LqGkXbwzI1ul80JODVlrw/QKYJ4GrJcRb+E0Wta2
         a5Jw==
X-Gm-Message-State: APjAAAXbo+3f1sUp+SOeCJ3sVB8b6WcWxwNc6uhmdODpphXwbZzITFD+
        vK44lxgRxBbQ//UwH4Rx9fs=
X-Google-Smtp-Source: APXvYqwI1nJDbJSVMGxtQSidgNts09caNTobTeKDf1wBhfQvmV1wo1rK3gfIICPNI+/poV+uKRVrVQ==
X-Received: by 2002:a17:902:f216:: with SMTP id gn22mr39826028plb.118.1562138051132;
        Wed, 03 Jul 2019 00:14:11 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j21sm1256593pfh.86.2019.07.03.00.14.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 00:14:10 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [PATCH v2 6/9] x86/mm/tlb: Do not make is_lazy dirty for no reason
Date:   Tue,  2 Jul 2019 16:51:48 -0700
Message-Id: <20190702235151.4377-7-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190702235151.4377-1-namit@vmware.com>
References: <20190702235151.4377-1-namit@vmware.com>
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
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/mm/tlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 9bd24aecbd58..b47a71820f35 100644
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

