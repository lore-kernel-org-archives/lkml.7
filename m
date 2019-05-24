Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95F8C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9177621848
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ilpl5HFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732084AbfEXSRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 14:17:41 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36691 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbfEXSRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:17:39 -0400
Received: by mail-lj1-f196.google.com with SMTP id z1so3996489ljb.3;
        Fri, 24 May 2019 11:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AitnibXnsEfzpUu6HXlCBGqxsM7f3oVwPktBIsU9dZw=;
        b=Ilpl5HFlrboLQeGOD/OFT8IhSrFmaUBjQpWEez2YHvNJz2iXRZCFuerj7LEYI9bUL+
         bQXOFHbVmlw4yGuY0yc5np5xCIQj0eUMHETbqiCRtSS3us8RL4mW3kxq399lKzo46gm+
         3g06jpAbtFxdslmYgK2925qYZjFWtSKhgQyEExS1Pn4NUBPjnABQZNolsab5dHqLQR0n
         wQmjoiks1YrETORKfr6YdTsurphVXK1otj5Nb0PeoGYaVDqcAZ0KD8sS3Tsicm4jttUJ
         dZ7WvCbiek8NVkJF9FGeQ2KnHMkwFuCcDFeHksuFYu4fX6Y0GIi2BLY+zGuTaeloobOS
         zo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AitnibXnsEfzpUu6HXlCBGqxsM7f3oVwPktBIsU9dZw=;
        b=Ui69LLYlVCcrALCII49MqHLdVZMmeUL3za1C1OTB62BkSyMn+NQkCjaDPtvY2ig2Xi
         +TQcd16/nQORUFpKjKP515Ej3bxz80qKzSY7T6CGsT9Jz7XMdDGFYy6V72FYvJoVlgNc
         LxhMSF12wufw/TFpLhDrO/9wMSe/l5ay8iYuMaM6x0YevPqnaRPJwcP1jkNQOYrFBxH3
         JBxnsH2mimPJakFlV0V4Ahpdznz4brSveilp+BerzLHCrHH3IdH41Qeot0DVtgqzuSUy
         6cTGoFQu+0FDugXRuOxEs7Ez0h1FL/W31vTC8ewV0Rp22n45a/3zJUkpcA+kPWUWHxnl
         4r8w==
X-Gm-Message-State: APjAAAXE419TpHY6ZGWoxlN7j7IcslhaVWkT0+wGC4P3IFB0JrGxZmNF
        CqCHmiiNve/cU8Is6W8xfIwhdwgn
X-Google-Smtp-Source: APXvYqym2oCg9Sa/M7W+zNv55wqaTr6QqA+Mz+Ik3fwZJStiat9x7n/ys/Y1wLW0HAoJmWt9g29+CQ==
X-Received: by 2002:a2e:9f44:: with SMTP id v4mr914088ljk.85.1558721857495;
        Fri, 24 May 2019 11:17:37 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id h10sm810376ljm.9.2019.05.24.11.17.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 11:17:36 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] drm/tegra: dc: Tune up high priority request controls on Tegra20
Date:   Fri, 24 May 2019 21:16:25 +0300
Message-Id: <20190524181627.16490-2-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524181627.16490-1-digetx@gmail.com>
References: <20190524181627.16490-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra20 has a high priority request control that allow to configure
when display's memory client should perform read requests with a higher
priority (Tegra30+ uses other means). Set up the controls for a more
aggressive prefetching to reliably avoid FIFO underflow on a lower memory
frequency, this allow to safely drop the memory bandwidth requirement by
about two times in a most popular cases (only one display active, video
overlay inactive, no scaling is done).

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 079250c85733..3e13948dcdcd 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1828,12 +1828,12 @@ static void tegra_crtc_atomic_enable(struct drm_crtc *crtc,
 		tegra_dc_writel(dc, value, DC_CMD_INT_POLARITY);
 
 		/* initialize timer */
-		value = CURSOR_THRESHOLD(0) | WINDOW_A_THRESHOLD(0x20) |
-			WINDOW_B_THRESHOLD(0x20) | WINDOW_C_THRESHOLD(0x20);
+		value = CURSOR_THRESHOLD(0) | WINDOW_A_THRESHOLD(0x70) |
+			WINDOW_B_THRESHOLD(0x30) | WINDOW_C_THRESHOLD(0x70);
 		tegra_dc_writel(dc, value, DC_DISP_DISP_MEM_HIGH_PRIORITY);
 
-		value = CURSOR_THRESHOLD(0) | WINDOW_A_THRESHOLD(1) |
-			WINDOW_B_THRESHOLD(1) | WINDOW_C_THRESHOLD(1);
+		value = CURSOR_THRESHOLD(0) | WINDOW_A_THRESHOLD(0) |
+			WINDOW_B_THRESHOLD(0) | WINDOW_C_THRESHOLD(0);
 		tegra_dc_writel(dc, value, DC_DISP_DISP_MEM_HIGH_PRIORITY_TIMER);
 
 		value = VBLANK_INT | WIN_A_UF_INT | WIN_B_UF_INT | WIN_C_UF_INT |
-- 
2.21.0

