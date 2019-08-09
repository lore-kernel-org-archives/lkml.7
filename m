Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7C0C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8002171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DcQZdgr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407138AbfHINeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 09:34:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33834 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406937AbfHINeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 09:34:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so98304168wrm.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 06:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0HujpxJDALuBLWUqjS8zq5NBk/WyCBZfMmdnlRTpNtM=;
        b=DcQZdgr2IlFroNIH+nLIyKRTWFgLTPuEN1bDsv4N8D5zGm8ZqLRiw14VLSCE1WjSjA
         l5cUBLF29k/e6ssUrIqAvYe+WGKfvsLlWyavYiYiDC/Iwo7gZ602Xg6LGySET24t9jLy
         SXznkZWj8N1WtvSXSYngfTpgBTabH4LUTGl9Y2W7Po/wN1EARpyUHyif13pwgzvm0UAF
         k1RX9axwIeRu4C0pVccAi1fG1DmY1/TEIXRTwVIlOuMcDsVGjtT0dKrN3KIlW5zgnZUb
         hK3eiL+bOsp7rzGQV0NoeV6XEjkJYwn7H778pBmYu7kcXctMI5F7AkXm2lYG+1r5r1Da
         fZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0HujpxJDALuBLWUqjS8zq5NBk/WyCBZfMmdnlRTpNtM=;
        b=uR0fjUPHoMV6xfgYIj7qteChpmlW8EgFTKo1zhlnMEJluPOQ4Pfl1/pPlzlfkfnv4C
         kUea+2CmfN77uc+zEVFVXrabED5Um06e76YVYPrfG/udAw0l9rLUg8eovHeKSRRpEVBf
         JsSstrwfwbUzHFPZpLAanMpTTzOtpFowFEsAkkkSmmVJx0XdIzKYsIJXTd25iB+e1AE9
         w3u+cO3JedVawwzaJfOEzK+Wc+AMW6ubmu3PgS/SoR5O8AfReUSHvL01j6NN9hOhkfly
         sFRU3gcacKLEz7QEK8ik3tfhP1i5D5dbYeFsaDd7LIukCSMCyBgx48rDy47ZRtg2rJzA
         /sEg==
X-Gm-Message-State: APjAAAUf5uEerg3Wa2sNbbA0V9353aurIU1cVgp86cngVD8xdqZbjP8Y
        +koR7L5l+S3cahkoAnqJkm0XDRsPlWs=
X-Google-Smtp-Source: APXvYqxcL/4UZ+zBOXcgvw4tHlarYgHxBGZtino0zaUbILQwiVTHaAxi7DlzP3mT4N0JY7khimgnvg==
X-Received: by 2002:adf:f7cd:: with SMTP id a13mr1202327wrq.165.1565357669514;
        Fri, 09 Aug 2019 06:34:29 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id y18sm5674641wmi.23.2019.08.09.06.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2019 06:34:28 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, broonie@kernel.org
Cc:     bgoswami@codeaurora.org, plai@codeaurora.org,
        pierre-louis.bossart@linux.intel.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 1/4] dt-bindings: soundwire: add slave bindings
Date:   Fri,  9 Aug 2019 14:34:04 +0100
Message-Id: <20190809133407.25918-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190809133407.25918-1-srinivas.kandagatla@linaro.org>
References: <20190809133407.25918-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds bindings for Soundwire Slave devices that includes how
SoundWire enumeration address and Link ID are used to represented in
SoundWire slave device tree nodes.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/soundwire/slave.txt   | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soundwire/slave.txt

diff --git a/Documentation/devicetree/bindings/soundwire/slave.txt b/Documentation/devicetree/bindings/soundwire/slave.txt
new file mode 100644
index 000000000000..201f65d2fafa
--- /dev/null
+++ b/Documentation/devicetree/bindings/soundwire/slave.txt
@@ -0,0 +1,51 @@
+SoundWire slave device bindings.
+
+SoundWire is a 2-pin multi-drop interface with data and clock line.
+It facilitates development of low cost, efficient, high performance systems.
+
+SoundWire slave devices:
+Every SoundWire controller node can contain zero or more child nodes
+representing slave devices on the bus. Every SoundWire slave device is
+uniquely determined by the enumeration address containing 5 fields:
+SoundWire Version, Instance ID, Manufacturer ID, Part ID
+and Class ID for a device. Addition to below required properties,
+child nodes can have device specific bindings.
+
+Required properties:
+- compatible:	 "sdw<LinkID><VersionID><InstanceID><MFD><PID><CID>".
+		  Is the textual representation of SoundWire Enumeration
+		  address along with Link ID. compatible string should contain
+		  SoundWire Link ID, SoundWire Version ID, Instance ID,
+		  Manufacturer ID, Part ID and Class ID in order
+		  represented as above and shall be in lower-case hexadecimal
+		  with leading zeroes. Vaild sizes of these fields are
+		  LinkID is 1 nibble,
+		  Version ID is 1 nibble
+		  Instance ID in 1 nibble
+		  MFD in 4 nibbles
+		  PID in 4 nibbles
+		  CID is 2 nibbles
+
+		  Version number '0x1' represents SoundWire 1.0
+		  Version number '0x2' represents SoundWire 1.1
+		  ex: "sdw0110217201000" represents 0 LinkID,
+		  SoundWire 1.0 version slave with Instance ID 1.
+		  More Information on detail of encoding of these fields can be
+		  found in MIPI Alliance DisCo & SoundWire 1.0 Specifications.
+
+SoundWire example for Qualcomm's SoundWire controller:
+
+soundwire@c2d0000 {
+	compatible = "qcom,soundwire-v1.5.0"
+	reg = <0x0c2d0000 0x2000>;
+
+	spkr_left:wsa8810-left{
+		compatible = "sdw0110217201000";
+		...
+	};
+
+	spkr_right:wsa8810-right{
+		compatible = "sdw0120217201000";
+		...
+	};
+};
-- 
2.21.0

