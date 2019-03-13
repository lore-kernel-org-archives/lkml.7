Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3876C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F4B2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjV/dmhf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfCMSg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:36:57 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46465 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfCMSg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:36:57 -0400
Received: by mail-yw1-f67.google.com with SMTP id v127so2001134ywe.13;
        Wed, 13 Mar 2019 11:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WjY60rR7W8h/rdE/GHr0t9DyetScE6OivwQJwXM8I5E=;
        b=NjV/dmhfMlK7BLpAInnrr6ientMA9FqTTYyaVP73q4Ec5iJScIepb9IcjSy/tXTn3a
         7hYyBiHuC6fhawkE8bgVWIcnVDXQBQRIoy9GeFA+EJfX24Izka2bsvbhs90ZIZexUCLb
         AkbDWqvMJV4LyQVt2G6lKO03BCyv40kIkc87RrFs3DZlXgi+OeHZSHxiZT8o3VP8Gy2C
         De78vOgyE1mfxSFtur7/o1C7ShDpNCU2jH7wb2L2lhBtwMxzCpTSmw9MNmjrwgeOnaAi
         o/35eNyNas39l1VdzFaS1AcQMG06KhJA3pkci+ZhYZW7njMkWTJdIGSBk8ssL+InPk8i
         aylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WjY60rR7W8h/rdE/GHr0t9DyetScE6OivwQJwXM8I5E=;
        b=hhBCxHji+hltacXfSisD/BWoDF5NJCWjFpo/IT/alrSv6yDz19nkwFvOu7/NdDOv6f
         UixRNZUp6noYcUWdmZiSabu1klFq4LBjMHfMdJLapsFKGeuYJFO6T+1pYxR5sI3zFXCF
         mCm30sroX3yzSEsGSTOjEagc4CLl7KdebZA28sU/S0SyjNqH8sDyCkSzU/wUy3QATJDt
         Umtonl9qA4n/5gsqU3BZQasDo3+Wns+7F5cUTj5ZmxvQzyuuUQnwKMcgk829WE+CKpAx
         ImPe7fLN/g4YaPeiH+TPcinS5Oj8J09FO38QhsoDVelQ7ZWB8EsegISHcRmHS12nFv/+
         Q5mg==
X-Gm-Message-State: APjAAAUP6MTQBehmwqf9I+0hBVfgT2kigorqwoil6ronUi4Lcc2Hi2JZ
        Tk831GzBygTlQY99q+FlR2Y=
X-Google-Smtp-Source: APXvYqyeVO9okMUTGVsh45T8yhU3+Bggiw7XPAKP80/CWX8XgCHc4TbzPKw9dcDgXZ/RP4ByyUsN8g==
X-Received: by 2002:a81:6054:: with SMTP id u81mr35372819ywb.189.1552502216529;
        Wed, 13 Mar 2019 11:36:56 -0700 (PDT)
Received: from vince-laptop.corp.lucid.lcl ([12.151.33.163])
        by smtp.googlemail.com with ESMTPSA id a194sm5571200ywh.103.2019.03.13.11.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 11:36:55 -0700 (PDT)
From:   Vince Kim <vince.k.kim@gmail.com>
Cc:     Vince Kim <vince.k.kim@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: display: bridge: TI FPD-Link III Serializer/Deserializer
Date:   Wed, 13 Mar 2019 11:34:58 -0700
Message-Id: <20190313183527.22883-2-vince.k.kim@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190313183527.22883-1-vince.k.kim@gmail.com>
References: <20190313183527.22883-1-vince.k.kim@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documments of device tree bindings for TI FPD-Link III Serializer
and Deserializer chips;  DS90UB927, DS90UB949, DS90UB948

Signed-off-by: Vince Kim <vince.k.kim@gmail.com>
---
 .../bindings/display/bridge/ti,ds90ub9xx.txt  | 39 +++++++++++++++++++
 .../bindings/display/bridge/ti,fpdlink.txt    | 25 ++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,ds90ub9xx.txt
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,fpdlink.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,ds90ub9xx.txt b/Documentation/devicetree/bindings/display/bridge/ti,ds90ub9xx.txt
new file mode 100644
index 000000000000..351d9cb79ebd
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/ti,ds90ub9xx.txt
@@ -0,0 +1,39 @@
+Binding for TI FPD-Link III Bridge Serializers; TI DS90UB927, DS90UB949
+TI FPD-Link III Bridge Deserializer; DS90UB948
+
+Required properties:
+- compatible: shall be one of
+		"ti,ds90ub927"
+		"ti,ds90ub948"
+		"ti,ds90ub949"
+- reg: i2c device address
+
+
+Optional properties:
+- power-en-pin: GPIO pin for power enable
+- reg_config: register address and value to be written during initialization
+
+
+Example:
+--------
+I2c-master-node {
+...
+	fpdlink_serializer_i2c3: serializer@0c {
+		status = "okay";
+		compatible = "ti,ds90ub949";
+		reg = <0x0c>;
+	/* Enabling passthrough for GPIO0 on serializer for touchscreen IRQ */
+		reg_config = <0x0d 0x25>;
+	};
+
+	fpdlink_deserializer_i2c3: deserializer@2c {
+		status = "okay";
+		compatible = "ti,ds90ub948";
+		power-en-pin =  <&gpio9 8  GPIO_ACTIVE_HIGH>;
+		reg = <0x2c>;
+		/* 0x90 for DISP enable, 0x9 is for Touch enable on GPIO1 and 2*/
+		reg_config = <0x1e 0x99>;
+	};
+...
+}
+
diff --git a/Documentation/devicetree/bindings/display/bridge/ti,fpdlink.txt b/Documentation/devicetree/bindings/display/bridge/ti,fpdlink.txt
new file mode 100644
index 000000000000..2f2e1a269722
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/ti,fpdlink.txt
@@ -0,0 +1,25 @@
+Binding for TI FPD-Link III Bridge driver
+
+Wrapper DRM Bridge driver for TI FPD-Link III Serializer and Deserializer
+
+Required properties:
+- compatible: "ti,fpdlink"
+- fpdlink-serializer-i2c-handle: i2c node for TI FPD-Link III serializer driver
+- fpdlink-deserializer-i2c-handle: i2c node for TI FPD-Link III deserializer driver
+
+
+Example:
+--------
+fpdlink_lvds: fpdlink_bridge@0 {
+	status = "okay";
+	compatible = "ti,fpdlink";
+	fpdlink-serializer-i2c-handle = <&fpdlink_serializer_i2c0>;
+	fpdlink-deserializer-i2c-handle = <&fpdlink_deserializer_i2c0>;
+};
+
+consumer: {
+...
+	fpdlink-bridge-handle = <&fpdlink_lvds>;
+...
+}
+
-- 
2.17.1

