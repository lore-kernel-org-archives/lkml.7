Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E605C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625F821479
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ECz4Hpcn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389853AbfETNs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:48:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38004 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389715AbfETNs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:48:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so14711017wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 06:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WgQQkRup1RP/+DNyWfqO+Epqum0KCIs3YroTyrmMm+M=;
        b=ECz4HpcncgSFwRp81ULoGgyzEIf01j7MVMVLUZs5icfIEXRflAb/GdIZWzBcr1afr/
         WM6xeLK2gQpzHdGOjHFjxZoVP8gTIryAKKa6EUxoGNw7r+rXxtAMkPaNkUAzEfWikVh4
         9lGze587fgpcG71LRQ5fv3KjqmA3GizDMCnzJwrHsZ49sUaM33yumda5F1Z9HoR47goe
         3pWjQg9XGdwFRxHhxphQAeKvU8UZfYDiA75fbivygOL7h+iJzzckvEaE7f6Y+kQdtLcq
         pLT015MGQzFCjpLqAN/abu/1p9WpcJbyTEaUZz8tSRRCtpw3ogSH1vxoDjYxasMSBQCV
         +Zsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WgQQkRup1RP/+DNyWfqO+Epqum0KCIs3YroTyrmMm+M=;
        b=nFlIWTzqhK45fWB324YBf9vg+x6p+60hxBjwczmkas2AhfDztRlcKz7wgveZ7xf6wQ
         l5jMGdLAQdcIeLr0Le+Ua6pxBekOjNyhA+SaCo3x7yt7E7jd1I+GwKqQqLCFJLB4jJLr
         iaToO9d9wIhjPqYQujBS8D+rUJy+4r6BLbStGf2pE9L1tzLYDN1UNZumcD11M7r2JerM
         DtWKbcby6ZegyrsyZ7D3fOL1VfAAy6dobk9d+8mx7QGoHN+hi1WcYWP5ek+oNH1OpezQ
         VmXujsQkOygSJIfQuQDLiMTIqarJorhZ0L18ZjGxLcDH24pi91mZYZPdKcqEYIdsN+5x
         dzMw==
X-Gm-Message-State: APjAAAXDQ6QxPFq6tf7hQzFia74uvi4br/hBZMcPwODUeDtkePvGRnU0
        2ppRiiUcs0XkeKJU5WaQ2feU/w==
X-Google-Smtp-Source: APXvYqz03Oc3TW8sF7k3k7ydP3/3Hz99odDAm9g4tJMrQuAYQOPdZACa3NTVTLiwAg2Y0+KJDpcBug==
X-Received: by 2002:adf:f049:: with SMTP id t9mr25662404wro.17.1558360105562;
        Mon, 20 May 2019 06:48:25 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h12sm12091358wre.14.2019.05.20.06.48.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 06:48:24 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: meson: g12a: add drive-strength hdmi ddc pins
Date:   Mon, 20 May 2019 15:48:15 +0200
Message-Id: <20190520134817.25435-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520134817.25435-1-narmstrong@baylibre.com>
References: <20190520134817.25435-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the default boot settings, the DDC drive strength is too weak,
set the driver-strengh to 4mA to avoid errors on the DDC line.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 5b4942c73e65..aa678d92238b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -327,6 +327,7 @@
 								 "hdmitx_sck";
 							function = "hdmitx";
 							bias-disable;
+							drive-strength-microamp = <4000>;
 						};
 					};
 
-- 
2.21.0

