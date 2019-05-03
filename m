Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB66C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB9F21479
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556843155;
	bh=Qzjv3+RnY7+BmrfbdxeZ5O1WeMRqJB9whz4LrS90x30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J17XKYce/PmMngsOCUETRaaQvGvVCJCFYaFXD6AeeoTD74pERBiAL75gwNA/gzEbd
	 Pq8tVAbpMLPKsOYT/kKCY3TyjVLtl8uR7XH+f8bWqTRayKLP0EMpA/TLawMGiNnsJc
	 5hnTkZ7VlbQRCiZOud3hAKntwvKQRTQLswrB0s6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfECAZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 20:25:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfECAZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 20:25:52 -0400
Received: from quaco.ghostprotocols.net (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6393F2133F;
        Fri,  3 May 2019 00:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556843151;
        bh=Qzjv3+RnY7+BmrfbdxeZ5O1WeMRqJB9whz4LrS90x30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pebkGLQ6Je++Tg+Bn1HCjR1oXaYPceDAxn0Bpe/trzcsnIXZ6bfHJ+loBkTCbf+E4
         Dm2jObz/B37D71nSSQG0EbB9aWd/sIaCrMQMAYv8aarhZJ30Tt/GvprZPgdMjzuG6a
         VxPCD/l+ae9n49hyMM4kIqTICSrTs1bjCQPtPN14=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 02/11] tools uapi x86: Sync vmx.h with the kernel
Date:   Thu,  2 May 2019 20:25:24 -0400
Message-Id: <20190503002533.29359-3-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503002533.29359-1-acme@kernel.org>
References: <20190503002533.29359-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes from:

  2b27924bb1d4 ("KVM: nVMX: always use early vmcs check when EPT is disabled")

That causes this object in the tools/perf build process to be rebuilt:

  CC       /tmp/build/perf/arch/x86/util/kvm-stat.o

But it isn't using VMX_ABORT_ prefixed constants, so no change in
behaviour.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/vmx.h' differs from latest version at 'arch/x86/include/uapi/asm/vmx.h'
  diff -u tools/arch/x86/include/uapi/asm/vmx.h arch/x86/include/uapi/asm/vmx.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lkml.kernel.org/n/tip-bjbo3zc0r8i8oa0udpvftya6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/vmx.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/arch/x86/include/uapi/asm/vmx.h b/tools/arch/x86/include/uapi/asm/vmx.h
index f0b0c90dd398..d213ec5c3766 100644
--- a/tools/arch/x86/include/uapi/asm/vmx.h
+++ b/tools/arch/x86/include/uapi/asm/vmx.h
@@ -146,6 +146,7 @@
 
 #define VMX_ABORT_SAVE_GUEST_MSR_FAIL        1
 #define VMX_ABORT_LOAD_HOST_PDPTE_FAIL       2
+#define VMX_ABORT_VMCS_CORRUPTED             3
 #define VMX_ABORT_LOAD_HOST_MSR_FAIL         4
 
 #endif /* _UAPIVMX_H */
-- 
2.20.1

