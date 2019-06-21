Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6604DC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C439208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3RGBRAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfFULOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 07:14:03 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33312 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfFULOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:14:00 -0400
Received: by mail-lf1-f67.google.com with SMTP id y17so4825856lfe.0;
        Fri, 21 Jun 2019 04:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f6xjWBy9TQS+zhfQJ9nG9LBSK3tytcH5dBUe6FTu/5U=;
        b=f3RGBRAFQKi005KQ6wPCJb9Oouh/obHVloQejzAiNzPrZ4K1WKsw4hZOnpBkGaOEFN
         SAdIh4fR3rhgZrApoN5YhUV/3ULEn6X3q0aT+2Y8cPFVDyMfoWkebKBV18RoANMqil9P
         OspOi2EixozTCSQNdLUMWBvQ6StTt1/FwjOdRbHcZMh2EXfRu/qXXkSF5euwxFkPZnqM
         xTWGDYy5Qp60ZZNankgsCJ1urj9jkd0Dgu+A9qM8/Nni5Audj9o8povcfnLCLUxtirIi
         FwKGAxbrO/02kbawdTRqQl5mP9HQKKbkQHZgsKhUEuE0AW7FNOIFvZHCTUKzDXOdzFdx
         o0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f6xjWBy9TQS+zhfQJ9nG9LBSK3tytcH5dBUe6FTu/5U=;
        b=BOkBhY1++UK0idIbojITRGYxYmgZN5//q7ziHwr57HDyjtHxaUHji3gOzXlppPceXX
         GtwKE1bkKNIU4hd7XGf6kc+Y39iZNRwGaC4fc90MVoox8ldW6xJsxrS3VcVfHq87+Z05
         QOE8Ibo3WaZheti1x9MgaNwDBmzRBvvZNIiCmALjk6LAr3r+JEKwoT83LXoUugB1BXeW
         rRe9iEQMPZRFy913GlhKrdmBp+Iy/qJ3070Yf+bFkOiQbd59yi+ZgwLWOQb39Sr6lWEv
         /rHUj+GtXAfyjNCxF6/0nJjV4TctgmrsTdKbreKyBuX0P/7mGdBd4LcESA7C8m/sqW71
         eYRw==
X-Gm-Message-State: APjAAAV/3g3/kJETIzfEqwQVA9f4J1dDpddo1MoF/paACzxqw+ISUYz+
        BtQP/FJYD8Fl0eVjWSy56zug1OrA
X-Google-Smtp-Source: APXvYqymR4up1otzVkuDTFRRu11eZiy/lOkm3huoIgu7OYse7f/Sibc2d/r4MGiOZzxJ4BkrDJkagg==
X-Received: by 2002:ac2:598d:: with SMTP id w13mr65862451lfn.165.1561115638372;
        Fri, 21 Jun 2019 04:13:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a315:5445:5300:a5e4:32fe:c6e4:d5eb])
        by smtp.googlemail.com with ESMTPSA id l11sm391202lfc.18.2019.06.21.04.13.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 04:13:57 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     myungjoo.ham@samsung.com
Cc:     cw00.choi@samsung.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: extcon: Add support for fsa9480 switch
Date:   Fri, 21 Jun 2019 13:13:51 +0200
Message-Id: <20190621111352.22976-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190621111352.22976-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190621111352.22976-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Figa <tomasz.figa@gmail.com>

This patch adds documentation for binding of extcont Fairchild
Semiconductor FSA9480 microusb switch.
This usb port accessory detector and switch, can be found for example in
some Samsung s5pv210 based phones.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
Changes from v1:
  - Added newline at end of file
  - Removed interrupt-parent as it is implicit
  - Added Acked-by
---
 .../bindings/extcon/extcon-fsa9480.txt        | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt

diff --git a/Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt b/Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt
new file mode 100644
index 000000000000..d592c21245f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt
@@ -0,0 +1,19 @@
+FAIRCHILD SEMICONDUCTOR FSA9480 MICROUSB SWITCH
+
+The FSA9480 is a USB port accessory detector and switch. The FSA9480 is fully
+controlled using I2C and enables USB data, stereo and mono audio, video,
+microphone, and UART data to use a common connector port.
+
+Required properties:
+ - compatible : Must be "fcs,fsa9480"
+ - reg : Specifies i2c slave address. Must be 0x25.
+ - interrupts : Should contain one entry specifying interrupt signal of
+   interrupt parent to which interrupt pin of the chip is connected.
+
+ Example:
+	musb@25 {
+		compatible = "fcs,fsa9480";
+		reg = <0x25>;
+		interrupt-parent = <&gph2>;
+		interrupts = <7 0>;
+	};
-- 
2.17.1

