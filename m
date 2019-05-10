Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D86C04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1157B21479
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="th74W3D0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfEJQuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 12:50:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35719 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbfEJQtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 12:49:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id w12so8688845wrp.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 09:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JZfQcIBiz1i3SRmrwc/arntEPv+nCMO6l3LE883zetw=;
        b=th74W3D0yD8uI176CqzEb333lOWfbdmCBjoHDt+lqvRtWMu0u/G3SmHA041wAkDQdd
         mTNSJvCzxFr5oTxFjpjCnCm+TcUskdfBp9oRn0uzDRRdl8qrfRHXv1AVL6+ZgJ6bXIxw
         +ECZilXHGJ9JcQP4jTlgjC3o3eiEl2RBUZnUQaDvI5f2g7lb9kJI9GqLpNG/dmekomAn
         dIH6UXQIisXE1GVn8C0r1bfC8vZvAbRdDqUfpQJ2INF1S7ax3LlxL2sPu4wdcSVJGOdL
         taxuT0PWtDhfFyiu1pwcwiV8mLLkMHEpuOgn8YEcw5o7yxCSkucuIb9bHvUtp8FsXc1N
         g78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JZfQcIBiz1i3SRmrwc/arntEPv+nCMO6l3LE883zetw=;
        b=bKEd3OE5FeUSooCohRu75EoPIsi1/w8GBEevgfWWvp0q584iyRMGmw7kVH8fkmYYl0
         4Lfbky46r4TLDjtxkM3ffrrx33IGHKqIaVNbfQl6U4pgqddtQYk9xL99XZeTjvVvAJyh
         d/RdYNpucTrKvfkNZxr7TOdUmisGmGSrYu0u/ABTtU3I0lBehfWBNUBUlBXuH5qH+ghP
         1Cb4lIIZxQmMLA2iIQ5eeqolPe87Kez9OY2bOAvlhKiotXpoEyE3kuV+v6gnpKJEoK2F
         5ioFFdS6Gvrya8flOPG5i0QUfc1gqfnRNsrdMYgTFbdmA+cwE9naRVRfchgYOOJt2Aza
         tTqg==
X-Gm-Message-State: APjAAAXp6ydpE6hEYlh6acrvD3LlN/qp0oXN3sT2XkuzeioTpJiYdXpj
        p9sH7PtqBww2K4kKMXTgggJE+A==
X-Google-Smtp-Source: APXvYqyhBIUntAhXx/YaGyCbZND/bim7HJ1XT0IIdj+NqZiauxARKtqXAsvMcQvRqufVAAGZ8Nny6w==
X-Received: by 2002:adf:82b2:: with SMTP id 47mr9001609wrc.76.1557506989230;
        Fri, 10 May 2019 09:49:49 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id q26sm5114308wmq.25.2019.05.10.09.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 09:49:48 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 4/5] arm64: dts: meson: u200: add internal network
Date:   Fri, 10 May 2019 18:49:39 +0200
Message-Id: <20190510164940.13496-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510164940.13496-1-jbrunet@baylibre.com>
References: <20190510164940.13496-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The u200 is the main mother board for the S905D2. It can provide
both the internal and external network. However, by default the
resistance required for the external RGMII bus are not fitted, so
enable the internal PHY.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index 7cc3e2d6a4f1..c2221eb4549e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -15,6 +15,7 @@
 
 	aliases {
 		serial0 = &uart_AO;
+		ethernet0 = &ethmac;
 	};
 
 	chosen {
@@ -145,6 +146,12 @@
 	};
 };
 
+&ethmac {
+	status = "okay";
+	phy-handle = <&internal_ephy>;
+	phy-mode = "rmii";
+};
+
 &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
-- 
2.20.1

