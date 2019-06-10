Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1FAC4321B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C08D2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560198344;
	bh=WF3B/aIvuBdm+TMuhD75MVtaeujW0nD0b49/HCAzAx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C9B7LWanl4p0fEbJ3lr642V2FDwkLIRFL6ArN6HwAe5/W/5Hv/uvpaUTYmqX5/K/S
	 CJnFsS26yJALpPaGSvCQtfTyZi9STMqS9P6ezr61hU8cpo71zUSmSEuhu0FNR8Rb+W
	 g6g1dtOY+9gf1N/K6srQ0NDs1DPW3Vp5Qg64Qu04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389603AbfFJUZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 16:25:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389439AbfFJUZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 16:25:40 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7E27208E3;
        Mon, 10 Jun 2019 20:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560198339;
        bh=WF3B/aIvuBdm+TMuhD75MVtaeujW0nD0b49/HCAzAx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AQ7uBkPmm2NRfTUnxryyvHfccHzhoRYcH+tt4Js/wI0zGOgLM4ihUQ6XTTPBDh3qz
         zwVlymP8S6YM6g9EnnK1XBYMG2dVLTK5jP2fDHlHKkQ8mzWxDIy6E07dqrh56l+dXD
         lIwZ9ETQix+o3sTzfsZnXeMoLHoHN/noZ4FdxeH8=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5/5] x86/vsyscall: Change the default vsyscall mode to xonly
Date:   Mon, 10 Jun 2019 13:25:31 -0700
Message-Id: <25fd7036cefca16c68ecd990e05e05a8ad8fe8b2.1560198181.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560198181.git.luto@kernel.org>
References: <cover.1560198181.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use case for full emulation over xonly is very esoteric.  Let's
change the default to the safer xonly mode.

Cc: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 054033cc4b1b..e56f33e6b045 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2280,7 +2280,7 @@ config COMPAT_VDSO
 choice
 	prompt "vsyscall table for legacy applications"
 	depends on X86_64
-	default LEGACY_VSYSCALL_EMULATE
+	default LEGACY_VSYSCALL_XONLY
 	help
 	  Legacy user code that does not know how to find the vDSO expects
 	  to be able to issue three syscalls by calling fixed addresses in
-- 
2.21.0

