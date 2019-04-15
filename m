Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80602C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8C12073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555353936;
	bh=jvdnfx7i1BZOSc0nVxbkv8tDOtMDTq7xv2YEYUFs0K0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yxNEvorMIqizdyRAjTILVXpJBFikYV0GAbweFylQWljAHwpbemCiqkuy/5fNyEf0j
	 OzZnNRCIyDXZIPjnjVqwNK3GWGNubuJw1skYzFR3fTlFbVcWao7uPCRO0JI97EJzfq
	 yUeIVmT4Uw88Hab770LsRGMip6GyD6RXPBeUaBlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbfDOSpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:45:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728393AbfDOSpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:45:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 641EB2073F;
        Mon, 15 Apr 2019 18:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353930;
        bh=jvdnfx7i1BZOSc0nVxbkv8tDOtMDTq7xv2YEYUFs0K0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bLhyjSCMCSwmX6unKz8ZpLNTrZbhNsadfqLzlGz8C2LgSoSI7wsLNqSV1n1pBVNM/
         fZQc+CSN8qupvNxTDHcTKTl5IIUDT3Tfkh11/T1D0No7ReyPb3CGXQbD/m8/SjgaZV
         ndQMoFsQebU7im0IOUYmF6q/PzdXEchVsplCNrvE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 23/76] powerpc/64: Call setup_barrier_nospec() from setup_arch()
Date:   Mon, 15 Apr 2019 20:43:47 +0200
Message-Id: <20190415183713.834205881@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit af375eefbfb27cbb5b831984e66d724a40d26b5c upstream.

Currently we require platform code to call setup_barrier_nospec(). But
if we add an empty definition for the !CONFIG_PPC_BARRIER_NOSPEC case
then we can call it in setup_arch().

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/setup.h       | 4 ++++
 arch/powerpc/kernel/setup-common.c     | 2 ++
 arch/powerpc/platforms/powernv/setup.c | 1 -
 arch/powerpc/platforms/pseries/setup.c | 1 -
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 38525bd2ed65..d3e9da62d029 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -51,7 +51,11 @@ enum l1d_flush_type {
 
 void setup_rfi_flush(enum l1d_flush_type, bool enable);
 void do_rfi_flush_fixups(enum l1d_flush_type types);
+#ifdef CONFIG_PPC_BARRIER_NOSPEC
 void setup_barrier_nospec(void);
+#else
+static inline void setup_barrier_nospec(void) { };
+#endif
 void do_barrier_nospec_fixups(bool enable);
 extern bool barrier_nospec_enabled;
 
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index bf0f712ac0e0..d5a128f54537 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -918,6 +918,8 @@ void __init setup_arch(char **cmdline_p)
 	if (ppc_md.setup_arch)
 		ppc_md.setup_arch();
 
+	setup_barrier_nospec();
+
 	paging_init();
 
 	/* Initialize the MMU context management stuff. */
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index eb5464648810..17203abf38e8 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -123,7 +123,6 @@ static void pnv_setup_rfi_flush(void)
 		  security_ftr_enabled(SEC_FTR_L1D_FLUSH_HV));
 
 	setup_rfi_flush(type, enable);
-	setup_barrier_nospec();
 }
 
 static void __init pnv_setup_arch(void)
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 2b2759c98c7e..91ade7755823 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -525,7 +525,6 @@ void pseries_setup_rfi_flush(void)
 		 security_ftr_enabled(SEC_FTR_L1D_FLUSH_PR);
 
 	setup_rfi_flush(types, enable);
-	setup_barrier_nospec();
 }
 
 static void __init pSeries_setup_arch(void)
-- 
2.19.1



