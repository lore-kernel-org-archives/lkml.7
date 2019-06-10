Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6C9C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822F8206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lT00zEWQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfFJQpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 12:45:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33909 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfFJQpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 12:45:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id e16so9927743wrn.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 09:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nahDfB+sETBKegXKfy/SodtmY1BLud+5qo+bYwVBnVw=;
        b=lT00zEWQBKTcIrdf1DSG77zx3wzE+5oMxUfbuyi2w9rk7Bh7REl+ToPUKJaxy4vL7z
         AqIWtzDYPCsA+cXDkybh0W8egNZ+BfklMhL4EMKjhXt/xATwOhBE2BHH8UQK71dGRYKR
         bafdZRPL3D/QHr+jqKY6gxaqmNNKdp631kykqe1agrXyqRi0epe/4jUNfLdAaz7ijFvq
         8fhpgFhME9k7nOnYNU1k6bXaGECR9WsgvbdtCR3jAEaOuN17y2AfyJbTPhmd7j+4jkAf
         lMttQxi++m8IWT2/3EOc4N8rNDjrsh5XfUBtpQHl/G8fKQ30R+lakY5550yVloGUL+zu
         5soA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nahDfB+sETBKegXKfy/SodtmY1BLud+5qo+bYwVBnVw=;
        b=VemqkE3ZsmDyJn0E6/krveYU6el2C+cW3wDk5LPIO3PUAr7lw6CosMa1/QIxqoKVMX
         58wxFpKQsNmB9ZIC7Dfgf6idWS1rSKzSWg7USy5VjdW9I/UxdjUhtXJORAf6R16DG9HH
         uw9EjRqncw4rh9eqrPoKLz9BnYutEbeej9A7zLw73TAau4WMWennT+wSXeJRps0lIOTE
         6ezqM0FSR2a37aLR7P68isHPBbK6DgLqDm+FEYmz3R3wayHFIAO0ZlcrxvxO9TCqnaw4
         XEmPj7kpYNwCtb1025UzLlgwxqgdF6ip1Ngh9kTtjfPWsDELcSpmDpEuOT2u2i+V34Q6
         C0qA==
X-Gm-Message-State: APjAAAWM+/VuzcQz3kimluIgXHAQaEdzvL4blGlwzhZ5s/533rmi1VBo
        mKFW83kn9GwSycNDdQ9DHFU=
X-Google-Smtp-Source: APXvYqx0x0tmbODDCfYeLJWzIheIC7aPsNOI9HSuYlsJi+GMqfDcrpthcsLlQSlsn/njQXUotdTv4w==
X-Received: by 2002:adf:f041:: with SMTP id t1mr1446704wro.74.1560185140616;
        Mon, 10 Jun 2019 09:45:40 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA40000C4C39937FBD289.dip0.t-ipconnect.de. [2003:f1:33dd:a400:c4:c399:37fb:d289])
        by smtp.googlemail.com with ESMTPSA id g17sm11441158wrm.7.2019.06.10.09.45.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 09:45:40 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/2] arm64: dts: meson: g12b: odroid-n2: add the Ethernet PHY interrupt line
Date:   Mon, 10 Jun 2019 18:45:30 +0200
Message-Id: <20190610164531.8303-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190610164531.8303-1-martin.blumenstingl@googlemail.com>
References: <20190610164531.8303-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt line of the RTL8211F PHY is routed to the GPIOZ_14 pad.
Describe this in the device tree so the PHY framework doesn't have to
poll the PHY status.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index 0d9ec45b8059..8c9535880007 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -190,6 +190,10 @@
 		reset-assert-us = <10000>;
 		reset-deassert-us = <10000>;
 		reset-gpios = <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
+
+		interrupt-parent = <&gpio_intc>;
+		/* MAC_INTR on GPIOZ_14 */
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
-- 
2.22.0

