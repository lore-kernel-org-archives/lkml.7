Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057CDC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41E120717
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387880AbfIMJzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 05:55:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:11019 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387439AbfIMJzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 05:55:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 02:55:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="336850934"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 13 Sep 2019 02:55:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 5317DF3; Fri, 13 Sep 2019 12:55:08 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] x86/mm: Enable 5-level paging support by default
Date:   Fri, 13 Sep 2019 12:54:52 +0300
Message-Id: <20190913095452.40592-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support of boot-time switching between 4- and 5-level paging mode is
upstream since 4.17.

We run internal testing with 5-level paging support enabled for a while
and it doesn't not cause any functional or performance regression on
4-level paging hardware.

The only 5-level paging related regressions I saw were in early boot
code that runs independently from CONFIG_X86_5LEVEL.

The next major release of distributions expected to have
CONFIG_X86_5LEVEL=y.

Enable the option by default. It may help to catch obscure bugs early.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 222855cc0158..2f7cb91d850e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1483,6 +1483,7 @@ config X86_PAE
 
 config X86_5LEVEL
 	bool "Enable 5-level page tables support"
+	default y
 	select DYNAMIC_MEMORY_LAYOUT
 	select SPARSEMEM_VMEMMAP
 	depends on X86_64
-- 
2.21.0

