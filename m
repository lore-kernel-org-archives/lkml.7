Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650ECC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE7C206C1
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tMnBMEYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbfHEM64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:58:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35946 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728716AbfHEM6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:58:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id g67so68804667wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 05:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=98lh3VhEJYcNP4cO6bfAWLsXJomqXzKBLTJKfb0rfuY=;
        b=tMnBMEYxd6Lk47wVxq8np1s07LPbtohRCD9xifUu+u/mzgsVZzai5W9om02Rx3+Nb1
         tv62V9YKJ2x9GGQSuyYppVpgKlfNYYE9mhFKylGM4whvoeB5s2wWMLc+W4EmXTbO0gXB
         oLjGlL8FWWWdesfvwBYBq4LJ0Vi3usyG9KhMN/2TLtcowEOakLiV8qSWKkzmCeDfxKG3
         qRtvMzkDWgc63UQxW79fR00LSbu9OWNG0btdqFgsNig9WykCCzGhqwgfs0YLE6eL0ohl
         JWXR8vRNpcJR0AGTyBKmbK1NXKrbojwL7TVJmgmCvj8GHPKFPfPXoWH9f3Nk+MRf2jzJ
         qLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=98lh3VhEJYcNP4cO6bfAWLsXJomqXzKBLTJKfb0rfuY=;
        b=lwhOEfBzbrMFiJPjBsFP4ZayUXDgIdS9ygzwduwsMFz6TFPepijuwAUv0o86mzwSTY
         P8Ar/5G3Lk/gOMWZQFW4iqs050gaGgLADeicQ4pJoP2XW0rMZP/4ygzot3qz/im5P4Tx
         nFfyN6p2WNueZBzKij9l8a9Ve3hsia+EL2d9B48jyqG34iV4YSL8Sp2+xu94lVyWL4pI
         egU0nkuPnEF+s8QUrBaHYNaDjnfK5oMJPmObFH8w5H16SBeFmYU9l5wmaf2ciXnGN68M
         jFQhFE6QJPzvuylzKy96H3a9t6U041H5r/UgfgX8vk8A/2qKH/nOcIWqmGQ/0pae3srR
         /cyQ==
X-Gm-Message-State: APjAAAVwpftjLUEC27X4WfOx/fphYmOpGVZu96dL65Rb8guRZUuupSf/
        3jB9Zll6p2WfqvwaUzoa4jWW6g==
X-Google-Smtp-Source: APXvYqzsqQmdgJj3jeIDVq76HPcJpxfluPpf19/xxhP3uizn5JqLt/VNLa8L7aHlrqKs6BQBR3c4qA==
X-Received: by 2002:a1c:e108:: with SMTP id y8mr18411997wmg.65.1565009932852;
        Mon, 05 Aug 2019 05:58:52 -0700 (PDT)
Received: from radium.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k9sm15582779wrd.46.2019.08.05.05.58.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 05:58:52 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     mark.rutland@arm.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 2/2] pwm: pwm-mediatek: Add MT8516 SoC support
Date:   Mon,  5 Aug 2019 14:58:48 +0200
Message-Id: <20190805125848.15751-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190805125848.15751-1-fparent@baylibre.com>
References: <20190805125848.15751-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible and the platform data to support PWM on the MT8516
SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/pwm/pwm-mediatek.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index eb6674ce995f..6697e30811e7 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -302,11 +302,18 @@ static const struct mtk_pwm_platform_data mt7628_pwm_data = {
 	.has_clks = false,
 };
 
+static const struct mtk_pwm_platform_data mt8516_pwm_data = {
+	.num_pwms = 5,
+	.pwm45_fixup = false,
+	.has_clks = true,
+};
+
 static const struct of_device_id mtk_pwm_of_match[] = {
 	{ .compatible = "mediatek,mt2712-pwm", .data = &mt2712_pwm_data },
 	{ .compatible = "mediatek,mt7622-pwm", .data = &mt7622_pwm_data },
 	{ .compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data },
 	{ .compatible = "mediatek,mt7628-pwm", .data = &mt7628_pwm_data },
+	{ .compatible = "mediatek,mt8516-pwm", .data = &mt8516_pwm_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, mtk_pwm_of_match);
-- 
2.23.0.rc1

