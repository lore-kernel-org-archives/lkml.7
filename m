Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC79C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072DF2190F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570697838;
	bh=WIl6W8ebQcojUGSsK88TdAJ9kurCE2C5egXd6emtgqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r7R6NJt9u4All8dDU6E73OQpFVuhzB0dasYYg17OEWYpVhRXx1KzRtSW9XRoMXFwb
	 zK23zTtWZ+NfGp9s9Ma4AnMruexApnKCaT69k2hMsI25+P2n/oNsf6S5wuWlVbJ65/
	 aKzl5afEZ47lxeBz3DikD2ky6k+SloARi5SGXwV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389369AbfJJI5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:57:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387660AbfJJIrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:47:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78853218AC;
        Thu, 10 Oct 2019 08:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570697223;
        bh=WIl6W8ebQcojUGSsK88TdAJ9kurCE2C5egXd6emtgqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=inGKHgFlGGWVDtXUFxkfOmv3HkuY/YBpORsGv3H4TNaM6wQEBBib8iWalBB0bmbah
         d1S9DFSf4emTNB3D48bxoeOuap27J8CyJVs+DmLk3WQGEut+07LUurEGj+ShMYj7P9
         M3HxkUNoQgLp1ngcIVXvDq9UxW5qp53+Xzm5g9p0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 063/114] x86/purgatory: Disable the stackleak GCC plugin for the purgatory
Date:   Thu, 10 Oct 2019 10:36:10 +0200
Message-Id: <20191010083609.872858848@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083544.711104709@linuxfoundation.org>
References: <20191010083544.711104709@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

[ Upstream commit ca14c996afe7228ff9b480cf225211cc17212688 ]

Since commit:

  b059f801a937 ("x86/purgatory: Use CFLAGS_REMOVE rather than reset KBUILD_CFLAGS")

kexec breaks if GCC_PLUGIN_STACKLEAK=y is enabled, as the purgatory
contains undefined references to stackleak_track_stack.

Attempting to load a kexec kernel results in this failure:

  kexec: Undefined symbol: stackleak_track_stack
  kexec-bzImage64: Loading purgatory failed

Fix this by disabling the stackleak plugin for the purgatory.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: b059f801a937 ("x86/purgatory: Use CFLAGS_REMOVE rather than reset KBUILD_CFLAGS")
Link: https://lkml.kernel.org/r/20190923171753.GA2252517@rani.riverdale.lan
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/purgatory/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 10fb42da0007e..b81b5172cf994 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -23,6 +23,7 @@ KCOV_INSTRUMENT := n
 
 PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
 PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss
+PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN)
 
 # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
 # in turn leaves some undefined symbols like __fentry__ in purgatory and not
-- 
2.20.1



