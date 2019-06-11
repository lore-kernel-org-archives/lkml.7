Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8D9C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31242080A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yz9mV4N+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbfFKKlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:41:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40625 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbfFKKlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:41:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id p11so12436084wre.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 03:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Gpz9OAv6XE5jXE+cWS3impQo2MFLCRNnAJiI/H46i8=;
        b=yz9mV4N+vItMSb0ZebnnzAvl58O0ImcBvJpG+VgMse/+oVEetTdiTMgqrMARsDg4Ca
         /Pflabz2rgCT3/eYvf/xJWmONndZxu8tpveX6p7Lz8wpb4m53mr2+vyltKqHt/l5Dkr3
         qDPFzKHCkgMXSXmb2L+53zNmiTYUhnJi/qI3IPPH/TmGuN2hUQZvBFW63jmx9tKBTo8P
         ySQkITia6tY0svstKyHYwb1Vvd+a1uVeDm2C1Naxm5VdQ1acAJe7lXFxQ/M70CiSq/u5
         G5yL3SXtZ3dTXs6TQ1zFJ+axj3T4s8IkMUSoYO5wiO07q183uZ2Ma+cT/OFkUV1TEDHs
         jfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Gpz9OAv6XE5jXE+cWS3impQo2MFLCRNnAJiI/H46i8=;
        b=mL4GNVWhK8fA7W2ugzz/YSlVN/2Tu1bxBZN3oiPqKaBrnotPvsiGEW+BJQ/Cww2EkT
         MtZCY6CAloIZiuJ+5bzPHEh8EeDWX6IhBALdgYl5pRkgeZuoBVgtkVtTMPSOK59+hoBN
         ptEcmALegpDuRf3PO+JanNu7iVGyEvPe8tOoNn1+sycpM1UQMMwFQZtn5y0lyoMzvjNC
         pLul4Yo2VUlFHst05IeAywCNkEPnt4hBr5B9aA40vP2kGRqiYMyDDRLCMn9fWFdqkNyB
         kQ1GuLHRgZSnlmnskKvMRs1zXCZLr2F0O5yy2gXBXjwvsFUOloVgYkTy45vSPR8Uyn3d
         twMQ==
X-Gm-Message-State: APjAAAVo43vOlRxEPj2JD7249+z+dTeUP5tTAl85lqTk9xiVuj19euuR
        DA+2z5jd0rCmB0umAagBoyUhYQ==
X-Google-Smtp-Source: APXvYqw0VHgX1azWWjQDETpNylE10g6+4P3bUZ01iGYUimXj1pqhrwetgi3EVywiQlTKCKQS9Y0+Xg==
X-Received: by 2002:a5d:4f81:: with SMTP id d1mr25750987wru.156.1560249659592;
        Tue, 11 Jun 2019 03:40:59 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id c65sm2359614wma.44.2019.06.11.03.40.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 03:40:59 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bgoswami@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 1/5] dt-bindings: soundwire: add slave bindings
Date:   Tue, 11 Jun 2019 11:40:39 +0100
Message-Id: <20190611104043.22181-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611104043.22181-1-srinivas.kandagatla@linaro.org>
References: <20190611104043.22181-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds bindings for Soundwire Slave devices which includes how
SoundWire enumeration address is represented in SoundWire slave device
tree nodes.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/soundwire/bus.txt     | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soundwire/bus.txt

diff --git a/Documentation/devicetree/bindings/soundwire/bus.txt b/Documentation/devicetree/bindings/soundwire/bus.txt
new file mode 100644
index 000000000000..19a672b0d528
--- /dev/null
+++ b/Documentation/devicetree/bindings/soundwire/bus.txt
@@ -0,0 +1,48 @@
+SoundWire bus bindings.
+
+SoundWire is a 2-pin multi-drop interface with data and clock line.
+It facilitates development of low cost, efficient, high performance systems.
+
+SoundWire controller bindings are very much specific to vendor.
+
+Child nodes(SLAVE devices):
+Every SoundWire controller node can contain zero or more child nodes
+representing slave devices on the bus. Every SoundWire slave device is
+uniquely determined by the enumeration address containing 5 fields:
+SoundWire Version, Instance ID, Manufacturer ID, Part ID and Class ID
+for a device. Addition to below required properties, child nodes can
+have device specific bindings.
+
+Required property for SoundWire child node if it is present:
+- compatible:	 "sdwVER,MFD,PID,CID". The textual representation of
+		  SoundWire Enumeration address comprising SoundWire
+		  Version, Manufacturer ID, Part ID and Class ID,
+		  shall be in lower-case hexadecimal with leading
+		  zeroes suppressed.
+		  Version number '0x10' represents SoundWire 1.0
+		  Version number '0x11' represents SoundWire 1.1
+		  ex: "sdw10,0217,2010,0"
+
+- sdw-instance-id: Should be ('Instance ID') from SoundWire
+		  Enumeration Address. Instance ID is for the cases
+		  where multiple Devices of the same type or Class
+		  are attached to the bus.
+
+SoundWire example for Qualcomm's SoundWire controller:
+
+soundwire@c2d0000 {
+	compatible = "qcom,soundwire-v1.5.0"
+	reg = <0x0c2d0000 0x2000>;
+
+	spkr_left:wsa8810-left{
+		compatible = "sdw10,0217,2010,0";
+		sdw-instance-id = <1>;
+		...
+	};
+
+	spkr_right:wsa8810-right{
+		compatible = "sdw10,0217,2010,0";
+		sdw-instance-id = <2>;
+		...
+	};
+};
-- 
2.21.0

