Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F2EC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79AF621479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/SfDAFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfGBPog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 11:44:36 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:35926 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGBPof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:44:35 -0400
Received: by mail-qk1-f175.google.com with SMTP id g18so14488659qkl.3;
        Tue, 02 Jul 2019 08:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0SNIqZ1eXNTXTiBWnYdzokV/6s0LphXPV28wgFgO7+Y=;
        b=A/SfDAFXG8B33NLAuR2aHJKfJq4Yy7L2nviUpcX6L2uRGij6Mq2/MxO7ekS9lkxJ1X
         e1S7zhlW85oULhG1Dfxve8SFAOlLmOGKCkEfOJ9efMIUlS7JC5S1XOhhToUtbZugfnfP
         q+vSwNgnRZTFRjkg+B3LXhmTWckczqo0qf7A1iiV33mCAnUWdonnm/dQc4trsf9lzEyS
         M4KmtaNo6J9m3X2NP++/fVQX4pIwZ/9msZdflOc9RmJoHoksAXDDxYx8B+cBYMXwMkXf
         Pi1RF8ffg6LSphQ6nPrFZoFMGq4a9bPJ+5h+iYhVMCA5cQwi2A67s8YGsQwRH1PuDmmr
         LXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0SNIqZ1eXNTXTiBWnYdzokV/6s0LphXPV28wgFgO7+Y=;
        b=rp3lu7yGJcVPku590YZvUiCW/nHnR/UBcVbilQ7MGFAq8fSnbCsGNo/jXIrZiiRGfu
         Q55nNDJyhXIQ3izLsM9oNviIfwlcRc5G77ZqS6Ajwa6n/dL6smbQpKDg1hGe+uucG50L
         PdiaASIq88DQjSo6iMNhiE78KSNOXd8n6KokgwV0tbi8NmDMsFMD5ZvISSmeWFnge7tZ
         hXhO/qqpAAG0LU6JO6QAEWNkSQsPgFuQZHj+ais46EfY+CGOiFZmfRp7hIbRFPohJheq
         jr2eAsSenbPSFuRIuy0KJ6wGPYmbH3q2QeW7JIS3EmYsHLd4h2vlXoE/wYv1DMxcDRv5
         YEug==
X-Gm-Message-State: APjAAAXlOHF+bSUV2k13Z6svLTjQLd2axclLntp+eHtBfGrc7M9idsFM
        NQvjw6YBSVXXIwSrJHaRl74Nhun67z8=
X-Google-Smtp-Source: APXvYqy/DQiaFs1LsX0WgEbqxRdbnX6EGJXOOnXyMa0gYPhm28oRBjSKtRB4pJgIl/8V5uuGMGyMYg==
X-Received: by 2002:a37:8741:: with SMTP id j62mr23578387qkd.78.1562082274356;
        Tue, 02 Jul 2019 08:44:34 -0700 (PDT)
Received: from localhost ([2601:184:4780:7861:5010:5849:d76d:b714])
        by smtp.gmail.com with ESMTPSA id c192sm6389184qkg.33.2019.07.02.08.44.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 08:44:33 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, Sean Paul <seanpaul@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm/bridge: ti-sn65dsi86: add link to datasheet
Date:   Tue,  2 Jul 2019 08:44:16 -0700
Message-Id: <20190702154419.20812-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702154419.20812-1-robdclark@gmail.com>
References: <20190702154419.20812-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

The bridge has pretty good docs, lets add a link to make them easier to
find.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index bcca9173c72a..f1a2493b86d9 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ * datasheet: http://www.ti.com/lit/ds/symlink/sn65dsi86.pdf
  */
 
 #include <linux/clk.h>
-- 
2.20.1

