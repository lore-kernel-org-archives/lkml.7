Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EF8C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1412184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfGSA7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 20:59:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34022 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfGSA7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 20:59:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id b13so13392514pfo.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 17:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MlOkGjlKe23/Wup3KXevKcIurY4O1G8mMmCmtgnZfrQ=;
        b=HOhKSzYqV6KqMIm52mdYN9BLgbiOqdSSCp2b9Ly/J/gPatb5FqP+ZgppPgI0Bff+xr
         OR2CQNyClTIQ/AtXimOwzy5tVNmbVqkPf81b8B25eX+b9l2fvRPSMN3pn1Y07E50F5ux
         aeLhBX3k8V5k3N6u8bP6It6sjSDjCewNi80MCRLeayUqVtig4nQgqZ6nF01jfgKHf711
         OtuoDqqT2nkmeDtaCoLDnDeym+xUH2PFQvAHXWWef6sLJn1vOrmSAKEDjTZxSod98yNI
         znZSNavSAFAH1xtr3gTDNVFI3CE3hJAS4Xs9tcOBwyfhq9QLWP90YMVTC3K4u9Dy3O9B
         PpnQ==
X-Gm-Message-State: APjAAAUnE3aIFZT/i6r0tzwhnJkn1a0DPhI+TcUDyUeImhtHvJHgfhQY
        Y0cVBVM2JYt7N1BIvH1rXdxAyzJV/3o=
X-Google-Smtp-Source: APXvYqzTrtPwuTC0VDUpV7kyMgndF0s9Wa/i8EXJD31LgPjv9Tl6Ni8zmXCml5tRSEyXiz6OMjd2eQ==
X-Received: by 2002:a17:90a:8a15:: with SMTP id w21mr54640132pjn.134.1563497946884;
        Thu, 18 Jul 2019 17:59:06 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j128sm14025166pfg.28.2019.07.18.17.59.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 17:59:06 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v3 6/9] x86/mm/tlb: Do not make is_lazy dirty for no reason
Date:   Thu, 18 Jul 2019 17:58:34 -0700
Message-Id: <20190719005837.4150-7-namit@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719005837.4150-1-namit@vmware.com>
References: <20190719005837.4150-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index af80c274c88d..89f83ad19507 100644
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
2.20.1

