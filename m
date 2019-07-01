Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9915EC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B972208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hW14fZOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfGAKrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 06:47:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43382 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727613AbfGAKrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 06:47:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so13236228wru.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 03:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c8sM/HnNuJjRWY+rt2JMg/RY9zhPGzYFwgmUvpAZUJI=;
        b=hW14fZOPSzk6UX/QjIdp3cq3rhVDpryRuT/4AdMSNpLtZHSS5SN5YM2X2oMMRRozGE
         W9qD1uFpQfXRcVBWnjTDSZa9AX3vBIcABnI7Oo8txFe5N7z91+Qhjo/3wdh/6HoX25Wz
         0TZWhPmIPjR0buoDyq9glGNxHHqbufpOb1HcNTCsFrNI4khqEAmUGARsH2SqN4mSM6oy
         ybdJ0gyn9ryE1sgfh4+DiYye5IXkYRqele3wb1oyFb7Ld/sEyoa6an7LT+/amfb83e0f
         +FXdJBqK7bZCw53gkkeLkKw2zO5syGWsbA15ONVA7OSrD7pgFX7Ipgklg12pIgxzQ8G3
         HX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c8sM/HnNuJjRWY+rt2JMg/RY9zhPGzYFwgmUvpAZUJI=;
        b=Cmh7ydrbyDh5mZ8NcJFYMz9a0TKT2KtzyVd2zDORWZ6fwKQgQart7JNY9tKTunVne+
         5I4H4e0vV8S12/+88i2UwyrqUsh1f6LseLFqAOScCcE2dIy1qBxYTlXP0Jbnm0Igf7mP
         f/rxt88D9mrMUmE0Li7m8XOZHYykYLR2JGa35OWJiIyEybFyauVmv3fD7L/Un/nDvqpk
         QEYqZOiAWj7GKTZSKu3faysqKYsL43lj/b/awdUBPSPvj4ClDR5YmXOvAfONhzaAxlLw
         /Wz8faCG0bAN8k7U4cDQGcya74yQENEVNA863oNScL7DsX3IHEORzxTMi3zlv6cLQG5G
         IaRw==
X-Gm-Message-State: APjAAAVglNN8VhIqntCB44K3b4F3tdNR9Fsd275O0i7vttu6PnQkP6wV
        2G8wzCEeIDMgR+LUonp1Z1qZZw==
X-Google-Smtp-Source: APXvYqyvZrofC8pt/Phh7KaZcgrbDtY8HT8ZChdGn4dtfDOnaLItYIGb8JCn6KtB2wj5NvFsw8KwFw==
X-Received: by 2002:adf:fbcf:: with SMTP id d15mr20030929wrs.50.1561978055347;
        Mon, 01 Jul 2019 03:47:35 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id d24sm11658802wra.43.2019.07.01.03.47.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jul 2019 03:47:34 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC 10/11] dt-bindings: arm: amlogic: add SEI Robotics SEI610 bindings
Date:   Mon,  1 Jul 2019 12:47:04 +0200
Message-Id: <20190701104705.18271-11-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190701104705.18271-1-narmstrong@baylibre.com>
References: <20190701104705.18271-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible for the Amlogic SM1 Based SEI610 board.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 0b419fd0bac2..ebf707165d73 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -143,5 +143,7 @@ properties:
 
       - description: Boards with the Amlogic Meson SM1 S905X3 SoC
         items:
+          - enum:
+              - seirobotics,sei610
           - const: amlogic,sm1
 ...
-- 
2.21.0

