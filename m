Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D05C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B230D208CA
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="w90nqpfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbfGALz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 07:55:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35301 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbfGALz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 07:55:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id c27so5816171wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 04:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qmqH9rUtyBqQ8/Pqi8TtxfD5jhJ2Pj45pX1IFFE+c74=;
        b=w90nqpfyUXLoK9HwqQjWvkFBF8kUXPM70Ljq5G3iO0MB/FMV92bgziq8XMCA/p6iTI
         /hXFLYZloGuyJURQm5gfYucvWpGNbSG5hyWaffs0p6+RA6uF27U5vS4F4oxB+CmwEPjX
         Dr0etGwOOqXg08MIYcnKDxgiPhaMJblYiTyg7ymIyM3QtAnxqBSldgKKB8+fnWlXQ9pP
         fZzR1YHzA9xIqoQYSSSXM+6jxOXusnNBrf6MhSM1/gCNCyrcKWcKkiu4bJWaRP13KNX0
         SjsnqJFGw90WL3HMYiZ1FVH0yMFj6RYOmAMhQZrF8oU+WobbyLQJB3XlazBbRxdki0N9
         1c4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qmqH9rUtyBqQ8/Pqi8TtxfD5jhJ2Pj45pX1IFFE+c74=;
        b=VuBCrGTVYFn/0ZCSv2cmVwzCnVIfGrddJVZo1zx0iYmH7fixH0aBIpn5SG9FgR1q1b
         xGj/HcyXxkZq2NiHaCZ5HA9ZvueadLwBwaW070Xo0qrChBFuhPKOSJw8sp7W62x1W9AC
         zKioGxTMsLlwq1CPQhDxNIVE7bl7oqC77LY0406J3xN1BknJGEPSPOO5M2d5fbfLAEfZ
         DfiVD7PEqddO/6uy9pWHFUxx9CIF0IFIpepov/+1DwHqoIvzNS2fzlcF69h2sXtSQx3V
         wvyAYOLZIWPCsadJo+5RjxeqU1Fky+0FCQ9hj5fvYYX0UvMod/qNq1Z58QINDr+kIgmA
         EgDw==
X-Gm-Message-State: APjAAAW0DS7I24TFvdAKexlXmd2Myp4zboqLDiJR+6n1TZRGE6FNT83s
        dmDDXJL9MBoiBsAEDgR2s40zcw==
X-Google-Smtp-Source: APXvYqyYKsCFPZS7MzmobncNQun9FRifaopq+RvFcsPDvQx+xuv/xlBF4qmqiCBuSt75XoHIYUdXzA==
X-Received: by 2002:a5d:6508:: with SMTP id x8mr20035348wru.310.1561982155268;
        Mon, 01 Jul 2019 04:55:55 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id j7sm14210686wru.54.2019.07.01.04.55.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jul 2019 04:55:54 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] arm64: dts: meson-g12a-sei510: enable IR controller
Date:   Mon,  1 Jul 2019 13:55:51 +0200
Message-Id: <20190701115551.15618-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable IR receiver controllera on the SEI510 board.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index c7a87368850b..12aa7eaeaf68 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -339,6 +339,12 @@
 	pinctrl-names = "default";
 };
 
+&ir {
+	status = "okay";
+	pinctrl-0 = <&remote_input_ao_pins>;
+	pinctrl-names = "default";
+};
+
 &pwm_ef {
 	status = "okay";
 	pinctrl-0 = <&pwm_e_pins>;
-- 
2.21.0

