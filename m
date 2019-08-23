Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B854C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 13:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFC822CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 13:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqHtalEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404775AbfHWNJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 09:09:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38796 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394994AbfHWNJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 09:09:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so8605672wrr.5;
        Fri, 23 Aug 2019 06:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MRgcnuzG2I8lDuGL1jMNsqN/KgyJ2300oOMbrHcQPAk=;
        b=UqHtalEMPEp3cSm+E2tTMndX4iPSkrW7CknIbiyhI7JRQv9rH2Rk6ZpoWDasM7bS2g
         fbDOBgLxD04GDfGsaEYGYZlE/IZ8DYSS6DBuV1m2s2LXImC2UdQsCWbLJIaTrvGjaLoe
         uobQ55c5l9XrUmvtrySAQlGTinrOQkwxVfrwn+4XNsgGfs3zGmgpNUzF9jACZP7jgiWV
         HC/GR8yzSH5Vg8rIiGgiPeYjFhkrMgMvKn4I7US4uWTmDsYJ7qJytWAInzN7TQhwiFDx
         wdklaIoI8CPt0zCZ/dt5yxrRe/WnsDcBxZe1HRcb/KqxaE4EoAZtJpO3FC1igcKlM9ul
         mnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MRgcnuzG2I8lDuGL1jMNsqN/KgyJ2300oOMbrHcQPAk=;
        b=Hic16hcA5EKGAB5L7V4fz9wMQ5Tz9dUSjsw5YwNw4YxVAuw2QkOo/fSnC3cRtUx/EI
         pcfrDo5SrLSsxmlnzvqfugnRaGjO+CvEI8NecO5QUNHM9Ryt5haG3/lx3gFgyd5l/Bzf
         zArMw2OqIo//D+kfcg9GRVbdayqRyUdLIX3cUQIgDAQeLT3Jka4HM3ATWnyKJ/A6z9rN
         UaigTqVmmbO4ZJplzgM1+7DeUX0lQLhVc4pHhw0S0+COZeF0QzzUM7+xjPA2RTJxuqoJ
         bYg5JdBqHz9AgLWG4Nix0znLCncQhmuxYGpgmBwVXC7vv0ukEiVwlvUrFRnQ53wmCeiU
         WIow==
X-Gm-Message-State: APjAAAXSDH5Deb/858uKR+tGm3E3TL2ve/OiUe56yT1OfUXXFXUYLhzN
        f7bTC/9J+WQXDIKL3oYqc7Y=
X-Google-Smtp-Source: APXvYqxcQ+4cLIrzVciiwjDYzpbA9TaWEp26IDcmHpMs2V3goBt61z+hwndHALj9mnOCwTB+n0vPPw==
X-Received: by 2002:adf:a55d:: with SMTP id j29mr4849842wrb.275.1566565774269;
        Fri, 23 Aug 2019 06:09:34 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id m7sm4359854wmi.18.2019.08.23.06.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Aug 2019 06:09:33 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chrisitian Hewitt <christianshewitt@gmail.com>,
        Oleg Ivanov <balbes-150@yandex.ru>
Subject: [PATCH 2/3] dt-bindings: arm: amlogic: Add support for the Ugoos AM6
Date:   Fri, 23 Aug 2019 17:08:36 +0400
Message-Id: <1566565717-5182-3-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566565717-5182-1-git-send-email-christianshewitt@gmail.com>
References: <1566565717-5182-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Ugoos AM6 is based on the Amlogic W400 reference design using the S922X
chipset. Hardware specifications:

- 2GB LPDDR4 RAM
- 16GB eMMC storage
- 10/100/1000 Base-T Ethernet using External RGMII PHY
- 802.11 a/b/g/b/ac + BT 5.0 sdio wireless (Ampak 6398S)
- HDMI 2.0 (4k@60p) video
- Composite video + 2-channel audio output on 3.5mm jack
- S/PDIF audio output
- Aux input
- 1x USB 3.0
- 3x USB 2.0
- 1x micro SD card slot

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 325c6fd..2ded61d 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -139,6 +139,7 @@ properties:
         items:
           - enum:
               - hardkernel,odroid-n2
+              - ugoos,am6
           - const: amlogic,g12b
 
 ...
-- 
2.7.4

