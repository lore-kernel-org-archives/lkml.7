Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8136C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 02:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8E5218E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 02:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqy6rCkD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731679AbfDACYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 22:24:35 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34690 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731628AbfDACYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 22:24:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id y6so3703383plt.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 19:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LBN0mkzwyw8Rcu7pQS+Gmvv7waoUnDRCjSKeMe9btfg=;
        b=nqy6rCkDYDihbkhg+H1iqvHsyjNFaAAz5D8hdvLkAbURsam8cZQd+YS3U8No7c5fFJ
         o1JVxQZVLKixH0rh2hG6KGa4HR7ONRy1wvAo6xNz1RtN7EjB6ikxczPU702t/nRobX+V
         gnP0jlfA6LsnjyAJTSvEK1ifI8AJXxii8A0eTwXNK78/E77zDtWSYuhVLPn/vz2htZKp
         3fCouBnNHgEzHjwh3+6MHumTF7GXX9yP484IjLzT5JTsBI8HC5ooTrxkwhAbPt0jiqKf
         PL7OMlEc95P40WdeE36QkgNpvKhJ7uKCRa6O5slqxbEHmVXLbBw6jdhbJ6Js0Qqyw5oE
         AUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LBN0mkzwyw8Rcu7pQS+Gmvv7waoUnDRCjSKeMe9btfg=;
        b=MVHW6VPSklYu7LPqqENulxkBzWfIq2MiifYHG1U0tggIEO5FK/43EjBWac62z1B3zr
         YuZ4xqmmm9ZCEERfuuqzxiPhnhYVs82rFFgnLNNIKs8raXEzqynqZ7FA88e5uXhU/mtC
         WrtBoNafa65nKRSMAKpEEjErCga/0+NCVyBAKurWQooMEwCLyB6r7whjQvMhpr175xdt
         9LNMDvvs2pXVhs+5SODJ4nYWDKMj0uWOW9a8LSwvYS+VSakO6uTwAQqubxcjBnTLQeMu
         SkhC0UJSM+f6AT1j4oC78enEKtQcS7n0FgKuxErvVaYc2PqIgVq6ESXb8UjwnRKbM7yg
         uxqQ==
X-Gm-Message-State: APjAAAU810P28wnrwC4T6MMXrIZOW/wV0/XQFEcLiTTGgHumT0GBDDPh
        pHW5V1v5AOzqqTFZzrbYdu4=
X-Google-Smtp-Source: APXvYqxlUYNIp6vgLGIzM+7LwSfeYD4Sxtuamulpdp+co8ZgZzmFnYFcmtaF1LbSRbcNhdGBgZNzyQ==
X-Received: by 2002:a17:902:3381:: with SMTP id b1mr52183067plc.5.1554085470940;
        Sun, 31 Mar 2019 19:24:30 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id n82sm13597289pfi.63.2019.03.31.19.24.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 19:24:30 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] arm64: dts: imx8mq: Add a node for SRC IP block
Date:   Sun, 31 Mar 2019 19:24:10 -0700
Message-Id: <20190401022413.6682-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401022413.6682-1-andrew.smirnov@gmail.com>
References: <20190401022413.6682-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for reset controller IP block found on i.MX8MQ.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 3de390777af1..656f7cb97703 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -450,6 +450,12 @@
 				              "clk_ext3", "clk_ext4";
 			};
 
+			src: src@30390000 {
+				compatible = "fsl,imx8mq-src", "syscon";
+				reg = <0x30390000 0x10000>;
+				#reset-cells = <1>;
+			};
+
 			gpc: gpc@303a0000 {
 				compatible = "fsl,imx8mq-gpc";
 				reg = <0x303a0000 0x10000>;
-- 
2.20.1

