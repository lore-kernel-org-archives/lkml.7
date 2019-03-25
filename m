Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D81C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E1320879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nfoV1sBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbfCYKPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:15:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52843 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730804AbfCYKPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:15:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id a184so8214001wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 03:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qGmnnBPdv0kX3d1SiwFphEnQB3L12sT0h0laTVodru8=;
        b=nfoV1sBH0DBevTe5jXjzrSNl6evf2KHgFrcK/dqRPCJpWJeM/dPvzX/O8vM7NbAhMI
         spSQ7mS3fq19hkNYKzxb/zlStiWOBQ3c19WgO3e8Lr5VXuc/jOtrh8xhIbzIen+kzAE5
         hXJamnznpz4diFAOJ1ARhjGvC1w1kit0uu5A9AYtIasOqlD45jzMk5y99l0XNuW3at7D
         NHGBH1LTrxoiIOE4NVNyHsku4WPuFtBaLSJxaNwhuMIdFeI7/cybkIDcBA/V+fdV9hab
         M4/pVTAxhZqYME5AOKjEfpcK2zYTUdeRf3csP5zZ+5F+vZ4LMlq/KPVExp8y0HAdyn31
         nn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qGmnnBPdv0kX3d1SiwFphEnQB3L12sT0h0laTVodru8=;
        b=tddep01qELoo75NeMLtzA2+bCyutTr4aCcYXSW7DN3fNn3UJUwBQAzq122jnN7Iue6
         fx46Yj/rNQ5efxO8Ws43P7mhYNbk7u59njKTix+lKQIzy32rOzbfB9xLkTYl6sL3P59H
         6GQFf6qyv7/GGbauTBijS/orZZiqn9MTELX/IaBucNwJCQLiJynCyuXBtp5rveM8gZOZ
         TLfwb5moc7SLMRWy9+fOT4vIT0W0BbiFFNHwf4/yKBtlcIm67x1aYwlSia8FC+o4YslG
         Ot7iOtW2Hq1Vard/yM9WjVHxtgaJeGieiUOSufVBSlwQtiAoQHtSEVTZcjeNjfcCwmdl
         WlFQ==
X-Gm-Message-State: APjAAAVFB2PYcIh0VjNI6xGLpS9fsag0zNEImXfEwJPyRjIOdeIxenL+
        HDVxmGMQNhQ013uCg+KYQn0bIQ==
X-Google-Smtp-Source: APXvYqwKgrj6KqlCj4sDwrNiNJaZXi3Tj2kOESIcHceArA1jrd/Ab1CXqmvsUNn4sic91ardTt5YiA==
X-Received: by 2002:a7b:cd03:: with SMTP id f3mr2473755wmj.130.1553508900223;
        Mon, 25 Mar 2019 03:15:00 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v14sm20049484wrr.20.2019.03.25.03.14.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 03:14:59 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 4/6] arm64: dts: meson-g12a-sei510: Enable USB
Date:   Mon, 25 Mar 2019 11:14:51 +0100
Message-Id: <20190325101453.3009-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325101453.3009-1-narmstrong@baylibre.com>
References: <20190325101453.3009-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the USB2 and USB3 Host ports on the SEI520 Set-Top-Box.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index ebdad5a192f1..c350a0165d44 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -125,3 +125,8 @@
 	pinctrl-0 = <&uart_ao_a_pins>;
 	pinctrl-names = "default";
 };
+
+&usb {
+	status = "okay";
+	dr_mode = "host";
+};
-- 
2.21.0

