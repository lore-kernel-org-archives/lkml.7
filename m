Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4CDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713582084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141782;
	bh=JXMHdHjIfxC29hq4YtblfTsF6WSvxNtqgIwunSh+V5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DvAmUv+AMgmh0CWCF7/90ZN+TqasXx1cbH1W/VtrNF5nK51qOuCSjCZ8MR7/9Uf/C
	 vPanl5vqJNv46grrzaZyJOxO00rK6EcoWq9IKns2H1Ig8tCLN+74da+vGCv7dwPB4T
	 Oyz+MtwTPfxZ+Fi0557WU5Psno4TRPaaLUklR2bA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbfDASDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:03:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729749AbfDAROV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:14:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31C97206C0;
        Mon,  1 Apr 2019 17:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138860;
        bh=JXMHdHjIfxC29hq4YtblfTsF6WSvxNtqgIwunSh+V5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UB5tYqg/O7/IyLFT8qmHEkYpbBVqgeFQkE+x1cd6KWPuZNZwQ5zkvaZBqgNMu5fW/
         UEmL+e4gYnH0ElsOz/M1DUFGsZvPZA2fkpBh22lYKCfXmUVvfBQCREQN/SUjiv+nqI
         es1LkKvAeylYUX919v7B+hjIvB0mamIW/8GeFxmk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Daniel Axtens <dja@axtens.net>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.19 043/134] powerpc/fsl: Fix the flush of branch predictor.
Date:   Mon,  1 Apr 2019 19:01:19 +0200
Message-Id: <20190401170048.652941349@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit 27da80719ef132cf8c80eb406d5aeb37dddf78cc upstream.

The commit identified below adds MC_BTB_FLUSH macro only when
CONFIG_PPC_FSL_BOOK3E is defined. This results in the following error
on some configs (seen several times with kisskb randconfig_defconfig)

arch/powerpc/kernel/exceptions-64e.S:576: Error: Unrecognized opcode: `mc_btb_flush'
make[3]: *** [scripts/Makefile.build:367: arch/powerpc/kernel/exceptions-64e.o] Error 1
make[2]: *** [scripts/Makefile.build:492: arch/powerpc/kernel] Error 2
make[1]: *** [Makefile:1043: arch/powerpc] Error 2
make: *** [Makefile:152: sub-make] Error 2

This patch adds a blank definition of MC_BTB_FLUSH for other cases.

Fixes: 10c5e83afd4a ("powerpc/fsl: Flush the branch predictor at each kernel entry (64bit)")
Cc: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Daniel Axtens <dja@axtens.net>
Reviewed-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/exceptions-64e.S |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -349,6 +349,7 @@ ret_from_mc_except:
 #define GEN_BTB_FLUSH
 #define CRIT_BTB_FLUSH
 #define DBG_BTB_FLUSH
+#define MC_BTB_FLUSH
 #define GDBELL_BTB_FLUSH
 #endif
 


