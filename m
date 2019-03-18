Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE14C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3EC20879
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="J77rpt5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfCRKF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:05:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37233 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727766AbfCRKFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:05:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so3538534wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 03:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ifq+TfMjiWMh1JgJ9FAR08E6K1K0cnIdwZQaSTVzWwQ=;
        b=J77rpt5Lv0AXfOES62Ho3p209TyyRxV+gkafmU1NGW/UnQQqqeVB4z+rNhV6k3lMgW
         2WZnc3SRo3lg0CZJasdnGUYtK1xSMRZ92P0fhrCkmOJYKoJtkEPjwa+9Yq9fuVe22bkA
         nvkXKuPu9P/D5NQk23+9JdTp5ZjDg3ah3DLAwzd9kBX/Hp1kQdUaTAJqsCUoSE/KOwx5
         224ULKAZLZzJDxQPy/u6eSsvpikBma143Uo7wXrfhVQetZrA4m/4NkGK5hiEdQcgBmtA
         mjlXUiKfj9zz2Wm7rnRMPs/4uP7y1GhGBxemQ/bjD8ivlD0IwEValIucAVuAGfmGYI9S
         1Jug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ifq+TfMjiWMh1JgJ9FAR08E6K1K0cnIdwZQaSTVzWwQ=;
        b=P68fSoXmoMkYN5+CTFL3IZvgL6Y9TPDEv2bTK3W8bZ0QY1Rip3QK03++jO5Ivb3Acv
         L9LjTXksWkQAFazD3jkOEJ3RJXq6yKAXmJekx5aaR3wfuGBtBirlLdvNSYEfK3vZxh6W
         PiaCtuiK0n6VVMktzNr9suhfCE0PMvYUTvpiMd+RShCEdwSCBUZHq+IfoeTEIo9DfSeg
         p9e5SKigs+388OcrcUZ2BGjS+AEzQEifXSMJm5A+YzpkL6uk1RKudJoYvm2NqQDKqncD
         EvXCzeksUB9PqAemPl9uKHkQX1FuoQc4qer+9mfF+v4KNqFzZOrLxY8Fe3QD/ep0J55B
         oAlg==
X-Gm-Message-State: APjAAAXCzQzolmTdQhNiXhT2Mg2OHfY+6GSl/ZETkM/ZD7Mvws/2PdBx
        be8aHxqru8UrctFlK6NBt/9ssg==
X-Google-Smtp-Source: APXvYqwHI9b9sBqu1dHQaoafeF4RhB2DGqUaITfFZJxgctzs3P+R5vzssllsQ4aVSZLCwtOoy5V7Rw==
X-Received: by 2002:a1c:5f06:: with SMTP id t6mr6724566wmb.7.1552903510009;
        Mon, 18 Mar 2019 03:05:10 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i11sm5216800wrp.40.2019.03.18.03.05.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 03:05:09 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 10/11] arm64: dts: meson-g12a-u200: Enable USB
Date:   Mon, 18 Mar 2019 11:04:57 +0100
Message-Id: <20190318100458.5619-11-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318100458.5619-1-narmstrong@baylibre.com>
References: <20190318100458.5619-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the USB2 OTG and USB3 Host ports on the S905D2 Reference Design.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index c69328d16333..2240e365af27 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -108,3 +108,15 @@
 	pinctrl-names = "default";
 };
 
+&usb {
+	status = "okay";
+	vbus-supply = <&usb_pwr_en>;
+};
+
+&usb2_phy0 {
+	phy-supply = <&vcc_5v>;
+};
+
+&usb2_phy1 {
+	phy-supply = <&vcc_5v>;
+};
-- 
2.20.1

