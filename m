Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A47C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477AD233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="V+GRa2Dv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfH2N1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 09:27:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34993 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfH2N1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:27:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id g7so3460070wrx.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 06:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ObZxzVUzRVJkzuGbqaSj0zLHjJYTKVhbZ4DRyEiw5iM=;
        b=V+GRa2DvQOlLn0X+4NST+cS1WZ4h3PtMrz76coZnLJl7sJ0s9T6gbOS9+Tbs3b9Ntk
         8ghDZm6ofJrbfDX+jkkWoqRsCsFjNWULiUOthNoB9SIWFeGduuPxoSqp90V8+hUWxKBu
         FdrwiKzfHq8mwi+ONQPyptIpRWkIAo6ji0DiGNoFxexuWDtCL9+0oD+X8fZTr0UQK8nR
         Ca7zaolB5j1QD7H8bNSZHjQfRVf6dgdYugvY8uL0YQWBtLLXpY8BwcwSgnfo1PKAn2Jo
         4t08AAgTQS17cFRVCDs1hgrJfq4OkNhcJG2zCPKUAFIvu3kJh4bw4mAxb+SbL8M0vHgG
         VMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ObZxzVUzRVJkzuGbqaSj0zLHjJYTKVhbZ4DRyEiw5iM=;
        b=KLkAaDZvIXCTKNICkUAfAACs47vkiultJP3KnF8Ahd3uVTfuk2SaEz+5sq7g36p1QC
         kP11KOdWupjXDM5+GGxxAQMZKBT1nNQ20TRk3SGSvE0oCm+E+5DemYpdapXuUdar7LBL
         wOisNDeP5XwmxNmbX3wcsmpSrMpoJ40XTaXZN7Rd+YXr2m1+81yS3g9+BcIueLJjrfBi
         fE4yNe3OxYXLVMinu4/pXJHu+psueSo4kGw7x5Tr9xXjBF1UpXnporwbfe3yK4HJAdt5
         5Aqu0Khqdc24R+tcSSUs64YZjy3CyQuHwrqCEJHZSQhaZ0olto/xdu0RuWY37rvL0/9/
         ZTNw==
X-Gm-Message-State: APjAAAVRHENd4bQwNC/jmhOahBULiTNBBDAzddsccckcq3vuuaxxp8jA
        8je7AanpNVN+MLgFKgKh4IfnHQ==
X-Google-Smtp-Source: APXvYqyOHXWpdSBnIHcSQVNTV28gpUMVgF6m5ArVN54Ou1BYOV7RZWWE14x6SLW7DnHo3o6yeQTnYA==
X-Received: by 2002:a5d:658d:: with SMTP id q13mr4108312wru.78.1567085250674;
        Thu, 29 Aug 2019 06:27:30 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c62sm2420823wme.20.2019.08.29.06.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 06:27:30 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] arm64: dts: meson-sm1-sei610: add stdout-path property back
Date:   Thu, 29 Aug 2019 15:27:28 +0200
Message-Id: <20190829132728.20042-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit d4609acce187 ("arm64: dts: meson-sm1-sei610: enable DVFS")
incorrectly removed the chosen node and the stdout-path property.

Add these back.

Fixes: d4609acce187 ("arm64: dts: meson-sm1-sei610: enable DVFS")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
index e1cac880b02c..3435aaa4e8db 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
@@ -19,6 +19,10 @@
 		ethernet0 = &ethmac;
 	};
 
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
 	emmc_pwrseq: emmc-pwrseq {
 		compatible = "mmc-pwrseq-emmc";
 		reset-gpios = <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
-- 
2.22.0

