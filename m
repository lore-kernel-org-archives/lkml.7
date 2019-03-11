Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AB4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBFFB206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="AMPtmvi5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfCKJ5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:57:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51093 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfCKJ4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:56:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id x7so3703192wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 02:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ml6CvXuME0Z+K5TCp7FSk/CVb63UuP6ge6cT6uImDU8=;
        b=AMPtmvi5NAGFDML5TgMFV7WG36BWxCIx4m3lQQGavm7KeyQKpRo62YqVhzKrsLgnLX
         mkx/WyT/WNCiqlI1XCF1y4DNSfUOWdc1HGIzhjI1057rWLHxmNhPztMRuc60T8NHtzOF
         WBn+3ASO3kg7vVOzOe6qNdELim+5seUNOQshDL5P+YzAFGZMweRZbmNC35Y9NaqBcaBF
         gTv2W2+IdFa2jHPj+V9xlYXYt+PTu02vG8sKSpjk1NnwIzpCNsGjjGJC9EbAWdtfPEEi
         3oWgLQ4yiHwLLUbhayElbU5pAFDwOqz8NuzrKv9ng5LTVshWo53HmDQzj+y+T5xp1McM
         MAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ml6CvXuME0Z+K5TCp7FSk/CVb63UuP6ge6cT6uImDU8=;
        b=ODxqyHE5sPwxX4aXrK8vG4Ls/hJuc0jDW35tW0VJBKpFZk89knaEnXrLHFMaMtGLBj
         6Y18/tkvwa0bDAfJzvKe3T36LSu8UvIZLgMXX3fo/TjmEucn/wLE8gIbJt76S69rvFaI
         AOrcAUTYsLkWWQAewuYGS9W9w+DBEI2HHs7yKSXlGGz0oRuDw71A6VPxXLWsr7iU2zt8
         9rwSmQ41f8PzwUL/85IJ5351vYN/N8Hd1XGzK1hb5bn0FTv0sLtB/omRBpKWTH3RpX0A
         rW8oZaBb87wvhGw6UPKKTJCEDs2xGVi6mK955IAdx4KhzhK6MqpRHIlEaChtuDEieDsP
         ybtQ==
X-Gm-Message-State: APjAAAXF/WyyldLt3bwMcW5j/3cB3n9QiwqgkgLj4XRsdNGy9mPnW6kn
        ejau++fRGiL8PoF8DJ+x+nmPEg==
X-Google-Smtp-Source: APXvYqwvl+lCRstMEevCscukF7R3/hPAwQBtGqgvjwzVd8d9iutAtbpToeqeZa64LkCF9H2Uv+DC5w==
X-Received: by 2002:a1c:4c1a:: with SMTP id z26mr17081379wmf.139.1552298178656;
        Mon, 11 Mar 2019 02:56:18 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e12sm4764737wrs.91.2019.03.11.02.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Mar 2019 02:56:17 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] arm64: dts: meson-g12a-sei510: add uart_AO pinctrl
Date:   Mon, 11 Mar 2019 10:56:04 +0100
Message-Id: <20190311095613.11371-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311095613.11371-1-narmstrong@baylibre.com>
References: <20190311095613.11371-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl on the always-enabled debug UART AO.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index 6a7c3241862a..63c515fe4996 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -35,4 +35,6 @@
 
 &uart_AO {
 	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
 };
-- 
2.20.1

