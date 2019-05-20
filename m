Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0437EC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD5D216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MloCGBgG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391701AbfETOhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:37:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34143 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731837AbfETOhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:37:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id f8so8504826wrt.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ZPnH+BSeytSJ0GzOG2PZj66Szf087YxbYc0Zzf9tB8=;
        b=MloCGBgGxmhC2AaJM4Yfyd9GITmWu9zFDTbO0fVXOuDtj+0FDjtDlEQZ5AoxX5SCSd
         itJXLYDU561D2JCwVaVAiLN6GFz03Sq52sPXt62EuKqal8J7BoIF8gQT/DqeRHtn9ID/
         FzsBMFXaLYGTp3Q/4Zbln/rx0qKGlcurMKpoi1mI/+59w/EfheL5nNynShbxJ4KFYb6m
         gh3tYN8JI6ueVnUchBx/GrVIdy3mlpeBn71R9/fX4eTDJH+D+3K59rKLkgPzz0NDUWuo
         55R78ydOZh/yA2/R+TLJxo2fiQWGYMZ3USs2tNH6K+d95efcYxNh9ylR05L2NKna3BSR
         vcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ZPnH+BSeytSJ0GzOG2PZj66Szf087YxbYc0Zzf9tB8=;
        b=eQs9njuotXdku7q2f6qSGU8YKvOgf0bOV/h9kal++cKJEKxn37ZwF/qSNe3yyv6mdK
         5MgdoJVUYz9E9sgjQIr5NhfqdYsD2SE1WskLS495vnbkFTb9Mf+QyekZ0lsWdv8bbQu7
         TDhBHqkHfeX5/ueoYHTuuwvPfmPoHnHBX+QldsXUOm8TQuUpHKTyaQsUxlBma709SAgM
         Sla1mrhBDrtmjDdKZkBhM8wL301Ww+XIrU8iFqlK44FXMDU6n4i84ViD/Ncz92DSts57
         YCok57DEb7YIroGFoEBTmoPmzUPD1mnfYFqP8u17nUL7cGUYXMhU+ffUHkp94zqxaqeS
         duTw==
X-Gm-Message-State: APjAAAUQvpo8Oo97JaDDREqSeLxinQvFaj8OcyFDjIaButAJeiHsu/iz
        yuwb6hJnngwK4v2WmMfI2+bDzg==
X-Google-Smtp-Source: APXvYqzn+2uf2+vPE7LkPQ4jzhij7vsiv9pt5JZaDxuWn8nRN1eEdiKjEx6MY2xGwB4nxy2ND/GeQg==
X-Received: by 2002:adf:dc4a:: with SMTP id m10mr45656409wrj.0.1558363056611;
        Mon, 20 May 2019 07:37:36 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b136sm19076204wmg.1.2019.05.20.07.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:37:36 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     srinivas.kandagatla@linaro.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/2] nvmem: meson-mx-efuse: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:37:32 +0200
Message-Id: <20190520143732.2701-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520143732.2701-1-narmstrong@baylibre.com>
References: <20190520143732.2701-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/nvmem/meson-mx-efuse.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/nvmem/meson-mx-efuse.c b/drivers/nvmem/meson-mx-efuse.c
index a085563e39e3..2976aef87c82 100644
--- a/drivers/nvmem/meson-mx-efuse.c
+++ b/drivers/nvmem/meson-mx-efuse.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Amlogic Meson6, Meson8 and Meson8b eFuse Driver
  *
  * Copyright (c) 2017 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
  */
 
 #include <linux/bitfield.h>
-- 
2.21.0

