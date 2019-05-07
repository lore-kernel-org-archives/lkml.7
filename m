Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E071C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACA6214AE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4n96ez5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfEGGBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:01:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41654 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfEGGBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 02:01:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id z3so4012531pgp.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 23:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UdlhNmncQt68SNh9Q/6nsPN42unpZnH30BwmpVsaWqg=;
        b=K4n96ez51FxYMSjV3AwWRVwu6aK7Sv3T3F40tH9NH8ExfkH6Y0pSeyuAX2ulXGiXgZ
         ddqJ9y2IvS73rx/MJg9VBNfVn7m+ohjwG1KX+KSIQ+0d2GIwN3MP6LqgxfOW3eA8YO8X
         d5LyIpElXCazVoF7i1pRb0ZVBUFZhwhz09mZzCIEhnQVhWbR6H4gd0F+zAUqWh6PqRVz
         opyGTK6m5aFIfxcNn8ZlhO73Ug16Jt5bRMNUeMCGUmZ3CmuVEpqk0tihpLSOFSGmBwaj
         +mB09oPvNhoKVigRS9fpicLYHpf28UFfQkeubRYepnjbqLI0cu0TWjZBygrfUdr96wxN
         KzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UdlhNmncQt68SNh9Q/6nsPN42unpZnH30BwmpVsaWqg=;
        b=c0Fag87wWtAE6W6KZM4+UzumuwBSWDkpIbvB6ENyrOFtaHoWRDwjfA9n/1OLqMORyE
         8ij5bFaaEm1172d26fFqJTPHYLlBjczJ8DMBb8yrDmFcUV3rXFEy2r5Gk2kay3yoQpQB
         gkpN1Kkc2hBOAhC8rCtw2jyLXkMYedUujQH6vq75AFu4A3nT02Vl1LQmXwxEtS1Pinrd
         iCzuRJ5flcZnomW1H3jLiZ3+W20098DW/5Ukkk9ESrVq4LLEeF3rA0uJbXfI5/N4npvx
         YPVgQ+AzIFGGAMYQSO0ECaqk5eBYQohd897VKTFZVWG+o8OdgGT4LxsgbqWLLtKS78a0
         NBfA==
X-Gm-Message-State: APjAAAVAGJ90r2nDZKDcUeP3S3G4+13uYiSvVah1lGPWzo/U5ZNb1qgH
        BgNf6x/cMRk8h0NvI/ByuA==
X-Google-Smtp-Source: APXvYqxkSRBG5Y+LBRYnfawHEhwPlKbopAjaFHdRmODBvET7Q/5U3ABNq51poGlBhwo+tU9oEj19Xw==
X-Received: by 2002:a63:2cc9:: with SMTP id s192mr33552150pgs.24.1557208877228;
        Mon, 06 May 2019 23:01:17 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b18sm8997409pfp.32.2019.05.06.23.01.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 23:01:16 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jordan Borgner <mail@jordan-borgner.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86/boot: move early_serial_base to .data section
Date:   Tue,  7 May 2019 14:00:59 +0800
Message-Id: <1557208860-12846-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/x86/boot/compressed/head_64.S clears BSS after relocated. If early
serial is set up before clearing BSS, the early_serial_base will be reset
to 0.

Initializing early_serial_base as -1 to push it to .data section.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jordan Borgner <mail@jordan-borgner.de>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/boot/compressed/early_serial_console.c | 2 +-
 arch/x86/boot/early_serial_console.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/early_serial_console.c b/arch/x86/boot/compressed/early_serial_console.c
index 261e81f..624e334 100644
--- a/arch/x86/boot/compressed/early_serial_console.c
+++ b/arch/x86/boot/compressed/early_serial_console.c
@@ -1,5 +1,5 @@
 #include "misc.h"
 
-int early_serial_base;
+int early_serial_base = -1;
 
 #include "../early_serial_console.c"
diff --git a/arch/x86/boot/early_serial_console.c b/arch/x86/boot/early_serial_console.c
index 023bf1c..d8de15a 100644
--- a/arch/x86/boot/early_serial_console.c
+++ b/arch/x86/boot/early_serial_console.c
@@ -149,6 +149,6 @@ void console_init(void)
 {
 	parse_earlyprintk();
 
-	if (!early_serial_base)
+	if (early_serial_base <= 0)
 		parse_console_uart8250();
 }
-- 
2.7.4

