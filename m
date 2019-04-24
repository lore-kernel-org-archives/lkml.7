Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0906C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7196421902
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116787;
	bh=ffuS2YlLGfWKuSDBqz0cTSvblLPLqxxwnPU2mc8t5+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tb9RMazw8Uc56uD1WXGED4wjbO/Em4Kq77X+D+ILIicMeYfQJLS+Pn/ixNlI6RBV5
	 BirKaOnPMhp8Ocdc6Rs2vf0qSHoFLr6aNnLe9UP4yzVl9nPWvu4toVTcCEPB5Cbjkl
	 yRW24pNydm37HoVUwHG3E3yGpi2JqrFI8osykDII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731777AbfDXOjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:39:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731076AbfDXOjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:39:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55E5121902;
        Wed, 24 Apr 2019 14:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116784;
        bh=ffuS2YlLGfWKuSDBqz0cTSvblLPLqxxwnPU2mc8t5+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2FcrqC6MdKcO/7hG8GHez7DCoyAbzlsd6u062MBTEDraD+2r7V7hJnZtwWUfHoVvz
         iYluZiXVzO0/BW68WjRCkvQZ8DMGSWhDxMEXnFZlUzZ61L9lplfhV1vqBI8Gyfvlpo
         9aduns880N0iTXpZINKYJx3ARpN3+OBQjA9L4DfI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alan Kao <alankao@andestech.com>,
        Greentime Hu <greentime@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 14/52] riscv: fix accessing 8-byte variable from RV32
Date:   Wed, 24 Apr 2019 10:38:32 -0400
Message-Id: <20190424143911.28890-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143911.28890-1-sashal@kernel.org>
References: <20190424143911.28890-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Kao <alankao@andestech.com>

[ Upstream commit dbee9c9c45846f003ec2f819710c2f4835630a6a ]

A memory save operation to 8-byte variable in RV32 is divided into
two sw instructions in the put_user macro.  The current fixup returns
execution flow to the second sw instead of the one after it.

This patch fixes this fixup code according to the load access part.

Signed-off-by: Alan Kao<alankao@andestech.com>
Cc: Greentime Hu <greentime@andestech.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index 8c3e3e3c8be1..f0ea3156192d 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -307,7 +307,7 @@ do {								\
 		"	.balign 4\n"				\
 		"4:\n"						\
 		"	li %0, %6\n"				\
-		"	jump 2b, %1\n"				\
+		"	jump 3b, %1\n"				\
 		"	.previous\n"				\
 		"	.section __ex_table,\"a\"\n"		\
 		"	.balign " RISCV_SZPTR "\n"			\
-- 
2.19.1

