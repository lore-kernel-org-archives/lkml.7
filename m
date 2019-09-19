Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54592C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 05:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279C5218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 05:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XpIyaEir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388075AbfISF2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 01:28:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44777 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387421AbfISF2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 01:28:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id q15so1038552pll.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 22:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E8KFyd/TP6XKCfQ2oRClCpzfGJuYKDTzZWJ6RMaNc7U=;
        b=XpIyaEirHSq/r7bNW+OHgSAFA4nLR1NS2ExLkb1HX9sjR961wapQb1OBvviY1rbtlu
         QrV9Hma5WMowRwq5dKiuIDQrSUmfckih2b5OLxxW3mCBI99/LHD7dMJcGOLQ6prwBQSq
         sWviVTRlu10qfi+H7BjPBzB1uZS5rYWg+X6q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E8KFyd/TP6XKCfQ2oRClCpzfGJuYKDTzZWJ6RMaNc7U=;
        b=aq6n2Sbz24qvS5ASMCajSxhcGHZ2sUSgWF7AuwjwjV3gm9iN31bbx8CGv6ws+DR1OO
         hZC4incmrVBu6aTO1o8dbMNjv/sO1yf4A0gJkBs+Ng0SvuGMY13CpB/fOrgHTIa/GeGw
         8mONKg+GnvMA77wGr6QJ1VPnssxsGz0tVVnEme1roa4mx71I4i5gzgTtZO9/dxzdhCF1
         Nfo+WnRIrHnscDvP7oy6zE4gEUCMe63GBFimoaYVIxdl4WBqdnyzWZuPuon/7yicn6Ef
         KQ1vPteud80mPxBGq8DsnjsX/z1CBMcvuF9dYVldH39yXipsoCxHIKTTBp59n1O8JrTp
         f46Q==
X-Gm-Message-State: APjAAAUlxfW6BTU/NGGgj3QInPUOP6sPgOWxvT1UFv9Ftb+t5xmH+DK1
        /+6vIybCPFaPnMIxjWh1bTVfcg==
X-Google-Smtp-Source: APXvYqyXep4j3PxBeU3HcFSA72SjdVCFY3JFDwTX+hv+32+q1l8s4NYodtDu9DB7lZ+aFuZ2ut2P8g==
X-Received: by 2002:a17:902:7485:: with SMTP id h5mr8110269pll.240.1568870922029;
        Wed, 18 Sep 2019 22:28:42 -0700 (PDT)
Received: from localhost.localdomain ([49.206.200.127])
        by smtp.gmail.com with ESMTPSA id z20sm5051930pjn.12.2019.09.18.22.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 22:28:41 -0700 (PDT)
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
Subject: [PATCH 0/6] arm64: dts: rockchip: ROC-PC fixes
Date:   Thu, 19 Sep 2019 10:58:16 +0530
Message-Id: <20190919052822.10403-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is trying to fix the Linux boot and other
regulators stuff for ROC-RK3399-PC board.

patch 1: attach pinctrl to pwm2 pin

patch 2-4: libretech naming conventions

patch 5-6: regulator renaming, input rails fixes

Any inputs?
Jagan.

Jagan Teki (6):
  arm64: dts: rockchip: Fix rk3399-roc-pc pwm2 pin
  dt-bindings: arm: rockchip: Use libretech for roc-pc binding
  arm64: dts: rockchip: Use libretech model, compatible for ROC-PC
  arm64: dts: rockchip: Rename roc-pc with libretech notation
  arm64: dts: rockchip: Rename vcc12v_sys into dc_12v for roc-rk3399-pc
  arm64: dts: rockchip: Fix roc-rk3399-pc regulator input rails

 .../devicetree/bindings/arm/rockchip.yaml     | 11 +++---
 arch/arm64/boot/dts/rockchip/Makefile         |  2 +-
 ...dts => rk3399-libretech-roc-rk3399-pc.dts} | 38 ++++++++++---------
 3 files changed, 27 insertions(+), 24 deletions(-)
 rename arch/arm64/boot/dts/rockchip/{rk3399-roc-pc.dts => rk3399-libretech-roc-rk3399-pc.dts} (95%)

-- 
2.18.0.321.gffc6fa0e3

