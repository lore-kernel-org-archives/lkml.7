Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C07FA3733
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3519F2089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="a81Dft1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409315AbfJQLtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 07:49:19 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40026 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409303AbfJQLtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:49:18 -0400
Received: by mail-lf1-f68.google.com with SMTP id f23so1634017lfk.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 04:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aRODApNsJVV2rJDwziBmWs3j8yPs9YphekPtecPLAiU=;
        b=a81Dft1duwadDoXnkkFElfwe10DpV2vpElINNcypWE7FBfOQcdZm18KcVc+ATFFWfY
         kljiMjoHa3+55HWqHvmqVQgGWo9RXUzhVHZjrE0zd8OkR6gSrKFL7ZiKkq1dZa9xeKmK
         ffSTvwj0Yuxj0ci/iv67cg1+6pSoOtiHZBRI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aRODApNsJVV2rJDwziBmWs3j8yPs9YphekPtecPLAiU=;
        b=YgVSKIGWbdjqGP6MXo4xFHHNyEDCPqdl7ZI6nCgVKBTWhf84K5IZQV5yywkSrKJ7+y
         tZW11AZLnL4yaAYCVASfw6vHL3uqGU4HdeztlNSF8YG6IvEV0lpxJTu0Zk7qWctPxWVW
         mKhtbajeHFyOFel1Jbxmk6bgagt5X4/T94iZUZUVM02KH7iaAI70qXGghGcZUP5ZyUbZ
         N+jcRw6K2Q+9HI7ICK8HUu4L+/LXLNPEGuqjbuCg8oUBHCvQYDDm6Tw1TZyxCZ9P98yh
         dQ6il6QmSCMS4sUVBBIKygddu+VRS4kl6CtfqsQOZB2ZMu4Yasr9UgJYGU2BsUa6rI3S
         +/Hg==
X-Gm-Message-State: APjAAAUtXE9Uf3dAWBsTkgB/GtRr1vgaZvqOZHhusCWqh9h5S3RKcZb4
        jFRHNPcj5Xgh8wGKj5G2ZoCamg7oZ6JgRMGM
X-Google-Smtp-Source: APXvYqyli5l3scW9RbTMDV7OJSAaURiEht8wF2Q1Cz/jerpQFJ/kBqqYjXUNWLCSY1A1nEqVUxLm7w==
X-Received: by 2002:a19:f707:: with SMTP id z7mr2017958lfe.162.1571312954818;
        Thu, 17 Oct 2019 04:49:14 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id x30sm920772ljd.39.2019.10.17.04.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 04:49:14 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gao Xiang <xiang@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel@pengutronix.de, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 2/3] lib: lz4: wire up watchdog keepalive during decompression
Date:   Thu, 17 Oct 2019 13:49:05 +0200
Message-Id: <20191017114906.30302-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017114906.30302-1-linux@rasmusvillemoes.dk>
References: <20191017114906.30302-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some boards have a hardware watchdog that (a) cannot be disabled
and (b) has a timeout short enough that there's no chance for the
kernel to get through decompression, let alone reach the
initialization of the appropriate watchdog device driver.

In order to allow booting such boards, the decompression routine needs
to service the watchdog in its main loop. This wires up lz4 to do that
via the decompress_keepalive() macro defined in the new
linux/decompress/keepalive.h.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/lz4/lz4_decompress.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/lz4/lz4_decompress.c b/lib/lz4/lz4_decompress.c
index 0c9d3ad17e0f..54ba41d073a6 100644
--- a/lib/lz4/lz4_decompress.c
+++ b/lib/lz4/lz4_decompress.c
@@ -39,6 +39,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <asm/unaligned.h>
+#include <linux/decompress/keepalive.h>
 
 /*-*****************************
  *	Decompression functions
@@ -129,6 +130,7 @@ static FORCE_INLINE int LZ4_decompress_generic(
 
 		/* ip < iend before the increment */
 		assert(!endOnInput || ip <= iend);
+		decompress_keepalive();
 
 		/*
 		 * A two-stage shortcut for the most common case:
-- 
2.20.1

