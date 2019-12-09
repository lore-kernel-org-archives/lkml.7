Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE47C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34075207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KIUFYWsW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfLIMUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 07:20:38 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39171 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfLIMUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 07:20:34 -0500
Received: by mail-pl1-f193.google.com with SMTP id o9so5742603plk.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 04:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=14NsRbqvK8Ly4ZGyXxprE+o0uGGyUabr+uKcGJngRc4=;
        b=KIUFYWsWooBe3edZNIIK7RXwJ6wb5f00cg24QfqUtdtz/nDGBq8wF0lINT2oj/lltn
         qGuR66Y8XZcShHtXczD8K/WpgbVd7OyG4FNPuhveaOYNufHdlbpLAShWQaII1Q+g8Ham
         3NYkNFbWFYmHJBjUFVtJfFEOXZXteK3znBRew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=14NsRbqvK8Ly4ZGyXxprE+o0uGGyUabr+uKcGJngRc4=;
        b=KGDWvNaNuLwMGhgiI49YyuDQmgS7+plZWYePcbhsOIKi6WfYC8dYLS16Fa7KyTjU6g
         yDWwitNO45ty+5EZNKslQ4E0ctSAFqPvemZtKjlp9qvEbvur0iklpnqhRT6u6bDnh88g
         IljjaBZvFmaIsiAyl3XYB8CVzBBVtblMIUEb6KjX/mtQm890iMSWzK2LaA5Z3xBK6kTx
         W030efgVldx7fxg67ZAJPWctWTwCMTl5kE1oYF/oqwff52hB5sUAXGRrs6eiENP0D2xK
         PBd2hrbZnqBuSn1bPQpoEP0gGdt0OIwpstaaZXf2q6sA78QGsCz5ELgnnEfPIBxo/weI
         Wagw==
X-Gm-Message-State: APjAAAWVq9TSIpVr/flTWRr6hUCnsLiUZFVGuzgSh8kV8UR5d+ZHTNDU
        JfIDi/xsl2L4+cnRsPkCtF5aYA==
X-Google-Smtp-Source: APXvYqxMY0xvW14ePmqad7uZDMT0lAjkHermkSqJ1BHmnyUjnmY0Z8cUIEjYN76Ys5I89pUGIXVcHQ==
X-Received: by 2002:a17:902:9a04:: with SMTP id v4mr29561894plp.192.1575894033251;
        Mon, 09 Dec 2019 04:20:33 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id p21sm26733813pfn.103.2019.12.09.04.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 04:20:32 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Archit Taneja <architt@codeaurora.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Thierry Reding <treding@nvidia.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Matthias Brugger <mbrugger@suse.com>, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] drm: bridge: anx7688 and an optional feature
Date:   Mon,  9 Dec 2019 20:20:09 +0800
Message-Id: <20191209122013.178564-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

