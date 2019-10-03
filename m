Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6A9C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505E8222BE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570120207;
	bh=DCEiTU4UemXwcgVyei6aTJbJvetLYVFFZnXWVNu4XLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R49BAbxWsPwY/+JTvKso2oDH6/d/Yb6uzl93wrW3tKYwjaOExe7i9kDd9CZxNaABG
	 zV174q0UpgQSaw8eBYYCQ9kT0r9HCpXJHtq3z3PxxY0KI/yuHEZCtxF4lD6BuBNioC
	 rUhSJ1GWy2joYjEW3BuZaY2VfPoLhbeXIzCEbfVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391059AbfJCQaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389910AbfJCQaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:30:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AF5720700;
        Thu,  3 Oct 2019 16:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120203;
        bh=DCEiTU4UemXwcgVyei6aTJbJvetLYVFFZnXWVNu4XLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m6JJfcH/07Z3GBxlyR80cWemO5Vtna4QvvsBgok0EF5MLNsS9jbDqQRfNZ3ZtxF5F
         zUPgdsXScNDLv6x5vSQGG0K1NucxudQNTy6bPZ+wJ09ZdiLLsQv143e428HUeA85/u
         kCkzJrVfOHWng3QA26uJxaZWGyCdJO6yA+zZecv4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 136/313] soc: renesas: Enable ARM_ERRATA_754322 for affected Cortex-A9
Date:   Thu,  3 Oct 2019 17:51:54 +0200
Message-Id: <20191003154546.272144193@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 2eced4607a1e6f51f928ae3e521fe02be5cb7d23 ]

ARM Erratum 754322 affects Cortex-A9 revisions r2p* and r3p*.

Automatically enable support code to mitigate the erratum when compiling
a kernel for any of the affected Renesas SoCs:
  - RZ/A1: r3p0,
  - R-Mobile A1: r2p4,
  - R-Car M1A: r2p2-00rel0,
  - R-Car H1: r3p0,
  - SH-Mobile AG5: r2p2.

EMMA Mobile EV2 (r1p3) and RZ/A2 (r4p1) are not affected.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/renesas/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 68bfca6f20ddf..2040caa6c8085 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -55,6 +55,7 @@ config ARCH_EMEV2
 
 config ARCH_R7S72100
 	bool "RZ/A1H (R7S72100)"
+	select ARM_ERRATA_754322
 	select PM
 	select PM_GENERIC_DOMAINS
 	select SYS_SUPPORTS_SH_MTU2
@@ -76,6 +77,7 @@ config ARCH_R8A73A4
 config ARCH_R8A7740
 	bool "R-Mobile A1 (R8A77400)"
 	select ARCH_RMOBILE
+	select ARM_ERRATA_754322
 	select RENESAS_INTC_IRQPIN
 
 config ARCH_R8A7743
@@ -103,10 +105,12 @@ config ARCH_R8A77470
 config ARCH_R8A7778
 	bool "R-Car M1A (R8A77781)"
 	select ARCH_RCAR_GEN1
+	select ARM_ERRATA_754322
 
 config ARCH_R8A7779
 	bool "R-Car H1 (R8A77790)"
 	select ARCH_RCAR_GEN1
+	select ARM_ERRATA_754322
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select SYSC_R8A7779
@@ -150,6 +154,7 @@ config ARCH_R9A06G032
 config ARCH_SH73A0
 	bool "SH-Mobile AG5 (R8A73A00)"
 	select ARCH_RMOBILE
+	select ARM_ERRATA_754322
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select RENESAS_INTC_IRQPIN
-- 
2.20.1



