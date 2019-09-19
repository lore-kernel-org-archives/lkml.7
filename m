Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19218C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 05:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E262C218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 05:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CVrhIqzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388101AbfISF2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 01:28:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35125 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387421AbfISF2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 01:28:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id 205so1520332pfw.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 22:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XPWIJYAR47Worstin6zW+dVRix1pyzYI/7tlhqwLmcw=;
        b=CVrhIqzEBP+EyUAVxY2kKenvRSLjM/kDVDi5A1RYbnBpBG+8/E94MY4AM0cLYF1Tsr
         ylqt/pSWzFvWtpYVq0S/5E6lkJy2n3J0OIU9yfRB58+rgKdE3utAvYu+obSsiTsDUSzs
         ewuKHkaieM/KaNUCEz+7NmRhdqohxPeCcdy2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XPWIJYAR47Worstin6zW+dVRix1pyzYI/7tlhqwLmcw=;
        b=QA6wn8QW5OLnS6h6c5tYP6y0SSGorOTNwfvo0JD3ZkBwP6nM2/IJNq6CEucIp5yc+b
         qLBPc/zcOm+gJ9/rT+Tv4gaUN60r/TzhAOCANjTboM2i3jBe8bsUNay7aaM3n+iRVWZt
         1stDEU6BHLs2+Pp3eYLhCnB58UrJmmdXewyxesGC/2PcuU5eBZVLfwdt80rkL2n4HsE+
         ji0BibVZ/GWyHunaRfnuyCl9CIOdQT1eZewnmi+YPZ5TiqTz/dy5FkCfkpS6VelDHaJW
         hayerPaK9LCq+NKPmdeZdfVHgIm94Yq58C3OxCgwi9fgCDsekUWd24RsWwNTPyOObbSP
         0egw==
X-Gm-Message-State: APjAAAVXjC4cmMURZuwNlVnOq92+IkP1zVSNxly0chveRTfK7DyIW69j
        mhCm2VfbRQdTuyTEZ8+WVrsf6VcpQDM=
X-Google-Smtp-Source: APXvYqzYV9rQ44H/pk5Hsqy5s4BegMtVSBEUWtMyOkGlq4eqULoz1dX+pIF76eOAQ8TcrjSoiDL+Ew==
X-Received: by 2002:a63:5fcf:: with SMTP id t198mr7340060pgb.270.1568870926501;
        Wed, 18 Sep 2019 22:28:46 -0700 (PDT)
Received: from localhost.localdomain ([49.206.200.127])
        by smtp.gmail.com with ESMTPSA id z20sm5051930pjn.12.2019.09.18.22.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 22:28:46 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Levin Du <djw@t-chip.com.cn>,
        Akash Gajjar <akash@openedev.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Da Xue <da@lessconfused.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 1/6] arm64: dts: rockchip: Fix rk3399-roc-pc pwm2 pin
Date:   Thu, 19 Sep 2019 10:58:17 +0530
Message-Id: <20190919052822.10403-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190919052822.10403-1-jagan@amarulasolutions.com>
References: <20190919052822.10403-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ROC-PC is not able to boot linux console if PWM2_d is
unattached to any pinctrl logic.

To be precise the linux boot hang with last logs as,
...
.....
[    0.003367] Console: colour dummy device 80x25
[    0.003788] printk: console [tty0] enabled
[    0.004178] printk: bootconsole [uart8250] disabled

In ROC-PC the PWM2_d pin is connected to LOG_DVS_PWM of
VDD_LOG. So, for normal working operations this needs to
active and pull-down.

This patch fix, by attaching pinctrl active and pull-down
the pwm2.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
index 19f7732d728c..c53f3d571620 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
@@ -548,6 +548,8 @@
 };
 
 &pwm2 {
+	pinctrl-names = "active";
+	pinctrl-0 = <&pwm2_pin_pull_down>;
 	status = "okay";
 };
 
-- 
2.18.0.321.gffc6fa0e3

