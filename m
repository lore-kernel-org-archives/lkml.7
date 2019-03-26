Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B22FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065DE204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="ceziVE5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbfCZLTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:19:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43803 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfCZLS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:18:58 -0400
Received: by mail-ed1-f68.google.com with SMTP id d26so10364157ede.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 04:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OTeF7P8CMXOQSyh4b05fzYdChTzLr7I8xwnDJpAXFEw=;
        b=ceziVE5Lqjn+EzSYxVUfdbAXgDuQyl09MLo2d6dcJUGOlWQf+M7qjLCDQGRvrZ8ecj
         fRCeBQtuGSIa7BRfAqAfh8neVpceL9RfVdZC+wy1KfTAKKA22IMCtMcngMFGRR2Oa9E9
         4tfojn71wm8FIGpomfVKgPPYv67h7gtHpZ2OsPasv2DIg+TgBWjuWk//ndYanmKw4OOI
         cm77rc22jzuskrga2j/DEXF6FVw6RlRwm5e+hjALlwt0hxudtG3JGm/Nd7SRLG08ZRPv
         +YbAv6YfUeH3CCz7ZL6N7KCbi4VB7n636duiB6ror0sG1TIm+qeis+AwYyhfgicHQEuX
         YNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OTeF7P8CMXOQSyh4b05fzYdChTzLr7I8xwnDJpAXFEw=;
        b=gwIawZXP/ETBvHLf/BH8IDyajxqeyhWZPrEeDieHJZ58YjYtllFd4cHlWUeEoyWbb0
         TKcnTMLXIzFmDzBZB3tuKMiR3uY61NC1YH5wZBXTaBkwlwQb04JM3HJpDfFiFqI3FoXW
         biQRCYGtwb/dJxMdjJaVREo6OtV3FhkAj3Sd98x9CbrWwq6TrAY0fMPAYD2Rj3CFkHRY
         MKFEUQjC3mIWJAFCpSpo42lFiopMPC2KBS/ob3PR294XatHRDs76WlNc7/mRJ6Qc8OGb
         BrpcATzExTiVWIIhWnqqBMf0YREBciGXT8sISkfKhErys5hu+QozamOIXhe3WGdmWPRO
         dLFg==
X-Gm-Message-State: APjAAAWnXadm3GNqFdxWYxL4RWrR9+zaVXshtkFYLNuqdY+Qj1PTEcWP
        UFhhUNM52FKQiyWv8/hKGpssw9lCgv0=
X-Google-Smtp-Source: APXvYqyPI9yf/G8o+B/i8lkXsHpu2xIXaBze0QkRfdU2PriQBPfrJr1MvqSHq1fuZxhBPV3/Oa70ug==
X-Received: by 2002:a50:aa4e:: with SMTP id p14mr14193692edc.59.1553599137227;
        Tue, 26 Mar 2019 04:18:57 -0700 (PDT)
Received: from ph-ThinkPad-E560.local.ess-mail.com (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id i3sm3842464ejj.46.2019.03.26.04.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 04:18:56 -0700 (PDT)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH v7 2/3] iio:temperature:max31856:Add device tree bind info
Date:   Tue, 26 Mar 2019 12:18:41 +0100
Message-Id: <20190326111842.12399-2-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190326111842.12399-1-patrick.havelange@essensium.com>
References: <20190326111842.12399-1-patrick.havelange@essensium.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
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

v6 -> v7
[Patrick
 - None
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

