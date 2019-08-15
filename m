Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE7FC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8102206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbfHOQUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 12:20:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:10800 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728956AbfHOQUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:20:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 09:20:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="201263661"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by fmsmga004.fm.intel.com with ESMTP; 15 Aug 2019 09:20:32 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: x86: Fix x86_decode_insn() return when fetching insn bytes fails
Date:   Thu, 15 Aug 2019 09:20:32 -0700
Message-Id: <20190815162032.6679-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jump to the common error handling in x86_decode_insn() if
__do_insn_fetch_bytes() fails so that its error code is converted to the
appropriate return type.  Although the various helpers used by
x86_decode_insn() return X86EMUL_* values, x86_decode_insn() itself
returns EMULATION_FAILED or EMULATION_OK.

This doesn't cause a functional issue as the sole caller,
x86_emulate_instruction(), currently only cares about success vs.
failure, and success is indicated by '0' for both types
(X86EMUL_CONTINUE and EMULATION_OK).

Fixes: 285ca9e948fa ("KVM: emulate: speed up do_insn_fetch")
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/emulate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 8e409ad448f9..6d2273e71020 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -5126,7 +5126,7 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len)
 	else {
 		rc = __do_insn_fetch_bytes(ctxt, 1);
 		if (rc != X86EMUL_CONTINUE)
-			return rc;
+			goto done;
 	}
 
 	switch (mode) {
-- 
2.22.0

