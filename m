Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68943C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B242175B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SeLgJyzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbfCLRdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:33:25 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:61487 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729491AbfCLRdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1552412001; x=1583948001;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4RwtLig5cNzwFS0w/o/vGJ4u0OMGC8lrOqOpbRTWsIo=;
  b=SeLgJyzuY/VoFgwKjUX/uPuOOwCI1xKiUlZSrb9keCSNM8Zjs0mTmYC2
   hWwd4pVJ8RV31oeoEQI/ykpDnob4mt1HQMU9Sa77x16jvEXX9Fh90TAH3
   k8AjfAwE94OZI3qcE6oL4JKJzbI2l1Ie5Y1YnmLeyUzcHGX1bnuFodij0
   I=;
X-IronPort-AV: E=Sophos;i="5.58,471,1544486400"; 
   d="scan'208";a="792968025"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Mar 2019 17:33:19 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x2CHX78Z084577
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 12 Mar 2019 17:33:14 GMT
Received: from EX13d09UWA001.ant.amazon.com (10.43.160.247) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Mar 2019 17:32:58 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13d09UWA001.ant.amazon.com (10.43.160.247) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Mar 2019 17:32:57 +0000
Received: from dev-dsk-alisaidi-i31e-4ac69482.us-east-1.amazon.com
 (10.200.136.151) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Tue, 12 Mar 2019 17:32:57 +0000
Received: by dev-dsk-alisaidi-i31e-4ac69482.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 115B347D3D; Tue, 12 Mar 2019 17:32:57 +0000 (UTC)
From:   Ali Saidi <alisaidi@amazon.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>
CC:     "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ali Saidi <alisaidi@amazon.com>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Anthony Liguori <aliguori@amazon.com>
Subject: [PATCH 1/2] arm64/mmap: handle worst-case heap randomization in mmap_base
Date:   Tue, 12 Mar 2019 17:32:47 +0000
Message-ID: <20190312173248.13490-2-alisaidi@amazon.com>
X-Mailer: git-send-email 2.15.3.AMZN
In-Reply-To: <20190312173248.13490-1-alisaidi@amazon.com>
References: <20190312173248.13490-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase mmap_base by the worst-case brk randomization so that
the stack and heap remain apart.

In Linux 4.13 a change was committed that special cased the kernel ELF
loader when the loader is invoked directly (eab09532d400; binfmt_elf: use
ELF_ET_DYN_BASE only for PIE). Generally, the loader isn’t invoked
directly and this issue is limited to cases where it is, (e.g to set a
non-inheritable LD_LIBRARY_PATH, testing new versions of the loader). In
those rare cases, the loader doesn't take into account the amount of brk
randomization that will be applied by arch_randomize_brk(). This can
lead to the stack and heap being arbitrarily close to each other.

Signed-off-by: Ali Saidi <alisaidi@amazon.com>

---
 arch/arm64/mm/mmap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index 842c8a5fcd53..0778f7ba8306 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -67,6 +67,14 @@ static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
 	unsigned long gap = rlim_stack->rlim_cur;
 	unsigned long pad = (STACK_RND_MASK << PAGE_SHIFT) + stack_guard_gap;
 
+	/* Provide space for randomization when randomize_va_space == 2 and
+	 * ld-linux.so is called directly. Values from arch_randomize_brk()
+	 */
+	if (test_thread_flag(TIF_32BIT))
+		pad += SZ_32M;
+	else
+		pad += SZ_1G;
+
 	/* Values close to RLIM_INFINITY can overflow. */
 	if (gap + pad > gap)
 		gap += pad;
-- 
2.15.3.AMZN

