Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5CAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CF920820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIlC+CZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfDJXQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:16:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37576 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfDJXPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 19:15:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so4844592wrm.4;
        Wed, 10 Apr 2019 16:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kq8Fk6m07P6jzWZ9olFEh1l8VyZCS3V+gmVAUG9Nqhs=;
        b=sIlC+CZQDLmSAHBjWktNS6GjvQQK+LNh2Dgq4eBoN54cK8kNs3GNfX9w0OFMK8Vgx/
         88kNsVYUoaI1ue4521+OfDimpL74RyzscB3xBDfYWEYYSZ7B0THGuwuV1pRKXScxtVeE
         ihtGhEaD6A9FHvFmFC5iuuVmXsbvkELR9nXUFA9c2dLd2QtkcR8XIT+W7y8UbEnMXihr
         i18in6xUY6D7ptZP36+LDhX8ffjT128SAqN4o1EUNd12m+RTttl8/GprNDhCfsvhtE3k
         fI6YbiPUbEWutFSY1pPGu0+cPFUFJaV1d7JHGtX+tKnC01WIwpE8EEM4iABBAbgo1ECi
         YpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kq8Fk6m07P6jzWZ9olFEh1l8VyZCS3V+gmVAUG9Nqhs=;
        b=Y4LsUjcDHwbARjPrZhF/InjXt/qHA6hFGpIK+QM+apHZ024rW8HoFJe54n9LGQFj8h
         +OGjOU0V3zYQupGX2pj9XNjJseM+G70GhdkqrxE32IVtIUYIfxRIYOXLUjX8GCZNlzka
         lUa9IINXlUMvQRgi9HPc/WX/eyIQxu36qa18TRxxpOmB4Yi84UYCTji9WVxTLBo0DCuK
         IJ3w4G+LQHg6+6leFsMAPuZrgYWJKAzAy+NbXiDW0TlKf5EwxeF6QF/rh5KkvufB64aH
         Cwcqo7oxJQnKFqgIKvnomqFzWCy8iz1j3rwxSitrG/eC0XPx1ldtpnFJ5MrNMZjTrVnP
         Bkjg==
X-Gm-Message-State: APjAAAUAmAyJ+En5f29gL2fkrH2+sk3Vh5WeZ7AhqtWfZYYV45CnklYa
        Nb92Y0qrTllfxc0yXj4IexA=
X-Google-Smtp-Source: APXvYqy1mP74mIs9gFl+OL7J5jVXFMmS7M1TKpkjWocGf/mK4U0ERj4+bBEPadv2HHx/F6iWPL17Ng==
X-Received: by 2002:adf:fa86:: with SMTP id h6mr27837901wrr.67.1554938132715;
        Wed, 10 Apr 2019 16:15:32 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id n6sm8504947wmn.48.2019.04.10.16.15.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 16:15:31 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 3/8] dt-bindings: gpu: mali-midgard: Add h6 mali gpu compatible
Date:   Thu, 11 Apr 2019 01:25:38 +0200
Message-Id: <20190410232543.13297-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410232543.13297-1-peron.clem@gmail.com>
References: <20190410232543.13297-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add the H6 mali compatible in the dt-bindings to later support
specific implementation.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../devicetree/bindings/gpu/arm,mali-midgard.txt          | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
index 2e8bbce35695..9e71146b5c8a 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
@@ -15,6 +15,7 @@ Required properties:
     + "arm,mali-t860"
     + "arm,mali-t880"
   * which must be preceded by one of the following vendor specifics:
+    + "allwinner,sun50i-h6-mali"
     + "amlogic,meson-gxm-mali"
     + "rockchip,rk3288-mali"
     + "rockchip,rk3399-mali"
@@ -49,9 +50,14 @@ Vendor-specific bindings
 ------------------------
 
 The Mali GPU is integrated very differently from one SoC to
-another. In order to accomodate those differences, you have the option
+another. In order to accommodate those differences, you have the option
 to specify one more vendor-specific compatible, among:
 
+- "allwinner,sun50i-h6-mali"
+  Required properties:
+  - resets: Should contain phandle of :
+    + GPU reset line
+
 - "amlogic,meson-gxm-mali"
   Required properties:
   - resets : Should contain phandles of :
-- 
2.17.1

