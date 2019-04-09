Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D3FC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B946D2084B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j/P7HvSG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfDIUtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:49:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46123 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfDIUtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 16:49:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id y6so10110220pll.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 13:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XlYzZy8TYO5PMiZ/P87s3/AMR2PGS6dQ+mqKjGyhDdQ=;
        b=j/P7HvSGfharjDN338Ohh0VmEVGNHqh9aoAYdfaUqcWqyMAJ5wyY+lKGlXis0jdn1M
         J+/iWmHtUFJgYO45NLPe/B4jKKg7bVt3g0gCVM+BqSNWzn42GQSuWocup1Rv/4pJTwQC
         jEesh+eo6/oajNOj9xCxn2yL4GSC3PdaSCMq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XlYzZy8TYO5PMiZ/P87s3/AMR2PGS6dQ+mqKjGyhDdQ=;
        b=ok0M5CBdtlhq3NbDSICDlfpoZphLLJBz5Np1jOKFQ9uJmxmgQaU2lwsyFDpyET6URa
         wMe60eiTGis6+zf3tPs0TWJ/WlQgtPwnoqZVN+GIRAjNeGtc/ZpjbQ8a1YbMD/Skwpmu
         EjH8ziT4Qs7AyBS8gOZPUNbMUixw5dNFpwWMGHOSMLKUVKXE7Anb1qp/SdKhsZZeFPxp
         2DEk8eKHi5rkGE0qFNi+JehTZ2xA1ZGkBdCVLieEguADj4QCB8mH+9Mt68QC/J5LRZVq
         WRwXJ/yoyYEv8Jk+xUqF/+Bx7etZabNFvWQNV0VW8hYgAcQ1sQtzpgSiveJPbeka+FOl
         whIg==
X-Gm-Message-State: APjAAAU/kCZphANfUSLtTgm2dQ4/dRtJ2QWsOsNzOpPT4xduhKMTtm5F
        x/nagoF/8ILWxB9QSbU3P56Qwg==
X-Google-Smtp-Source: APXvYqx8nR26wlcezqVkZiGwrmjJLH83E3OxO61TrSgWpEDGkyEDTRG5cgFmn4sKiB4fIhRzSbZBgA==
X-Received: by 2002:a17:902:141:: with SMTP id 59mr3322848plb.132.1554842953307;
        Tue, 09 Apr 2019 13:49:13 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id x9sm54349543pfn.60.2019.04.09.13.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 13:49:12 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Caesar Wang <caesar.wang@rock-chips.com>, mka@chromium.org,
        ryandcase@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: rockchip: Set the proper PWM for rk3288
Date:   Tue,  9 Apr 2019 13:49:05 -0700
Message-Id: <20190409204905.152432-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rk3288 SoC has two PWM implementations available, the "old"
implementation and the "new" one.  You can switch between the two of
them by flipping a bit in the grf.

The "old" implementation is the default at chip power up but isn't the
one that's officially supposed to be used.  ...and, in fact, the
driver that gets selected in Linux using the rk3288 device tree only
supports the "new" implementation.

Long ago I tried to get a switch to the right IP block landed in the
PWM driver (search for "rk3288: Switch to use the proper PWM IP") but
that got rejected.  In the mean time the grf has grown a full-fledged
driver that already sets other random bits like this.  That means we
can now get the fix landed.

For those wondering how things could have possibly worked for the last
4.5 years, folks have mostly been relying on the bootloader to set
this bit.  ...but occasionally folks have pointed back to my old patch
series [1] in downstream kernels.

[1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1391597.html

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/soc/rockchip/grf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/rockchip/grf.c b/drivers/soc/rockchip/grf.c
index 96882ffde67e..3b81e1d75a97 100644
--- a/drivers/soc/rockchip/grf.c
+++ b/drivers/soc/rockchip/grf.c
@@ -66,9 +66,11 @@ static const struct rockchip_grf_info rk3228_grf __initconst = {
 };
 
 #define RK3288_GRF_SOC_CON0		0x244
+#define RK3288_GRF_SOC_CON2		0x24c
 
 static const struct rockchip_grf_value rk3288_defaults[] __initconst = {
 	{ "jtag switching", RK3288_GRF_SOC_CON0, HIWORD_UPDATE(0, 1, 12) },
+	{ "pwm select", RK3288_GRF_SOC_CON2, HIWORD_UPDATE(1, 1, 0) },
 };
 
 static const struct rockchip_grf_info rk3288_grf __initconst = {
-- 
2.21.0.392.gf8f6787159e-goog

