Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC9DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085F92184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rTku9ekx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfCNIiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 04:38:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39369 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfCNIiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 04:38:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id h8so3495871pgp.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 01:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=30vebO2M7s86h+bgRozKToa38rLhn+5TImed8PXHvkA=;
        b=rTku9ekxRqeOqpFkpVZDslv9tFwbpQhuc71cG7VkVF4/FTWDXBGYLy20CpYUk61o25
         qYLUePdfe0AwTST86gRzsAgLGul6u8ZadKZO3JNxpudPg9A+i89qIdcC+6/zSlnglMKQ
         jsI2JjLC7rJ12jgG43AUDSXPjtYsNMDQDCr8pR3ZpxrN0WsKOiKdH2o3YklQgtZeT41E
         600DnOFkg2H7zDfbd9rEWP5eYxvABGpODAqBoT4oQqZ3nUdeTF/8B52flh+8pGJ4ytwZ
         54jx4gWcOuY9Wqmw+7eGu0gW9of6L6mXj7rRqz2mjGB5EjdAowgzErehONEV7UAr//2Z
         StQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=30vebO2M7s86h+bgRozKToa38rLhn+5TImed8PXHvkA=;
        b=HU8VWd8GUJEf0iNj9R5WKH6IIRCen12RKBvw0wVmhaJyWDzz38hAijBcA9GbTUMJ1b
         LdrjVw46KuqCafCtlwyXFKrnNC4MKxZBwfb73x/5Fe4tI9mpPaMTzb4ioR5yhOZ0TMnR
         a14KB5HdM/uK+oeZ7fOTFMR9K0RvXnuaYUWaqhr+1bwIMGB20+LrNGZ6EvUS3kRYkTTw
         7MR0+/y6iMy8wFcG2P4VgnF1uA9rcH7nAQWSgMv06/m11nam3HO2RmZk0xiUj2iqmSvd
         yOM7R1tvhQOjZDYoR2SsAhUrfp/LXyHO6Ms071O6k0MVDw3nVljwLAd5BNlw0HnrF7un
         6AfA==
X-Gm-Message-State: APjAAAWfQ4rJPP9qdAnuqxcg0Ik515S8qX2TRF+bzn1lvFnBsDiazzbM
        qoeKc9xomsUhU4il6jiOKvM=
X-Google-Smtp-Source: APXvYqz6L6mEkSM9vos0uXnnWgupOgEVWWz8y1Pyy7Od8UEIi7Vka7RAYKD0H0rSFh+Hp/+M9XMCnA==
X-Received: by 2002:a63:4650:: with SMTP id v16mr16281311pgk.329.1552552684200;
        Thu, 14 Mar 2019 01:38:04 -0700 (PDT)
Received: from localhost.localdomain ([175.223.23.218])
        by smtp.gmail.com with ESMTPSA id g3sm20830999pfo.125.2019.03.14.01.38.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 01:38:03 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] jffs2: do not use __constant_cpu_to_xx
Date:   Thu, 14 Mar 2019 17:37:57 +0900
Message-Id: <20190314083757.25039-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A trivial patch.

cpu_to_XX() functions are smart enough to detect and
handle __builtin_constant_p() at compile time.

So we can use cpu_to_XX() instead of __constant_cpu_to_XX().

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 fs/jffs2/nodelist.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/jffs2/nodelist.h b/fs/jffs2/nodelist.h
index 0637271f3770..b1de897b3408 100644
--- a/fs/jffs2/nodelist.h
+++ b/fs/jffs2/nodelist.h
@@ -48,8 +48,8 @@
 #define cpu_to_je32(x) ((jint32_t){cpu_to_be32(x)})
 #define cpu_to_jemode(x) ((jmode_t){cpu_to_be32(os_to_jffs2_mode(x))})
 
-#define constant_cpu_to_je16(x) ((jint16_t){__constant_cpu_to_be16(x)})
-#define constant_cpu_to_je32(x) ((jint32_t){__constant_cpu_to_be32(x)})
+#define constant_cpu_to_je16(x) ((jint16_t){cpu_to_be16(x)})
+#define constant_cpu_to_je32(x) ((jint32_t){cpu_to_be32(x)})
 
 #define je16_to_cpu(x) (be16_to_cpu(x.v16))
 #define je32_to_cpu(x) (be32_to_cpu(x.v32))
@@ -59,8 +59,8 @@
 #define cpu_to_je32(x) ((jint32_t){cpu_to_le32(x)})
 #define cpu_to_jemode(x) ((jmode_t){cpu_to_le32(os_to_jffs2_mode(x))})
 
-#define constant_cpu_to_je16(x) ((jint16_t){__constant_cpu_to_le16(x)})
-#define constant_cpu_to_je32(x) ((jint32_t){__constant_cpu_to_le32(x)})
+#define constant_cpu_to_je16(x) ((jint16_t){cpu_to_le16(x)})
+#define constant_cpu_to_je32(x) ((jint32_t){cpu_to_le32(x)})
 
 #define je16_to_cpu(x) (le16_to_cpu(x.v16))
 #define je32_to_cpu(x) (le32_to_cpu(x.v32))
-- 
2.21.0

