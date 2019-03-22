Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B55C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544352082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254580;
	bh=hGtLCtVWZRAXucGjc5BVXWhWYWDk9J+iaCsnRx5sg9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lae7b0VQx8SKup0BacuzZOl1R5w2XuK7KrccSYUuLtzbzoWpQ6qkL4v6RWuC0RSUa
	 5hqJ5Beqy1qDAqdinODgacaPskYT924DRYO8THdrqvNBomPl0RddR5wMmyDbItSb+X
	 mPgqNp6aB+2mpYt3ZQNiV7qUfbfd5ad7q7hOA9qA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbfCVLgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:36:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730058AbfCVLgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:36:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC6182082C;
        Fri, 22 Mar 2019 11:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254575;
        bh=hGtLCtVWZRAXucGjc5BVXWhWYWDk9J+iaCsnRx5sg9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b5a/ymC73sCpnQ6rNO+4FiTxVu4hU+Njs1SkiailYmLqUBfV/AYeEqcIQFO8AYFPK
         OGP4ncNqE9d4Ob1Gd8W/MT5bhuH02nSclI2EzpCGC7W16DazimFoOUSm3K+0pz7BZl
         6rd7+HWKYE6bNFMS/QzVdcOz6/Wx4wNsCuryCJ/I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chase Conklin <Chase.Conklin@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 170/230] arm64: Relax GIC version check during early boot
Date:   Fri, 22 Mar 2019 12:15:08 +0100
Message-Id: <20190322111248.688535995@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 74698f6971f25d045301139413578865fc2bd8f9 ]

Updates to the GIC architecture allow ID_AA64PFR0_EL1.GIC to have
values other than 0 or 1. At the moment, Linux is quite strict in the
way it handles this field at early boot stage (cpufeature is fine) and
will refuse to use the system register CPU interface if it doesn't
find the value 1.

Fixes: 021f653791ad17e03f98aaa7fb933816ae16f161 ("irqchip: gic-v3: Initial support for GICv3")
Reported-by: Chase Conklin <Chase.Conklin@arm.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/head.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 0382eba4bf7b..6299a8a361ee 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -478,8 +478,7 @@ CPU_LE(	bic	x0, x0, #(3 << 24)	)	// Clear the EE and E0E bits for EL1
 	/* GICv3 system register access */
 	mrs	x0, id_aa64pfr0_el1
 	ubfx	x0, x0, #24, #4
-	cmp	x0, #1
-	b.ne	3f
+	cbz	x0, 3f
 
 	mrs_s	x0, ICC_SRE_EL2
 	orr	x0, x0, #ICC_SRE_EL2_SRE	// Set ICC_SRE_EL2.SRE==1
-- 
2.19.1



