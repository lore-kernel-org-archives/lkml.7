Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021ABC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72952084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YjzrK8ED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfDKJBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:01:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39389 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfDKJBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:01:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id a96so3099773pla.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 02:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RTF2E5ylTuzDMJPP0P/IBxfb/0jpKGQmyA7LKmJUhec=;
        b=YjzrK8EDpinqDyuf+0WcBG1czU3cBjLySNPlPbFj8F7zwCaovVSQ0D45HHeNZSejDT
         hKiE/E/5rvXNVUNFnjqA6ru/i/uFCk/8KbPzGLzXjEfr+n1zFljh1aHzCa2TQzXx59ES
         S0lf9CWNKLzObegKAw1apyctW1Ez4t6wEufimawPjVtvOOGDt62rTFdqY4jH4CWNm7YX
         z3KPkdBso4jH+OtB0/rj2zcSUaAI4KPKEXmeSp89QBHLa/sd1ug1gTwaSWPy/wYb2av4
         rsfy3E0Fzt5pxSNWLR6OL0nJYyYlcVOZr/9gJyKNNSh38NqApJttIvc6Oj9Rr6Y15v3y
         Xomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RTF2E5ylTuzDMJPP0P/IBxfb/0jpKGQmyA7LKmJUhec=;
        b=VuMyxUIrgb5jNITKLYdeuMTRey9XxF/7RijoSuAYJh1+MzLN+nq1/JDNT9fhhA5UPr
         XL3UwRJC+uZZq0fbsg/6AG75Zz0zMECL2c6vU6J5Ire60/ofQxsJONDWMgwPwO+Ln99u
         K3EHn8Ogj5cmhiEXqBOTc412UozO64QtKRblUfhG3A4D/UtjqZDzjh1EFHVYcpr2cO+I
         H1B1oi1QiijjTvbe41RNCLscnjF0FPOayNfx6HtvSww73CQOtgpmrtyG+avG8SdpYMhf
         zqfdqLqKa6m6o59I4O4OOYPu0xtnAvdAYLyOlFB4Xu0ljVi3B8XcvgsCusxgCBVMX8PZ
         q3Hg==
X-Gm-Message-State: APjAAAWtPYSwgWOwgO/71hT1NzpKLGEaYZkWRGj9HU1jeLvJELOzqFVQ
        aOZqK2mSgwQDnApsOWHZkbWpT83LUqs=
X-Google-Smtp-Source: APXvYqzewUZ3f+WjnmQRAZB/rayetaRpUjtNnyzQu95VWVo1xU922WP44urHqsL7acerFot1dTWncw==
X-Received: by 2002:a17:902:b484:: with SMTP id y4mr48779055plr.88.1554973262483;
        Thu, 11 Apr 2019 02:01:02 -0700 (PDT)
Received: from viisi.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id m2sm64317272pgr.74.2019.04.11.02.01.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 02:01:01 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Paul Walmsley <paul@pwsan.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>
Subject: [PATCH v4 1/2] dt-bindings: serial: add documentation for the SiFive UART driver
Date:   Thu, 11 Apr 2019 02:00:28 -0700
Message-Id: <20190411090027.8670-2-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411090027.8670-1-paul.walmsley@sifive.com>
References: <20190411090027.8670-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding documentation for the Linux driver for the SiFive
asynchronous serial IP block.

This revision incorporates changes based on feedback from Rob
Herring <robh@kernel.org>.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: linux-serial@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
---
 .../bindings/serial/sifive-serial.txt         | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt

diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.txt b/Documentation/devicetree/bindings/serial/sifive-serial.txt
new file mode 100644
index 000000000000..c86b1e524159
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/sifive-serial.txt
@@ -0,0 +1,33 @@
+SiFive asynchronous serial interface (UART)
+
+Required properties:
+
+- compatible: should be something similar to
+	      "sifive,<chip>-uart" for the UART as integrated
+	      on a particular chip, and "sifive,uart<version>" for the
+	      general UART IP block programming model.	Supported
+	      compatible strings as of the date of this writing are:
+	      "sifive,fu540-c000-uart" for the SiFive UART v0 as
+	      integrated onto the SiFive FU540 chip, or "sifive,uart0"
+	      for the SiFive UART v0 IP block with no chip integration
+	      tweaks (if any)
+- reg: address and length of the register space
+- interrupts: Should contain the UART interrupt identifier
+- clocks: Should contain a clock identifier for the UART's parent clock
+
+
+UART HDL that corresponds to the IP block version numbers can be found
+here:
+
+https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/uart
+
+
+Example:
+
+uart0: serial@10010000 {
+	compatible = "sifive,fu540-c000-uart", "sifive,uart0";
+	interrupt-parent = <&plic0>;
+	interrupts = <80>;
+	reg = <0x0 0x10010000 0x0 0x1000>;
+	clocks = <&prci PRCI_CLK_TLCLK>;
+};
-- 
2.20.1

