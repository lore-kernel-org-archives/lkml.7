Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8874C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14B0215A5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887289;
	bh=7LaErUhJdmTpbtcjeuEhaAeVt66iI+/qbhdzpL30bTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jQsqOS7gQnK92G/vQwvV9H7LB8aMT5xKIprRqWvCv14d3ABBCVjNTltHmWXjnqzQU
	 uUU6x0SCP9C9LtfU21mEGlIeVozG5Rg1p50Xi+Hk7wu55ogeOEvsNXkit3maiik35t
	 3AqBgeE4Bw5QW4mg0Xb49CS/DrkVLsMXN3xAcNno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfK0Ul2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:41:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:46606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729178AbfK0UlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:41:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FD2320863;
        Wed, 27 Nov 2019 20:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887284;
        bh=7LaErUhJdmTpbtcjeuEhaAeVt66iI+/qbhdzpL30bTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V96QwTAPbGa/0nxJXIymzdv1sU6OSDF7gDZxQp+3by59TgCsILHxcM8P+iXWXWpYX
         FgNrD2PRFk/a57NNjm7YeXq7sNNUqhNT7XPAUtELmgaZfMyOcn1AoHfLZO9AF7cDoq
         B7zcEBZrofvoTa4pzn2o4hYo85Vt9SYEEfsvcVJQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 050/151] sparc: Fix parport build warnings.
Date:   Wed, 27 Nov 2019 21:30:33 +0100
Message-Id: <20191127203030.203630207@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David S. Miller <davem@davemloft.net>

[ Upstream commit 46b8306480fb424abd525acc1763da1c63a27d8a ]

If PARPORT_PC_FIFO is not enabled, do not provide the dma lock
macros and lock definition.  Otherwise:

./arch/sparc/include/asm/parport.h:24:24: warning: ‘dma_spin_lock’ defined but not used [-Wunused-variable]
 static DEFINE_SPINLOCK(dma_spin_lock);
                        ^~~~~~~~~~~~~
./include/linux/spinlock_types.h:81:39: note: in definition of macro ‘DEFINE_SPINLOCK’
 #define DEFINE_SPINLOCK(x) spinlock_t x = __SPIN_LOCK_UNLOCKED(x)

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/include/asm/parport.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sparc/include/asm/parport.h b/arch/sparc/include/asm/parport.h
index f005ccac91cc9..e87c0f81b700e 100644
--- a/arch/sparc/include/asm/parport.h
+++ b/arch/sparc/include/asm/parport.h
@@ -20,6 +20,7 @@
  */
 #define HAS_DMA
 
+#ifdef CONFIG_PARPORT_PC_FIFO
 static DEFINE_SPINLOCK(dma_spin_lock);
 
 #define claim_dma_lock() \
@@ -30,6 +31,7 @@ static DEFINE_SPINLOCK(dma_spin_lock);
 
 #define release_dma_lock(__flags) \
 	spin_unlock_irqrestore(&dma_spin_lock, __flags);
+#endif
 
 static struct sparc_ebus_info {
 	struct ebus_dma_info info;
-- 
2.20.1



