Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA04C28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F6D206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="b1GKNOnN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfFDOrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:47:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38056 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbfFDOrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:47:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so16135705wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 07:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SnjvT/D0cW1JiliaxzQrnOjeQzlchEAI6VR+JZ5y+Qk=;
        b=b1GKNOnN95jk6p9sY+UTKLGXWVTPtbcumXKRhyS/7BVQ0GSsVUG3onM+bQfdjl6yoc
         ukbAzcipgmBZWkOSbAkttBYNgCq6tDvGfhzOFjJAodCqZKHhLdCtnFSdGB+EhpvJVWVv
         Ao5yFwm+UVLgGbs0siLkS87AK9ePzyhi+lbK6avLEqyfxa2tcWEtIsf8/g+PA8vxqy0a
         XzPgCwVb972Ddl9WFCD+0q8Qg0S6z4D/KffGpWfog+syujg7OJWZPxJemwHT44InwjGo
         +8Z8xPxWQpIyOay3xiAVFFEa5JWwSWFNWlvuDSWLPeUWykVajK4/5dpKHsoeVERZzb2i
         hWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SnjvT/D0cW1JiliaxzQrnOjeQzlchEAI6VR+JZ5y+Qk=;
        b=Tw2Hvlasin/01EDzhBkl2mh7LSxdm1G4rN0pFDFgKhgNFZ3NM0ujPj6vJQ9YbIRUGi
         wDFcbeHn5Dnuf8SCA1gKC1lNVPcUDjBFXaiPvb8fgcUNXX45bWXCZ7c0gke8r6W1EUvI
         iDjwDBhSz6hH72eWuuydm0F7kgaHChRqcT/0bTzcJ0If/nh2HTKyHMS4p5BbL4Q5xV0s
         duiHEEhueRGO1tTaXkyPQa+ap+qTQn7JmU40GXXuYg131+pwwWEEcNGj70zdKo1i18cT
         ZmcyAW5zUjQDyUjNLZEuzTspuwIHRVNYA4y/TpetT9QBJ44ybHcDpHDR2rvy5hlbEaZB
         4vYQ==
X-Gm-Message-State: APjAAAUJuIoGiNaEf6tqSsYGXm46Eh4X5/LIy9SiSb/ms00PlgsVfGuj
        HpYTPHyU6b0iBawXchqc4quKOQ==
X-Google-Smtp-Source: APXvYqyRQhjdyMK6YK07C+dlJF+QvuSSvZcEwhbdHS+SKqZ1uaK2nDj1a6UiJjyrdfuKgXxc/NmwfQ==
X-Received: by 2002:adf:e54b:: with SMTP id z11mr6859295wrm.198.1559659637766;
        Tue, 04 Jun 2019 07:47:17 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v184sm3649639wme.10.2019.06.04.07.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 07:47:17 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     jic23@kernel.org, khilman@baylibre.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Documentation: dt-bindings: add the Amlogic Meson Temperature Sensor
Date:   Tue,  4 Jun 2019 16:47:12 +0200
Message-Id: <20190604144714.2009-2-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604144714.2009-1-glaroque@baylibre.com>
References: <20190604144714.2009-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the devicetree binding documentation for the Temperature
Sensor found in the Amlogic Meson G12 SoCs.
Currently only the G12A SoCs are supported.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 .../iio/temperature/amlogic,meson-tsensor.txt | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/amlogic,meson-tsensor.txt

diff --git a/Documentation/devicetree/bindings/iio/temperature/amlogic,meson-tsensor.txt b/Documentation/devicetree/bindings/iio/temperature/amlogic,meson-tsensor.txt
new file mode 100644
index 000000000000..d064db0e9cac
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/amlogic,meson-tsensor.txt
@@ -0,0 +1,31 @@
+* Amlogic Meson Temperature Sensor
+
+Required properties:
+- compatible:	depending on the SoC and the position of the sensor,
+		this should be one of:
+		- "amlogic,meson-g12a-cpu-tsensor" for the CPU G12A SoC sensor
+		- "amlogic,meson-g12a-ddr-tsensor" for the DDR G12A SoC sensor
+		followed by the common :
+		- "amlogic,meson-g12a-tsensor" for G12A SoC family
+- reg:		the physical base address and length of the registers
+- interrupts:	the interrupt indicating end of sampling
+- clocks:	phandle identifier for the reference clock of temperature sensor
+- #io-channel-cells: must be 1, see ../iio-bindings.txt
+- amlogic,ao-secure: phandle to the ao-secure syscon
+
+Optional properties:
+- amlogic,critical-temperature: temperature value in milli degrees Celsius
+	to set automatic reboot on too high temperature
+
+Example:
+	cpu_temp: temperature-sensor@ff634800 {
+		compatible = "amlogic,meson-g12a-cpu-tsensor",
+			     "amlogic,meson-g12a-tsensor";
+		reg = <0x0 0xff634800 0x0 0x50>;
+		interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
+		clocks = <&clkc CLKID_TS>;
+		status = "okay";
+		#io-channel-cells = <1>;
+		amlogic,meson-ao-secure = <&sec_AO>;
+		amlogic,critical-temperature = <115000>;
+	};
-- 
2.17.1

