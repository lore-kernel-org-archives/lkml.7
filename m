Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE89CA9EAB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E232245B
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571436445;
	bh=9bqpOQ/HTpFfl9Zq2N2vZhaiabTgyqLrkdRiLClf/oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PpSP2YrUXYoUHukdzy3c5hPS0wMS4P8nXVnJyzGilO+Hqet/KzkFdT9RDj78zjHww
	 R5921WZCs0qavxTWq/3uKtMp6EsHuDlgAxu7gxAOULwizGF4RnnctUIs1vlTgTEpVH
	 CzXIQFcOs/DtgpSZab8LuJA7TdVtg6XjQg4vudus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732802AbfJRWHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:07:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732739AbfJRWHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:07:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE1812245C;
        Fri, 18 Oct 2019 22:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436440;
        bh=9bqpOQ/HTpFfl9Zq2N2vZhaiabTgyqLrkdRiLClf/oc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YL1639z4V5uZB3Htw3CXlTnn5S7VNtT1I7e/X7ZI9BPXBbUua5STab9IgkuZ1D8mc
         96OFXoit5N5j1JgP2x/TfhmWS/g0jqOFsX7Ez/6n5odyG5wuaEDhgdF7ELm9wqtFVM
         b50yTkgwAUWr4jQr1b4ONCnmozQ5WevRlh/Ui6Ug=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>, linux-mips@linux-mips.org
Subject: [PATCH AUTOSEL 4.19 078/100] MIPS: include: Mark __cmpxchg as __always_inline
Date:   Fri, 18 Oct 2019 18:05:03 -0400
Message-Id: <20191018220525.9042-78-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220525.9042-1-sashal@kernel.org>
References: <20191018220525.9042-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Bogendoerfer <tbogendoerfer@suse.de>

[ Upstream commit 88356d09904bc606182c625575237269aeece22e ]

Commit ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING
forcibly") allows compiler to uninline functions marked as 'inline'.
In cace of cmpxchg this would cause to reference function
__cmpxchg_called_with_bad_pointer, which is a error case
for catching bugs and will not happen for correct code, if
__cmpxchg is inlined.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
[paul.burton@mips.com: s/__cmpxchd/__cmpxchg in subject]
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/cmpxchg.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index 89e9fb7976fe6..895f91b9e89c3 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -146,8 +146,9 @@ static inline unsigned long __xchg(volatile void *ptr, unsigned long x,
 extern unsigned long __cmpxchg_small(volatile void *ptr, unsigned long old,
 				     unsigned long new, unsigned int size);
 
-static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
-				      unsigned long new, unsigned int size)
+static __always_inline
+unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
+			unsigned long new, unsigned int size)
 {
 	switch (size) {
 	case 1:
-- 
2.20.1

