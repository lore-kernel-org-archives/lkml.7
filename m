Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791F8C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 19:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448D62085A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 19:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LatV4qLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfEYTCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 15:02:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39692 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfEYTCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 15:02:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id e2so4246892wrv.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 12:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k5Z2vQv4+mxGzq5NHJL9r7H2SeVLz0dEkeMxRxdzaQM=;
        b=LatV4qLlhA99QGCSC93FdD3vXhWw1oZ4jMNYbv9CKXMa2MEB4+SNZw2Xt4yL9WmQmJ
         fzUAqfCI9q1T1AIel5zAR4EkK5N9r7M7yhsbIe8aQgCmpi3HF5cXdEahz44Le58++7vM
         j79awfduRMUSB42icd6Zx2p338TtnPdE8Rst+fygwzXKcET9izH8MNHoLsWfxUiior9N
         2VtroBaHIFHu+iZ+GrCnsyo5JZSzhO95CM3YDRd69Yi1x41gkeIc834JJdXm4XgP28or
         PDLum5OcJ79A6LN0AEnncI7cnhE/7EbN0YMMtQk4xQnX++9srhxAQ6iq+ZVGeubQ+oWa
         uSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k5Z2vQv4+mxGzq5NHJL9r7H2SeVLz0dEkeMxRxdzaQM=;
        b=Hc+FBOEVWGniYTe9OpKr6hpxNpNSYugM+m8HzmXN0BU41Y2PcVMU3uWhMlHC2MWRW+
         bHlaq61WNuQeJJ4kU4uUSjSsaqDxmUUb2Ux63OVAzmmQx77B9uOfafRJIiI9Vp3z1Gss
         xNFhbMjv3p1MWmpnevO/U5lY/GUr+ICAlygzSxHs4/NlHlagd28tJFvX4Ydp2ZiV5omK
         zFPNOpG/7sohNHpbC4Lgu+Jq4YFS0iI1zgBH9eIbWXZTAVSDHH8Eqd7AVZ/0CYQ8Pw0n
         ubnhmcFNaeuPhqdEmgsoBRyZchgEsz9+hfF5DH6HGN9ynzZQF7CxGggaikcUq8NUJPt0
         v1cQ==
X-Gm-Message-State: APjAAAVk9/2iCN2iirXMyYNwCisDtpRIshWFuLHIjVIeFUMeIegn9waD
        DrVUfAdze+4IVkVCSviq0v4=
X-Google-Smtp-Source: APXvYqwV7IWvw17HEtCRwyYsrkLC7Sb0QOduLY0RyH85vGGlo3rUBqkxmVfQ/w0LMwquK+19YhgJtA==
X-Received: by 2002:a5d:6189:: with SMTP id j9mr3642872wru.151.1558810930972;
        Sat, 25 May 2019 12:02:10 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA4007CB8841254CD64FD.dip0.t-ipconnect.de. [2003:f1:33dd:a400:7cb8:8412:54cd:64fd])
        by smtp.googlemail.com with ESMTPSA id f2sm6870426wme.12.2019.05.25.12.02.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 12:02:10 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/4] ARM: dts: meson8b: add the PWM_D output pin
Date:   Sat, 25 May 2019 21:02:01 +0200
Message-Id: <20190525190204.7897-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190525190204.7897-1-martin.blumenstingl@googlemail.com>
References: <20190525190204.7897-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PWM_D output is used for the VDDEE PWM regulator which supplies for
example the Mali GPU on the EC-100 and Odroid-C1 boards. Add the output
pin the VDDEE regulators can be added.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index e4134c63a48c..1b0106fbb0ac 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -401,6 +401,14 @@
 			};
 		};
 
+		pwm_d_pins: pwm-d {
+			mux {
+				groups = "pwm_d";
+				function = "pwm_d";
+				bias-disable;
+			};
+		};
+
 		uart_b0_pins: uart-b0 {
 			mux {
 				groups = "uart_tx_b0",
-- 
2.21.0

