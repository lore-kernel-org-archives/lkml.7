Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6E6C32770
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50B82464E
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgADPdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 10:33:52 -0500
Received: from wp126.webpack.hosteurope.de ([80.237.132.133]:44202 "EHLO
        wp126.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726080AbgADPdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 10:33:51 -0500
Received: from [2003:a:659:3f00:1e6f:65ff:fe31:d1d5] (helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1inlQn-0000ox-Gq; Sat, 04 Jan 2020 16:33:37 +0100
X-Virus-Scanned: by amavisd-new 2.11.1 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from roc-pc (p508F384D.dip0.t-ipconnect.de [80.143.56.77])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.14.5/SuSE Linux 0.8) with ESMTPSA id 004FXass009220
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 4 Jan 2020 16:33:36 +0100
From:   Markus Reichl <m.reichl@fivetechno.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Markus Reichl <m.reichl@fivetechno.de>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 0/5] regulator: mp8859: add driver for DC/DC converter used on rk3399-roc-pc board
Date:   Sat,  4 Jan 2020 16:32:44 +0100
Message-Id: <20200104153321.6584-1-m.reichl@fivetechno.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1578152030;a7085fc8;
X-HE-SMSGID: 1inlQn-0000ox-Gq
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On rk3399-roc-pc board a voltage regulator MP8859 from Monolithic Power Systems
is used to supply the 12V power line. This delivers 5V as a default value after
boot. The voltage is controllable via I2C.
Add a basic driver to set and get the voltage of the MP8859 and add a matching
node with fixed 12V in the DT of the board. 

Markus Reichl (5):
  regulator: mp8859: add driver
  regulator: mp8859: add config option and build entry
  dt-bindings: add vendor Monolithic Power Systems
  dt-bindings: regulator: add MPS mp8859 voltage regulator
  arm64: dts: rockchip: Enable mp8859 regulator on rk3399-roc-pc

 .../devicetree/bindings/regulator/mp8859.txt  |  22 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 .../boot/dts/rockchip/rk3399-roc-pc.dtsi      |  32 ++--
 drivers/regulator/Kconfig                     |  11 ++
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/mp8859.c                    | 156 ++++++++++++++++++
 6 files changed, 210 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mp8859.txt
 create mode 100644 drivers/regulator/mp8859.c

-- 
2.24.1

