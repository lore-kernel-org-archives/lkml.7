Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97756C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9B42173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="iLz1uYNN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbfEUPBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:01:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35122 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728788AbfEUPBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:01:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so6050264wrv.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 08:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cOkHldzyBFH9X/HosQWb1+4hRM7Ru7GoP6WYL8SoxXY=;
        b=iLz1uYNNrP1wzBd0TtjfZdiiXyUgafCaZPWzdqW1C7AyvgRQwNgYlnaB2oVq1fgvGC
         zUJGOHNaStkp5rxJtlAiNrMXntlQnmnlSNVHbdeiXtMKsI1xEPZ3yFVAYaB2QsoMHTcF
         4ptUEp+iYLSvFypp9o1FJ+OcsMQyC7ODhArXmCmmoY+3uaCQMNAk8MQea/UiDncY2VT5
         Hc3i1oAruKqXtJMHCwrwwjIzxbeycv14H5cmoulfEKDUZAPLikUWDFGVYxFa7vndnoDU
         c7UISO884tWxdVq/zw4M0UAHznZmVPLLg9vjY0yKsdHQ1D4C39VeZj4WvM/X/kkHB+Jc
         s8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cOkHldzyBFH9X/HosQWb1+4hRM7Ru7GoP6WYL8SoxXY=;
        b=pcekaRmMpqU1WxknhAQOrzhITOGin7QZaYaZoAQqJxnf9ipHozcoWt0FMNZIil38dH
         5OID6QI6P8RhNbMkBYmFp7e4uBaRS4LDw5UdAV/rx9gJ2ZnPfCSssiZTpN9sFLjMxoBE
         Flu1XW2qE08/aYYnjEhbUjXp50ebljZtC/rIV2UI1cs7lpS+GGMnrnfnuzfwB1t/a5au
         R3kppGwV+5GPBbK9qQAoeJA7DUzMkjWWvbt7w+ij+l+bHaQTg+IeEj5dDxM98XNW/mlM
         Uch9YiRV0szWax4jddbLfBz7vr3PldoNwy34kR4SB/PZSBuNr/4PMnyETcb2Tf94fcJ0
         VrDw==
X-Gm-Message-State: APjAAAWG17JpA4OLXE8jq0SA4lu+Rd2ZiZENPMYldVSS0YxAGx6UMkkV
        Q6gIdz8CsyLtoo0IgBKIuCAVng==
X-Google-Smtp-Source: APXvYqyIk/qrN/n0dkOKQIYiCuXs1z6aYIvyyVnYqLMYI9XDoGTJxEnIDige/eKJnv1im9nxaSSdxQ==
X-Received: by 2002:adf:b611:: with SMTP id f17mr52412220wre.162.1558450895175;
        Tue, 21 May 2019 08:01:35 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b194sm3407505wmb.23.2019.05.21.08.01.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 08:01:34 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 1/3] dt-bindings: clk: meson: add g12b periph clock controller bindings
Date:   Tue, 21 May 2019 17:01:28 +0200
Message-Id: <20190521150130.31684-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521150130.31684-1-narmstrong@baylibre.com>
References: <20190521150130.31684-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the documentation to support clock driver for the Amlogic G12B SoC.

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

