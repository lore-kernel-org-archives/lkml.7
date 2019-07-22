Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C915C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD082231F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAh0Z3QD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfGVHLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 03:11:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43510 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfGVHLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 03:11:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so16930129pfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 00:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e1pJmXf06oFMwCzMyXmo4V3Hcs9L90I0Lgp7Zs+lizs=;
        b=iAh0Z3QDrCqnhE6s5INTogxHKD1RMM0Afq5gQ9G5TTIv+84InCYsEJwIsWDmMzciYL
         kF+ABGPCiz7nv6hIoX8J8Nmk2Ia2Pmn47cXlHbRFq4lon6dXVUeqycjg29Y1cV2zs7Ot
         RjhwlEu0RliMS34cgKQSSQJTCZNet7811kRlvigJITVWiaii2cRdvxMqF3cx2axLKWx8
         XF/EDjGBzXO0TaAucl3/mhya7x+4yNTW0HgmTGRfH9cHY3VPPTI49syz9CI1bbZ509m0
         Zx4Hmg5zt4+boXTsyw14Nlq2iT+xb1E52Cju9XpqVQRUnK9aBiesTv8j6Ga+lU+6qYdY
         uS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e1pJmXf06oFMwCzMyXmo4V3Hcs9L90I0Lgp7Zs+lizs=;
        b=qrbfV0KvPeA/DSH2q4aGYGm13ivGupgFePsUuWx545sMbH/qV3mlpL6uLjcRGMRMrT
         oQAhbRW5cu1j+HubL5Plc+YVEh8HN6gLaw5Ss47UirrmspCJmTzKzrm5WrkiWQbE6EhH
         yU02SqbH2v5nA/gganigaW4aSU7+RUBXssvu6W0cp9KtTCNdoaraDFbEvO+zpprUi67n
         q3KDNKb0QMvMdkEFORI/epAw7LSPXkPJbxjnBOQy1qlkJMx/wek/Y0iUlr/pPoPJZgrD
         PuQu8sqyDvtgMGPbytwn2/VWg0fJhRyiHaO7rx8EhLpUfl4XAb1cTuxYepLqPw4WILN1
         coPA==
X-Gm-Message-State: APjAAAWbwdg7eO9kGvr2WO96zYVAkusTStFpQN6v321YKIguY09+l6cc
        CEJNeqnX7SZ/alres2I/DXQ=
X-Google-Smtp-Source: APXvYqw90pms2WbCzTCZEmaN/6pRv51JhveW4MUeNKwghaamFFptL7ODl0b6Urb5d753rcgiiBSEZQ==
X-Received: by 2002:a65:6546:: with SMTP id a6mr15364250pgw.220.1563779502459;
        Mon, 22 Jul 2019 00:11:42 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id q69sm53738861pjb.0.2019.07.22.00.11.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 00:11:41 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Lvqiang Huang <lvqiang.huang@unisoc.com>
Subject: [PATCH] ARM: check stmfd instruction using right shift
Date:   Mon, 22 Jul 2019 15:11:22 +0800
Message-Id: <20190722071122.22434-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lvqiang Huang <Lvqiang.Huang@unisoc.com>

In the commit ef41b5c92498 ("ARM: make kernel oops easier to read"),
-               .word   0xe92d0000 >> 10        @ stmfd sp!, {}
+               .word   0xe92d0000 >> 11        @ stmfd sp!, {}
then the shift need to change to 11.

Signed-off-by: Lvqiang Huang <Lvqiang.Huang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
---
 arch/arm/lib/backtrace.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/lib/backtrace.S b/arch/arm/lib/backtrace.S
index 7d7952e..926851b 100644
--- a/arch/arm/lib/backtrace.S
+++ b/arch/arm/lib/backtrace.S
@@ -70,7 +70,7 @@ for_each_frame:	tst	frame, mask		@ Check for address exceptions
 
 1003:		ldr	r2, [sv_pc, #-4]	@ if stmfd sp!, {args} exists,
 		ldr	r3, .Ldsi+4		@ adjust saved 'pc' back one
-		teq	r3, r2, lsr #10		@ instruction
+		teq	r3, r2, lsr #11		@ instruction
 		subne	r0, sv_pc, #4		@ allow for mov
 		subeq	r0, sv_pc, #8		@ allow for mov + stmia
 
-- 
1.7.9.5

