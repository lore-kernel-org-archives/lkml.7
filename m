Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA15ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8F921D7A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571328223;
	bh=obQjV75iF1HXLeAsReTFfbAP36dp/qbcBsEsyIfYaiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YCPxIAOhkw5vSUnpVgdjBH8i/cqxpA46oBrZukrC7KpEWNcfoa0gbtUtj0AaFCStm
	 DdCsE/4AMFb2kvT6r+z+qeKcoktbBYSrdvFEYTa7N9vluDTBq9DEA6kD6fKV6ZuE9M
	 66SSU6Z0doZnhappNmPNnC3DrCYujYixEeomc5wY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440397AbfJQQDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:03:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440343AbfJQQDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:03:38 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 348B021D7C;
        Thu, 17 Oct 2019 16:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571328217;
        bh=obQjV75iF1HXLeAsReTFfbAP36dp/qbcBsEsyIfYaiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hz5eiWfem/ddo4b3RA7/aDM1KSJU28PYmrHgN8bro2aoZn6SX2ZVDDENiDv/LQF04
         E+iVCux2K6oSC7ndGrU/k4hTuYdowEXw2DIvSFatJukrzBErU7aZIrpeWmVGjqz1t4
         132rJbimUTu7i1M+QV+m0yGshFYf0dVOehWoNQUQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: [PATCH 09/11] tools headers kvm: Sync kvm.h headers with the kernel sources
Date:   Thu, 17 Oct 2019 13:02:59 -0300
Message-Id: <20191017160301.20888-10-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017160301.20888-1-acme@kernel.org>
References: <20191017160301.20888-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick the changes in:

  344c6c804703 ("KVM/Hyper-V: Add new KVM capability KVM_CAP_HYPERV_DIRECT_TLBFLUSH")
  dee04eee9182 ("KVM: RISC-V: Add KVM_REG_RISCV for ONE_REG interface")

These trigger the rebuild of this object:

  CC       /tmp/build/perf/trace/beauty/ioctl.o

But do not result in any change in tooling, as the additions are not
being used in any table generatator.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
  diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Anup Patel <Anup.Patel@wdc.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>
Link: https://lkml.kernel.org/n/tip-d1v48a0qfoe98u5v9tn3mu5u@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/kvm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 233efbb1c81c..52641d8ca9e8 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -999,6 +999,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_PTRAUTH_GENERIC 172
 #define KVM_CAP_PMU_EVENT_FILTER 173
 #define KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 174
+#define KVM_CAP_HYPERV_DIRECT_TLBFLUSH 175
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1145,6 +1146,7 @@ struct kvm_dirty_tlb {
 #define KVM_REG_S390		0x5000000000000000ULL
 #define KVM_REG_ARM64		0x6000000000000000ULL
 #define KVM_REG_MIPS		0x7000000000000000ULL
+#define KVM_REG_RISCV		0x8000000000000000ULL
 
 #define KVM_REG_SIZE_SHIFT	52
 #define KVM_REG_SIZE_MASK	0x00f0000000000000ULL
-- 
2.21.0

