Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3342C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858002070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbfCZGut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:50:49 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44287 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCZGut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:50:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id g12so1183978pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 23:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FZhwv3yi5zyZbOFCZb2GEhrF1eNPuv7xg9JUzeBkJ/I=;
        b=RD6pFDX9mw91sCEDV8fcyWef9EA1jI2Ui5J+mVOM7S8DM9w1Kub0tcYhXzp0t0+7Rp
         /5oxxGu71L7GNpeQSbZ3gtxIM4or/BYtODqmsyOTOiahpZf20p4fIZx1OoAtPVGSOqek
         94j/+BQLDF0DycJ3MYZBzVuPETcOBqCqCjUsMOMDxI1ujftGlk9gg8wz3zvnyXleex4n
         b9BQdpiQyCmVBWLN3b9MEoef+/z+NC+/rAUgXLdFNnqh8Edyj4hsyEa1MBPDeG2X/iCR
         /DbdPoZjJzMjfYbJEBFykKa5H4Uuc+hTDsr+lxvIRYHEL+/FK9sULA/xVv6cTcShHDFN
         9OCg==
X-Gm-Message-State: APjAAAWTEXrrJjWyYTGqc+mKR5ZN8pRMEFVUMSCDlC1X67JKSx+zGiru
        gjv60VTSSIXTlPu9Ep2fmSB7qJ0crWo=
X-Google-Smtp-Source: APXvYqy39bmf1qbyFI6moNdEPCXkx4W2gXiUlmd3KBrqDCU2xEuOLaQloNXGw74Vf1g20sAehiiMvw==
X-Received: by 2002:a17:902:142:: with SMTP id 60mr29516055plb.191.1553583048524;
        Mon, 25 Mar 2019 23:50:48 -0700 (PDT)
Received: from localhost ([182.69.197.66])
        by smtp.gmail.com with ESMTPSA id e13sm30256596pgb.37.2019.03.25.23.50.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 23:50:47 -0700 (PDT)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     bhupesh.linux@gmail.com, bhsharma@redhat.com,
        James Morse <james.morse@arm.com>, Boris Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dave Anderson <anderson@redhat.com>,
        Dave Young <dyoung@redhat.com>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org
Subject: [PATCH] include/kcore: Remove left-over instances of 'kclist_add_remap()'
Date:   Tue, 26 Mar 2019 12:20:28 +0530
Message-Id: <1553583028-17804-1-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit bf904d2762ee ("x86/pti/64: Remove the SYSCALL64 entry trampoline")
removed the sole usage of 'kclist_add_remap()' from
'arch/x86/mm/cpu_entry_area.c', but it did not remove the left-over
definition from the include file.

Fix the same.

Cc: James Morse <james.morse@arm.com>
Cc: Boris Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Dave Anderson <anderson@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: x86@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 include/linux/kcore.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/kcore.h b/include/linux/kcore.h
index c843f4a9c512..da676cdbd727 100644
--- a/include/linux/kcore.h
+++ b/include/linux/kcore.h
@@ -38,12 +38,6 @@ struct vmcoredd_node {
 
 #ifdef CONFIG_PROC_KCORE
 void __init kclist_add(struct kcore_list *, void *, size_t, int type);
-static inline
-void kclist_add_remap(struct kcore_list *m, void *addr, void *vaddr, size_t sz)
-{
-	m->vaddr = (unsigned long)vaddr;
-	kclist_add(m, addr, sz, KCORE_REMAP);
-}
 
 extern int __init register_mem_pfn_is_ram(int (*fn)(unsigned long pfn));
 #else
@@ -51,11 +45,6 @@ static inline
 void kclist_add(struct kcore_list *new, void *addr, size_t size, int type)
 {
 }
-
-static inline
-void kclist_add_remap(struct kcore_list *m, void *addr, void *vaddr, size_t sz)
-{
-}
 #endif
 
 #endif /* _LINUX_KCORE_H */
-- 
2.7.4

