Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E8BC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1EF21BE6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="uyB8j/ts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbfHGO5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 10:57:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33515 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729278AbfHGO5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 10:57:19 -0400
Received: by mail-pl1-f195.google.com with SMTP id c14so41133770plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 07:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wCmmwD53XttWvxo3IyfDIXHfbZJtgpbW8gfsweTknQc=;
        b=uyB8j/tsSzit3NKNl6frCAIzbjxLYgwq157qH/us4cCgDbniSP8u0YjsXYJFHLRLJe
         XfAArNBgUVQvE9F/L3yxnLhUs+jDBwJewdRgiRoq0KXQ1XKO4hBB8nQnx8Iusd95byWx
         h+s9Vpqka6JyUtLZ3LQakBnx4JPY3m8jvwZjGe7md+PhukFp79FHDGnwagpY2RxrmHgX
         KIL8oO2iQY/6ZH1YjBncEqczITFPz19Zo+7qYfFremFmmV34WFndOv3MVCXi2noADWhJ
         A80O0zkkDUdRc70fXZD+GJ+7Z8SxTklgF9EvLamXOEETQl+13uVd5UokuifJUcqqLtta
         u9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wCmmwD53XttWvxo3IyfDIXHfbZJtgpbW8gfsweTknQc=;
        b=flrXhxNx3zgrKLUG9/u/pgTXshloIrem7cnboNK+Ma7dsKbPNR0BZeHyrfBIvr9lOa
         PechSijimLt3Oj7ggoOE0OnD5pHlsKrdc6qtjXw30H9/5+xKGgAU7h9Wpi5GZxGY5aYE
         EB5RDYMPT+8hwFhxxEuqEVaEKAPL8kDucwQZ4Rt2pM/AfATI2KRKf8EazZXyK/QpR7q4
         3S/6pDLz3vb0gtsNpPaBSkfGVX5bpGqXxL/zJgd/iLlcL5dWUzlrVMd8HZ6TlpY6mNWv
         nk1f6nu6O8H/5rljzF2Sf69tyzmyMMCV6mmVDtjjeT2eZFDlnfcXh8xlEITdvi4eS3rA
         /HQg==
X-Gm-Message-State: APjAAAU4LYrXromXcbRUaZfmpnDJUL11Z1WcidnX/Rj35+sV6p9PfVtH
        AFzdvVg8I0aHpGPM0cFreYe/8Q==
X-Google-Smtp-Source: APXvYqwEdtTkYTZY5Lvvefr4X0NqDCNkF1rLMWL7F2pp5Z47593oQIrCYDO/j784NjBZ2G3xux6gFQ==
X-Received: by 2002:a63:e306:: with SMTP id f6mr7928966pgh.39.1565189838910;
        Wed, 07 Aug 2019 07:57:18 -0700 (PDT)
Received: from santosiv.in.ibm.com.com ([183.82.17.96])
        by smtp.gmail.com with ESMTPSA id l4sm93617475pff.50.2019.08.07.07.57.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 07:57:18 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        christophe leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v8 1/7] powerpc/mce: Schedule work from irq_work
Date:   Wed,  7 Aug 2019 20:26:54 +0530
Message-Id: <20190807145700.25599-2-santosh@fossix.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807145700.25599-1-santosh@fossix.org>
References: <20190807145700.25599-1-santosh@fossix.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

schedule_work() cannot be called from MCE exception context as MCE can
interrupt even in interrupt disabled context.

fixes: 733e4a4c ("powerpc/mce: hookup memory_failure for UE errors")
Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 arch/powerpc/kernel/mce.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index b18df633eae9..0ab6fa7cbbbb 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -144,7 +144,6 @@ void save_mce_event(struct pt_regs *regs, long handled,
 		if (phys_addr != ULONG_MAX) {
 			mce->u.ue_error.physical_address_provided = true;
 			mce->u.ue_error.physical_address = phys_addr;
-			machine_check_ue_event(mce);
 		}
 	}
 	return;
@@ -275,8 +274,7 @@ static void machine_process_ue_event(struct work_struct *work)
 	}
 }
 /*
- * process pending MCE event from the mce event queue. This function will be
- * called during syscall exit.
+ * process pending MCE event from the mce event queue.
  */
 static void machine_check_process_queued_event(struct irq_work *work)
 {
@@ -292,6 +290,10 @@ static void machine_check_process_queued_event(struct irq_work *work)
 	while (__this_cpu_read(mce_queue_count) > 0) {
 		index = __this_cpu_read(mce_queue_count) - 1;
 		evt = this_cpu_ptr(&mce_event_queue[index]);
+
+		if (evt->error_type == MCE_ERROR_TYPE_UE)
+			machine_check_ue_event(evt);
+
 		machine_check_print_event_info(evt, false, false);
 		__this_cpu_dec(mce_queue_count);
 	}
-- 
2.20.1

