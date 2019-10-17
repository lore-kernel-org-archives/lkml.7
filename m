Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B71FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1C621848
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Y94hZcrB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502103AbfJQLtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 07:49:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37376 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405899AbfJQLtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:49:16 -0400
Received: by mail-lj1-f195.google.com with SMTP id l21so2221408lje.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 04:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v8LKBRBxcaymYywQC1yoyW7qk1pLqld/GOLoE3N0/Gk=;
        b=Y94hZcrB1Y777DAYUOPKEcDZveCY0YSN4thc+ix3qgL9cYKMOVj69ctzDms1zp9Pck
         jt8E4tROWs+rMeMU4TR/buZTRzbxGNP4SpmvAyNhcttPsW8OXf3f21N6EyvoC2dhf+8l
         MMmTyDhdL9xm3opCRJRWwlpcbPUmnPAaUZ+As=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v8LKBRBxcaymYywQC1yoyW7qk1pLqld/GOLoE3N0/Gk=;
        b=s1OWA158tlRw8PqDLgilgs+upiDke9+QsoB+pEMT7S0Lpq9qU9YSKLcRoOaHLDfhiu
         SYgOthpEoHei/GeCQjX67A1dyotrvRE5d1/GvQvj/efKE2tgFJ3Y9J42UEoix9iiNCSO
         TUbI6pLrsKDQAsVu54/cjcsOhY7H3ML6QofqVYV+JTxOrD+hTgni2x5phWGGd4jSLRa1
         gr3AB85MdlLKwkLUHvCWklRpAOlU8+HFkGlme0tN1c5CoUsaQROTLQyJQqyqdXZdpRXK
         6t0LaduIxMCstHzdBIV+ZSlRGDgGYSSeV1gCmkNSMwKtmmRHvq/qTo50547VHmPPwGwn
         jXaw==
X-Gm-Message-State: APjAAAUapRRDmPq7csL0ITa9cr+5/uCgSzoLmn3WXjdCK68qgs1+7XQI
        XfLJVrKrr/sQa6OjvW9lLlQwNA==
X-Google-Smtp-Source: APXvYqwMm83t6Ayeaku/Uq23tNm6C0IkV0iS3pOoZUwg5XfkH0rI651FLIb5bwUm/9F+fKO8u6JQ3A==
X-Received: by 2002:a2e:8417:: with SMTP id z23mr2192660ljg.28.1571312953668;
        Thu, 17 Oct 2019 04:49:13 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id x30sm920772ljd.39.2019.10.17.04.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 04:49:13 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gao Xiang <xiang@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel@pengutronix.de, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 1/3] decompress/keepalive.h: prepare for watchdog keepalive during kernel decompression
Date:   Thu, 17 Oct 2019 13:49:04 +0200
Message-Id: <20191017114906.30302-2-linux@rasmusvillemoes.dk>
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
to service the watchdog in its main loop. This adds a header making it
easy to wire up each decompressor - just include this header and add a
decompress_keepalive() in the main loop.

Outside of the pre-boot stage, this is always a no-op.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/decompress/keepalive.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 include/linux/decompress/keepalive.h

diff --git a/include/linux/decompress/keepalive.h b/include/linux/decompress/keepalive.h
new file mode 100644
index 000000000000..39caa7693624
--- /dev/null
+++ b/include/linux/decompress/keepalive.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef DECOMPRESS_KEEPALIVE_H
+#define DECOMPRESS_KEEPALIVE_H
+
+#ifdef PREBOOT
+
+#endif
+
+#ifndef decompress_keepalive
+#define decompress_keepalive() do { } while (0)
+#endif
+
+#endif /* DECOMPRESS_KEEPALIVE_H */
-- 
2.20.1

