Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F535C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77130206DD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566494883;
	bh=f+kUTcj8Rsrip7sV5Dpjqv2y5nYkGXzJ45JK1GhTtYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LtozivQwhk3fvP9HWJab5jyVNqnKZWcMyPtl2bp66uhvAJPiNFB1oZ50xGF/K4RS/
	 UDsNU6xpkfLvrRAy36qFTA1ol9YsxrEHuH422Wyv/+dfu5i3OaotBycyjASTq0gCKX
	 Qjv7qiaCKWKIUgCVv8dEeUL9wckQyEI4KjDTpVPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404902AbfHVR1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:27:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404700AbfHVR0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:26:20 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0FF323429;
        Thu, 22 Aug 2019 17:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494779;
        bh=f+kUTcj8Rsrip7sV5Dpjqv2y5nYkGXzJ45JK1GhTtYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YEr5/pkOoxZB22XLJV3dAVmzpZwHkojEb+ppm+bpSGGpDDAlmten9vDL2CHN2h6ve
         dah9GtPgULXc5//GHw2eFyChmxDpllDaFB6Lvrt/rMU2P6f569BIOioR0LHdGNm/jV
         5y2iJBOMlJZciqhh/spvU4pFTYr3olnYlpFQNsNI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 45/85] arm64/mm: fix variable pud set but not used
Date:   Thu, 22 Aug 2019 10:19:18 -0700
Message-Id: <20190822171733.247078136@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171731.012687054@linuxfoundation.org>
References: <20190822171731.012687054@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 7d4e2dcf311d3b98421d1f119efe5964cafa32fc ]

GCC throws a warning,

arch/arm64/mm/mmu.c: In function 'pud_free_pmd_page':
arch/arm64/mm/mmu.c:1033:8: warning: variable 'pud' set but not used
[-Wunused-but-set-variable]
  pud_t pud;
        ^~~

because pud_table() is a macro and compiled away. Fix it by making it a
static inline function and for pud_sect() as well.

Signed-off-by: Qian Cai <cai@lca.pw>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/pgtable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index ea423db393644..2214a403f39b9 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -419,8 +419,8 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 				 PMD_TYPE_SECT)
 
 #if defined(CONFIG_ARM64_64K_PAGES) || CONFIG_PGTABLE_LEVELS < 3
-#define pud_sect(pud)		(0)
-#define pud_table(pud)		(1)
+static inline bool pud_sect(pud_t pud) { return false; }
+static inline bool pud_table(pud_t pud) { return true; }
 #else
 #define pud_sect(pud)		((pud_val(pud) & PUD_TYPE_MASK) == \
 				 PUD_TYPE_SECT)
-- 
2.20.1



