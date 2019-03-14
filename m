Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FD2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B1D2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Av3AOM0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfCNGP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:15:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36278 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfCNGP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:15:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id n22so3150457pfa.3;
        Wed, 13 Mar 2019 23:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q87LftWO5iBuJXaxM2/XOAFMoWPTRqR3XSEk65pBRv8=;
        b=Av3AOM0kM7z41gbJ1u4uzSLlAN+B7ZVV+3SYwaAuw6F1PKTN5wr86Vi7FGYn1CfoTF
         KWAqiUTJysfSCBvn82caF3OCssa+zgMpY+kMxCgO0lfdMv1v56XS71rT67n/A5wlOH+S
         6Pj6Y7rTONQTtCrT0jUSSYpU7uKI1FfkZ1jFFEoQQkQAgikxMPGcIZti4dCQ4eSfUa8F
         U1BYVJ9yW5iILc3mojeRx2wN/RY/VycJN4LOpv3wELmGDGPSqED56uTmDcdjoNkPDqUh
         BZS52mjtw1V0MQdKLdkkx8FfNsZNEUSA01uEWQX8NdO11VtJZoFyhD8lEVMraToODXHN
         a1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q87LftWO5iBuJXaxM2/XOAFMoWPTRqR3XSEk65pBRv8=;
        b=WefUEs2MYCGHgdEFDPvGjMJoIBjSaOwD6PP/SiI9yhZdonJ79ZwQh7ssGPs7YPfg4h
         wN+ns/V9n33OkXMIfAYbsuE1Vwlq6Hep5ARqhr6ljrqu2rxfgepDp48BClJfYoiPkG9D
         qFr4x+TNHQKr4QNA1DopUzpYqRUzUVhyO21jkQWkIplmBMgkGh9QZ2n6UQ5ycPMUNzTq
         6HruagLHi07e6JrhZawTf9esAAS/G7YyvdHF2/s8aLsdbjK198jQ5z7uh66whxsgqTye
         HViDi3IroOlROWSRM6OvXwu4YN/xYtfDUX1uRJo2iAqgWcOfbeu//X/i4+um0NuLxdu0
         UW3Q==
X-Gm-Message-State: APjAAAWDupERO8ltHhzj7K2gz80v1t4r1dxJzU0B+YmoJgcwyb4tWuEj
        Z+bRnfuq4dyFPuWQHWAsa8A=
X-Google-Smtp-Source: APXvYqzYdmO99PUgIZyzN0u4qUloWDNk/L0Vlh+AIGfkoPKZIR52OmjZmZbBB9onHODabr9RE1ovEA==
X-Received: by 2002:a17:902:e85:: with SMTP id 5mr49965272plx.13.1552544126975;
        Wed, 13 Mar 2019 23:15:26 -0700 (PDT)
Received: from localhost.localdomain ([175.223.23.218])
        by smtp.gmail.com with ESMTPSA id k7sm17179498pgo.60.2019.03.13.23.15.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 23:15:26 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] tcp: don't use __constant_cpu_to_be32
Date:   Thu, 14 Mar 2019 15:15:14 +0900
Message-Id: <20190314061514.19586-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A trivial patch.

cpu_to_be32() is capable enough to detect __builtin_constant_p()
and to use an appropriate compile time ___constant_swahb32()
function.

So we can use cpu_to_be32() instead of __constant_cpu_to_be32().

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 include/uapi/linux/tcp.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index 8bb6cc5f3235..7d2330df9652 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -70,16 +70,16 @@ union tcp_word_hdr {
 #define tcp_flag_word(tp) ( ((union tcp_word_hdr *)(tp))->words [3]) 
 
 enum { 
-	TCP_FLAG_CWR = __constant_cpu_to_be32(0x00800000),
-	TCP_FLAG_ECE = __constant_cpu_to_be32(0x00400000),
-	TCP_FLAG_URG = __constant_cpu_to_be32(0x00200000),
-	TCP_FLAG_ACK = __constant_cpu_to_be32(0x00100000),
-	TCP_FLAG_PSH = __constant_cpu_to_be32(0x00080000),
-	TCP_FLAG_RST = __constant_cpu_to_be32(0x00040000),
-	TCP_FLAG_SYN = __constant_cpu_to_be32(0x00020000),
-	TCP_FLAG_FIN = __constant_cpu_to_be32(0x00010000),
-	TCP_RESERVED_BITS = __constant_cpu_to_be32(0x0F000000),
-	TCP_DATA_OFFSET = __constant_cpu_to_be32(0xF0000000)
+	TCP_FLAG_CWR = cpu_to_be32(0x00800000),
+	TCP_FLAG_ECE = cpu_to_be32(0x00400000),
+	TCP_FLAG_URG = cpu_to_be32(0x00200000),
+	TCP_FLAG_ACK = cpu_to_be32(0x00100000),
+	TCP_FLAG_PSH = cpu_to_be32(0x00080000),
+	TCP_FLAG_RST = cpu_to_be32(0x00040000),
+	TCP_FLAG_SYN = cpu_to_be32(0x00020000),
+	TCP_FLAG_FIN = cpu_to_be32(0x00010000),
+	TCP_RESERVED_BITS = cpu_to_be32(0x0F000000),
+	TCP_DATA_OFFSET = cpu_to_be32(0xF0000000)
 }; 
 
 /*
-- 
2.21.0

