Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D9EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CEB2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHbabakp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbfDBTT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:19:26 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34047 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDBTT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:19:26 -0400
Received: by mail-io1-f68.google.com with SMTP id n11so11949364ioh.1;
        Tue, 02 Apr 2019 12:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KAuT93FL/T7+bDPNkTO+kqBb77YV0Jq933v3CJxUkZw=;
        b=AHbabakp2VubV4yWs1vbHuWcxA5uj9EQDgxv44uikqQPKGD+EozaZik4y2E1RsyPHr
         1c/cFYwjSTqNGza2ipL/DRjesdMEHk4p0a70YMQpko4F+sb/sbbGXzlu+3RzEl8CSITd
         wXs8d0rRNbAy8RibRBULZ0pJcutU1jLZfm6uJCnKzZphEd+0p+TrxyRo0u6PMTSV4eF2
         Ni+LIQXrYfbDdE1LPeJOKbfzRXcIaJAMyt3ot6LfDdbZALx8M+iTwlSPb1SeFEUCsaPW
         NTNIkiOqEGuUPzOwcgxorAJuhPIbOpLVMsXPlcXaNINFO+KK9+g7S8R/j2YFfVlZf9Tb
         rzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KAuT93FL/T7+bDPNkTO+kqBb77YV0Jq933v3CJxUkZw=;
        b=qRGqPJE9Mo0BUQ180Qj1fv88EoBWstCFyk6ZHYD93rT4AvLhBGAHd9mY6Yhad+vBMZ
         q6uz1ZvCfhohMRmWXYdtyLnU/Sv2+2AVhTOsqo4BMIBczHrcMWK/TsoKKBbZFg/P/AI6
         p/d4TMH4Oq+g+VrcLbqfKZczCyuhe2zbBhZHKZNQWeqg69jEEj4Ou4fY/eDFxG7gC+Ri
         TU/SSa5HxBYvqjB9gKGI0evp5Jdlm/nXYjpJtWaNMQ9LzADBQEqwajXZ8Kdha9yuCc1i
         UURWwPQNK5bDWfNZv+eVnRp+KLXwYvFwAcubysHok+p+1p/Ylw+cxqmcng9G4vqwrXLa
         23HA==
X-Gm-Message-State: APjAAAX3z+yIkwtpToDb+K02M5FOuJeWFwM92OCIfAo/DjVF5NeG4Cnj
        TlFCE2ky63wy9BhF3g/soIQ=
X-Google-Smtp-Source: APXvYqyOykSfVzJdj7sp/mJ0SO0aEslbKdXnQ/KMJk2kHJsX4SHBMT1t/urWpC6AJlO5l0SHIMa5mg==
X-Received: by 2002:a5d:8910:: with SMTP id b16mr46782280ion.178.1554232765383;
        Tue, 02 Apr 2019 12:19:25 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id m143sm7428370itm.32.2019.04.02.12.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 12:19:24 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     adam.ford@logicpd.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] ARM: dts: imx6q-logicpd: Reduce inrush current on start
Date:   Tue,  2 Apr 2019 14:19:08 -0500
Message-Id: <20190402191908.4306-1-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main 3.3V regulator sources a series of additional regulators.
This patch adds a small delay, so when the 3.3V regulator comes
on it delays a bit before the subsequent regulators can come on.
This reduces the inrush current a bit on the external DC power
supply to help prevent a situation where the sourcing power supply
cannot source enough current and overloads and the kit fails to
start.

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

