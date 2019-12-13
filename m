Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1746DC751DE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3907B247DC
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKVRcrFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfLMQFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 11:05:51 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43187 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbfLMQFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 11:05:51 -0500
Received: by mail-yw1-f68.google.com with SMTP id s187so22199ywe.10;
        Fri, 13 Dec 2019 08:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XEqMHcTdDOYOvlqXuxrY0ZDmTfpLPgj3LFItvyhrGW8=;
        b=NKVRcrFQi760LHcc2CA3mSfP216r5ge0bRp8GoTBxQzDEoVuCBqhn0AnB12G/DmyIN
         7Zi15rAWKE+6u8EKYPiy3nu7oTaK5y4xGj5v1FFU9OeZdev3wLePzS27Rkg9I+xGub9I
         BjVjua+vP5CtwTTtDm0Erd2lv6gGzHFiO+eHL3CS+WnWEJavdNg4ge7f1YNh8qPoTOvJ
         oLeb8/YH+bUQBRJK+1ii49WoOVdX9FMfzWXw+QClPLnUwhLIqprDDRsL2pU6LRXvQd85
         JKxf1xFOMXICKrzwC0pUKzTXHqKJHui89SGkOKuS83pvy6UfKsVaILzw1wcnRL9L9mEa
         Nbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XEqMHcTdDOYOvlqXuxrY0ZDmTfpLPgj3LFItvyhrGW8=;
        b=sIptDIS6AalEA1rtX6Rte91Svnp3l3R4BfNfkD5PXqpMTgULeX+BCKigqDYhwx5rWw
         LlOq1+AXqvbHblJK74yxcoBSj9UFvNw9zzqzhVmHbHaxyQFgmdBw9fosIcrcul/5jW8n
         v5bavzQzdc8NoIWWSJVTVEM0I7kI7QUTIV2W+SD0slgrRhTW11Y0uIqVt8Es20hIA7Y+
         ueLWVlzdRlk4gonRwt6yb3G7uL/Z7bFWpccQ86ZLRFBnjzUesU0Yp08GHVxaKfTrbKf4
         H2tMvDyYV70cVHhp5s9viZCA1gz/MLhS0VpWvhJvjVb0SdRPMI+DE7arMTe3afvgp42l
         FqmA==
X-Gm-Message-State: APjAAAXemg3wc4XybPsNNamwQino2XTQMspbFXMDMpixsjqXVPyitm6B
        ahSBmLsKWA+inNlw1bjrJi0=
X-Google-Smtp-Source: APXvYqys0XoQhk+58M8smG2N+QHVvjzqTiqDCi74zIQgQS1eYZb6PW/ZmzSN70o7vzlpSbz5S4WEFw==
X-Received: by 2002:a0d:c041:: with SMTP id b62mr9089386ywd.488.1576253149508;
        Fri, 13 Dec 2019 08:05:49 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id v38sm3984694ywh.63.2019.12.13.08.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 08:05:48 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     peng.fan@nxp.com, ping.bai@nxp.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/7] soc: imx: Enable additional functionality of i.MX8M Mini
Date:   Fri, 13 Dec 2019 10:05:35 -0600
Message-Id: <20191213160542.15757-1-aford173@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPCv2 controller on the i.MX8M Mini is compatible with the driver
used for the i.MX8MQ except for the register locations and names.
The GPCv2 controller is used to enable additional periperals currently
unavailable on the i.MX8M Mini.  In order to make them function,
the GPCv2 needs to be adapted so the drivers can associate their
power domain to the GPCv2 to enable them.

This series makes one include file slightly more generic,
adds the iMX8M Mini entries, updates the bindings, adds them
to the device tree, then associates the new power domain to
both the OTG and PCIe controllers.

Some peripherals may need additional power domain drivers in the future
due to limitations of the GPC driver, but the drivers for VPU and others are
not available yet.

Adam Ford (7):
  soc: imx: gpcv2: Rename imx8mq-power.h to imx8m-power.h
  soc: imx: gpcv2: Update imx8m-power.h to include iMX8M Mini
  soc: imx: gpcv2: add support for i.MX8M Mini SoC
  dt-bindings: imx-gpcv2: Update bindings to support i.MX8M Mini
  arm64: dts: imx8mm: add GPC power domains
  ARM64: dts: imx8mm: Fix clocks and power domain for USB OTG
  arm64: dts: imx8mm: Add PCIe support

 .../bindings/power/fsl,imx-gpcv2.txt          |   6 +-
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 127 ++++++++-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     |   2 +-
 drivers/soc/imx/gpcv2.c                       | 246 +++++++++++++++++-
 .../power/{imx8mq-power.h => imx8m-power.h}   |  14 +
 5 files changed, 387 insertions(+), 8 deletions(-)
 rename include/dt-bindings/power/{imx8mq-power.h => imx8m-power.h} (57%)

-- 
2.20.1

