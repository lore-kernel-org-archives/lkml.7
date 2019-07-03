Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908B6C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E8D218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfGCRB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:01:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50896 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfGCRB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:01:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id n9so2971063wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 10:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GTnb3wOq3N88WSvvVUf/IfvNsBRFmYHBdDSAW0StD1A=;
        b=rtwhJ9SmuBdFFn7JAiYuC99kWvTxS6d7WXEyNg1pR34kC60VIvOf1B1Rww6eV+C3jh
         nLlw4Dqmgr4LkfzolVrbkdXDUq3V0J61cHvgQpKQpxTNCP5vorP1s6VPE/9XbeWX0my1
         av6vQmxB0zw3IiTzwPNhzwCfBSNJfsH7Xvzwq+1MjwS5cJ7NgVLoPe5k8HzNrDji7mso
         /ZOJ8d48q9kjcbtgcJow7iLT/QHqI2KxTsM678pBRqOHVFSKtbn0fb1u7JTcPBR2/JmD
         gmozjueJpR+qo9qAp91P5dF8rm7ysd2mI53WQCwwSgQkP5q9hlOwaT5Q7Cx85MbKX0Hl
         1JHA==
X-Gm-Message-State: APjAAAUTkEN8U3U3J38ogpNmoog8LDZYa4PsSGDnT6PTo9fsirlUaDpE
        32Il90OXl9OfH4MZzsbh1bA3sGT4
X-Google-Smtp-Source: APXvYqyjAHPEpCL8N6tHtJF3KphEj+qBYOV0Mtg0ovBu+V7H9bU8XkndFHxSlCRSbhJrwClV10dXbA==
X-Received: by 2002:a1c:4184:: with SMTP id o126mr8571665wma.68.1562173314889;
        Wed, 03 Jul 2019 10:01:54 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id e7sm3990330wrt.94.2019.07.03.10.01.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 10:01:54 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     Denis Efremov <efremov@linux.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/client: remove the exporting of drm_client_close
Date:   Wed,  3 Jul 2019 20:01:50 +0300
Message-Id: <20190703170150.32548-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function drm_client_close is declared as static and marked as
EXPORT_SYMBOL. It's a bit confusing for an internal function to be
exported. The area of visibility for such function is its .c file
and all other modules. Other *.c files of the same module can't use it,
despite all other modules can. Relying on the fact that this is the
internal function and it's not a crucial part of the API, the patch
removes the EXPORT_SYMBOL marking of drm_client_close.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/gpu/drm/drm_client.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
index f20d1dda3961..bffc87ac21c7 100644
--- a/drivers/gpu/drm/drm_client.c
+++ b/drivers/gpu/drm/drm_client.c
@@ -60,7 +60,6 @@ static void drm_client_close(struct drm_client_dev *client)
 
 	drm_file_free(client->file);
 }
-EXPORT_SYMBOL(drm_client_close);
 
 /**
  * drm_client_init - Initialise a DRM client
-- 
2.21.0

