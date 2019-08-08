Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3B3C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7111821880
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lplD0g3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732981AbfHHOpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 10:45:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54448 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732811AbfHHOp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 10:45:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so2681920wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 07:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cdCXxiJkZwv+z5nIdjZ1AKoaP38PZYsnJaBif7OuI/w=;
        b=lplD0g3mm2VDvN4ZziBK53kO4dWPlXrDd+bIfvsd9Q/afBYVz3TbQIgbfVvh6CyFrB
         KgKT+8WNETIsbVlqEO3riSawg/fvGWgkQxR9ZRXykPLUfH7Z7YlFTvgj0nOLewJ80gHY
         QWGem+5rrNBDL/MkNhYGhbETd6tgFRanlojOa+X4CKUngQDU5gI6ZjDJu1pjKqD/qXIW
         vybdtVeWFf7Fq627Jd58d0inlRXE2k+HLR4oQUEGr+IKP9H9Y1AjVavwDV2ji+/2RvBK
         OMnGQOvqqUdZU7xrisepFW3DhOpGwuEvhzZuW74SJeqV792IPUOKBxgV2dG57wP/XCEl
         rMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cdCXxiJkZwv+z5nIdjZ1AKoaP38PZYsnJaBif7OuI/w=;
        b=cQxtmMnmUwOK6xu1cT/tzvftqm1uhh++3owz+R/Kq7sIMwzZCmN8HGh5zqS24suFVD
         PVMhahVjnVlh1hSAYMi3Bhl2BFAEv4eBaDkLsqw+zeTIyNIP6/db/KI55ogV3Zxw2yzT
         WIk+DO3WNpJJcIh942d/avN9Eu2nVWYjmRCWY8antXjPbNjx3okHrP7rlEOGHkuaseDo
         TfOSYZr/lwhoDPgCKD8K9XhKBBf7PRCfJ/HD1kemXwTJgrJXpS6v8qIP8iZji/oiI9C2
         n2l2XTE+ZAWJbePHkz2ojnOd4y//DPGs8YCzF3TtaqGX3gD6Jn5nmIPpsZs9eytq1QNU
         yJdg==
X-Gm-Message-State: APjAAAU7czwWSzA6cVukTN1Zl71iHyQj/NDdiuHLakvZ3rDnhFV25tdu
        mVq74yIr26uZmVTVki9czeaiUw==
X-Google-Smtp-Source: APXvYqyySBvQDtGOAbhZvwKWDq+6U8mjD9rtieI80XujmHaIyhwAVfgGvszj3f2Jrs1j1a/mhV/y/g==
X-Received: by 2002:a1c:6c14:: with SMTP id h20mr5098118wmc.168.1565275525435;
        Thu, 08 Aug 2019 07:45:25 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id g15sm2009060wrp.29.2019.08.08.07.45.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 07:45:24 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, broonie@kernel.org
Cc:     bgoswami@codeaurora.org, plai@codeaurora.org,
        pierre-louis.bossart@linux.intel.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/4] dt-bindings: soundwire: add slave bindings
Date:   Thu,  8 Aug 2019 15:45:01 +0100
Message-Id: <20190808144504.24823-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
References: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
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
 .../devicetree/bindings/soundwire/slave.txt   | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soundwire/slave.txt

diff --git a/Documentation/devicetree/bindings/soundwire/slave.txt b/Documentation/devicetree/bindings/soundwire/slave.txt
new file mode 100644
index 000000000000..b8e8d34bbc92
--- /dev/null
+++ b/Documentation/devicetree/bindings/soundwire/slave.txt
@@ -0,0 +1,46 @@
+SoundWire slave device bindings.
+
+SoundWire is a 2-pin multi-drop interface with data and clock line.
+It facilitates development of low cost, efficient, high performance systems.
+
+SoundWire slave devices:
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

