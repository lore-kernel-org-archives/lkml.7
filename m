Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28164C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8542175B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UJyvOwxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbfCLRdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:33:08 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:64543 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729682AbfCLRdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1552411986; x=1583947986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jKqOztkO6Tw7b7bLjzZbKzMPNWbtoN0lKwLRS/I16E8=;
  b=UJyvOwxP5V8ZTt0XCcRVArJ7mvLpOcnR5ylxzwZSHMCbLbmgRy2OD5TI
   88vlzOB7tKnNa1hFItMJwFCncUgxe3f6PFVkjW/6Z7UV0UkVX5mnvTj1Y
   5QQIUAbwBVaasMXQ+Mw+Hv/II9yYdXIYx5E18EhQto/NP5gsudwP26HI3
   w=;
X-IronPort-AV: E=Sophos;i="5.58,471,1544486400"; 
   d="scan'208";a="792967971"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Mar 2019 17:33:05 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x2CHWtLn091501
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 12 Mar 2019 17:32:59 GMT
Received: from EX13d09UWA003.ant.amazon.com (10.43.160.227) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Mar 2019 17:32:58 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13d09UWA003.ant.amazon.com (10.43.160.227) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Mar 2019 17:32:57 +0000
Received: from dev-dsk-alisaidi-i31e-4ac69482.us-east-1.amazon.com
 (10.200.136.151) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Tue, 12 Mar 2019 17:32:57 +0000
Received: by dev-dsk-alisaidi-i31e-4ac69482.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 1480147D3F; Tue, 12 Mar 2019 17:32:57 +0000 (UTC)
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
Subject: [PATCH 2/2] x86/mmap: handle worst-case heap randomization in mmap_base
Date:   Tue, 12 Mar 2019 17:32:48 +0000
Message-ID: <20190312173248.13490-3-alisaidi@amazon.com>
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
 arch/x86/mm/mmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index db3165714521..98a2875c37e3 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -31,6 +31,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
 #include <linux/compat.h>
+#include <linux/sizes.h>
 #include <asm/elf.h>
 
 #include "physaddr.h"
@@ -97,6 +98,9 @@ static unsigned long mmap_base(unsigned long rnd, unsigned long task_size,
 	unsigned long pad = stack_maxrandom_size(task_size) + stack_guard_gap;
 	unsigned long gap_min, gap_max;
 
+	/* Provide space for brk randomization */
+	pad += SZ_32M;
+
 	/* Values close to RLIM_INFINITY can overflow. */
 	if (gap + pad > gap)
 		gap += pad;
-- 
2.15.3.AMZN

