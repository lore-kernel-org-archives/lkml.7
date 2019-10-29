Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E47CA9EC0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB7421835
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6jovQAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbfJ2Bnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 21:43:40 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46689 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729825AbfJ2Bnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 21:43:37 -0400
Received: by mail-qk1-f195.google.com with SMTP id e66so10583631qkf.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 18:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fiV788X183wD/PJfPt+Y7yn0iwo8M5Gxr89huOLS4Zc=;
        b=G6jovQAe7x6LBX2vtvRWfmgewJF5/FN52paTG1A+n0xjqe1cGSCFKjNNJQnLsSG177
         4MOfLqXcjVtkToCru32J6USc3azmwoO+nO30Bf7JhCFSy9ivk1EhL7dTmttKd9xAQUJe
         OGi3T2uHrRumoQNPaeA7genPoRTBZaVq9APsBRJspeiMxAgFepK396ARq/VEUVcIYpup
         TlGt1KXoSjXIQ5Z9y0VFJkyOuNMp17/AwNnDHG4f9JKOa9bCBqe4kNlhUr1A8GBAdjzN
         6OPW+uv033TPHo90xqBq5KdSXrFCGy2V3RsHaf283k+Q87udaLzUk7YGn5+ErkyQaZjk
         F3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fiV788X183wD/PJfPt+Y7yn0iwo8M5Gxr89huOLS4Zc=;
        b=sPaDdxprGIUaPDfDR5f7w83HEZOtuM0g/t1UhvTdcYECCr+QXH0RdLlDJdqt7gpZMY
         xix3YUL63ppwL0p0jYjchdTtBWEf8piXNaSPVs5JDDM80m7NPaTIw73DY/kSpPn9Wf8X
         YB4WnR61flDkJxOQ0dfNKRDMjyrGTNWuolu+OkQtt4SPR+7ZDZ7Eig+HFDRMGrwiOQAX
         Ad1uMwS8OparMcY+acIjURbKbnLNle5lSPXeVdCtZ0fB3tyd5I2cJLKOmC3Zv0pNB9tY
         ppMLqPPEMbCK7BGq3PVEjEwAksv2ChOIYHzE4ZEKmx1MNd864dNM1VQZtFdlSraQdcyb
         JXpA==
X-Gm-Message-State: APjAAAWXpmghV7dfdiAaaBWiX7P/tajA1vB1PvoApF+mHEsOu4AvvI9v
        t3mn8GcKPgaJTICS683x8X4=
X-Google-Smtp-Source: APXvYqzAgg7m+AIygZ095GEKwcNZi/0+FvLXaeYAahW9+rl9wZo86URqelkkHqPnbMZC11x4Q/OrwA==
X-Received: by 2002:ae9:e50f:: with SMTP id w15mr718693qkf.436.1572313416435;
        Mon, 28 Oct 2019 18:43:36 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:483:ade:87ad:69fb:5b32:cf88])
        by smtp.gmail.com with ESMTPSA id 197sm6698394qkh.80.2019.10.28.18.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 18:43:35 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        kim.jamie.bradley@gmail.com, nishkadg.linux@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH 4/5] staging: rts5208: Eliminate the use of Camel Case in file xd.h
Date:   Mon, 28 Oct 2019 22:43:15 -0300
Message-Id: <20191029014316.6452-5-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191029014316.6452-1-gabrielabittencourt00@gmail.com>
References: <20191029014316.6452-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up checks of "Avoid CamelCase" in file xd.h

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/rts5208/xd.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rts5208/xd.h b/drivers/staging/rts5208/xd.h
index 57b94129b26f..98c00f268e56 100644
--- a/drivers/staging/rts5208/xd.h
+++ b/drivers/staging/rts5208/xd.h
@@ -36,7 +36,7 @@
 #define	BLK_ERASE_1			0x60
 #define	BLK_ERASE_2			0xD0
 #define READ_STS			0x70
-#define READ_xD_ID			0x9A
+#define READ_XD_ID			0x9A
 #define	COPY_BACK_512			0x8A
 #define	COPY_BACK_2K			0x85
 #define	READ1_1_2			0x30
@@ -72,8 +72,8 @@
 #define	XD_128M_X16_2048		0xC1
 #define	XD_4M_X8_512_1			0xE3
 #define	XD_4M_X8_512_2			0xE5
-#define	xD_1G_X8_512			0xD3
-#define	xD_2G_X8_512			0xD5
+#define	XD_1G_X8_512			0xD3
+#define	XD_2G_X8_512			0xD5
 
 #define	XD_ID_CODE			0xB5
 
-- 
2.20.1

