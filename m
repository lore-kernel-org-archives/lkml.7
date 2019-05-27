Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF8DC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2813820883
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="t9o+VHkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfE0Qil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 12:38:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40938 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfE0Qil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 12:38:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id t4so9130459wrx.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 09:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Bqi68PuSXLVEVLuO7LSaFlse4/AD2TLXqhrMO5+t/s=;
        b=t9o+VHkGvIvT0HDb8ZjOiqBRLOoUc5kWeyRgmYho2RPGRmH0ZnuXzcqn3kg01UlU2j
         JX39ymiB/xdXu3uAGlkcFCnYWbn6kS6rctKh+njpJV/Qey101yz+wlHe46vnii8ReG/X
         l96Pl1jis1PIdZ5RMMvKa+WCa/2/yyqNQ+oB4MgCEjRF7XB6SD8AGKFN8jS24U6UCVg7
         2/bL/EGszKhFv7I03dnmDghnsDfKRRU3elOEVuIx5uC2mexaribalgCtbZBElxBH8Kra
         VbFzUA2XBYYWEaq3QV740Zv2bULz7WdVS+ntoD7Cans8e5YEK9esPTHEGz7J0+YvNAkT
         otOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Bqi68PuSXLVEVLuO7LSaFlse4/AD2TLXqhrMO5+t/s=;
        b=myOBykMm+8drzReYg23BGa7XQ7DVZgkR7HQyGMfOy9bs3a77I/qFnYd+mo0XjLzS6P
         CL3d1D0PJ8oA2ttAoKboqMOWeSAKJDaq9Byv4Tl4duzrP7dUIR9ljifCAM5oiEXNYXOe
         el1SBdf51felVn80S8/KNntqMFWBQ5VBk1/WApB6vpwd4bD/ZY/KeXK/zMKzRfjuoiX9
         oO13aXA1nnjuzTaWRqR4gCd9xvT4GCFUUjCczRG2s/q5c3h0/5/iFrKhcFKuqYTPs1GC
         2x3T3P9tCEDQS/S7iEz7bvyjkHVgI0JTtSJXUadfOjVPNh/Hb7vBHbN6hSXqyu5/+iOe
         48cg==
X-Gm-Message-State: APjAAAXTYC/DM1ZOXvN2pET0uYf9l9MTM7YYzLKPXhY85ehNvJx4OeIi
        OefF3HTyijWbJnH1pnVVpZw3gw==
X-Google-Smtp-Source: APXvYqwW5D2MiFDPr61jSEXTAG4KZCBQjmYLwJacCtcfEehqN4vs2Rft948Q6iSOpPvwE9NSns6L7w==
X-Received: by 2002:a5d:6108:: with SMTP id v8mr19108589wrt.150.1558975119723;
        Mon, 27 May 2019 09:38:39 -0700 (PDT)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id k8sm9483173wrp.74.2019.05.27.09.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 09:38:39 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: max98357a: Show KConfig entry
Date:   Mon, 27 May 2019 18:38:09 +0200
Message-Id: <20190527163809.28104-1-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SEI510 board features a standalone MAX98357A codec.
Add a tristate prompt to allow selecting the codec.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 sound/soc/codecs/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index e730d47ac85b..48c94065072a 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -708,7 +708,8 @@ config SND_SOC_MAX98095
        tristate
 
 config SND_SOC_MAX98357A
-       tristate
+	tristate "Maxim MAX98357A CODEC"
+	depends on GPIOLIB
 
 config SND_SOC_MAX98371
        tristate
-- 
2.21.0

