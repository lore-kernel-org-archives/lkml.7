Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB77C31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 10:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A1220861
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 10:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PQ/BYi21"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfFOKoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 06:44:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38157 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfFOKoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 06:44:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id s15so4595758wmj.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 03:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MlMxB1kkxmHmQmoUfndP7WEc3kmIml+FN9RGpOVU2A0=;
        b=PQ/BYi21UH6+Ssb5iH96mB8o+aNRXd2tJIOFhAfqxaQaYYiU2uI4IH2xGHAzu744l4
         C6tiY3gWFvycZKcoP0Jj8TM1Vponm6Oi+0j7JuG/7glC8uispNWXMWrz6gY30sw330g1
         iJ79DFPCtg7GmMhDoXdu5DGQFFMI9QismZbp0YrrTBhdrg3bKYjU5JLZryx85OWIjeUy
         h52lhJDAUqv5Xoy3yTBalyYnUVXJHq8s5TYQlhjJjlUrPXiSJb9gaWH9lE47TAdZu2/O
         TrqsQYUmolj/RCdi1/7zC1brF+7luIJyPkGaP9kgLVhSjl8Fq7ObHTk5jaw2jW81FMov
         aV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MlMxB1kkxmHmQmoUfndP7WEc3kmIml+FN9RGpOVU2A0=;
        b=LXSHJUfPpHXqZWLgUvYFqy5RG7JYid0mIZv4svOggEv/IXpe4weJEcngDLUDVzQfxA
         WPwP8DaKsrY3HzLkwEQfvoufcDZ61PilQvSloIvE3uf+OUXZrRUremzxcTlLzPzHcHcb
         5nw1gJnHI+6cqUOiUx6mI2upmaRkozX2KYqdOjONbOPsSXZ6CYnWdbkH1QnQRtKT3Cyq
         8wuUlb5KxXacOsx8iamola+sawOcpTihQQgoVO2sPCE7BIZqyDkdITbEwuGK8hhmXYWn
         vfqFMYFUkfgaymQvoXPY8wCmunRs2pvLAObWITX/tcVZnJTIku2P9wXQPblCpEDusjzq
         7Lqw==
X-Gm-Message-State: APjAAAXcRV7u6DYWyPzrqAlUFFjLvxFFXs5vmGO7qLS++E89E81HclCs
        dCWAgBnTYt8GS8pCey2iC6c=
X-Google-Smtp-Source: APXvYqx6+Vnz65TOT8l4fd6YCoiZukdBu/ZU2e8kjlDhqiLJ6xa/48ufal7xACP07XTDnGHc15LVYQ==
X-Received: by 2002:a1c:7217:: with SMTP id n23mr11435578wmc.47.1560595444894;
        Sat, 15 Jun 2019 03:44:04 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C20E00A9A405DFDBBC0790.dip0.t-ipconnect.de. [2003:f1:33c2:e00:a9a4:5df:dbbc:790])
        by smtp.googlemail.com with ESMTPSA id l12sm16761120wrb.81.2019.06.15.03.44.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 15 Jun 2019 03:44:04 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/2] arm64: dts: meson: g12a: x96-max: add the Ethernet PHY interrupt line
Date:   Sat, 15 Jun 2019 12:43:51 +0200
Message-Id: <20190615104351.6844-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190615104351.6844-1-martin.blumenstingl@googlemail.com>
References: <20190615104351.6844-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

X96 Max has the PHY reset and interrupt lines are identical to the
Odroid-N2:
- GPIOZ_14 is the interrupt on X96 Max
- GPIOZ_15 is the reset line on X96 Max

Add GPIOZ_14 as PHY interrupt line on the X96 Max so we don't have to
poll for the PHY status.

Suggested-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 3f9385553132..fe4013cca876 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -289,6 +289,10 @@
 		reset-assert-us = <10000>;
 		reset-deassert-us = <30000>;
 		reset-gpios = <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
+
+		interrupt-parent = <&gpio_intc>;
+		/* MAC_INTR on GPIOZ_14 */
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
-- 
2.22.0

