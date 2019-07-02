Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED1DC06508
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23C12173E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562039012;
	bh=9xXXAaNVoQxMbnf7HOo9+uevM9EuW2CJWbh76Gnu18w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KXqAlhC9cSjxrNf6MZAuS5WwOiorMnCx1+W24tu0xEvLW8t75N0BYI4/05Q3hG4Xh
	 U4wCHs/Kaes5clEZCS5V8+XO3M+L0UADz7qvzf02iDjON8py9+F9m0tNz5Z/PtznwB
	 jzrAviMNb8LG0uf658vNZ+7u4jrbIyoJ9qcwPq3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfGBDnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 23:43:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbfGBDnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 23:43:25 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F39A521848;
        Tue,  2 Jul 2019 03:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562039005;
        bh=9xXXAaNVoQxMbnf7HOo9+uevM9EuW2CJWbh76Gnu18w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ue+Zsg+aHxkVlZDcResfbXU0BW6bW96I6vwIGPkWuc4UNCGY76NWHLJ8b9fdrpaWa
         Rkkb41xJx6UTpfeMrrOnffwCbmxAfKiN/NkYHHxFR1TAIhdwG5LygBDlJlCbZiFXk1
         rgtHYIQY9ssrwNr1hj5Y+/zUOJif/EJslTivWX2s=
From:   Andy Lutomirski <luto@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 2/3] x86/entry/64: Don't compile ignore_sysret if 32-bit emulation is enabled
Date:   Mon,  1 Jul 2019 20:43:20 -0700
Message-Id: <0f7dafa72fe7194689de5ee8cfe5d83509fabcf5.1562035429.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1562035429.git.luto@kernel.org>
References: <cover.1562035429.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's only used if !CONFIG_IA32_EMULATION, so disable it in normal
configs.  This will save a few bytes of text and reduce confusion.

Cc: "Bae, Chang Seok" <chang.seok.bae@intel.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/entry_64.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 7f9f5119d6b1..54b1b0468b2b 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1743,11 +1743,17 @@ nmi_restore:
 	iretq
 END(nmi)
 
+#ifndef CONFIG_IA32_EMULATION
+/*
+ * This handles SYSCALL from 32-bit code.  There is no way to program
+ * MSRs to fully disable 32-bit SYSCALL.
+ */
 ENTRY(ignore_sysret)
 	UNWIND_HINT_EMPTY
 	mov	$-ENOSYS, %eax
 	sysret
 END(ignore_sysret)
+#endif
 
 ENTRY(rewind_stack_do_exit)
 	UNWIND_HINT_FUNC
-- 
2.21.0

