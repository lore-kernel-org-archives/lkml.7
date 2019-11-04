Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03619CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC7E218BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572904095;
	bh=DuplhoRQredmAuojEW6TUPC1yPAM/K2dTnu2HW9tcM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QVgDGEJgdbB9IvQ54Nb9P82WUva3d4TXZbd7oQezRO2yZjBhjmGo8X6YE+9aq3Tc/
	 xtYa8497vhVZaT7MOpfOdNq9UCMmYfeuooC80/ShMnNaLC4aPAUVfTNfO6SUcqxC31
	 4C+EQeHpD6L8RcRLNrdqv4LazJ5oWKXByCYTdHYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbfKDVsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:48:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729937AbfKDVsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:48:12 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 296D021D71;
        Mon,  4 Nov 2019 21:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904091;
        bh=DuplhoRQredmAuojEW6TUPC1yPAM/K2dTnu2HW9tcM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XZI/4WdVmqhdykJ+MY+TE4cLW3Duur4Q27ccYB3v245jlFXvvYA/Z5V4VJgsTDaSv
         AnQCx8OTjiHjZExOz1SrHv7olMZFbj6LZZYgJXXwFjPZyCSakzFYm8CKMrgfykzz5E
         TAvMWa6pYXl62YmAMx89tRxRfmhN1e2mwCFhf3qk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 19/46] MIPS: fw: sni: Fix out of bounds init of o32 stack
Date:   Mon,  4 Nov 2019 22:44:50 +0100
Message-Id: <20191104211849.216560250@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104211830.912265604@linuxfoundation.org>
References: <20191104211830.912265604@linuxfoundation.org>
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



