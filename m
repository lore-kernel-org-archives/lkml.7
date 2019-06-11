Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C893C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607A02063F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405148AbfFKJ5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 05:57:35 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:60623 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405130AbfFKJ5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 05:57:32 -0400
X-Originating-IP: 90.88.159.246
Received: from dell-desktop.home (aaubervilliers-681-1-40-246.w90-88.abo.wanadoo.fr [90.88.159.246])
        (Authenticated sender: mylene.josserand@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 32F5240019;
        Tue, 11 Jun 2019 09:57:29 +0000 (UTC)
From:   =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To:     peda@axentia.se, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, thomas.petazzoni@bootlin.com,
        mylene.josserand@bootlin.com
Subject: [PATCH v1 3/3] dt-bindings: iio: afe: Add hwmon example
Date:   Tue, 11 Jun 2019 11:56:59 +0200
Message-Id: <20190611095659.29845-4-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190611095659.29845-1-mylene.josserand@bootlin.com>
References: <20190611095659.29845-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the support of CHAN_INFO_PROCESSED in voltage-divider,
it is possible to read the processed values directly from iio's
sysfs entries or by using iio-hwmon. Add an example for this last
use case.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 .../bindings/iio/afe/voltage-divider.txt           | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/afe/voltage-divider.txt b/Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
index b452a8406107..f7e1c7cb2744 100644
--- a/Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
+++ b/Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
@@ -51,3 +51,27 @@ sysv {
 		spi-max-frequency = <1000000>;
 	};
 };
+
+It is also possible to retrieve the processed values using hwmon node:
+
+div0: div0 {
+	compatible = "voltage-divider";
+	io-channels = <&adc0 0>; /* Channel 0 of the ADC */
+	output-ohms = <47>; /* R2 */
+	full-ohms = <73>; /* R1 (26) + R2 (47) */
+	#io-channel-cells = <1>;
+};
+
+div1: div1 {
+	compatible = "voltage-divider";
+	io-channels = <&adc0 1>; /* Channel 1 of the ADC */
+	output-ohms = <47>; /* R2 */
+	full-ohms = <115>; /* R1 (68) + R2 (47) */
+	#io-channel-cells = <1>;
+};
+
+iio-hwmon {
+	compatible = "iio-hwmon";
+	io-channels = <&div0 0>, <&div1 0>;
+	io-channel-names = "3v3", "usb";
+};
-- 
2.11.0

