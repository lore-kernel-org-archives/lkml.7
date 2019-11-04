Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E91FCA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E772214D8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572904232;
	bh=DuplhoRQredmAuojEW6TUPC1yPAM/K2dTnu2HW9tcM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QUx6JuKWwuvW5hUP4NsaQUTKQVmkACd8rHyFn1oEyHvNamBMu9PxJHHQsireErh8s
	 DCsta1T7aAo7IEo+kWw2m96OltyyNpJjt2d+hcAy0lem4ZQJalLuIJ6qI/MpMHWnzJ
	 6gyY3Y/Elf3jYLfnMVRNRY2V0Ak/FiIovgPMkHkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387721AbfKDVub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:50:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:42526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387689AbfKDVuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:50:24 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51C87214D8;
        Mon,  4 Nov 2019 21:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904223;
        bh=DuplhoRQredmAuojEW6TUPC1yPAM/K2dTnu2HW9tcM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1XaCdidX3cAqn0QGGO8VqZLygYyOoA7BlCfDnky9VRSXLuWYhheJHBrA4vc+7koTw
         LHJuSjpGr5aFTezViQ+YwYK+PjlkCFWmBOgisjFI/2lhBjA0hVjT4K11XOGe38HMmZ
         +ANgp89SSTxf3ISEPrHH+lyahFFxNSHxH3spZJWk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 27/62] MIPS: fw: sni: Fix out of bounds init of o32 stack
Date:   Mon,  4 Nov 2019 22:44:49 +0100
Message-Id: <20191104211926.294578388@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104211901.387893698@linuxfoundation.org>
References: <20191104211901.387893698@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Bogendoerfer <tbogendoerfer@suse.de>

[ Upstream commit efcb529694c3b707dc0471b312944337ba16e4dd ]

Use ARRAY_SIZE to caluculate the top of the o32 stack.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/fw/sni/sniprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/fw/sni/sniprom.c b/arch/mips/fw/sni/sniprom.c
index 6aa264b9856ac..7c6151d412bd7 100644
--- a/arch/mips/fw/sni/sniprom.c
+++ b/arch/mips/fw/sni/sniprom.c
@@ -42,7 +42,7 @@
 
 /* O32 stack has to be 8-byte aligned. */
 static u64 o32_stk[4096];
-#define O32_STK	  &o32_stk[sizeof(o32_stk)]
+#define O32_STK	  (&o32_stk[ARRAY_SIZE(o32_stk)])
 
 #define __PROM_O32(fun, arg) fun arg __asm__(#fun); \
 				     __asm__(#fun " = call_o32")
-- 
2.20.1



