Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4448FC282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 02:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FCF2084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 02:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CPfLLhzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfDMCBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 22:01:36 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39025 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfDMCBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 22:01:35 -0400
Received: by mail-io1-f68.google.com with SMTP id e13so10170496ioq.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 19:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RTF2E5ylTuzDMJPP0P/IBxfb/0jpKGQmyA7LKmJUhec=;
        b=CPfLLhzEBXBWgr/TQWDSJy7ko+31cU3Ek5T/80Is4zI/rTjYZotAlXslVc4H3LD7Ki
         W4I4ynqy/2Fd5rP/QSHnxHvWQptZ1dWsRL0ShjJ+nubGYEnPZ93EbDoGPZrx6ojNsn+n
         shacIrgwg3PayIz8E6kKgbuKr6BFF7zQ+FkmWjt49mFqO74ka4pv4cl1z6n2/3BDMCVn
         5Xac7Exr6lIIf+0WP/fuE+jKozXzxgczS3U7IFfFp0zXn65yVBXNgH88SuSdHjXZe+5e
         2CEYE64IxwhiexQBa80riayxH/4ED4mqsplAdBC1UTq0IjBXvqIwjqc1x23p+w+y6pD6
         C5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RTF2E5ylTuzDMJPP0P/IBxfb/0jpKGQmyA7LKmJUhec=;
        b=WAgp59KlE8sFVrF1pY/FdPSsDUtTITTbbDu6hzCVZGxs0IJCR0FxMWQ2Zgiowc44yb
         5QRbe9aCrqdeI4p/EmnBEFGWXkw4oT7gkLXMgtzlmUcXTY3nJX0NkgX+h/8vAiYB4N8Y
         k5SHIAz8TIQDFgxcqgytg4ocE6dBnrhSsz8bqs479B1GtuvPH3ZtkUK7YhHKcIYkus3V
         Q8EQXE6WqOx1dTLCgeztuIdORmdLx4DQbWzB2YOyo7AstLgEQgpLgzWAI3Y0+tSN8l/E
         /aeJTsSUJwie0elys/zOaZorDPrtLLQBPE641qXEo085iXGnWUqamaS5ZUAvYsf7U24O
         1Jjw==
X-Gm-Message-State: APjAAAU+W6P0hAO0v2vbTeJ7DidQB48v0JTZZeHE/gQ9uCP7rGn7dfRx
        JaBGthSpwWnI79SzWFe6sBXtVXoLU7c=
X-Google-Smtp-Source: APXvYqwTAkwyg4xZSTOFVQsVRlFhKJyJ6oArCM3JsgqV3x61CX/H5CpTflhLAkBH0Q285KiMrIagXg==
X-Received: by 2002:a5e:c604:: with SMTP id f4mr17399502iok.263.1555120894511;
        Fri, 12 Apr 2019 19:01:34 -0700 (PDT)
Received: from viisi.lan (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id v187sm7198473ita.0.2019.04.12.19.01.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 19:01:33 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-riscv@lists.infradead.org, gregkh@linuxfoundation.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Paul Walmsley <paul@pwsan.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>
Subject: [PATCH v5 1/2] dt-bindings: serial: add documentation for the SiFive UART driver
Date:   Fri, 12 Apr 2019 19:01:11 -0700
Message-Id: <20190413020111.23400-2-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190413020111.23400-1-paul.walmsley@sifive.com>
References: <20190413020111.23400-1-paul.walmsley@sifive.com>
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

