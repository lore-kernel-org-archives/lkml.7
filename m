Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B840BC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC0D22CF5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="stvEzN4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388917AbfIEMBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:01:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33050 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729809AbfIEMBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:01:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id r17so4835183wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 05:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yFK6X2V6i39GcNDQWpzEpnOVpoV1Dx+VySBb8i2GX/I=;
        b=stvEzN4tUS8oK1tZu/EaUIi2TPABQfmjiU4mPlGJpIy9qIoGskfwsPYca0Dq0e4oPl
         DuwEICzFSm8kaAm51AaPy9tOzbXLDJifxZjw4c8+ZPPOrZm8/E6ECYeVwnZxC+XiUvjp
         949UTxAT6G0O23iPXgjV+Wdf6ES/zchaFfEK3pbnJVhU/VhlNBLdYpUFhhwZyEhE6vsb
         2PejIUevv+7DNzmPNZPNwnpVDYBmE3CDCi0TZ4lHHEq63JrW1Pa3NgH9AUBRJHkGT/eZ
         jfbufeoQpcZCnDjTh5FgfFfKIrhUCSvsSE5L6Bk3uw0/fkIOsb2YUIubWIWWuRXiJ0B4
         PWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yFK6X2V6i39GcNDQWpzEpnOVpoV1Dx+VySBb8i2GX/I=;
        b=lcKz2KI3GDGoNUD/IhL+zzk71SGtwS52bC7k3y3l2CuUSi1yPbTvRfZsgzHgKy7oKo
         YrBV1YH3wkQoltWVSc7YB+zm8siSlAJo5ZZ9kmGO8QgGuAqlhNN/npzhV+RPfsINLlc3
         uMV4zMUEB+zg1kjsPvFqwOaCcbn/lHXr8OFbufBoSE1oO+pN++nSeZDLtfeWbISYI6Rg
         J29DTPVivt9UXPTyBtyqgq2KzOUypVD6k5VXyoJ4UXNk0hPdwcy0p1VUjiRZXPHn7i7C
         M8ZNdWf8hiyWfULwGiyY3YHSW9tMZrxeTNUVyKIArjCPS7eclSJ67KRhruVjcZ13maL0
         B5sQ==
X-Gm-Message-State: APjAAAW1ND2/4yKUPR7pmkq51wdnzGW9qr06mHZCWs0mSh5nA4I+wHAO
        EknpnMS2xjpJpUcPF1RxtcXmTA==
X-Google-Smtp-Source: APXvYqx0FuZccTavmCfh5UKk59D68gUWa1P+Lko4JSyqzHolIXwrXQ2h9DNNhEMWzPwh8vmYnLQyAw==
X-Received: by 2002:a7b:c059:: with SMTP id u25mr2593849wmc.140.1567684888491;
        Thu, 05 Sep 2019 05:01:28 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a18sm3436311wrh.25.2019.09.05.05.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 05:01:27 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 0/8] ASoC: meson: add sm1 support
Date:   Thu,  5 Sep 2019 14:01:12 +0200
Message-Id: <20190905120120.31752-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset prepare then add the audio support on the amlogic sm1
SoC family in ASoC.

This has been tested on sei610 platform. Since this platform does
not have spdif, this patchset does not include the change necessary
to support spdif input or output on the sm1.

Jerome Brunet (8):
  ASoC: meson: add sm1 compatibles
  ASoC: meson: add reset binding
  ASoC: meson: axg-frddr: expose all 8 outputs
  ASoC: meson: axg-toddr: expose all 8 inputs
  ASoC: meson: tdmin: expose all 16 inputs
  ASoC: meson: axg-frddr: add sm1 support
  ASoC: meson: axg-toddr: add sm1 support
  ASoC: meson: tdmout: add sm1 support

 .../bindings/sound/amlogic,axg-fifo.txt       |   9 +-
 .../bindings/sound/amlogic,axg-pdm.txt        |   6 +-
 .../bindings/sound/amlogic,axg-spdifin.txt    |   6 +-
 .../bindings/sound/amlogic,axg-spdifout.txt   |   6 +-
 .../sound/amlogic,axg-tdm-formatters.txt      |   4 +-
 .../bindings/sound/amlogic,g12a-tohdmitx.txt  |   5 +-
 sound/soc/meson/axg-fifo.c                    |   2 +-
 sound/soc/meson/axg-fifo.h                    |   1 +
 sound/soc/meson/axg-frddr.c                   | 105 ++++++++++++++++--
 sound/soc/meson/axg-tdmin.c                   |  47 +++++---
 sound/soc/meson/axg-tdmout.c                  | 103 +++++++++++++----
 sound/soc/meson/axg-toddr.c                   |  83 ++++++++++++--
 12 files changed, 321 insertions(+), 56 deletions(-)

-- 
2.21.0

