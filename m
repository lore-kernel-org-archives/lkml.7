Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7A5C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150BA20818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5eho0RS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfKKIE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 03:04:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31739 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726770AbfKKIE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 03:04:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573459495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=A9dYMCoBKwMezl1qACKOOLgxGxk0IE3Nin8lXmnvd8M=;
        b=P5eho0RSvcAfgYUEmO2kfqjfq4zGW2KPOXjhnnkKxy/QhOyZJvGEUVbKw8NhWwiUBYNfVw
        58lQwUsWo5oPSmH19/J7GoZAQmsm3swYRtv/FhtyLKvD4vARjUGmP5r8JPvA7hlC1xjr6H
        7v2jHhjzE2NS7Vw5j3IuqWEtgWs/UGM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-E5Tbw4UVM8qdZvcxcej0UA-1; Mon, 11 Nov 2019 03:04:53 -0500
Received: by mail-pl1-f197.google.com with SMTP id a11so10098729plp.21
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 00:04:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CQAhTC/o2YJhj0AZfjwdsGhelqoKVj50q9FveL4NL08=;
        b=lu7LWh9y511pZmSd8iNboz1Qw+yTYnl1wmje5JwfuFSJL6LDiLIU2MB6vMN19s5NQc
         FAn4R2X+RpsJ24iBq390R+TDTqLrY8XeLUfL10jeP6hIYY3NsRlL5Jdde/Uy6GuBJKCt
         Dbl3B0CIHU0wmfM7POZHhTcUCr643+Ma8TMiYQgYdOmSxeMklV87A5bRHtdZYfojNxDJ
         a0zjZhU+FSzsufqe9z+gbucmhqGzvrUeKcdU0qn+UvKktSvv2dFhUmp32RIQwAS3LWlv
         45lCdNR2OxKw58mDZKZutJIlBHh/XFcfJqGWPR8CcPhmuo0/MrfYxYdiegiwxrDossdj
         P/SA==
X-Gm-Message-State: APjAAAWw7i9gFte+Gk1UKzqcCiTpR08tgaJ0mzO2yqt678v8z3U+C3qc
        GsxpdJCWboedbWaY6Qhfs9bAH5q5v/NxhzLZJ2369bFMTE+UF73yD0J/IgJGe4l98m6EQQdXHRC
        mYRstBnJnmqGxPJtQv3i/6ayn
X-Received: by 2002:a17:90a:cc18:: with SMTP id b24mr31115547pju.141.1573459491920;
        Mon, 11 Nov 2019 00:04:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqwYn3i3YBnhT+ZAxJ1SZwxD2hnT8z5SmG2cTnSfOAsjmdb/sBRMzhcOXON77fu4WCIQlrVPaQ==
X-Received: by 2002:a17:90a:cc18:: with SMTP id b24mr31115508pju.141.1573459491651;
        Mon, 11 Nov 2019 00:04:51 -0800 (PST)
Received: from localhost ([122.177.0.15])
        by smtp.gmail.com with ESMTPSA id y1sm15008239pfq.138.2019.11.11.00.04.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 00:04:50 -0800 (PST)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     bhsharma@redhat.com, bhupesh.linux@gmail.com,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org
Subject: [PATCH v4 2/3] arm64/crash_core: Export TCR_EL1.T1SZ in vmcoreinfo
Date:   Mon, 11 Nov 2019 13:34:44 +0530
Message-Id: <1573459485-27219-1-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
X-MC-Unique: E5Tbw4UVM8qdZvcxcej0UA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vabits_actual variable on arm64 indicates the actual VA space size,
and allows a single binary to support both 48-bit and 52-bit VA
spaces.

If the ARMv8.2-LVA optional feature is present, and we are running
with a 64KB page size; then it is possible to use 52-bits of address
space for both userspace and kernel addresses. However, any kernel
binary that supports 52-bit must also be able to fall back to 48-bit
at early boot time if the hardware feature is not present.

Since TCR_EL1.T1SZ indicates the size offset of the memory region
addressed by TTBR1_EL1 (and hence can be used for determining the
vabits_actual value) it makes more sense to export the same in
vmcoreinfo rather than vabits_actual variable, as the name of the
variable can change in future kernel versions, but the architectural
constructs like TCR_EL1.T1SZ can be used better to indicate intended
specific fields to user-space.

User-space utilities like makedumpfile and crash-utility, need to
read/write this value from/to vmcoreinfo for determining if a virtual
address lies in the linear map range.

The user-space computation for determining whether an address lies in
the linear map range is the same as we have in kernel-space:

  #define __is_lm_address(addr)=09(!(((u64)addr) & BIT(vabits_actual - 1)))

Cc: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Dave Anderson <anderson@redhat.com>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 1 +
 arch/arm64/kernel/crash_core.c         | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/as=
m/pgtable-hwdef.h
index d9fbd433cc17..d2e7aff5821e 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -215,6 +215,7 @@
 #define TCR_TxSZ(x)=09=09(TCR_T0SZ(x) | TCR_T1SZ(x))
 #define TCR_TxSZ_WIDTH=09=096
 #define TCR_T0SZ_MASK=09=09(((UL(1) << TCR_TxSZ_WIDTH) - 1) << TCR_T0SZ_OF=
FSET)
+#define TCR_T1SZ_MASK=09=09(((UL(1) << TCR_TxSZ_WIDTH) - 1) << TCR_T1SZ_OF=
FSET)
=20
 #define TCR_EPD0_SHIFT=09=097
 #define TCR_EPD0_MASK=09=09(UL(1) << TCR_EPD0_SHIFT)
diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.=
c
index ca4c3e12d8c5..f78310ba65ea 100644
--- a/arch/arm64/kernel/crash_core.c
+++ b/arch/arm64/kernel/crash_core.c
@@ -7,6 +7,13 @@
 #include <linux/crash_core.h>
 #include <asm/memory.h>
=20
+static inline u64 get_tcr_el1_t1sz(void);
+
+static inline u64 get_tcr_el1_t1sz(void)
+{
+=09return (read_sysreg(tcr_el1) & TCR_T1SZ_MASK) >> TCR_T1SZ_OFFSET;
+}
+
 void arch_crash_save_vmcoreinfo(void)
 {
 =09VMCOREINFO_NUMBER(VA_BITS);
@@ -15,5 +22,7 @@ void arch_crash_save_vmcoreinfo(void)
 =09=09=09=09=09=09kimage_voffset);
 =09vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=3D0x%llx\n",
 =09=09=09=09=09=09PHYS_OFFSET);
+=09vmcoreinfo_append_str("NUMBER(tcr_el1_t1sz)=3D0x%llx\n",
+=09=09=09=09=09=09get_tcr_el1_t1sz());
 =09vmcoreinfo_append_str("KERNELOFFSET=3D%lx\n", kaslr_offset());
 }
--=20
2.7.4

