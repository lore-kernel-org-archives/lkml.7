Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2900BC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC09206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="c0hsP+yI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfDWJPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:15:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37673 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWJPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:15:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so17847463wmf.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 02:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bInNvpdWwB8SzqqGmXY3uxa+isS0spqIYrGtdkeVxUk=;
        b=c0hsP+yIZF19h+AXx0mT2d4eJ0IH1y85CxXD65JPhpKFXgcv3Wd0iRQGjENk5eURYC
         qHX80QIlnFt2Guh/QQ5OvVATzOHhyzVlnBjlhdFnRj5Pi3uPhnIk0z3rm1+SEFLlaQvf
         7dbKeJC/GTcVs/DV6w0bePrR1nIxItr/BJKT9UZlP/i20vQz6TzUSwn2bd6ANhsRwRM9
         RaFHlh8zPuq/fMMCrU3TnItYiJcvrfe8xcw63X//qr6q21QvSj0ObbiBsfmSvUgGSTq4
         2D/FMUJKqOz7bclq7VOqjGw7LZtRSnh8NjU7xbcsRjoCtCYWEImkUxCRYbs6mPDuCOaJ
         LqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bInNvpdWwB8SzqqGmXY3uxa+isS0spqIYrGtdkeVxUk=;
        b=GANSlHt8r2WjDLBiXngnXZ+D6QV50AlXPuqaxXMoA3jimykDfyxdfSd8vrAzuGLEtc
         uSiQBS7gDckQToYGmvvwbRzZpCI3Chf1sdlQo2p14jO6XFcbGneih93La5XUvpuPo1ZJ
         crJLsc0UB42Ji8KV+TD+/q0Rdg0HAW02PG8G9sGf1flevgEy1/NuKRfARVwFwNLkyYYg
         Z8xeuIBH9ckTDqmFH1al88rQekilNRAyyDq2Xb7exNTswJtq9aj9NDpb0nJ1h14EIFtl
         no/onidOchLGht3HcZpv5M+H/sfzvU7IUMP5vOt3ZK+kuWKbO19NqDBFCYbl5mVsKvdG
         RYeA==
X-Gm-Message-State: APjAAAXwcK61X6cHHw1/7BUeB3bDvEZz4qxVypDRg5uHfxg80UUUgahl
        T+rx/AqgNn7hZ94FYMEx7bEXYQ==
X-Google-Smtp-Source: APXvYqytnShlWc7jx99S4PTztqmWXYznar8H0bgJqj5IMVe4/uzyShja8Eh3SDIedamYeQh+k6yQlQ==
X-Received: by 2002:a1c:1b16:: with SMTP id b22mr1549969wmb.101.1556010909322;
        Tue, 23 Apr 2019 02:15:09 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t17sm12241272wrr.26.2019.04.23.02.15.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 02:15:07 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org,
        jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/6] dt-bindings: clk: meson: add g12b periph clock controller bindings
Date:   Tue, 23 Apr 2019 11:14:58 +0200
Message-Id: <20190423091503.10847-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423091503.10847-1-narmstrong@baylibre.com>
References: <20190423091503.10847-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the specific Amlogic G12B clock driver compatible.

G12B clock driver is very close, the main differences are :
- the clock tree is duplicated for the both clusters, and the
  SYS_PLL are swapped between the clusters
- G12A has additional clocks like for CSI an other components

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
index 5c8b105be4d6..6eaa52092313 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
+++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
@@ -10,6 +10,7 @@ Required Properties:
 		"amlogic,gxl-clkc" for GXL and GXM SoC,
 		"amlogic,axg-clkc" for AXG SoC.
 		"amlogic,g12a-clkc" for G12A SoC.
+		"amlogic,g12b-clkc" for G12B SoC.
 - clocks : list of clock phandle, one for each entry clock-names.
 - clock-names : should contain the following:
   * "xtal": the platform xtal
-- 
2.21.0

