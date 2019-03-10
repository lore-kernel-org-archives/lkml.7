Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8636BC10F03
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 10:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C82720870
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 10:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfCJKFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 06:05:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43570 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfCJKFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 06:05:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id q17so1478233pfh.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 03:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L1C+T2uli6R0dd/vYObZu3h9qXje3TBmGHmavCoixHE=;
        b=eCgBI6RC47A53OnLQA61DrXxnAfC4V5JRMXtkht4UVSET0zBP4bYrYp7H98LNJn/Ae
         GkP/ZccSAb8FBqso6hJ1Ufj/bT6xPbOCHljBDzDAlRBVf62Asy5lmSZ49pfcUIGfMoav
         ufXt+42hb+6cepKUMVfbURZbYdMOzXWs6pnyJXIzszhWJXoL+bqJm9nruTkTi+sTtKA9
         F75TcCHVwJO7CVsz8HATAFBYF5tArD5aRYInBLmmEfi40wbHKZ+TUrQhmBbrTB3/m/FK
         aTDTPiURnmL0Toje4jC1++QMBjxBPbt7ninP5wNjkIASW1jH1togtNrwzfftkNtRERRI
         tYlw==
X-Gm-Message-State: APjAAAXAfJsUHMasc80yoRCreI5BLAcyWMsrUDw14RzaIfBu2fn1CRGN
        5MasBOLBXrQuyfbOyCvJnqONu3hA8Gw=
X-Google-Smtp-Source: APXvYqz8b9xjsFFZhd8G7xPoAENZwwwAhyiJlWkWEOR5IOWPW8b/pqUd6GSXZ5C0atZumHSeryF4cQ==
X-Received: by 2002:a63:cd06:: with SMTP id i6mr25240388pgg.267.1552212301991;
        Sun, 10 Mar 2019 03:05:01 -0700 (PDT)
Received: from localhost ([106.215.118.61])
        by smtp.gmail.com with ESMTPSA id e26sm3979010pfd.124.2019.03.10.03.05.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 03:05:01 -0700 (PDT)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     bhsharma@redhat.com, bhupesh.linux@gmail.com,
        Boris Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org
Subject: [PATCH v2 2/2] crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS' to vmcoreinfo
Date:   Sun, 10 Mar 2019 15:34:02 +0530
Message-Id: <1552212242-9479-3-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552212242-9479-1-git-send-email-bhsharma@redhat.com>
References: <1552212242-9479-1-git-send-email-bhsharma@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now user-space tools like 'makedumpfile' and 'crash' need to rely
on a best-guess method of determining value of 'MAX_PHYSMEM_BITS'
supported by underlying kernel.

This value is used in user-space code to calculate the bit-space
required to store a section for SPARESMEM (similar to the existing
calculation method used in the kernel implementation):

  #define SECTIONS_SHIFT    (MAX_PHYSMEM_BITS - SECTION_SIZE_BITS)

Now, regressions have been reported in user-space utilities
like 'makedumpfile' and 'crash' on arm64, with the recently added
kernel support for 52-bit physical address space, as there is
no clear method of determining this value in user-space
(other than reading kernel CONFIG flags).

As per suggestion from makedumpfile maintainer (Kazu), it makes more
sense to append 'MAX_PHYSMEM_BITS' to vmcoreinfo in the core code itself
rather than in arch-specific code, so that the user-space code for other
archs can also benefit from this addition to the vmcoreinfo and use it
as a standard way of determining 'SECTIONS_SHIFT' value in user-land.

A reference 'makedumpfile' implementation which reads the
'MAX_PHYSMEM_BITS' value from vmcoreinfo in a arch-independent fashion
is available here:

[0]. https://github.com/bhupesh-sharma/makedumpfile/blob/remove-max-phys-mem-bit-v1/arch/ppc64.c#L471

Cc: Boris Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dave Anderson <anderson@redhat.com>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: x86@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 kernel/crash_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 093c9f917ed0..44b90368e183 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -467,6 +467,7 @@ static int __init crash_save_vmcoreinfo_init(void)
 #define PAGE_OFFLINE_MAPCOUNT_VALUE	(~PG_offline)
 	VMCOREINFO_NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE);
 #endif
+	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
 
 	arch_crash_save_vmcoreinfo();
 	update_vmcoreinfo_note();
-- 
2.7.4

