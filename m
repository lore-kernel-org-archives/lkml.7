Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1308CC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55492133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zPBzDYcj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfGAKr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 06:47:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34706 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfGAKr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 06:47:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so14270488wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 03:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wfgjAQ3M5HY2NtkjVQDzRJpLev5yRfzCJhptr2owUzY=;
        b=zPBzDYcjDqHiHXy9jMFQwxCKaAAzbtCKZS+bwK61KcgKKpDtVjmshT4h915qhXcnxN
         GvwfCIK4DBZEZ4s2JPKlmLDWsh/l7icG41GIM20ZorILqhFXmjfYjLllTB8xnsfodCps
         Zt+QSHs1sZfGVGgZZgtsDLCQcMfhzB1vBZArWhJ6b3MIfCOM38RuEI6qunfj61p08z17
         x0U0vbKHjuPy4nXo3/46YLS53egemjbBMuCI4TRDKO/+a6HKHDCsWM05WohCj+QuxeRj
         3bDhWP5je88qRmMmnqCYb1z3f8ld5CRz3z04Rx50kwxO3V4eR8c42qaac+j76eVocv7Z
         QwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wfgjAQ3M5HY2NtkjVQDzRJpLev5yRfzCJhptr2owUzY=;
        b=DzbqQwXC4DASgApp+xW00r9a1aN5YiFWm772AwiF4N5dWWedh/nzrW3NOk6c7pGJlF
         Fm50Qrkk90rL4qTJuvRMpk2J+YJxCVjaXzH8UV77eVEkyeDpahSWhvAQ49fqCzQaRxQJ
         oN6/372t/7XMBPjfb4ftr0waYubHWlC+vqnWJJ8trD3HgnIEDGle7UoMlkcqScn//Q1v
         UXWus/258i/mZDxxzO8QIcQ3wkIvs2yQW++gd4XrJzvd+TkhqOn8+gMx7potREsyUtQ5
         Pf/i0Vk/049zRo9IE2Hjq4yBluIBqk3PhMhnPEqFFiF8QV0XLSbsvkEaqBFwryFAvFel
         KHeA==
X-Gm-Message-State: APjAAAWdHZQXlKhVB/DpZME8I+XP0R7qhiiKVcjwqdAZRtZqiszoxsRy
        X3aIg6GoiUUWNfqNtn4fELpbiA==
X-Google-Smtp-Source: APXvYqzrQnQF/+v+bIQvryP/j5lpMQ4UpR0oBp9qdOxkvujlAZoajK57bDQABJ8zj0Dn/XghUa8Djw==
X-Received: by 2002:a05:600c:1150:: with SMTP id z16mr16105586wmz.168.1561978044919;
        Mon, 01 Jul 2019 03:47:24 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id d24sm11658802wra.43.2019.07.01.03.47.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jul 2019 03:47:24 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC 01/11] soc: amlogic: meson-gx-socinfo: Add SM1 and S905X3 IDs
Date:   Mon,  1 Jul 2019 12:46:55 +0200
Message-Id: <20190701104705.18271-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190701104705.18271-1-narmstrong@baylibre.com>
References: <20190701104705.18271-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SoC IDs for the S905X3 Amlogic SM1 SoC.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/soc/amlogic/meson-gx-socinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
index bca34954518e..eb81d391b620 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -39,6 +39,7 @@ static const struct meson_gx_soc_id {
 	{ "TXHD", 0x27 },
 	{ "G12A", 0x28 },
 	{ "G12B", 0x29 },
+	{ "SM1", 0x2b },
 };
 
 static const struct meson_gx_package_id {
@@ -65,6 +66,7 @@ static const struct meson_gx_package_id {
 	{ "S905D2", 0x28, 0x10, 0xf0 },
 	{ "S905X2", 0x28, 0x40, 0xf0 },
 	{ "S922X", 0x29, 0x40, 0xf0 },
+	{ "S905X3", 0x2b, 0x50, 0xf0 },
 };
 
 static inline unsigned int socinfo_to_major(u32 socinfo)
-- 
2.21.0

