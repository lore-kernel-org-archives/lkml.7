Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423C1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122642082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jbx8eCCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbfC2GuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 02:50:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43740 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbfC2Gtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 02:49:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id c8so575940pfd.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 23:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k2Cjq9x631wLzGK9gtayGHpM1M/LJ4e0deWNdmi+j4Q=;
        b=Jbx8eCCxlkj9f7lJcaEAl/HEHgnmd23R2aMcPE63P988aQzKfTpRGRqss7KmVBiP90
         jDkNg2oZxMGgXzun5Z4ASHo65AF2SsbCn5jEGOFay2GfCplLoJfJoUL/DB6sgh67f3Kb
         Iqee6lVHWiaClL11akdrKiRKVFU/w4NX5+xFhJr+J+YLjO6rB68zuLnbMvJHd5ERWrWK
         X3TzLtwek6CnqwZIdkCfjs07KR2E7RzQbo5wSZ6QJ1Z+Idil0GyLY8vaErb6BrvK4B+A
         lypAoCjfnYgf4zDlCl40bsd23rJmlC2SHNtZRmOASJQsH18jiJPcsv4PgcskE9jN2gko
         dwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k2Cjq9x631wLzGK9gtayGHpM1M/LJ4e0deWNdmi+j4Q=;
        b=PG2h1QPxTV//uHj8+W00tvgtaXHIAL6ZQf6nhMJNQWMmmkSJ9sp5x1q1uYyZoncfCi
         WMNDtLItwUrjUiUnz/YAF6+EMjAyik/MqnR5kerHh4Z0ZcZ/I205C0p7EDwhgtS00LF4
         +IExeZC1KJ8AF3XfSe+OA1lhxueZ8G8jwlIsjEt5NNFnP11vPruvdUJUnKoj/EMDLazj
         +Gj9u4xDWbW2a+qVrGSTjw9mYQuM0KHw8UBqbZ6uq/NQyWuonB3o5IrnWiZvtgKnerdo
         jzyJ1Gnzxi1Se+DPghxRI07U9G3zJqNhdixHFXWlsgL55Mv2Cb/RHzZW/ddbuGcBqMaP
         2QBA==
X-Gm-Message-State: APjAAAUXt2mKc3wYYSvNhFV1M9DJrKLNlfmsC6wgGWULcik3dqUlz6Ud
        8yFqYuh7g1MpkrWi28GC548=
X-Google-Smtp-Source: APXvYqxLsZC5YO8cJYi/3oaIayEUxv71d9UTF146nTi30hXAygzBFtodjO31jw3aEpc97YjhVfGy+w==
X-Received: by 2002:a63:78a:: with SMTP id 132mr36937172pgh.196.1553842185715;
        Thu, 28 Mar 2019 23:49:45 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i5sm1602818pfd.16.2019.03.28.23.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 23:49:44 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/9] ARM: dts: imx51: Specify IMX5_CLK_IPG as "ahb" clock to SDMA
Date:   Thu, 28 Mar 2019 23:49:23 -0700
Message-Id: <20190329064924.8728-8-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329064924.8728-1-andrew.smirnov@gmail.com>
References: <20190329064924.8728-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 25aaa75df1e6 SDMA driver uses clock rates of "ipg" and "ahb"
clock to determine if it needs to configure the IP block as operating
at 1:1 or 1:2 clock ratio (ACR bit in SDMAARM_CONFIG). Specifying both
clocks as IMX5_CLK_SDMA results in driver incorrectly thinking that
ratio is 1:1 which results in broken SDMA funtionality. Fix the code
to specify IMX5_CLK_AHB as "ahb" clock for SDMA, to avoid detecting
incorrect clock ratio.

Fixes: 25aaa75df1e6 ("dmaengine: imx-sdma: add clock ratio 1:1 check")
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/imx51.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 0b28b68a17bb..e3fa3d213cd8 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -502,7 +502,7 @@
 				reg = <0x83fb0000 0x4000>;
 				interrupts = <6>;
 				clocks = <&clks IMX5_CLK_SDMA_GATE>,
-					 <&clks IMX5_CLK_SDMA_GATE>;
+					 <&clks IMX5_CLK_AHB>;
 				clock-names = "ipg", "ahb";
 				#dma-cells = <3>;
 				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx51.bin";
-- 
2.20.1

