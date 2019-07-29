Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C37FC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DACA206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wBqZVt+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387920AbfG2NC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:02:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52112 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbfG2NCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 09:02:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so53789682wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 06:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FZSqbY3GL0p/+O6r5hxQ7rW4Fn6zYsGa/G8TU990Zm4=;
        b=wBqZVt+24e7MrGM6D4QtCK7dwOo2lLvjmbEMiiR2UAiOclH3Z0IkE+1YEqWi444eZZ
         BTinoNCv6aAiIAej53vbi2ctu+BdemPyD8nsGUT+dOv2UzXg+UTsAYTPYuhRuMchE+gt
         +veg2+BMuV2/znnE27+G9YAXckBQCHi8lyj7M0BMoqCwVr173gbD7mAO/ZQvs5W8HxAe
         +7eddFQCTJ8EYeg9ZJpQWp1SVW8tmKgj3eUmhUYTOvljecr/OA1hMXvkrLTp+ieZTVPy
         SpgUB4f5arNhAUGxfadqhcYSuDn4MfwyaJpFyD6x6oYObxfV/KfAlRfqWB3bMmPElw0K
         fGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FZSqbY3GL0p/+O6r5hxQ7rW4Fn6zYsGa/G8TU990Zm4=;
        b=po8U9YEz57XJ5S2q4kk9Lb6kHCuXXHrOhZ9IynRyv10V224ATqgLdby/GdocgwooNG
         /ZFCTiJ17jKi81o7jyUoVX6n77bdopVbx6IK7cVEitqlZPwUNmFxVk30R6j46axhF7Jp
         VV6OvCsQKUsCEyCf65YsddM11lYZViokC/c5cly8sh3WQyIBHGEWnCnKvoQqHYoiWfWZ
         PyiX7soFLVyP1sN12Dc5b7nQQXmSTSloIpZI3IY9z2C6yTJWuXgYbqzZ2qi2W2Y+zKri
         HrmsNFAtVsjcvwN41hZmfohBQwxqlLIslcSxdBAnbe7JNH9GMcyTPsO1gDQI8/99L9pY
         pCOA==
X-Gm-Message-State: APjAAAUbMIcGF9SQS8iDO6TVw+XLGMpVC8efl/jNa45Vwz2Vut7nWcWl
        rrXDjz+W6oUPUSnuWFTszPncYA==
X-Google-Smtp-Source: APXvYqxMg4urTCpn21CaeGSw5dY2M7MMMl9NxfF6J2eFyFENSaHryb1CSNKJONpXaiV6dCAu4t76rA==
X-Received: by 2002:a1c:6555:: with SMTP id z82mr102462120wmb.129.1564405342535;
        Mon, 29 Jul 2019 06:02:22 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x185sm52990545wmg.46.2019.07.29.06.02.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 06:02:22 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] soc: amlogic: meson-clk-measure: g12a/b DVFS support
Date:   Mon, 29 Jul 2019 15:02:16 +0200
Message-Id: <20190729130218.6635-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset :
- protects the measure with a mutex, between concurrent user space debugfs reads
- adds entries for the G12B secondary cluster SYS_PLL and CPU clock

Neil Armstrong (2):
  soc: amlogic: meson-clk-measure: protect measure with a mutex
  soc: amlogic: meson-clk-measure: add G12B second cluster cpu clk

 drivers/soc/amlogic/meson-clk-measure.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

-- 
2.22.0

