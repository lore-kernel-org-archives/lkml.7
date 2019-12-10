Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752AAC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404B02077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfu2d5H7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfLJWvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:51:06 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:35201 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfLJWvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:51:05 -0500
Received: by mail-wr1-f54.google.com with SMTP id g17so21962127wro.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 14:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Iq7lLPDxZxyyF6K7jckWs0XvEiXpXcXtYgOmBPW0oiE=;
        b=qfu2d5H7ZzEuxsIddTw+GLtP96qTv+bVqRU7LssVtRfl7wPwS4w08BJpF9+uo823Z6
         lgtIu5Zvu3K5vC8P59KtpBKs17wDe09XqWmsGZZ1TRMHUZQYTBFSvG3pG+qjKAR0gKuu
         0AyvkBjFZ76Q7o6WMY8e2YGWNfQQv3IFO9TIYYqP7xvCgJTclaiyc60ZdsXSd/LeGBlW
         h9mwYwVVenTJpc5dlFc1BZ55IPjWea/q8jbea52IfZUIz6vorwSCcvFsyMZp6EIRmWRZ
         Y309LnnM/CWkzpkj7gStv4ey/z0MqbIjka9g2kNqRoDx50c+3W1ZphOhc2xsSAsHuXrj
         m35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Iq7lLPDxZxyyF6K7jckWs0XvEiXpXcXtYgOmBPW0oiE=;
        b=tlDNdY608aKp+jqqlHgdgB/m2Ix+TvBzzOE5Zrob0y6kFkuBL+cnDCOXNtF19/fBYY
         UxdVFfp4C1qiCDY+FNpKd2XZytkaAfTP9UfR2aqMJT+iTAfLby4Ao4wi5xSGwCbs7Ozf
         apEMncn7cCec9Pvn9wz5KcAKtkA7vIF8Q7qaFrQ7/ZZFA+SxDO7Dvv4zjzf/q4I+2+Oj
         UYQeAsQJ3jvpb80gJV1V8lggAksMBwfjkucWVAN/CywsHDwDr4XuEPGj+jS2JAf/SzC0
         HZN+vZ6cyMqJZthkC2Unw4VpopxAIEmOKT3mMsy6yJf9gzAsuUzYhgl5mI6E/0fGRDhd
         hyAg==
X-Gm-Message-State: APjAAAW9rzI+wGNPoU7cvX/YnGybSraFEQvHAlfuiBhjmA+nsR0kbKbr
        AWsbY8BoKmo4CqUXiteRkP4=
X-Google-Smtp-Source: APXvYqzWRtBZ0UuaeYln6buH5vRRA/W31n533sLUd++FnjhAQcd4ruwcZMQnYcr+kxgYU2wJVc78Cg==
X-Received: by 2002:a5d:4805:: with SMTP id l5mr5692293wrq.3.1576018263594;
        Tue, 10 Dec 2019 14:51:03 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id i8sm4884042wro.47.2019.12.10.14.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 14:51:02 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Justin Chen <justinpopo6@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: brcmstb: Add debug UART entry for 7216
Date:   Tue, 10 Dec 2019 14:48:56 -0800
Message-Id: <20191210224859.30899-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Justin Chen <justinpopo6@gmail.com>

7216 has the same memory map as 7278 and the same physical address for
the UART, alias the definition accordingly.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
[florian: expand commit message]
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/include/debug/brcmstb.S | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/debug/brcmstb.S b/arch/arm/include/debug/brcmstb.S
index bf8702ee8f86..132a20c4a676 100644
--- a/arch/arm/include/debug/brcmstb.S
+++ b/arch/arm/include/debug/brcmstb.S
@@ -31,6 +31,7 @@
 #define UARTA_7268		UARTA_7255
 #define UARTA_7271		UARTA_7268
 #define UARTA_7278		REG_PHYS_ADDR_V7(0x40c000)
+#define UARTA_7216		UARTA_7278
 #define UARTA_7364		REG_PHYS_ADDR(0x40b000)
 #define UARTA_7366		UARTA_7364
 #define UARTA_74371		REG_PHYS_ADDR(0x406b00)
@@ -82,17 +83,18 @@ ARM_BE8(	rev	\rv, \rv )
 
 		/* Chip specific detection starts here */
 20:		checkuart(\rp, \rv, 0x33900000, 3390)
-21:		checkuart(\rp, \rv, 0x72500000, 7250)
-22:		checkuart(\rp, \rv, 0x72550000, 7255)
-23:		checkuart(\rp, \rv, 0x72600000, 7260)
-24:		checkuart(\rp, \rv, 0x72680000, 7268)
-25:		checkuart(\rp, \rv, 0x72710000, 7271)
-26:		checkuart(\rp, \rv, 0x72780000, 7278)
-27:		checkuart(\rp, \rv, 0x73640000, 7364)
-28:		checkuart(\rp, \rv, 0x73660000, 7366)
-29:		checkuart(\rp, \rv, 0x07437100, 74371)
-30:		checkuart(\rp, \rv, 0x74390000, 7439)
-31:		checkuart(\rp, \rv, 0x74450000, 7445)
+21:		checkuart(\rp, \rv, 0x72160000, 7216)
+22:		checkuart(\rp, \rv, 0x72500000, 7250)
+23:		checkuart(\rp, \rv, 0x72550000, 7255)
+24:		checkuart(\rp, \rv, 0x72600000, 7260)
+25:		checkuart(\rp, \rv, 0x72680000, 7268)
+26:		checkuart(\rp, \rv, 0x72710000, 7271)
+27:		checkuart(\rp, \rv, 0x72780000, 7278)
+28:		checkuart(\rp, \rv, 0x73640000, 7364)
+29:		checkuart(\rp, \rv, 0x73660000, 7366)
+30:		checkuart(\rp, \rv, 0x07437100, 74371)
+31:		checkuart(\rp, \rv, 0x74390000, 7439)
+32:		checkuart(\rp, \rv, 0x74450000, 7445)
 
 		/* No valid UART found */
 90:		mov	\rp, #0
-- 
2.17.1

