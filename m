Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEB8C2D0CF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 06:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA4C20722
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 06:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="FM9WMbEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfLYG0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 01:26:32 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42308 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfLYG0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 01:26:31 -0500
Received: by mail-pg1-f196.google.com with SMTP id s64so11299115pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 22:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=famkZXGEeQgX6kTt3zfP2CBx94A2ZSijyfq87h1/O/k=;
        b=FM9WMbEuB/UBFWa8k7+u+HfhCJncU0OPPgLrnWwG7KsGK1Jc2CBoxiGvcilwJUIe8w
         KGxoKW7cEz5wLwkvhZH0/GB0BBApjty7XEmEUahB/66f3uDKzE8Z4Xj7CVGkm6r0yp+i
         3Kh8Ur/R5AvjHx54JXjgCawXvlBfQY3lUdgCqDTpxwNZICSvjatRMg3HVYdAYliZoqDb
         VzsC53PBtsSKiheIZsJurcT8ON2cLzoVYE3DBphfYNeiscDNleoCvCEXy0lSANdwqU5C
         SdNtHw24BpaSlkE3Et+FTLrxK+j5JTf8d8WQjVndXaEieoRaUY4Zi9nZ8Y/wyU0KSejG
         T5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=famkZXGEeQgX6kTt3zfP2CBx94A2ZSijyfq87h1/O/k=;
        b=DgdrU0P4I5mOX6KkHR2620bzrK4yWNA9Quk+1Z/SWKq/K89cBbhNZk+fCqWWYBsvs1
         y0KX0xT7A/DFjSihKAHJiUwQHZj3AlfNeF0KmO2856ZIjQWo/gleojDb27KfM8dQwiH4
         pQNrf7ej8JfizsPtHcDpW1MvqiekrhGNIHtc37nVo+C58pikGgIj03T+6TCaQlSeGDR8
         o2hJF7i3zNDzi8Ze1SwU/u2bhX3zWH3AHowc1Xz/QrUuemUUKxFiU+ph47zRcQHaROkz
         mpSDMAse0Vh1/erIwbz710wRaxqtyPFyO2gmZvacPLBVqTvBNDeIX1H708gnWp1I/BoG
         g8qg==
X-Gm-Message-State: APjAAAU9Ti5ZXEgMTgQWa0IqN6G9A6TRrleRZkLj9zbSSL5SPv3on4YD
        AurAdAsFppFl64D2mEPwVLDVYw==
X-Google-Smtp-Source: APXvYqzP48o9wHBQ8QrG/C0sOI71LwHmWQUHuI2RsrTfwN21WeuvQFjvxtTq8EXPXS7YzsAFPeayUg==
X-Received: by 2002:a62:b508:: with SMTP id y8mr17588329pfe.251.1577255191072;
        Tue, 24 Dec 2019 22:26:31 -0800 (PST)
Received: from libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id j7sm30875474pgn.0.2019.12.24.22.26.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Dec 2019 22:26:30 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, pizhenwei@bytedance.com
Subject: [PATCH v2 1/2] misc: pvpanic: move bit definition to uapi header file
Date:   Wed, 25 Dec 2019 14:26:21 +0800
Message-Id: <20191225062622.60453-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191225062622.60453-1-pizhenwei@bytedance.com>
References: <20191225062622.60453-1-pizhenwei@bytedance.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some processes outside of the kernel(Ex, QEMU) should know what the
value really is for, so move the bit definition to a uapi file.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/misc/pvpanic.c      | 3 +--
 include/uapi/misc/pvpanic.h | 8 ++++++++
 2 files changed, 9 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/misc/pvpanic.h

diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index 95ff7c5a1dfb..3f0de3be0a19 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -15,11 +15,10 @@
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
+#include <uapi/misc/pvpanic.h>
 
 static void __iomem *base;
 
-#define PVPANIC_PANICKED        (1 << 0)
-
 MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
 MODULE_DESCRIPTION("pvpanic device driver");
 MODULE_LICENSE("GPL");
diff --git a/include/uapi/misc/pvpanic.h b/include/uapi/misc/pvpanic.h
new file mode 100644
index 000000000000..cae69a822b25
--- /dev/null
+++ b/include/uapi/misc/pvpanic.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef __PVPANIC_H__
+#define __PVPANIC_H__
+
+#define PVPANIC_PANICKED	(1 << 0)
+
+#endif /* __PVPANIC_H__ */
-- 
2.11.0

