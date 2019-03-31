Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F98C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025FF21874
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlzgEH92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbfCaRzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:55:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34724 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731358AbfCaRzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:55:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id o10so13697980wmc.1;
        Sun, 31 Mar 2019 10:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0nBK/gH9etQtwX4BuyANxyIfeFafNbGD3G8mNW+0T4s=;
        b=DlzgEH920W6sTf3HIu4qKbqvmHGVmRBNV5WJToYmBAjBQ3BE/eYX9sUkex5dFv9XE7
         pt79midIXFoEepne642C5NlQp1YIO6k9cix6UPmaG+F0mCKIaOW54LN1JgPuywcEP82d
         Tkmdmcd4EGpMxLA8J1USTnHv0CLYbU5oJjA9A+DB/wYZmiS6zrqrPy944FiXIynI90wZ
         VThQZQyqkYR/JYlBKV/AsGSgQKI6bVQweLGipzRb7So+11Od819KSZ2Xyk3b/bR1JXEP
         vGVUYDxMwzTF1NTb0Q2Hzs4LRPMDAHTd1miUzVshNHLu8aGeGBQU+XT0MCPUVtUBcsV8
         al+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0nBK/gH9etQtwX4BuyANxyIfeFafNbGD3G8mNW+0T4s=;
        b=TrnEwa4tHdTRD7gX6uzi2emkxlf+TcV1fZivXY/DX/ECKq0t7JGWp+Nmlv/+snwjns
         kyzDrMGMnuh8Gt/4BknDsNpDiLd63sGmuNyTAFunyYi41jPwLePsKYfBb0DmmRw49Fjy
         AdUFfiKPVXgysUClYn/aqOqRgBhbZOgLfaYP9m7CAjoNuTtVzh9rtemgu/2URQfQ+sXW
         ZUkOLQwRCxgFBxsSdih/n/tb23p1Jo2i7BBCv72hHz+BHWgYTYaqPsvY8/Md8VrTZ2eE
         9IllUxF2wf+HXvUuDzrte1/2T/DINW3ncOAnGRSfmCNXwqbLaDMU4cb4dLFAB1U4kNbm
         waXQ==
X-Gm-Message-State: APjAAAXhdiRVPY9WBYhwg2pFEhxxgymm0XKffsyEwOzwA7PuEakpck0s
        jF22ZFuIABFHvpag3Zt8WJWvgRUj
X-Google-Smtp-Source: APXvYqw3ZQS8bIoZzh/SRNNB7TmhWCXirDiOKJTgos+N9WDSMlRQ5XS1uAU6PekFZjMB5fAQitPodw==
X-Received: by 2002:a1c:bd8b:: with SMTP id n133mr10281629wmf.73.1554054916863;
        Sun, 31 Mar 2019 10:55:16 -0700 (PDT)
Received: from myhost.home (bds153.neoplus.adsl.tpnet.pl. [83.28.4.153])
        by smtp.gmail.com with ESMTPSA id d7sm7473688wmf.31.2019.03.31.10.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:55:16 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Baolin Wang <baolin.wang@linaro.org>,
        Dan Murphy <dmurphy@ti.com>, Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
Subject: [PATCH v3 03/25] dt-bindings: leds: Add LED_COLOR_ID definitions
Date:   Sun, 31 Mar 2019 19:54:39 +0200
Message-Id: <20190331175501.23471-4-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
References: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common LED color identifiers for use in Device Tree.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Dan Murphy <dmurphy@ti.com>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Oleh Kravchenko <oleg@kaa.org.ua>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Simon Shields <simon@lineageos.org>
---
 include/dt-bindings/leds/common.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
index 0325db5b4208..c95f39b3a254 100644
--- a/include/dt-bindings/leds/common.h
+++ b/include/dt-bindings/leds/common.h
@@ -55,4 +55,15 @@
 #define LED_FUNCTION_WLAN "wlan"
 #define LED_FUNCTION_WPS "wps"
 
+/* Standard LED colors */
+#define LED_COLOR_ID_WHITE	0
+#define LED_COLOR_ID_RED	1
+#define LED_COLOR_ID_GREEN	2
+#define LED_COLOR_ID_BLUE	3
+#define LED_COLOR_ID_AMBER	4
+#define LED_COLOR_ID_VIOLET	5
+#define LED_COLOR_ID_YELLOW	6
+#define LED_COLOR_ID_IR		7
+#define LED_COLOR_ID_COUNT	8
+
 #endif /* __DT_BINDINGS_LEDS_H */
-- 
2.11.0

