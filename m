Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50514C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1870A205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483994;
	bh=KfUUKl4OJ/iRiB6WP0nLVctzTrRXlSgHQu7Wc1fD4IY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HJOENvCiNHYWc19UJ6bsUZnsz/9FtSK34EYM3MaIlOln0ELCV/pdJxx0C+aXkLvFk
	 QIXj2OypClpec3jvRIvOCfmh+e0OxuNCi+h72l4wZ/ynU63n/rYLtWnuznCuugOo+N
	 BMBADEGPh/8KUQMh6CXUU8VB+NXlLR24ptJV4/TA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbfLDS0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:26:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729106AbfLDR72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:59:28 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 604E22084F;
        Wed,  4 Dec 2019 17:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482367;
        bh=KfUUKl4OJ/iRiB6WP0nLVctzTrRXlSgHQu7Wc1fD4IY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0OIZ8I4xoJZJHUHpcXC8dPDTfmIKU6JlCyUbzMhBWDJRQVXii4bEm/YNR4w+qY87m
         wHxV9CwDWbyv1jfYok/n06OBHIyBYrC1s65nH4lXLvyAguMxBxnkE2Z3jq4rVtBNj/
         eU+X1oN6ccTyXeL94rJm1u3jfGAyDmqsc+4UrjGM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        Stafford Horne <shorne@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 42/92] openrisc: Fix broken paths to arch/or32
Date:   Wed,  4 Dec 2019 18:49:42 +0100
Message-Id: <20191204174333.056751048@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204174327.215426506@linuxfoundation.org>
References: <20191204174327.215426506@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>

[ Upstream commit 57ce8ba0fd3a95bf29ed741df1c52bd591bf43ff ]

OpenRISC was mainlined as "openrisc", not "or32".
vmlinux.lds is generated from vmlinux.lds.S.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/openrisc/kernel/entry.S | 2 +-
 arch/openrisc/kernel/head.S  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index fec8bf97d8064..c17e8451d9978 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -179,7 +179,7 @@ handler:							;\
  *	 occured. in fact they never do. if you need them use
  *	 values saved on stack (for SPR_EPC, SPR_ESR) or content
  *       of r4 (for SPR_EEAR). for details look at EXCEPTION_HANDLE()
- *       in 'arch/or32/kernel/head.S'
+ *       in 'arch/openrisc/kernel/head.S'
  */
 
 /* =====================================================[ exceptions] === */
diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index f14793306b03f..98dd6860bc0b9 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -1596,7 +1596,7 @@ _string_esr_irq_bug:
 
 /*
  * .data section should be page aligned
- *	(look into arch/or32/kernel/vmlinux.lds)
+ *	(look into arch/openrisc/kernel/vmlinux.lds.S)
  */
 	.section .data,"aw"
 	.align	8192
-- 
2.20.1



