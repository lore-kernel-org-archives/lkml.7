Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF91C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5C42072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbgAIPCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 10:02:21 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35060 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730273AbgAIPCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:02:20 -0500
Received: by mail-qk1-f193.google.com with SMTP id z76so6245724qka.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 07:02:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Drfn39aW4Rl8/ELEX75gHz2oq+AVmNe3gvmjo+MZ5To=;
        b=aMOz6sQkvEJHOw0XKPIfdnr4WL6lLwaaVZXjBeC4+h+m9qO3OFBvrdNoYEug4jvCdX
         YMDLpsMeZ4p4GV9ss4y/Kx/5niJw+xNqfRgdOEBIU9HiBcPjMacQXRRNZQuRDKOJWBDP
         CDVh5q+m3wC6LFzkkvnACwpa97Zq/Do13/wmsXb4RJZsXo1gNAlcJ9lN7cbnLQm1vRbz
         ccDCrGjbJ1qJepcrvCFFS48WLVQfYMHdocLZZcF3n0pQqSvcSbswedvhlTsgZ1rMeyjB
         l76CXUdq99zYbRdamCX3hotiV+92SWttU33mIXFjWW8iSpzKDP/pdMiKL9SyPzXUtbqa
         l0Hg==
X-Gm-Message-State: APjAAAX0oHNz+0UPbmViM/9Al8tMopsO7Ik9INN1T7eIg6C0r8QPpTLQ
        1r9iEnbq7fMxWfNgm/7NT2Q=
X-Google-Smtp-Source: APXvYqzkBJCtRB/2LdLoUS3NNoNLP4nXoUI/TSLbmKLeGwsWJHcH/pWWxh1lEJZcNNoPxM0YR3EbuQ==
X-Received: by 2002:a37:a00b:: with SMTP id j11mr9879780qke.268.1578582139738;
        Thu, 09 Jan 2020 07:02:19 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t73sm3217837qke.71.2020.01.09.07.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 07:02:19 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86/boot/compressed/64: Remove .bss/.pgtable from bzImage
Date:   Thu,  9 Jan 2020 10:02:17 -0500
Message-Id: <20200109150218.16544-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5b11f1cee579 ("x86, boot: straighten out ranges to copy/zero in
compressed/head*.S") introduced a separate .pgtable section, splitting
it out from the rest of .bss. This section was added without the
writeable flag, marking it as read-only. This results in the linker
putting the .rela.dyn section (containing bogus dynamic relocations from
head_64.o) after the .bss and .pgtable sections.

When we use objcopy to convert compressed/vmlinux into a binary for the
bzImage, the .bss and .pgtable sections get materialized as ~176KiB of
zero bytes in the binary in order to place .rela.dyn at the correct
location.

Fix this by marking .pgtable as writeable. This moves the .rela.dyn
section earlier so that .bss and .pgtable are the last allocated
sections and so don't appear in bzImage.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/head_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 58a512e33d8d..6eb30f8a3ce7 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -709,7 +709,7 @@ SYM_DATA_END_LABEL(boot_stack, SYM_L_LOCAL, boot_stack_end)
 /*
  * Space for page tables (not in .bss so not zeroed)
  */
-	.section ".pgtable","a",@nobits
+	.section ".pgtable","aw",@nobits
 	.balign 4096
 SYM_DATA_LOCAL(pgtable,		.fill BOOT_PGT_SIZE, 1, 0)
 
-- 
2.24.1

