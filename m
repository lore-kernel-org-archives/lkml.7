Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7302C0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 20:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747B32173C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 20:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ly+71Zaz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfHKUcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 16:32:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39074 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfHKUb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 16:31:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id t16so12773557wra.6;
        Sun, 11 Aug 2019 13:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OlAy4iNnvpXUfWGzbLAVAxpfZU/8XBVjL/0mbqQ077c=;
        b=ly+71Zaz/X9NyRaWrirRlpyMXzsGMNtcBIlaS9oIk8T1YKCC7/Tj4Vxo5nLS01EAbI
         30RLA6qzAZBLap2dED1SGNozXwZB0Pi7ELLnUdI5XLMGT11HRajfX+JJJm/ThUzrjB0Z
         h45iX8Go0ht636Kdz7pdzBLLmlBszFWSTwNc3vNvH5jFI4BA6vA8Rg0eWitkSOvysns6
         Tx4d1PgloYMj1ibLpY9n25gLp4VbUQj6RlqeQebIISg0ByU3jYymz+YPcHhkCbm75nR7
         21411fOa1cFTr6VQfX6FvQVEqHrypgXYU+P0k8D1bsuTmQqsmwZhEo6HqaoTLFiakUJI
         KYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OlAy4iNnvpXUfWGzbLAVAxpfZU/8XBVjL/0mbqQ077c=;
        b=st2S7iEV9ZSwYzQIym9ngXD0G1hgYFzbjvYLZEEFZr0I2ZQfSV/b7U9ItFBx5Q88Nv
         h/Pv2AFhnF9esoDv6X0hD1+Phkcc9xp+SNA9JOtZ6YrdLGqwg5EUm+L1989pgbzAVItX
         0t3U6+fXKpJbb63xiQkY5TRzjlDn2JI/2ZpWHZnhQJ+aKw/wqiLC1mafmUbdNMrPqJBB
         3NzziHemzJIhSd/Yq+RWnaxROVGsraDU+Br0F/BImuE/O/oMwOtCWYhGKCqzFLy0kWIY
         W6Q+4oTQuIH02f79UO6hLHTjfX5At/vJdQWhBKTHsemtdPfBDNgHahbKLGTmQNzwLXD9
         WZ8A==
X-Gm-Message-State: APjAAAU3F9/knnjvCzZhlNHs4agiitD9bwZ6ceMAkw+j1TtujiC8jHAB
        t/knLqhnOF8+EWoc27bZejo=
X-Google-Smtp-Source: APXvYqyujAHdwhl3y5Jb21DrU1zw3uVqtrkNnTjI4QUdlilQy7BcEMoR2pY5eXQt6p5wlKH2pHoGQw==
X-Received: by 2002:adf:cd11:: with SMTP id w17mr9316867wrm.297.1565555516367;
        Sun, 11 Aug 2019 13:31:56 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id a8sm11063269wma.31.2019.08.11.13.31.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 13:31:55 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 2/3] arm64: dts: allwinner: h6: Enable SPDIF for Beelink GS1
Date:   Sun, 11 Aug 2019 22:31:43 +0200
Message-Id: <20190811203144.5999-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190811203144.5999-1-peron.clem@gmail.com>
References: <20190811203144.5999-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Beelink GS1 board has a SPDIF out connector, so enable it in
the device-tree.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 0dc33c90dd60..76a95ad33dc5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -243,6 +243,10 @@
 	vcc-pm-supply = <&reg_aldo1>;
 };
 
+&spdif {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ph_pins>;
-- 
2.20.1

