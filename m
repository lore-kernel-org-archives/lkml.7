Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8927C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3312085A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfEATa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 15:30:29 -0400
Received: from secvs02.rockwellcollins.com ([205.175.225.241]:39311 "EHLO
        secvs02.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726088AbfEATa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 15:30:28 -0400
X-RC-All-From: , 205.175.225.60, No hostname, adam.michaelis@rockwellcollins.com,
 Adam Michaelis <adam.michaelis@rockwellcollins.com>, , 
X-RC-Attachments: , ,
X-RC-RemoteIP: 205.175.225.60
X-RC-RemoteHost: No hostname
X-RC-IP-Hostname: secip02.rockwellcollins.com
X-RC-IP-MID: 253408329
X-RC-IP-Group: GOOGLE_RELAYED
X-RC-IP-Policy: $GOOGLE_RELAYED
X-RC-IP-SBRS: None
Received: from unknown (HELO mail-oi1-f198.google.com) ([205.175.225.60])
  by secvs02.rockwellcollins.com with ESMTP/TLS/AES128-GCM-SHA256; 01 May 2019 14:30:27 -0500
Received: by mail-oi1-f198.google.com with SMTP id d198so76734oih.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 12:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=F4PFKivrCCt8E/bjYsH5ykIrQ9bNtH2T/uQxJDWTUxk=;
        b=n8by9zTq63WO0iAAKkbMf5d4fYOHFw2Xc2hWDs//4OFr7fqQRb907sHx0kJ1xLbTbk
         5jySp1z+jlWuML9vwsukDcZwCKmmm38gGv/0R8A1YJmp3iTObYy14AOiX9tulfaScdjL
         GniSrj18M2y2kemHCWJYoM/CCHVcfb/jK9O4qesPwVNw+zLy4alAnH21koaMgvfPJSsL
         Yn0pPxmE7N/BePObbMUtm8G2tG+TYWLY5H6Ka5BYNLrJwaqJYChNETMBEAm2J/lz693V
         swe3P9gQ4uq9XJzaNC63T5Kx1PjlJSva4VEiOyjNfobGAaiqq6QOX4vlb4MlyoHB0wVM
         zb0Q==
X-Gm-Message-State: APjAAAXZtN1kxwXF/pb4Rma5rRYn++87jjOzlGMlaXMUDz9GTQvcS17v
        X71nAErUVown78pMghtuB5kmems+lOljufqPnKdF1qzSSDsKJ5/rRsdVqk4/ouelxi4YGRabvZS
        Lf6ePoAY44cir11KeA1bULorozMvbjRMpxzwdYa8PbOqEifRgdDfXArRaeaE=
X-Received: by 2002:aca:c246:: with SMTP id s67mr7812474oif.159.1556739027176;
        Wed, 01 May 2019 12:30:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzwl9jaLwlQF3bo/hxPu7ykO2nZUNUL3iGGE/m6q02Ansh3+g/noBeDiTGYKszlPtmb9P02rIBb3GTVamr8Acs=
X-Received: by 2002:aca:c246:: with SMTP id s67mr7812457oif.159.1556739026959;
 Wed, 01 May 2019 12:30:26 -0700 (PDT)
MIME-Version: 1.0
From:   Adam Michaelis <adam.michaelis@rockwellcollins.com>
Date:   Wed, 1 May 2019 14:30:16 -0500
Message-ID: <CALMrGWUsr4+E3bYSj8hGvxDhZRZ1xiwVtd-x4RnOf3En6xMq5Q@mail.gmail.com>
Subject: [PATCH 2/6] dt-bindings: iio: ad7949: Add adi,reference-select
To:     lars@metafoo.de, michael.hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, charles-antoine.couret@essensium.com,
        devicetree@vger.kernel.org
Cc:     Clayton Shotwell <clayton.shotwell@rockwellcollins.com>,
        Brandon Maier <brandon.maier@rockwellcollins.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From d228a1a119e33aff91f481fb8ab301a027b5a4ac Mon Sep 17 00:00:00 2001
From: Adam Michaelis <adam.michaelis@rockwellcollins.com>
Date: Thu, 25 Apr 2019 15:22:00 -0500
Subject: [PATCH 2/6] dt-bindings: iio: ad7949: Add adi,reference-select

Adding optional parameter to AD7949 to specify the source for the
reference voltage signal. Default value is maintaned with option '6' to
match previous version of driver.

Signed-off-by: Adam Michaelis <adam.michaelis@rockwellcollins.com>
---
Sorry about the re-sends - GMail inserted HTML on me and it bounced from vger.
---
 .../devicetree/bindings/iio/adc/ad7949.txt         | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ad7949.txt
b/Documentation/devicetree/bindings/iio/adc/ad7949.txt
index c7f5057356b1..14ee9a2cb2a5 100644
--- a/Documentation/devicetree/bindings/iio/adc/ad7949.txt
+++ b/Documentation/devicetree/bindings/iio/adc/ad7949.txt
@@ -6,11 +6,29 @@ Required properties:
  * "adi,ad7682"
  * "adi,ad7689"
  - reg: spi chip select number for the device
- - vref-supply: The regulator supply for ADC reference voltage

-Example:
+Optional properties:
+ - adi,reference-select: Select the reference voltage source to use
+ when converting the input voltages. Valid values are:
+   0: Internal 2.5V reference; temperature sensor enabled
+   1: Internal 4.096V reference; temperature sensor enabled
+   2: External reference, temperature sensor enabled, no buffer
+   3: External reference, temperature sensor enabled, buffer enabled
+   6: External reference, temperature sensor disabled, no buffer
+   7: External reference, temperature sensor disabled, buffer enabled
+ - vref-supply: The regulator supply for ADC reference voltage. Required
+ if external reference selected by 'adi,reference-select'.
+
+Examples:
 adc@0 {
  compatible = "adi,ad7949";
  reg = <0>;
+ adi,reference-select = <2>;
  vref-supply = <&vdd_supply>;
 };
+
+adc@0 {
+ compatible = "adi,ad7949";
+ reg = <0>;
+ adi,reference-select = <0>;
+};
-- 
1.9.1
