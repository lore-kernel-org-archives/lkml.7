Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291C0C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88F020661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mL0APZsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfCFOEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:04:30 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46901 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCFOEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 09:04:25 -0500
Received: by mail-yw1-f66.google.com with SMTP id n12so9978712ywn.13;
        Wed, 06 Mar 2019 06:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rEf4ejbpthV1S86dVzs0RdnPSjp5YJYxDnpkYt7WdcQ=;
        b=mL0APZsafGKKrdJcMuvUcvABwk2reRhCRKMV92Xxy0iM1+/crnUVRw1gsG9Y3DcpOk
         nmoVh2pDvDxh1YzwRgstQVyfVTNwV0yWzeu7FtuQMYXArm2At8mHspbInWUHBAI+DMnm
         wIUFxRrVlzo9BLTP6uxVUIk0XEiDs0IOk5lJaPL2Aw9B6QJLdnsvPDTR7CS7Z6elFngD
         b3akg01MprlaM6jGuU9o73oIEuqmC5fBFQjZ4Sqjf4QN7Nm0Iv+Sl7O55YwFUru9A5lO
         J43+nFq4F45gK6l1CHESBuDKhNcuoKe12aEC79gtFA3pgKPyTuscwN96cSZeXPlnL8R0
         Qq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rEf4ejbpthV1S86dVzs0RdnPSjp5YJYxDnpkYt7WdcQ=;
        b=JIvJ9MuIoK80LpW3mZEfRI4U6+pEsDB8hu5hhsO9eInqstfzuX45RtbrAZiMwx4eA9
         DCk9sHb8+5I/42xbd4aKx+ig0SE0Iteao9uZPYe9Y08U57MF9io3u5QAyXZQVV4Av56M
         4juIgjduOib7GlrBS2e7oFOpTH2BQpgrr/CJpCT7aAjuvQWPp6rgEeg84QFQgHjZn6lo
         jnnxs+2pgp4y4Svj/lC8QHTompwNv1UUJqy7o/Em/ipXRZLUWUIjrpPyXKQ9fyHPbGW2
         GEqVJDIMcjO9ztGtPuP+UvuSigL2RRy4n0CQUqJVEt0hsqopAOctgOQO6gww0DQTUHMy
         TL2A==
X-Gm-Message-State: APjAAAXb5WFRMkP+oUpWmAB6qU1pETrwZSOhdnL6JH+DiRNyDDLMAP5d
        yKoojNHU15A5YtfQDgEbvBuPVW+bBzE=
X-Google-Smtp-Source: APXvYqxd3A1zohMnp5iXK9hyMunRMIlDZRi3uS77Qs5hyFktGAxSMTQr+8Gc7CtUeSWa3xgZqH7adA==
X-Received: by 2002:a0d:df44:: with SMTP id i65mr5462835ywe.180.1551881064322;
        Wed, 06 Mar 2019 06:04:24 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id r205sm859112ywb.70.2019.03.06.06.04.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 06:04:23 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Adam Ford <aford173@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ARM: DTS: imx6q-logicpd: Reduce inrush current on start
Date:   Wed,  6 Mar 2019 08:04:00 -0600
Message-Id: <20190306140402.17122-2-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190306140402.17122-1-aford173@gmail.com>
References: <20190306140402.17122-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main 3.3V regulator sources a series of additional regulators.
This patch adds a small delay, so when the 3.3V regulator comes
on it delays a bit before the subsequent regulators can come on.
This reduces the inrush current a bit on the external DC power
supply.

Fixes: 1c207f911fe9 ("ARM: dts: imx: Add support for Logic PD
i.MX6QD EVM")

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi b/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
index fb01fa6e4224..e31b6923cb72 100644
--- a/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
+++ b/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
@@ -99,6 +99,7 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio1 26 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <70000>;
 		enable-active-high;
 		regulator-always-on;
 	};
-- 
2.17.1

