Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E30C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC30D21530
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pE2Y50PA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfENKMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 06:12:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38415 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfENKMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 06:12:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id v11so686141wru.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 03:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xHJjEWZUv594HiG0VPz+WE+kbrZmHtfWvyl507EtN/8=;
        b=pE2Y50PAtDBbgvFGY3ovxKSYmZFOJKanRz1EL0QfjDbSnyY+qvPZhh7EoL3tvSpn73
         OhsLUb81ZFGcQtP56rCfPzZN52Qd9XCzXu74H5bDajY1a3pF5tJ8dD/KhFUc//XNmmtD
         Ul0X9voCizw2WGxMY8KT1wxry+rUilqsPiCBw0QdZ21CuMUEp63nnxiWSg3rRthIAZ2d
         kfThcY702TlgXKUi/aVT3zttU7CJ8UX5zc39ZR9F9l9fFY2xcQOQyHGiWXPdHNRpm9oN
         mwwFf8yL3paw8P4fWTvCe6AE8Fjf55C93Tr3obxKPPCYKrhZZBslfaeJZXJEbzR3Oni5
         4DZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xHJjEWZUv594HiG0VPz+WE+kbrZmHtfWvyl507EtN/8=;
        b=FVMWLgf8FV95OfDDF8o9/pUwsTPGys0ulAxziHSeFvuAMoc2+1/gMhm0ZL2oZO8R/V
         QjLmYdt3HYdw2hmSsC53XKJYnoswDpzzMo4lRuQZ+C1ZHGGXmnGhLyiKcH0eoKtkYDd1
         u64bWOGbHIoI3HWcJNA9GjxLca2wV68UrmWoP3HXjsIMFYJ6mcaHyl4erPvBpWQgscGG
         Y3qdS+EuHEPwkCavCAAw05TtJvPHl6QZNC+FE6QnFWZOfdWqeaQivKaE7Wano0LnMR2z
         YBfCIIWkVbNd34P1WnF9TPyWfG6xQCqFJYRYa5FDFezaBYz0nj+i2Zjsq4BX6FKt+G0f
         9rVg==
X-Gm-Message-State: APjAAAXpJVUYaYHxYmrj72odvcW3VYIeCg8KWqS+SpAHyAhYsj77+tdH
        qoVAW4bGyQ44ch4E/nH13QpB0Q==
X-Google-Smtp-Source: APXvYqyka7ntLm7R8ulXOcP73IjIezS5j2BDb79tfKgdL/YtywbuRB01jGqmaYoKzAaqyncN/snjcA==
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr5350107wru.91.1557828770693;
        Tue, 14 May 2019 03:12:50 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id r23sm2219564wmh.29.2019.05.14.03.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 03:12:50 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: meson: sei510: enable i2c3
Date:   Tue, 14 May 2019 12:12:37 +0200
Message-Id: <20190514101237.13969-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190514101237.13969-1-jbrunet@baylibre.com>
References: <20190514101237.13969-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the i2c bus used for RGB led controller.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index bb45e3577ff5..f420935b76db 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -161,6 +161,12 @@
 	};
 };
 
+&i2c3 {
+	status = "okay";
+	pinctrl-0 = <&i2c3_sda_a_pins>, <&i2c3_sck_a_pins>;
+	pinctrl-names = "default";
+};
+
 &saradc {
 	status = "okay";
 	vref-supply = <&vddio_ao1v8>;
-- 
2.20.1

