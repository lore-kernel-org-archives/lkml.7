Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267DFC2BD09
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C3224670
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ipIsPEHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbfLEUXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 15:23:06 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37408 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbfLEUXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 15:23:06 -0500
Received: by mail-pl1-f195.google.com with SMTP id bb5so1707250plb.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 12:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jRayL2fPl6QXTU1X2IWavTR7Yo2eBg/CqXK33XYBy24=;
        b=ipIsPEHW5UTXPYiz3f6QtrmZgRxejUQdh7nqa7uCLrBiB1pCIUwQLjKY+Hx3W8tpoG
         4JZH2HQj0kzSPqYsqUvaQY7ExySSj+PnYoqpRE0lr5b+1x5913Xotg9pssTMfbRZZGGH
         5pgKb163uie0tO5bmMpj/imErYbNd+oMzjpV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jRayL2fPl6QXTU1X2IWavTR7Yo2eBg/CqXK33XYBy24=;
        b=G9QFBiLgZXSUaNLDiKw5ByVLoAIaxYBYxjfS1Aar769GZ+dagv3QT1cMr5/Car0k2L
         P53ICMcnR8U7YGQI7CDe8Cb6mitlRhDhlwIyNiYm0xQ5EiAw/R2QLHha6Ub4gDnv0Ke/
         w0yw2Nt9tu8wANgAEvxGdc08lCc1Ii5LeUdS4OcwMVVe1+ix2bHhaA/nF3bFtmrLQI44
         l6r9NDtkXwfKje83faVNqFGLbM7toieUW+LYIH1/xcIfF/JyyMhRHxUKzfcfsjqYNAn9
         ocbY1AUezhMrLxQK3WQqcBtFssA4jVmM6PRDvfvx2SnhJjzWTkod3TBcMgMnTLoFgMMg
         bw2Q==
X-Gm-Message-State: APjAAAXabi14LzuGzO5AamDiTkRGlNRtkiCeCpaWeI9trx4xCwLqSmEu
        CUUI7Cvic1nRziDMOuQmMSi3Ig==
X-Google-Smtp-Source: APXvYqyhuW24FCLFzDv7K5KLFR+I/VPosr2uRJN/oZqO0hNSV+b/CSnMTJFLXtEYNnOjNboxSKC8AQ==
X-Received: by 2002:a17:90a:d344:: with SMTP id i4mr11653491pjx.42.1575577385316;
        Thu, 05 Dec 2019 12:23:05 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id o12sm560691pjf.19.2019.12.05.12.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 12:23:04 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>, devicetree@vger.kernel.org,
        Rocky Liao <rjliao@codeaurora.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Harish Bandi <c-hbandi@codeaurora.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH] dt-bindings: net: bluetooth: Add compatible string for WCN3991
Date:   Thu,  5 Dec 2019 12:22:59 -0800
Message-Id: <20191205122241.1.I6c86a40ce133428b6fab21f24f6ff6fec7e74e62@changeid>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7d250a062f75 ("Bluetooth: hci_qca: Add support for Qualcomm
Bluetooth SoC WCN3991") added the compatible string 'qcom,wcn3991-bt'
to the Qualcomm Bluetooth driver, however the string is not listed
in the binding. Add the 'qcom,wcn3991-bt' to the supported compatible
strings.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
index 68b67d9db63a3..999aceadb9853 100644
--- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
@@ -11,6 +11,7 @@ Required properties:
  - compatible: should contain one of the following:
    * "qcom,qca6174-bt"
    * "qcom,wcn3990-bt"
+   * "qcom,wcn3991-bt"
    * "qcom,wcn3998-bt"
 
 Optional properties for compatible string qcom,qca6174-bt:
-- 
2.24.0.393.g34dc348eaf-goog

