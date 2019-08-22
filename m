Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B168C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CDC20856
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495653;
	bh=lpQUJvtrEWcWG9LI+iNv9hSV93QIliF30ECel6c4tsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FQZ0iGn3x4SomPmZIYCuFM10YEyTJ3IZJulhHAZIV3xKsb4gJVBHI6l6q9SPpeqiH
	 q8BeCGPyaORaM1aTvzqSgAB/vla5l/mngFC4bT0316aKNX4V3IAsEJEXhJu9+lAKNe
	 Ik3oQny26lMF2w9frewZE/WEChIRAw4amknlCf0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405097AbfHVRkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:40:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404041AbfHVRYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:24:03 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1791221743;
        Thu, 22 Aug 2019 17:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494643;
        bh=lpQUJvtrEWcWG9LI+iNv9hSV93QIliF30ECel6c4tsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fezNPXas4HQzqq8StAIP+uwveIGEyKPJ+3/nvSVbUy1i4JAUnRncPqEGElX/uo9zS
         /QEUrUXV3r7+w2xiOF6e7fE8gTtx8A4Dbol/D1AdD/c+MSZJSDtSjjnDDJarOq+mdl
         cziOvZaVFcChLZsU0GrH9N2otlAv+sm1wEYrIHKk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 077/103] arm64/mm: fix variable pud set but not used
Date:   Thu, 22 Aug 2019 10:19:05 -0700
Message-Id: <20190822171732.082304129@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171728.445189830@linuxfoundation.org>
References: <20190822171728.445189830@linuxfoundation.org>
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
index 73e3718356b05..edb2c359480db 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -387,8 +387,8 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
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



