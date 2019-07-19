Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54C7C76196
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF0721849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Y9XnuhEH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfGSLKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 07:10:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44716 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbfGSLKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 07:10:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id t14so15443329plr.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 04:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pwS7P5TIt/JsDPbn/Wqhn2NHhUPFmyaKIcnCGFzzlHg=;
        b=Y9XnuhEHCwqrD+VnqN/I5dNL/nd27wLnf9HxZqu7Yg2OM1ueZeS0/g2KRiBLPiV5Vh
         4hUu/+Ylr0yt14FXLo5Gnu89VyujtGPnuS2GUYGP+RvCaSbVGqbmoMF46xJdSqWg65kR
         lUxhZhGb5kyGVIdh5UtVFHCKFDcb6DOXGmGDMcarVX71y4MR1lM5CHPX7vMzCvC/h1/X
         vhIlL78rYc9lkY30caXgi3S90FSEKQ+NViFOe/5mpqr67xd80u7OIRJZk84D9M858TKX
         bXCkzHwtY1xHxPOZhooFOOddV2kD+CxEPXtdsmidWv4IhJjIPUOvE99NM3ob8e3sLHxf
         FucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pwS7P5TIt/JsDPbn/Wqhn2NHhUPFmyaKIcnCGFzzlHg=;
        b=suJxmucOQuuagnfPBilIBcdOQDBA9pyKnqj+xK+2sbzHhengUl67w61bBm7vTilz0R
         gGIToFEU/4n/G6fdhNNVuopGrRPmWRaGKJMVED/OhmOXg1cBji2QexvmNNvWE9QOxrVW
         1SaQuxfxRCZYtin3k4OcoVlb7umLcHZyqkbu0UMQ0GjGVSyEsxmaEkBPnL1wwGU1AzaP
         BQhDd1DrdDLy7K6Eyctwu0dv5oTCxulfKfI8KbusJ5V9h/UkYvcxh7f5pi04+aXLWNya
         NictiaXvzmsMnH1GoM6W6oIi4/d+5qrjCLp7gEZneSg7kc7/2PTi/iC/wGMrMztRr/my
         5e3w==
X-Gm-Message-State: APjAAAUJzN4nt/uR31qoK2NY7/BfopfHw6aG0sebh3iltrutBKmRkc6e
        vc1xhTxnQ+YsrpFksoZKTN/0QQ==
X-Google-Smtp-Source: APXvYqyEfzz9Y8lJVBzXseZAguoF4LfnLNuKFVbuRz6dNbLVuhE/7V+E74719q73vO5yqLfAW8EZSQ==
X-Received: by 2002:a17:902:9f8e:: with SMTP id g14mr10404199plq.67.1563534653921;
        Fri, 19 Jul 2019 04:10:53 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id i9sm10196872pgg.38.2019.07.19.04.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Jul 2019 04:10:53 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     davem@davemloft.net, robh+dt@kernel.org, paul.walmsley@sifive.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     mark.rutland@arm.com, palmer@sifive.com, aou@eecs.berkeley.edu,
        nicolas.ferre@microchip.com, ynezz@true.cz,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 1/3] macb: bindings doc: update sifive fu540-c000 binding
Date:   Fri, 19 Jul 2019 16:40:29 +0530
Message-Id: <1563534631-15897-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the discussion with Nicolas Ferre, rename the compatible property
to a more appropriate and specific string.
LINK: https://lkml.org/lkml/2019/7/17/200

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 Documentation/devicetree/bindings/net/macb.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/macb.txt b/Documentation/devicetree/bindings/net/macb.txt
index 63c73fa..0b61a90 100644
--- a/Documentation/devicetree/bindings/net/macb.txt
+++ b/Documentation/devicetree/bindings/net/macb.txt
@@ -15,10 +15,10 @@ Required properties:
   Use "atmel,sama5d4-gem" for the GEM IP (10/100) available on Atmel sama5d4 SoCs.
   Use "cdns,zynq-gem" Xilinx Zynq-7xxx SoC.
   Use "cdns,zynqmp-gem" for Zynq Ultrascale+ MPSoC.
-  Use "sifive,fu540-macb" for SiFive FU540-C000 SoC.
+  Use "sifive,fu540-c000-gem" for SiFive FU540-C000 SoC.
   Or the generic form: "cdns,emac".
 - reg: Address and length of the register set for the device
-	For "sifive,fu540-macb", second range is required to specify the
+	For "sifive,fu540-c000-gem", second range is required to specify the
 	address and length of the registers for GEMGXL Management block.
 - interrupts: Should contain macb interrupt
 - phy-mode: See ethernet.txt file in the same directory.
-- 
1.9.1

