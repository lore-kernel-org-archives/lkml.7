Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DB2C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB3F20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="DIgMWPJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfCGKea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:34:30 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38085 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfCGKeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:34:23 -0500
Received: by mail-ed1-f66.google.com with SMTP id h58so12998471edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 02:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YWml5F5NmWFC29RC/IB7M978QiPtAs5XY75gb4XVM4U=;
        b=DIgMWPJVZiSmRqN2EdHU3MyvvPaKmRiilO+uAnrGaW3eu7g8MkwdJpZp15adDXc6G0
         HaXHnty4KFUPOukRrbv7qsMpR2ZjFOURIdLeXY2sWJRp/D+5ehkmG+Ia8aIefkEhphjf
         5ieUS9+/s9Q2EI9utK9v4m7xBQerqScZaW+ZOZ5fhRTIF1XiQrk5RRbLaMdate8s0S4Q
         dY0NRuCbkE2RLApjYPG867YHNi46PtO7ft38/MJA6rEw44er89/vrKDgvuHfhpmSVL9g
         MvyYdJ65yqKBw/MmmM66sy1LuwTjtBn2y/SjZuuG7l1OMsoz5y5C0sCZ7hGzN/9oeiC1
         Femg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YWml5F5NmWFC29RC/IB7M978QiPtAs5XY75gb4XVM4U=;
        b=MBNzI8gvqNjO5HN7pw01mB3d1pLe9aUzlQaht2uQddiuOVIk7wNYcQvYmrD+wXe0kj
         VfXIifjyZvmJuiYt4IAQ7nfiIqlav5sJd+rPmAfTUxBxkCmHpFf8p7Trc010TduL/JGf
         cwVc6pzecLLLIQKZ5nJ8Ybcp7ch/9k1NG67j7GoKv4or4/sgz+eizVs/WG5vO1eveH5y
         gYaWYX1XDMYN/+0+shnLclh08aQi4zd1oCdTmovneV2Et5EokfoJOSng5wYDRMUwUp28
         +XprSnK8f5jH6fjLtK1rl6fRHBHyx0W2aJJ966TBlc0c6luFFCNvxVGfS4N2Ua4wyfrA
         0jVw==
X-Gm-Message-State: APjAAAUYxoLuNyB1wLSpY4G3D5OE7rqYUv0Wk7PqmrzML3HrbxsQT5EO
        mA44DiJFXd7/EFj9D8wtpobF6w==
X-Google-Smtp-Source: APXvYqw3gHPuAqYeGqVtPdAY4+wzHx2jVlyDXOW73SkShl/67tHKg6aW3Q2/hV2TREBKjOrhkD59Cg==
X-Received: by 2002:a50:b87a:: with SMTP id k55mr28334830ede.92.1551954861465;
        Thu, 07 Mar 2019 02:34:21 -0800 (PST)
Received: from ph-ThinkPad-E560.local.ess-mail.com (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id h8sm1250998edb.36.2019.03.07.02.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 02:34:20 -0800 (PST)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH v6 3/4] iio:temperature:max31856:Add device tree bind info
Date:   Thu,  7 Mar 2019 11:34:08 +0100
Message-Id: <20190307103409.24174-3-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190307103409.24174-1-patrick.havelange@essensium.com>
References: <20190307103409.24174-1-patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>

This patch added device tree binding info for MAX31856 driver.

Signed-off-by: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
Signed-off-by: Matt Weber <matthew.weber@rockwellcollins.com>
Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
---
Changes
v1 -> v2
[Matt
 - Removed comment block and added possibilities of
   thermocouple type in device tree binding doc.

v2 -> v3
 - Rebased

v3 -> v4
 - Removed one-shot property related information.
 - Used standard name 'temp-sensor'

v4 -> v5
[Patrick
 - Rename thermocouple type to maxim,thermocouple-type for DT entry

v5 -> v6
[Patrick
 - use generic thermocouple-type for DT entry
---
 .../bindings/iio/temperature/max31856.txt     | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/max31856.txt

diff --git a/Documentation/devicetree/bindings/iio/temperature/max31856.txt b/Documentation/devicetree/bindings/iio/temperature/max31856.txt
new file mode 100644
index 000000000000..06ab43bb4de8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/max31856.txt
@@ -0,0 +1,24 @@
+Maxim MAX31856 thermocouple support
+
+https://datasheets.maximintegrated.com/en/ds/MAX31856.pdf
+
+Optional property:
+	- thermocouple-type: Type of thermocouple (THERMOCOUPLE_TYPE_K if
+		omitted). Supported types are B, E, J, K, N, R, S, T.
+
+Required properties:
+	- compatible: must be "maxim,max31856"
+	- reg: SPI chip select number for the device
+	- spi-max-frequency: As per datasheet max. supported freq is 5000000
+	- spi-cpha: must be defined for max31856 to enable SPI mode 1
+
+	Refer to spi/spi-bus.txt for generic SPI slave bindings.
+
+ Example:
+	temp-sensor@0 {
+		compatible = "maxim,max31856";
+		reg = <0>;
+		spi-max-frequency = <5000000>;
+		spi-cpha;
+		thermocouple-type = <THERMOCOUPLE_TYPE_K>;
+	};
-- 
2.19.1

