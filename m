Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94982C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 10:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639AA2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 10:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfCJKE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 06:04:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33411 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfCJKE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 06:04:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id h11so1721306pgl.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 03:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p0woFonxhQQij4xaUhXjp4CHNytg0N40QAtCXayEoro=;
        b=tfJtqHnFUmDCJWxfIbMW3y4lkk7SZHEVmM/LhMw2TUR9mA/MS2zFuqW2IsQ3hITpQ7
         unPo49qBf0jl5eGbZUv3GnTf8vZdvMC+Bc+mX0AM0nnXmxjeqwFo6gqzNkbg4ohx3QEn
         PRjDJyhhyzTGktDa93tmioW46tHfUuRixai0078lJPjboB52qiYhqEQ3rrfPeXvL4efV
         nYQH7lOdmIOz3UxLTlOJ/aKtkqR/lo0M4wswREwnFJlXK6AB8/4+u8mz14Sip7qKmh8/
         Lo43muDg9aN5s/DhicuKABOnZ09QgZPU+iAZno16Z0XIiKB8rsb8sy1wWZXs0sGMZFfu
         SDeA==
X-Gm-Message-State: APjAAAV+OuwZXoQAX7KIzRGSt36qItnlrpbtJgnbHXnQvC2ADLUhMSG+
        YoOGrco4WPQaYeA07gS16tp1sFXneyI=
X-Google-Smtp-Source: APXvYqzZOzpXKDW58QolX8yBU9HTROhz294pagdWcO/uzW7wcBeI+NRVaXE6VKdHz/9a1S/CymETIw==
X-Received: by 2002:a17:902:4081:: with SMTP id c1mr28394637pld.297.1552212296851;
        Sun, 10 Mar 2019 03:04:56 -0700 (PDT)
Received: from localhost ([106.215.118.61])
        by smtp.gmail.com with ESMTPSA id r6sm3380076pgp.46.2019.03.10.03.04.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 03:04:56 -0700 (PDT)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     bhsharma@redhat.com, bhupesh.linux@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] arm64, vmcoreinfo : Append 'PTRS_PER_PGD' to vmcoreinfo
Date:   Sun, 10 Mar 2019 15:34:01 +0530
Message-Id: <1552212242-9479-2-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552212242-9479-1-git-send-email-bhsharma@redhat.com>
References: <1552212242-9479-1-git-send-email-bhsharma@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With ARMv8.2-LVA architecture extension availability, arm64 hardware
which supports this extension can support a virtual address-space upto
52-bits.

Since at the moment we enable the support of this extension in kernel
via CONFIG flags, e.g.
 - User-space 52-bit LVA via CONFIG_ARM64_USER_VA_BITS_52

so, there is no clear mechanism in the user-space right now to
determine these CONFIG flag values and hence determine the maximum
virtual address space supported by the underlying kernel.

User-space tools like 'makedumpfile' therefore are broken currently
as they have no proper method to calculate the 'PTRS_PER_PGD' value
which is required to perform a page table walk to determine the
physical address of a corresponding virtual address found in
kcore/vmcoreinfo.

If one appends 'PTRS_PER_PGD' number to vmcoreinfo for arm64,
it can be used in user-space to determine the maximum virtual address
supported by underlying kernel.

A reference 'makedumpfile' implementation which uses this approach to
determining the maximum physical address is available in [0].

[0]. https://github.com/bhupesh-sharma/makedumpfile/blob/52-bit-va-support-via-vmcore-upstream-v3/arch/arm64.c#L459

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Dave Anderson <anderson@redhat.com>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Suggested-by: Steve Capper <Steve.Capper@arm.com>
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 arch/arm64/kernel/crash_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
index ca4c3e12d8c5..123a42c56b8e 100644
--- a/arch/arm64/kernel/crash_core.c
+++ b/arch/arm64/kernel/crash_core.c
@@ -10,6 +10,7 @@
 void arch_crash_save_vmcoreinfo(void)
 {
 	VMCOREINFO_NUMBER(VA_BITS);
+	VMCOREINFO_NUMBER(PTRS_PER_PGD);
 	/* Please note VMCOREINFO_NUMBER() uses "%d", not "%x" */
 	vmcoreinfo_append_str("NUMBER(kimage_voffset)=0x%llx\n",
 						kimage_voffset);
-- 
2.7.4

