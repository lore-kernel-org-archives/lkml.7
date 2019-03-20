Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7E8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C572186A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfCTFJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 01:09:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39946 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfCTFJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 01:09:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so1019102pfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 22:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p0woFonxhQQij4xaUhXjp4CHNytg0N40QAtCXayEoro=;
        b=h4FmPDjds3xbtXlpOLnJer8eyQpD1bgbTIPXu/cvviYF/Z8nHqyiaXsqJtQTe8nBdE
         1CDWl3Lqzufm/QS43lDQD9G7ItTntJe/C72LYjPqZSQfYHVoN022jA7gw4gXaqpmeB36
         RsFeL/PAcVacxDCX3yb5OYrbQP4rC/ma3Z+bNvbfk2ctwjRmeN24dhJDR5ACF2H0BUwJ
         XTWm5ClviK4cV/9gdhU837FXHMUOx/zF3rQhc70BR6XaH50Z5WyxdpiCN7AvnroW+RjD
         J7GfwGCM9h+D/f0eD3/5q8q6UvDxHw10K1DdvDR+9Db8X7xpY/fLsUdKGmLPOjKDr/Sm
         uElA==
X-Gm-Message-State: APjAAAWdWqezsTr8khrmK042RxmkwNgsg13s+J5VUIJ60LikoxBNCnTS
        nEclb5qNHW07T2mgtkGQGPPv9wzUMlM=
X-Google-Smtp-Source: APXvYqyVmE6pGU8aSc7Cd/ijJaa1EbQ1rS8QAcGSuGf0uphmkcdhHmkdPCl3wfUKWKXBLINHc5QNzQ==
X-Received: by 2002:aa7:885a:: with SMTP id k26mr5669463pfo.70.1553058587200;
        Tue, 19 Mar 2019 22:09:47 -0700 (PDT)
Received: from localhost ([122.177.144.121])
        by smtp.gmail.com with ESMTPSA id o7sm1351397pfi.105.2019.03.19.22.09.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 22:09:46 -0700 (PDT)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     bhsharma@redhat.com, bhupesh.linux@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/3] arm64, vmcoreinfo : Append 'PTRS_PER_PGD' to vmcoreinfo
Date:   Wed, 20 Mar 2019 10:39:32 +0530
Message-Id: <1553058574-18606-2-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553058574-18606-1-git-send-email-bhsharma@redhat.com>
References: <1553058574-18606-1-git-send-email-bhsharma@redhat.com>
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

