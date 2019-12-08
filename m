Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601E3C2D0C0
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 22:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3449920637
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 22:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVuzRl2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfLHWux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 17:50:53 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38019 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfLHWux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 17:50:53 -0500
Received: by mail-pf1-f195.google.com with SMTP id x185so6202373pfc.5;
        Sun, 08 Dec 2019 14:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Espf4zoBRH7IOzinqnlozBDMUE2zo9Pg8QdQ1lUhz9I=;
        b=bVuzRl2TeOx5OW8olsTt2AgrIIWlvDAFdy/WjgiwAKBIEUHDgytc9wHn/5cH23kaMa
         /qwf5iSOrTOC4035jNiG3oYCeGEsZ3Deg1AQD3UHnskwFCyi0FQg+yIy+xiZawwzIrCn
         psvppuQubPrwnJIYIQ2m8dcQvn7xPx8KhS5nKMe/F7Qa9exIav4qnWeGC8mx8G/XurYz
         B4JQU1eyRr6QJU1hHmoy7VTnrJIzTxollDybZbpXBrNFHj1qrRqkcVZ4MUO2LVrzuf2h
         n+7srJb4mB+JVOmX4wffxIwTO28o1dlsxdY0awV4RgU+tjX5EbEoLt2lI9lya1kaR05r
         8Xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Espf4zoBRH7IOzinqnlozBDMUE2zo9Pg8QdQ1lUhz9I=;
        b=fJmYb7a5G8n6D+WBhOo/lWD3zQC1Qfw3laOeYcdGjJn+dcznR2c8Wankov+mAxPe9M
         pZtz+uBKz6AP08V8Z4QuOm5gSPaGQXcS+0WmvZdP4K607mbTWtumQa3QqvUHQiDlJozG
         Iro3FkB32ordoZvRsQdAlkqrylzDkqN6uT29ULtjPD0+cTIVOntCy/TkihOHYbz9nAWc
         WAYekdsl7aFiVDrPWZ2GAyWbkqVOZzA4+KnKgmY/VyqwuH/Yp/VeP7lGcx7uu9nduVl3
         Q0NdzwRn/C9q2S67/4AcknBKXdH3Nr2/xzu6K5GfADqWTbV2t9GZ+YZyypcuK0YVJ43W
         9eyg==
X-Gm-Message-State: APjAAAV8UvryNjZPlME98kSjmRX90MCIFzNUovEqeOukVl3kUljCI6KK
        c2GDnp8DUoCnqM/mZM3BZkTlELgc
X-Google-Smtp-Source: APXvYqyC85GYdm0JfnPaiWUF06eeA2g5nNeRvbfXiXLHcRXOZtQUCF+z3kF8SltN/N/2F4UMR0Cpbw==
X-Received: by 2002:aa7:8e05:: with SMTP id c5mr3247782pfr.4.1575845452803;
        Sun, 08 Dec 2019 14:50:52 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w11sm22322612pgs.60.2019.12.08.14.50.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Dec 2019 14:50:52 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] dt-bindings: Add MAX31730 as trivial device
Date:   Sun,  8 Dec 2019 14:50:49 -0800
Message-Id: <20191208225049.21783-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxim MAX31730 is a 3-Channel Remote Temperature Sensor.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 765fd1c170df..2ec9bccde79e 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -132,6 +132,8 @@ properties:
           - maxim,max6621
             # 9-Bit/12-Bit Temperature Sensors with I²C-Compatible Serial Interface
           - maxim,max6625
+            # 3-Channel Remote Temperature Sensor
+          - maxim,max31730
             # mCube 3-axis 8-bit digital accelerometer
           - mcube,mc3230
             # MEMSIC 2-axis 8-bit digital accelerometer
-- 
2.17.1

