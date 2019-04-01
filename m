Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BB0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483DB20896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t/W32oZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfDAKk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:40:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36561 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDAKkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:40:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id h18so10802188wml.1;
        Mon, 01 Apr 2019 03:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7GevwntDVhSZ+fFuiuMye419avBI3XRhevXvsThsYhw=;
        b=t/W32oZ2T9ZsFL2FOZe2vJEkSVHPjUUsR948xEt0+nntjEDpcUjlgCT/oFiPuWBdni
         UxTxYdxG8jW4vb5W59Ztq2kHci9Q7W9W9pRLmYmlA1DEGOZ0FJTyT5wLyu4alNzATz+T
         X4RsO00bugp/t108vHoYimBVYKhRritkngYA6gcdjKuVUwRE8JV80057SWcQqHeRyoo3
         /tQyGb8FBkzFYZLXYI6OO3k7/FWYAf/0wpW8YDdgORz+ZW3ZA/r5N9aFZzwwnL9vNQc9
         8jqM0F3KB/RXp1g+wF1AvcWyXfT4U6oRrxxDipAAaXzOJIOlTlnUvcGj/q3Md4++NBVn
         pNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7GevwntDVhSZ+fFuiuMye419avBI3XRhevXvsThsYhw=;
        b=aDyOEq9s4WAqPpB/AhLAD/uUS/gXq2+J88aW75qjlc4n7jp1hWK6VcSv2ypJKTfi20
         Up8QgWr7WQ1Xn8dIopSYhwMWkQYvHoVeRSD4EEBIYxHWYSNzXWbIah8j4RqH8jF3vWLc
         e3cIV73jFptvSdPzvRRn8PtWgmsTgNZPFi7zLIHx05C1rCbm1TsPLpmte1Cax3trJnPJ
         tkyp1GNJQNRPFXT1dmKWs+8vwpgtxbmDYULXjsMqHLzVLLNXrZ2cP8+P9O3GJXMpDCLf
         rdGTxcFxQf5Tr/iDKziKfwCJppCpvvwtj4utWZp5722ybdj/ZPi6apNR6RmxniqVJsrv
         BdCg==
X-Gm-Message-State: APjAAAXLoiLVxTRwYNQDJVWjWo8xB7UbMxgZYlQPW5QWNI4gaN7EejxR
        IIvYRLcKX5nAS6PzkVVvLVE=
X-Google-Smtp-Source: APXvYqz005BIpoimL/qfJSxuSaeVV5oCdsyUWYmMsQmHheneRZ7j7oEQpeLdFiG7/7WgCcKJ/OSLIg==
X-Received: by 2002:a1c:67c1:: with SMTP id b184mr7563425wmc.12.1554115253553;
        Mon, 01 Apr 2019 03:40:53 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id v190sm26818483wme.18.2019.04.01.03.40.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 03:40:53 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v2 1/6] dt-bindings: usb: xhci-tegra: Add Tegra186 support
Date:   Mon,  1 Apr 2019 12:40:45 +0200
Message-Id: <20190401104050.31355-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401104050.31355-1-thierry.reding@gmail.com>
References: <20190401104050.31355-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Extend the bindings to cover the set of features found in Tegra186.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: JC Kuo <jckuo@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../devicetree/bindings/usb/nvidia,tegra124-xusb.txt          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt b/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt
index 4156c3e181c5..5bfcc0b4d6b9 100644
--- a/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt
+++ b/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt
@@ -10,6 +10,7 @@ Required properties:
   - Tegra124: "nvidia,tegra124-xusb"
   - Tegra132: "nvidia,tegra132-xusb", "nvidia,tegra124-xusb"
   - Tegra210: "nvidia,tegra210-xusb"
+  - Tegra186: "nvidia,tegra186-xusb"
 - reg: Must contain the base and length of the xHCI host registers, XUSB FPCI
   registers and XUSB IPFS registers.
 - reg-names: Must contain the following entries:
@@ -59,6 +60,8 @@ For Tegra210:
 - avdd-pll-uerefe-supply: PLLE reference PLL power supply. Must supply 1.05 V.
 - dvdd-pex-pll-supply: PCIe/USB3 PLL power supply. Must supply 1.05 V.
 - hvdd-pex-pll-e-supply: High-voltage PLLE power supply. Must supply 1.8 V.
+
+For Tegra210 and Tegra186:
 - power-domains: A list of PM domain specifiers that reference each power-domain
   used by the xHCI controller. This list must comprise of a specifier for the
   XUSBA and XUSBC power-domains. See ../power/power_domain.txt and
@@ -78,6 +81,7 @@ Optional properties:
   - Tegra132: usb2-0, usb2-1, usb2-2, hsic-0, hsic-1, usb3-0, usb3-1
   - Tegra210: usb2-0, usb2-1, usb2-2, usb2-3, hsic-0, usb3-0, usb3-1, usb3-2,
               usb3-3
+  - Tegra186: usb2-0, usb2-1, usb2-2, hsic-0, usb3-0, usb3-1, usb3-2
 
 Example:
 --------
-- 
2.21.0

