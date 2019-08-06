Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012D2C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC11121871
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565127370;
	bh=f4dGjI3OrhNRjV5gnLp4EV0MkcL7DBhSXrN5oYy7s0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VYFlbJNFWIyAFh4mlV+/ALHpd1742hnXKJMH6wlVf8W6G9JgUBJe9r4b4WPL1is5X
	 Vm15HKiSSXQD9e4BFkVGPPto54P7dYyjT6mgI5AJDn1DmrmBanf4fVI3CVVg81U101
	 8F8cn52ArqaxRhEQdb/flqVy48b5ySKa8WxgeREg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfHFVgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:36:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbfHFVgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:36:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7765217D9;
        Tue,  6 Aug 2019 21:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565127366;
        bh=f4dGjI3OrhNRjV5gnLp4EV0MkcL7DBhSXrN5oYy7s0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cp/AdDBCrcgoxLSZ5SQYTiwV3m8WXERsUSunM3tC4nonSMHzYPLPjaZppn+EgcQu8
         l4gWuOsAzyMgOZLFYslmDyBT+4KIJvABrGdptdD5Z1Ip9vHh2EqTbaa2u72Y7Y+vgr
         s298M4bC2e4wC2dDyU9a/za4tZS3l6m+if+Myudk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qian Cai <cai@lca.pw>, Will Deacon <will@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 23/32] arm64/mm: fix variable 'pud' set but not used
Date:   Tue,  6 Aug 2019 17:35:11 -0400
Message-Id: <20190806213522.19859-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806213522.19859-1-sashal@kernel.org>
References: <20190806213522.19859-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai <cai@lca.pw>

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

