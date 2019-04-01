Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BF1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890E1206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139305;
	bh=TpabW2eGlvjdY1bfSipFeehoT2RqbnPlk/ClkADxQ9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EI+VyU0JdA9e4L1NFFjZ5rXgKKKkZ1nfrkzjkCvV5MJZIE+ZlJPVAzbOQ6d4lc34m
	 xrS4PaBPpkhY6CPhG5xS9VxRuuk5Vt6b3ZQyjGu+qG3qEBGxlaAs+RDrm155DHpb+H
	 mzi57PwC46travQKUeoXDdQgxOmrR3ggEcpYYNeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731864AbfDARVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:21:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731592AbfDARVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:21:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 230E3206C0;
        Mon,  1 Apr 2019 17:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139300;
        bh=TpabW2eGlvjdY1bfSipFeehoT2RqbnPlk/ClkADxQ9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ut10y6uPMZwqxh+TDeh6vCPZt+0uJU0lDzQPFyHj/l5jwp/Is1YuWtpWSbZ3SIOD1
         Sev79n7NVGTM2FS0Su4tdnWTmC08ss8//mC73LmewtXKHep3SEGmEPgILuR9igR9z1
         VkluELbR2IJX0vQtQJFLXpgG40ZGUZfF09/+m7sM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 034/107] powerpc/64: Call setup_barrier_nospec() from setup_arch()
Date:   Mon,  1 Apr 2019 19:01:49 +0200
Message-Id: <20190401170048.790044225@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
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

From: Michael Ellerman <mpe@ellerman.id.au>

commit af375eefbfb27cbb5b831984e66d724a40d26b5c upstream.

Currently we require platform code to call setup_barrier_nospec(). But
if we add an empty definition for the !CONFIG_PPC_BARRIER_NOSPEC case
then we can call it in setup_arch().

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/setup.h       |    4 ++++
 arch/powerpc/kernel/setup-common.c     |    2 ++
 arch/powerpc/platforms/powernv/setup.c |    1 -
 arch/powerpc/platforms/pseries/setup.c |    1 -
 4 files changed, 6 insertions(+), 2 deletions(-)

--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -52,7 +52,11 @@ enum l1d_flush_type {
 
 void setup_rfi_flush(enum l1d_flush_type, bool enable);
 void do_rfi_flush_fixups(enum l1d_flush_type types);
+#ifdef CONFIG_PPC_BARRIER_NOSPEC
 void setup_barrier_nospec(void);
+#else
+static inline void setup_barrier_nospec(void) { };
+#endif
 void do_barrier_nospec_fixups(bool enable);
 extern bool barrier_nospec_enabled;
 
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -937,6 +937,8 @@ void __init setup_arch(char **cmdline_p)
 	if (ppc_md.setup_arch)
 		ppc_md.setup_arch();
 
+	setup_barrier_nospec();
+
 	paging_init();
 
 	/* Initialize the MMU context management stuff. */
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -123,7 +123,6 @@ static void pnv_setup_rfi_flush(void)
 		  security_ftr_enabled(SEC_FTR_L1D_FLUSH_HV));
 
 	setup_rfi_flush(type, enable);
-	setup_barrier_nospec();
 }
 
 static void __init pnv_setup_arch(void)
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -534,7 +534,6 @@ void pseries_setup_rfi_flush(void)
 		 security_ftr_enabled(SEC_FTR_L1D_FLUSH_PR);
 
 	setup_rfi_flush(types, enable);
-	setup_barrier_nospec();
 }
 
 static void __init pSeries_setup_arch(void)


