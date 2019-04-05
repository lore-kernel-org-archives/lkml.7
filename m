Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB39C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E445B20651
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVePdXn0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731895AbfDERaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:30:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45612 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731654AbfDERaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:30:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id y3so3412479pgk.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 10:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HOAAF7Q5+Mmfenk/B6ngFo5DLE/BFH08NZXQWMhLjcM=;
        b=YVePdXn0PPYs/znWcFPD/C/Q4Uy9Jn5uSph2Dxkr0S1+1jlFmaPcB7+CLDyAArC8Uv
         6YcZCzzcg8MsXw0UguG7EWkBRdkPDbadQyiKQpVlx4t5RmdvkaNeHLqTjOYskujArzjf
         uXJR4bMNc0v6VcMmzh/3dqs3FB0tREkf6febct9/aPkrKZSbDU7XZ/J0c9bnaJjiSLzT
         8/SgKn/Ci3zkkPXskE+YvT9lMQ+QzfJ+JAEaxJHa+V7naejpBAovV9vTTEvCdR7/e0n/
         5BbaEC9qMfqtiXYuUDpaxaOz/mkVz6EbHKJSa2r8hlk8HfAzWhl9zkdYrdFMwyVvSCGI
         13oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HOAAF7Q5+Mmfenk/B6ngFo5DLE/BFH08NZXQWMhLjcM=;
        b=I4aQElc/1y+CV1ScdBzhDGgxcl8VluNJlvJML7GXvIv6+OkiVZm3Cm+kpJNoqqGZo0
         YdFk7ZaaP6ns6FH9kofgI209itqD1On/sZfI7EPdoJkSrce5wxkivZuC8m7Vwd+R3KcK
         dqbwB1HszYdv128rBOcOwwEyJeMxeN15uZomKOfAoEy5W8kTzSREWT2mYfmlj9Ndie1s
         N81Yd9PefP33WlhhY3BuMMyiBIuFv9c+3Trdjo/oUwiD7FOZiodbRXz6TAdxDAGFrK3L
         Z3/WBw+GkRoWPEFCvKDkLQ4jjrAfaJfFWKDyjgMX0kz51fNokogKtfW0J+qcpC66Z2j0
         f2jg==
X-Gm-Message-State: APjAAAVq76XwNtVXlgELJKzkmlkRxPf2mHVIOTxMixW67dktaHNZGVXz
        GXb4cA1NusBxk4r1YZKX7hE=
X-Google-Smtp-Source: APXvYqwL4rxZCJlAeiWVDUyQr9XtI9WVfjplLWcaQTDnHCFHN116VXwhEcnjJHUkZuLm3H4FUpLsyw==
X-Received: by 2002:a62:6490:: with SMTP id y138mr13842754pfb.230.1554485415724;
        Fri, 05 Apr 2019 10:30:15 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id 17sm49206730pfw.65.2019.04.05.10.30.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 10:30:14 -0700 (PDT)
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
Subject: [PATCH v5 0/5] PCIE support for i.MX8MQ (DT changes)
Date:   Fri,  5 Apr 2019 10:29:59 -0700
Message-Id: <20190405173004.13277-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone:

This series contains all of the i.MX Device Tree changes I made to
enable support of PCIe on i.MX8MQ EVK.

Feedback is welcome!

Changes since [v4]:

    - Fixed "src" -> "reset-controller" in "arm64: dts: imx8mq: Add a
      node for SRC IP block"
      
    - Collected Reviewed-by for the series from Fabio

Changes since [v3]:

    - Added "num-viewport" to PCIE nodes in "arm64: dts: imx8mq: Add
      nodes for PCIe IP blocks"
      
    - Rebased on latest for-next of i.MX tree
    
    - Collected Reviewed-by from Lucas for "arm64: dts: imx8mq-evk:
      Enable PCIE0 interface"

Changes since [v2]:

    - Fixed various nits pointed out by Lucas

    - Collected Acked-by and Reviewed-by from Lucas

    - Moved EVK's WiFi reset pin configuration into a separate pinmux
      entry.

Changes since [v1]:

    - Dropped unsupported IRQ from PCIe nodes (a leftover from vendor tree)

    - Added "pcie_aux" clock and moved clock configuration to board
      file since "pcie_bus" clock is now board specific

Thanks,
Andrey Smirnov

[v1] https://lore.kernel.org/lkml/20190131204333.31846-1-andrew.smirnov@gmail.com/
[v2] https://lore.kernel.org/lkml/20190208002941.30343-1-andrew.smirnov@gmail.com
[v3] https://lore.kernel.org/lkml/20190220015857.7136-1-andrew.smirnov@gmail.com/
[v4] https://lore.kernel.org/lkml/20190401022413.6682-1-andrew.smirnov@gmail.com/

Andrey Smirnov (5):
  arm64: dts: imx8mq: Mark iomuxc_gpr as i.MX6Q compatible
  arm64: dts: imx8mq: Add a node for SRC IP block
  arm64: dts: imx8mq: Combine PCIE power domains
  arm64: dts: imx8mq: Add nodes for PCIe IP blocks
  arm64: dts: imx8mq-evk: Enable PCIE0 interface

 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 42 ++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 87 +++++++++++++++++++-
 2 files changed, 127 insertions(+), 2 deletions(-)

-- 
2.20.1

