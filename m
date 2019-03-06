Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE67C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D49620661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hv26uMzY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfCFOE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:04:28 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40067 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfCFOE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 09:04:27 -0500
Received: by mail-yw1-f65.google.com with SMTP id c67so9989824ywa.7;
        Wed, 06 Mar 2019 06:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hC5HT8j9xR/VbOnWOJXKq+qZxrk+ugO3pzNZQvzXvmU=;
        b=hv26uMzY/f3wBy2NHO+d9Sl7yS4hnzGjgDtlG0ILsOdFtfBKD6/mixloVSiNnPHqt8
         Mmwnyvt8gBKswRN9Jl3Tcx2ZbVcLclPYhtvXEVDc1yL3ybEx0TO1XGuNW/zHn3GKTU4q
         NqjLchxAPkHmjAAtD6a6HvXY96RGYZQXFAqMGjHgAnoAbUQQARES9ZSCSx1ufTrqjPdI
         4c9d8sIWJivFtgOQRDKNJou/j1AswLjRPBhKVHLyyCIChPXyENAJU3NLSP8CHavpkHvp
         PkXeku8gu81L4AGiJYeBru/GKuPz9DmYq02rHGcS94JpnHOVt6Y4aZIQwa0eCKWrSTJG
         E2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hC5HT8j9xR/VbOnWOJXKq+qZxrk+ugO3pzNZQvzXvmU=;
        b=dlKNkOZBPyC2jcNFx0/5zYW9LEF0I63bifrjePhO7XV2UAQeuKNAyynX85b9mjvAVM
         ZsZ5zOypFHU4F+1Yc1VqTDA4wfIkWYDa75hMMrx04RX5g1bF8c+2IEr3HYsJEReCDDoJ
         BU3eINRl3KL+hYrSsnYwR2g3er7IS89LTy3CJO2pco7RT+e25d/yZWPZAdkK3Erz2ZdD
         1BptRNtvZzkkovRr1FeR+elgtMkzQ14wTWVrF6g9rku7rmZ5MvIaTMEVTfzH4dvMCGAd
         DIytU4/UZfNn38cgG2IBK+CnURqxQhochE4ds7gaixROIAf9a55a6Lp6A96EM/5l0Mw2
         bMQQ==
X-Gm-Message-State: APjAAAVStAZiMifLTTQLGmJQQ//FTi/X+HGmzisz7TBB4t2/sRPoxzp5
        WFrDsFl2WPvRK8FvVNzJkts=
X-Google-Smtp-Source: APXvYqw7sDdKaYZrjvnBkOfutFOibK6I16GQLOvRNKvTD4yXTyy5UbQcOyLSOcKRW2kn9Oeyso8zEA==
X-Received: by 2002:a81:3b56:: with SMTP id i83mr5560902ywa.508.1551881065902;
        Wed, 06 Mar 2019 06:04:25 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id r205sm859112ywb.70.2019.03.06.06.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 06:04:25 -0800 (PST)
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
Subject: [PATCH 3/3] ARM: DTS: imx6q-logicpd: Fix Analog audio capture
Date:   Wed,  6 Mar 2019 08:04:01 -0600
Message-Id: <20190306140402.17122-3-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190306140402.17122-1-aford173@gmail.com>
References: <20190306140402.17122-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original submission had functional audio out and was based
on reviewing other boards using the same wm8962 codec. However,
the Logic PD board uses an analog microphone which was being
disabled for a digital mic.  This patch corrects that and
explicitly sets the gpio-cfg pins all to 0x0000 which allows the
analog microphone to capture audio.

Fixes: 1c207f911fe9 ("ARM: dts: imx: Add support for Logic PD
i.MX6QD EVM")

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi b/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
index e31b6923cb72..db6b5b900826 100644
--- a/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
+++ b/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
@@ -248,9 +248,9 @@
 		gpio-cfg = <
 			0x0000 /* 0:Default */
 			0x0000 /* 1:Default */
-			0x0013 /* 2:FN_DMICCLK */
+			0x0000 /* 2:FN_DMICCLK */
 			0x0000 /* 3:Default */
-			0x8014 /* 4:FN_DMICCDAT */
+			0x0000 /* 4:FN_DMICCDAT */
 			0x0000 /* 5:Default */
 		>;
 	};
-- 
2.17.1

