Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44E2C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856CD216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lXqccuzP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387770AbfETOlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:41:22 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:43571 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730630AbfETOlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:41:21 -0400
Received: by mail-wr1-f47.google.com with SMTP id r4so14884943wro.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1IcjIbQ8PHaq6VYvuNKdHBqkf9lRmX2qSNld7AdUH8Y=;
        b=lXqccuzPhOCSd0eAXFGQDmHVBo+Zq2t8h9b00w19EFmdsu1I3XhrW/tBLWjVyqiEqD
         NYNMGgTHkhQ8gv0kYOE8VK+4fdR122C0zkAs0bptbu7m0KoK8FhXjvNtPvTHvCmmqpeE
         HtsYRP6brrOcEjwOmTgixshcqRtzUQhYfvslxCUYWo+pzYXmu90z3KCAKhhNkGXAcJM3
         RUkeh5fMkvUUrlbcwSpUbxN8cxSnu6yrfaSJ6aXbt8FpsgiHxIm8aSUd+lwwlSneFKQp
         h5R5W0veH4EcdwjhYGFpkkJ/d7hj1LiWKpmRWUejw+G60jPTpe0LyyVS3VH5XRiAwdHl
         uqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1IcjIbQ8PHaq6VYvuNKdHBqkf9lRmX2qSNld7AdUH8Y=;
        b=ea0fSyrq8E7N/bpEq1+yx8bGzwRVSlS0IFKxTgDVwgWooVV9CoHEHzpXthJA2UXILS
         yQm6JDStfV703aIdZ33QAbXxK5o7wkSfhrLUm5TFnb78pWrozo48mYpNWskjSq9iSgiI
         AQWhZY7C9B19WTLcjtfRB89kVHwU0mk1MFW+CwjhnJN2ANqAogphfPaVBneNnH4zYyZT
         co65ep2FasL83vZq6S4vBr33bg6D3LiLSX/l2778/EuGpA+s5gchCmHUUaxTgmKJYEq6
         irINEGDPcIiZwWhHlXPHuv5dwIiAERqjquhEaq2AMnxvyM+BMJuSWAA91V32WsgSWAQd
         K0lA==
X-Gm-Message-State: APjAAAX0pX7RgjGNC4Pg3EBhTgeq15gOX/aPLA6Pk4K+/Y4XXzAgg28Z
        ytrEW1/JqoRL/52Kl3ypaI9BXQ==
X-Google-Smtp-Source: APXvYqzJrbDLhKYgrYJFKpMvydjk+z5fNJ4UI9UtYfEjiy5zXI97tUynBoSZwSPBPAr8FOXTlstiXA==
X-Received: by 2002:adf:f208:: with SMTP id p8mr26008555wro.160.1558363280342;
        Mon, 20 May 2019 07:41:20 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id w3sm6743679wrv.25.2019.05.20.07.41.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:41:19 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/5] pinctrl: meson: gpio: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:41:03 +0200
Message-Id: <20190520144108.3787-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the SPDX Licence identifier for the Amlogic Pinctrl drivers and
the corresponding GPIO dt-bindings headers.

Neil Armstrong (5):
  pinctrl: meson: update with SPDX Licence identifier
  dt-bindings: gpio: meson-gxbb-gpio: update with SPDX Licence
    identifier
  dt-bindings: gpio: meson-gxl-gpio: update with SPDX Licence identifier
  dt-bindings: gpio: meson8-gpio: update with SPDX Licence identifier
  dt-bindings: gpio: meson8b-gpio: update with SPDX Licence identifier

 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 8 +-------
 drivers/pinctrl/meson/pinctrl-meson-gxl.c  | 8 +-------
 drivers/pinctrl/meson/pinctrl-meson.c      | 8 +-------
 drivers/pinctrl/meson/pinctrl-meson.h      | 8 +-------
 drivers/pinctrl/meson/pinctrl-meson8-pmx.c | 8 +-------
 drivers/pinctrl/meson/pinctrl-meson8-pmx.h | 8 +-------
 drivers/pinctrl/meson/pinctrl-meson8.c     | 8 +-------
 drivers/pinctrl/meson/pinctrl-meson8b.c    | 8 +-------
 include/dt-bindings/gpio/meson-gxbb-gpio.h | 8 +-------
 include/dt-bindings/gpio/meson-gxl-gpio.h  | 8 +-------
 include/dt-bindings/gpio/meson8-gpio.h     | 8 +-------
 include/dt-bindings/gpio/meson8b-gpio.h    | 8 +-------
 12 files changed, 12 insertions(+), 84 deletions(-)

-- 
2.21.0

