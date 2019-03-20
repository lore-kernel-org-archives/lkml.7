Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68898C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330A021873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfCTFJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 01:09:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46298 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfCTFJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 01:09:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id 9so771958pfj.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 22:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e4gf7gQQRDrHYkHmBGmiy/271ro0jZqvmttHmTXDjOw=;
        b=SrkIFpH4EOPbdgwF27YutBG0dixIM9sxQ8Zul/jWYohOA/+mEPMaZX1OgmHTGqWK5r
         SmZuwgY3dPaFfSedf20NxPamhq3YTFN3XgsvU16EUxlsPoBLIa6bLtjEBrZcNNUJJg6K
         94Ssezf1vKwSiByj/O55+rx0gwzDFyGAANEKpky6nxv8cGaTBycBCQbcoj6E6yY+YF4S
         Dijy3dlJFrBFfINdBKJPbvunbIuXQm5RcWtVJhzaq3mxuxHV6jHfWYXS/VQnGMarYB2e
         KJSHT+zC49OtIHQ15v4qtI4cXHEU6LiLuRe8V9K+5xIy60b8Bksyu+FNIeDcoAXXSEdJ
         JPlA==
X-Gm-Message-State: APjAAAUSTiLIQ2TEUlWpQO/kjvD9CFpY6EkXFO2tRcmD/7SPWcaaRMPM
        JuAJ+hAJJ4oW+OApVwY07lLeWIS8aBM=
X-Google-Smtp-Source: APXvYqwquzJ/LobGlm7cNilKJM6zRdniDHacYy1BqPtGwxNdqRtts7VAQpU4ybvYWD6CVPzQvfam4A==
X-Received: by 2002:a63:e002:: with SMTP id e2mr5901612pgh.300.1553058590559;
        Tue, 19 Mar 2019 22:09:50 -0700 (PDT)
Received: from localhost ([122.177.144.121])
        by smtp.gmail.com with ESMTPSA id e123sm958508pfe.35.2019.03.19.22.09.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 22:09:49 -0700 (PDT)
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
Subject: [PATCH v3 2/3] crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS' to vmcoreinfo
Date:   Wed, 20 Mar 2019 10:39:33 +0530
Message-Id: <1553058574-18606-3-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553058574-18606-1-git-send-email-bhsharma@redhat.com>
References: <1553058574-18606-1-git-send-email-bhsharma@redhat.com>
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
index 093c9f917ed0..495f09084696 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -415,6 +415,7 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
 	VMCOREINFO_STRUCT_SIZE(mem_section);
 	VMCOREINFO_OFFSET(mem_section, section_mem_map);
+	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
 #endif
 	VMCOREINFO_STRUCT_SIZE(page);
 	VMCOREINFO_STRUCT_SIZE(pglist_data);
-- 
2.7.4

