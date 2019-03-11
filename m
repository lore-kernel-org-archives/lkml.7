Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB355C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932D32087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552335013;
	bh=PvFgnao3BGnA9sdolGvGxZLvaZhMaI6HmQF2SZyjQ7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rp4r+nFYyQV4qU5h/BWsfs6cWOIQvF7ggFAJAgmIS2ZHrsnbZ/9zZ53/Nltc0SXfJ
	 xXaMjTu8MAIcMcQ52zOEXg++HgF3TvJkYh7y7OrRwAMjhA0Z/9ktmDu5o6BiMR6adv
	 cg//D/wK3yME+qxQKJZ/tLhiXa1uSVhMWGVagaMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfCKUKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:10:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728740AbfCKT4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:56:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6F962087C;
        Mon, 11 Mar 2019 19:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334198;
        bh=PvFgnao3BGnA9sdolGvGxZLvaZhMaI6HmQF2SZyjQ7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AHuedRXmaQ9aAh21LQ/B2hCB8d9ARRSGmkUsB/pvgWxJDrPzRRpIHHCZRgr1s3oGE
         rFjB5rAYdMEM358fZl3uEyOTmHXtBAujzmKyJWXeE7b3FXgWQQF1bZr5ydAEDAJVao
         PVZ5SD46ZAW8gFLlET/4LzrxyS9DQXUBixbxQYtE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guo Ren <ren_guo@c-sky.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 41/52] csky: Fixup io-range page attribute for mmap("/dev/mem")
Date:   Mon, 11 Mar 2019 15:55:05 -0400
Message-Id: <20190311195516.137772-41-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195516.137772-1-sashal@kernel.org>
References: <20190311195516.137772-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

[ Upstream commit 76d21d186a65523b08ea5f70302e2c29ee8f6a8d ]

Some user space drivers need accessing IO address and IO remap need
SO(strong order) page-attribute to make IO operation correct. So we
need add SO-page-attr for all non-memory address.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Reported-by: Fan Xiaodong <xiaodong.fan@boyahualu.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/include/asm/pgtable.h |  5 +++++
 arch/csky/mm/ioremap.c          | 14 ++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index af7a7faa1010..dcea277c09ae 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -241,6 +241,11 @@ static inline pte_t pte_mkyoung(pte_t pte)
 
 #define pgd_index(address)	((address) >> PGDIR_SHIFT)
 
+#define __HAVE_PHYS_MEM_ACCESS_PROT
+struct file;
+extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
+				     unsigned long size, pgprot_t vma_prot);
+
 /*
  * Macro to make mark a page protection value as "uncacheable".  Note
  * that "protection" is really a misnomer here as the protection value
diff --git a/arch/csky/mm/ioremap.c b/arch/csky/mm/ioremap.c
index 7ad3ff103f4a..02025a2a9ec0 100644
--- a/arch/csky/mm/ioremap.c
+++ b/arch/csky/mm/ioremap.c
@@ -46,3 +46,17 @@ void iounmap(void __iomem *addr)
 	vunmap((void *)((unsigned long)addr & PAGE_MASK));
 }
 EXPORT_SYMBOL(iounmap);
+
+pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
+			      unsigned long size, pgprot_t vma_prot)
+{
+	if (!pfn_valid(pfn)) {
+		vma_prot.pgprot |= _PAGE_SO;
+		return pgprot_noncached(vma_prot);
+	} else if (file->f_flags & O_SYNC) {
+		return pgprot_noncached(vma_prot);
+	}
+
+	return vma_prot;
+}
+EXPORT_SYMBOL(phys_mem_access_prot);
-- 
2.19.1

