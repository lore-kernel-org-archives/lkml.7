Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBA7C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 20:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B068216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 20:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDZULnid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfK1UZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 15:25:35 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53198 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726569AbfK1UZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 15:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574972733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wgbAkKrJxLS1NEOR+82/qBcYhhrIFUtkNwc9k9kwPFE=;
        b=WDZULniduGjjLvO+zzzawH+wSTjE3cBxKEZ7RRI/ANQS+/rjitunV2VHnwz2D3eGoZD68k
        uRKBJvdOMhu0jHj1U0zUkXplw8nfuu4MiS16sfuJ5IzG/WV38dKkDVOEgigI/MY+FFUM7X
        E7/eBsnkQM1sW2+3wxQzhutrNW0tUlI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-PQ4MRTF4OtOGVsjxabDWQA-1; Thu, 28 Nov 2019 15:25:31 -0500
Received: by mail-pj1-f69.google.com with SMTP id t12so13405516pjy.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 12:25:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iJyjrUFfcmHAhH3JG4K3fZfDXNCj7aMMhMdC/cxhP5Q=;
        b=GDRvo8+xWRV/3zdO50xP/bBNWGode8BzSFh/cZjFz8eyYcxdXX2/dc/12WejV8H2Li
         LeYeYLVeS1rQSb3h78fiA4lFyQlkY3+afeWXmyFTbkbSUNDsT69uNDAqrQtgSUFnWPLF
         EVjNY6Tqcs8jHSCXd0INXMdSw0H0BhGYlWXfvAb0gWQuLCd3lotfvZGoznfBUpCRP4Hr
         /RVhsoozdw7Sy9uhknFZeWP4++sm89F6ZTJ0xbaMBnDfpP5gflFVYnRh5T7R6OUxOCka
         O4Vgzh39D+t3e6d4LKzz4/1jgOqssdPvhvMdfqFjFgqnpovk2XePDmgMaTm7EoVJbtSm
         dHBw==
X-Gm-Message-State: APjAAAVckVTQgUauLS396Bve40Bbosgoh5beViNHbmK72rMx3NfG41LG
        HCCwD3xjFTXkC7hkvJ2byyzaGHeJSV04rfIkE9jj0TmiFQMGYG3nd/56qQxVpBeDBtXBL7CNbib
        V4MPfrUCIrv4nfWif4zjCTwXI
X-Received: by 2002:a62:e708:: with SMTP id s8mr55037359pfh.80.1574972730291;
        Thu, 28 Nov 2019 12:25:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqy8inKnmjJQ3jsyvDZArqOTWo5QGvdHM+KGH3wVsC6Qega0Cnv/bnbln+swwqa3RoTSLPhAdw==
X-Received: by 2002:a62:e708:: with SMTP id s8mr55037330pfh.80.1574972730046;
        Thu, 28 Nov 2019 12:25:30 -0800 (PST)
Received: from localhost ([122.177.85.74])
        by smtp.gmail.com with ESMTPSA id v14sm21402742pfe.94.2019.11.28.12.25.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2019 12:25:29 -0800 (PST)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     bhsharma@redhat.com, bhupesh.linux@gmail.com, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: [PATCH v5 2/5] arm64/crash_core: Export TCR_EL1.T1SZ in vmcoreinfo
Date:   Fri, 29 Nov 2019 01:55:13 +0530
Message-Id: <1574972716-25858-1-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
X-MC-Unique: PQ4MRTF4OtOGVsjxabDWQA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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

I have sent out user-space patches for makedumpfile and crash-utility
to add features for obtaining vabits_actual value from TCR_EL1.T1SZ (see
[0] and [1]).

Akashi reported that he was able to use this patchset and the user-space
changes to get user-space working fine with the 52-bit kernel VA
changes (see [2]).

[0]. http://lists.infradead.org/pipermail/kexec/2019-November/023966.html
[1]. http://lists.infradead.org/pipermail/kexec/2019-November/024006.html
[2]. http://lists.infradead.org/pipermail/kexec/2019-November/023992.html

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

