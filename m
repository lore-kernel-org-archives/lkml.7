Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B45C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 19:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE33C2064A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 19:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jMGFetvU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388264AbfG0TrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 15:47:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37984 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387890AbfG0TrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 15:47:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id s15so28881686wmj.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 12:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nJlEm3dspnVA1ANEmrZqrPkw4P7Y/3ZVDcm+FttuwD8=;
        b=jMGFetvUkouy5oaS2jC9JloqDDB4ECT5Fa59B0q8l9FZFb1TmFQeFuDB+PkR6358Hl
         GZOcEZ06G86uK/6zH82Gwdj8NsArIOCIX+mrwQBhjItintgYrxBW/lL7dTjOMWK26XS4
         TqV5BIAhUlaj9eFliO6D+6sdMxwNl6eAb0oXuaKkUA/eQJ5DNtO1DC80LTUbEPC5AVst
         lkg2S+BsXMyk57FnQJaaRZ8VmvM8Fs8NJWI3jTfsOLQmyN0pJu5/8oWk+f6i3AKV23VO
         Lv7d5qg0GusMAKDMNUOkcVGtOIBjDpV9Di7lkH28WDLPSBn8ZyrA3lO6OfRueI1r24fG
         /mvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nJlEm3dspnVA1ANEmrZqrPkw4P7Y/3ZVDcm+FttuwD8=;
        b=eMxrXcNaPahAUib/fIFAjQNcXKRLuO2pL2Bn+DpZmLWMHAs/UWSqqHG7Cn5Es1fi5B
         06/ZtBWteoDv2izQWFv2/njSZ8UyWHZkXi4/usAEIhIT5y5Eh5GUQlCA8LoIYGC4t1uf
         Twt4/Y5X90dBTUURIUb+kIVVXz1cO74wV8GXTfLZ2VOKmbHjHwxErtoGQiO54tuP9poi
         pfmxPppwBSheXR7vdfyz2OAhfnAZthgCAwMbIcbCrgDBlB96FfwNNYwyrxjr52z6SBmS
         S/qdYAMnGUf4uEL9skUe5NOoD5HdZIkyXOXrN/LX0K1fLVuVJJ6O0c6HlXidCarMdP7u
         8raw==
X-Gm-Message-State: APjAAAXGOrsZgL1efThDfVyX/3Rup9AD6YhwmcYuCo8xC+iwDk+mE7zM
        kW69K9Dog0CrBxT6y23+CVE=
X-Google-Smtp-Source: APXvYqw957ik/KAi3QT0gjmD5rTkJZINjl7uhrK+NX+nd9KMeifyb6WC8ERCf40L6g/Rr/rocBXY7A==
X-Received: by 2002:a7b:c748:: with SMTP id w8mr17514641wmk.36.1564256829821;
        Sat, 27 Jul 2019 12:47:09 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C65C00B418D0F4A25A19EC.dip0.t-ipconnect.de. [2003:f1:33c6:5c00:b418:d0f4:a25a:19ec])
        by smtp.googlemail.com with ESMTPSA id c4sm44651726wrt.86.2019.07.27.12.47.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 12:47:09 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux.amoon@gmail.com, ottuzzi@gmail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/2] ARM: dts: meson8b: odroidc1: use the MAC address stored in the eFuse
Date:   Sat, 27 Jul 2019 21:46:47 +0200
Message-Id: <20190727194647.15355-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190727194647.15355-1-martin.blumenstingl@googlemail.com>
References: <20190727194647.15355-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Odroid-C1 (and probably other Meson8b boards which are based on the
reference designs) uses the MAC address stored in eFuse at offset 0x1b4.

Assign the nvmem cell to the Ethernet controller as "mac-address" so the
MAC address which is stored in the eFuse is assigned to the Ethernet
controller. This means the MAC address will be consistent across
reboots.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 90f66dc45115..df428a40a748 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -200,6 +200,9 @@
 	phy-handle = <&eth_phy>;
 	amlogic,tx-delay-ns = <4>;
 
+	nvmem-cells = <&ethernet_mac_address>;
+	nvmem-cell-names = "mac-address";
+
 	mdio {
 		compatible = "snps,dwmac-mdio";
 		#address-cells = <1>;
-- 
2.22.0

