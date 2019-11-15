Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B4AC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30FE20728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573799052;
	bh=TIK9pVtbBBILAUJCSvHvEmIwJ+1++E+kftAnB/VxuJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K7jZgjhZMyfAJz5gk/oCexAzkCZMObHTcLYI2KjTgzFrB7V8Tn59aD/461XyvYoNc
	 5VA02PxpwbgUsUm4WO4aVZcmu4MwOWSy1eogpF5/kztANSmSp9EKuMVcWf1xNUFyNf
	 FjezEcAt8kyQqJD2xmA1VguP10yV8iLzlqfIqqBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfKOGYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 01:24:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:50782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727442AbfKOGVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 01:21:48 -0500
Received: from localhost (unknown [104.132.150.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD1882073A;
        Fri, 15 Nov 2019 06:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573798908;
        bh=TIK9pVtbBBILAUJCSvHvEmIwJ+1++E+kftAnB/VxuJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HnxlwjdYhB1mj7j1I24RUSKnKHBuDREdpCFmCbXR1/bKzYXWZ2V4op9S0FvEoLeh4
         lXOhcMbCbAJdJLbgEezHuZPI0CwpigKdNHbvRaRaHFYS2SkS1unKdRMBY98IiLPotf
         CZ0QIavmO1uPjVRRooq6x/eXs+SykdOPk54NZBoA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.4 08/20] kvm: x86: IA32_ARCH_CAPABILITIES is always supported
Date:   Fri, 15 Nov 2019 14:20:37 +0800
Message-Id: <20191115062010.880089365@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191115062006.854443935@linuxfoundation.org>
References: <20191115062006.854443935@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Mattson <jmattson@google.com>

commit 1eaafe91a0df4157521b6417b3dd8430bf5f52f0 upstream.

If there is a possibility that a VM may migrate to a Skylake host,
then the hypervisor should report IA32_ARCH_CAPABILITIES.RSBA[bit 2]
as being set (future work, of course). This implies that
CPUID.(EAX=7,ECX=0):EDX.ARCH_CAPABILITIES[bit 29] should be
set. Therefore, kvm should report this CPUID bit as being supported
whether or not the host supports it.  Userspace is still free to clear
the bit if it chooses.

For more information on RSBA, see Intel's white paper, "Retpoline: A
Branch Target Injection Mitigation" (Document Number 337131-001),
currently available at https://bugzilla.kernel.org/show_bug.cgi?id=199511.

Since the IA32_ARCH_CAPABILITIES MSR is emulated in kvm, there is no
dependency on hardware support for this feature.

Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Fixes: 28c1c9fabf48 ("KVM/VMX: Emulate MSR_IA32_ARCH_CAPABILITIES")
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/cpuid.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -447,6 +447,11 @@ static inline int __do_cpuid_ent(struct
 			entry->ebx |= F(TSC_ADJUST);
 			entry->edx &= kvm_cpuid_7_0_edx_x86_features;
 			cpuid_mask(&entry->edx, CPUID_7_EDX);
+			/*
+			 * We emulate ARCH_CAPABILITIES in software even
+			 * if the host doesn't support it.
+			 */
+			entry->edx |= F(ARCH_CAPABILITIES);
 		} else {
 			entry->ebx = 0;
 			entry->edx = 0;


