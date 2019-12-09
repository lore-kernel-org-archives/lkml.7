Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AECC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6836020726
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MTVk39t+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfLIOva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:51:30 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45227 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfLIOv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:51:29 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so7336508pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 06:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y+0hUIOuHNjYLITTiiOz7YncnUCd05TXc7UArDjIWPQ=;
        b=MTVk39t+p3sutUs/EaeRJsE9LBl7uiMHkFMRLZd/nX+Pe2fsFUDRRmXx9l/V5Dj6aV
         59Z9O3SSk0vvqJhbLLM3jWLWTQgC0a5FRwezfJhM/mgIXd7HIQAOSTSiq0SsZSItO1RV
         LBTAWLNycc1s071U3sy9+SqAlBOMKjNrnU7mE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y+0hUIOuHNjYLITTiiOz7YncnUCd05TXc7UArDjIWPQ=;
        b=jw9/l9re5YzxBVbqo5i6BlC9yWQ6Pio3fS1G6QUtoCJ+vJoyyBTl7Xj8BhowSP/8Rt
         j1ZyRU9vTCMY5Kk/BkCfyI6LOa5YwWFCu9rFFzWqygqk/q/Ie6EsEAgBawGoNnBuota0
         XStNxwQkZspxAOGvOB48OwA5Hmo0A/TYYFUQCDBhVPXYLeEdW2z22GhvokTWGiHqkL7z
         dSqvXmgoVCBoIGpKRFGQS9iqn17wR5WoANE+0kVifLRDbjs7H3b3/6yjQr/9G4aKtjUh
         X9rWl+Rr3v1wiv+k61Mhxy/QbL9QsB1b7aF+kIWCleaEUETx9LClNABLvp2bJcPaTrZV
         FKhg==
X-Gm-Message-State: APjAAAVvP/mH04fOFkhB8C5DUCpHahT/KKeWHB3Vo688j6QWDnnBWyB+
        q4IwwGSJHqaAdX7WNMP1Qdw5JQ==
X-Google-Smtp-Source: APXvYqywaG4WX0pSxF4HCeSSMFbKbY3wDRtmsG50dx44TU1Ypx6sq4Pk+CTzkgbiq0kZiYkp7z8Gbw==
X-Received: by 2002:a63:1101:: with SMTP id g1mr18531573pgl.435.1575903089059;
        Mon, 09 Dec 2019 06:51:29 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id k16sm29143119pfh.97.2019.12.09.06.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 06:51:28 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Archit Taneja <architt@codeaurora.org>, p.zabel@pengutronix.de,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RESEND 0/4] drm: bridge: anx7688 and an optional feature
Date:   Mon,  9 Dec 2019 22:50:12 +0800
Message-Id: <20191209145016.227784-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Resend to cc more reviewers]

This series is to add anx7688 bridge driver. It is extended from
previous work[1].

The first 2 patches are same as previous version, with some modification
due to drm core function changes and use regmap abstraction.

We add an optional feature bypass-gpios so that driver can decide if it serves
as simple pass-thru by reading GPIO values, which is controlled by
hardware.

[1] https://lore.kernel.org/lkml/1467013727-11482-1-git-send-email-drinkcat@chromium.org/

Hsin-Yi Wang (2):
  dt-bindings: drm/bridge: analogix-anx78xx: support bypass GPIO
  drm: bridge: anx7688: Support bypass GPIO feature

Nicolas Boichat (2):
  dt-bindings: drm/bridge: analogix-anx7688: Add ANX7688 transmitter
    binding
  drm: bridge: anx7688: Add anx7688 bridge driver support.

 .../bindings/display/bridge/anx7688.txt       |  70 +++++
 drivers/gpu/drm/bridge/Kconfig                |   9 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/analogix-anx7688.c     | 260 ++++++++++++++++++
 4 files changed, 340 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/anx7688.txt
 create mode 100644 drivers/gpu/drm/bridge/analogix-anx7688.c

-- 
2.24.0.393.g34dc348eaf-goog

