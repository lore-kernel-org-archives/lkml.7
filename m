Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04F1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F162171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412266;
	bh=VnN47VIhTRBHuxvDYbDEWMZwTopU2hyk2L+SfDNjLVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f52+/pT0b6BAz16FoqdOnct/VIE2KIYSnK/jtstkWApAt4BkXgCyhMGemRUSojQWE
	 2R4NGipL1XRP1mPU9aZuXvZAOjdGMHE5bgqaM3ecvthB9xNAPsJ01JUVcNG6jwlXey
	 qNJb9Z9BqnVXxYkiiDezN26+/XXx7mNW11NoL6bU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbfCLRhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:37:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729201AbfCLRQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:36 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A3FF2171F;
        Tue, 12 Mar 2019 17:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410995;
        bh=VnN47VIhTRBHuxvDYbDEWMZwTopU2hyk2L+SfDNjLVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VgARiPnKIEGrzEBow9EBGAEVq2i6Q+hgJCjDnowf0/hHXQMvm/6OVaA3UQQRAF2jS
         UwIYZZf5Z71Hc+KqJIT+KfUutHQ42vjH2EUg6GO3vS23nwimpuaJN3qcLwLimrHMMZ
         RG9Du8M1ZBctsYoEg0O5aficA/5uA0/vDIFOiPyw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        James Morse <james.morse@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 077/135] arm64: kprobe: Always blacklist the KVM world-switch code
Date:   Tue, 12 Mar 2019 10:08:44 -0700
Message-Id: <20190312170348.291224830@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit f2b3d8566d81deaca31f4e3163def0bea7746e11 ]

On systems with VHE the kernel and KVM's world-switch code run at the
same exception level. Code that is only used on a VHE system does not
need to be annotated as __hyp_text as it can reside anywhere in the
 kernel text.

__hyp_text was also used to prevent kprobes from patching breakpoint
instructions into this region, as this code runs at a different
exception level. While this is no longer true with VHE, KVM still
switches VBAR_EL1, meaning a kprobe's breakpoint executed in the
world-switch code will cause a hyp-panic.

Move the __hyp_text check in the kprobes blacklist so it applies on
VHE systems too, to cover the common code and guest enter/exit
assembly.

Fixes: 888b3c8720e0 ("arm64: Treat all entry code as non-kprobe-able")
Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/probes/kprobes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 0417c929d21a..7d8c33279e9f 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -554,13 +554,13 @@ bool arch_within_kprobe_blacklist(unsigned long addr)
 	    addr < (unsigned long)__entry_text_end) ||
 	    (addr >= (unsigned long)__idmap_text_start &&
 	    addr < (unsigned long)__idmap_text_end) ||
+	    (addr >= (unsigned long)__hyp_text_start &&
+	    addr < (unsigned long)__hyp_text_end) ||
 	    !!search_exception_tables(addr))
 		return true;
 
 	if (!is_kernel_in_hyp_mode()) {
-		if ((addr >= (unsigned long)__hyp_text_start &&
-		    addr < (unsigned long)__hyp_text_end) ||
-		    (addr >= (unsigned long)__hyp_idmap_text_start &&
+		if ((addr >= (unsigned long)__hyp_idmap_text_start &&
 		    addr < (unsigned long)__hyp_idmap_text_end))
 			return true;
 	}
-- 
2.19.1



