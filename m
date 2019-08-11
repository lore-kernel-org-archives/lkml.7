Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C56C0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 20:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59181208C2
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 20:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViO0P++5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfHKUb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 16:31:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39943 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfHKUb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 16:31:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so10022050wmj.5;
        Sun, 11 Aug 2019 13:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6dOMEfOb1vmuX/6l/d3avTdPuEJdGUDFzKuzVhzSSwQ=;
        b=ViO0P++5hjh8dnkGtGqlG3J38bvwKJgVHbgG4HRRD2mqb03ZqtIsupG7JVG3AKdKB0
         uqGJD4EGCMwBtCQrCz1lSw+9mIzXjIFFAtpyPdk7iNhMdR/VwtC9xUtJsUUy2f3FBgPv
         A1Gm1HqtMZXGWX5sNowc4ICheOxtNKIFMtDXdjjMQE9FZZQR3RdJP+YmxvWQ6aM9c3Hw
         jX/cHA8SsoIUr+VbSOvCHCC9k8NNCdja6r+g/j1s0V7v8viQGEoIhN7KTGXsS/2hvmxb
         YjZoSKkOmUYPmuXl2TK8e+ip7A73zeMJeLL+ezFto+Zo3LRt1aKadA9TNSxk8LYVKTyS
         QJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6dOMEfOb1vmuX/6l/d3avTdPuEJdGUDFzKuzVhzSSwQ=;
        b=dt5G27TK0RG0XZrIyAGSSMF6wJSFPFWBSRA+l3VUGSIOr+1JHM2xtsX3tPBCvp84WG
         kjCni64YNrePiYPRxwU221CEfakE7pTk6fGd/ReQtLZYk6Tnq1k/XqkphrVC6rGXNEeQ
         ijdqv+sEY9nTH4i5IEAVJnXzEcxnjZXxf1JlQjI/GA/3gXDpdlNIQ06LksvK2S1vt26W
         qU/L7WXOmkSi+6IC7llMP8yakTPwEzBC70ZlURmXNwwoVXXWUuaI5044qz/H8XbQMRkw
         yyBLsJSanqlfYQb3IXkdgPUS6YTTzgXd6Qs6Cgs2ktNKaGsYpbiFCOA5LviK4kJJeeCL
         G/8w==
X-Gm-Message-State: APjAAAWPpR8821Q1Df7Oji7Bq/eTORRDYVBftow144BuDGgVlnFYfCoe
        ojFYVKt3jHZhONh3DoF40K8=
X-Google-Smtp-Source: APXvYqzEN7q5gvE9iuIA2xRk3W11noAPkkHt45AjTzx1U+c5eNJWmzVS+/Yb/w+zT/xNpTBDnGtYmA==
X-Received: by 2002:a7b:cd06:: with SMTP id f6mr9391045wmj.66.1565555514739;
        Sun, 11 Aug 2019 13:31:54 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id a8sm11063269wma.31.2019.08.11.13.31.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 13:31:54 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 0/3] Allwinner H6 SPDIF support
Date:   Sun, 11 Aug 2019 22:31:41 +0200
Message-Id: <20190811203144.5999-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 SoC has a SPDIF controller called One Wire Audio (OWA) which
is different from the previous H3 generation and not compatible.

Difference are an increase of fifo sizes, some memory mapping are different
and there is now the possibility to output the master clock on a pin.

Actually all these features are unused and only a bit for flushing the TX
fifo is required.

Changes since v4:
 - rename audio card name to sun50i-h6-spdif
 - drop patches already merged

Changes since v3:
 - rename reg_fctl_ftx to val_fctl_ftx
 - rebase this series on sound-next
 - fix dt-bindings due to change in sound-next
 - change node name sound_spdif to sound-spdif

Changes since v2:
 - Split quirks and H6 support patch
 - Add specific section for quirks comment

Changes since v1:
 - Remove H3 compatible
 - Add TX fifo bit flush quirks
 - Add H6 bindings in SPDIF driver


Clément Péron (3):
  arm64: dts: allwinner: Add SPDIF node for Allwinner H6
  arm64: dts: allwinner: h6: Enable SPDIF for Beelink GS1
  arm64: defconfig: Enable Sun4i SPDIF module

 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  4 ++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 38 +++++++++++++++++++
 arch/arm64/configs/defconfig                  |  1 +
 3 files changed, 43 insertions(+)

-- 
2.20.1

