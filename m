Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93572C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A84E2077B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="Q7PFKTGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731413AbgAIOCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:02:25 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39678 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729572AbgAIOCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:02:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id 20so2955080wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 06:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cH3/OtZ3DAvw8IgKFnqPXU8D4jtKtoD9aLE/M0BbcKs=;
        b=Q7PFKTGxpyCSu9tOEMplXNfwBzehjnBpiHUyvo+zkGU7Jnf4Pk73EORE5sthX5quPi
         NZfAq9ONyqTNDWQUy4XkVGDXC/iLmaFl6eHu/m+CGEyOKWB2SRTyN1Uh4M9aYlQyUCgI
         lPGue0manFc74H5onYbbMtUeLfH150STGLEYotHrptrBwpwaQX5908a5KWP/o3UuS/mc
         +Fhsc2Cgc6sI3nRyMiKGzsTlVjMYnosUMQoLRtSO0m4H2tbVrcV566XiPwRaTQYq1XrT
         h7oXEmdZf1tbOffD4LeeZ4Ye5a3GON25kL38+23iJBXg6Y65XEWVSDfxgNTVCq7X/h8o
         YkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=cH3/OtZ3DAvw8IgKFnqPXU8D4jtKtoD9aLE/M0BbcKs=;
        b=pWwvoOziZUQRfPL+JltETb1A39y34lphCJ78qB95Z0CQw6p9T9MpvdaIFEGiXks2/d
         bf8vQpCtPLAaqt1+c8QU99r6DT1as7dHPtcrceZ71juqaND3V6/vxp6LntmIIyQUWuON
         2lOC11U6fIx1uouTjxpg7BjsGErLWnWcCVShtxkUn3PjXlTxbrInqfEaWTHMJpj5E/Zi
         glgmHJg8R5rq8oPQgl3HONK8W4/Vi+dOxoJ6k2T1Lu0KeAON8l7tNXpRU4zNPXF7QsNk
         B3ZtENgUO7AiJzwnh4OUTREPSmZD6o+cDuDFtuxiR8H1deSkxa8u+eId8hdkWv+M5a0P
         gDpg==
X-Gm-Message-State: APjAAAWAlkdKo7BFeTKg9v9VBk+EvoV6dpChzRNdIiD65m0QphCN+w4I
        JtHDvREQ5haPlnSXWm6csEwEBw==
X-Google-Smtp-Source: APXvYqz9WNWkReumkSXQjkJSbEUPQl0vWe2bk7mCzx+9uimnftzUwsh7ehidAGZy+lLpg/8XU0tk6w==
X-Received: by 2002:a1c:7901:: with SMTP id l1mr5038497wme.67.1578578543372;
        Thu, 09 Jan 2020 06:02:23 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id g18sm2851975wmh.48.2020.01.09.06.02.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jan 2020 06:02:22 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-arm-kernel@lists.infradead.org, git@xilinx.com
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] arm64: zynqmp: Enable iio-hwmon based on iio ina226 driver with labels
Date:   Thu,  9 Jan 2020 15:02:14 +0100
Message-Id: <cover.1578578535.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the patch 2c3d0c9ffd24 ("iio: core: Add optional symbolic label to device attributes")
added support for labelling IIO devices that's why I can enable iio based
ina226 driver with label property.

Thanks,
Michal


Michal Simek (7):
  arm64: zynqmp: Enable iio-hwmon for ina226 on zcu100
  arm64: zynqmp: Enable iio-hwmon for ina226 on zcu111
  arm64: zynqmp: Add label property to all ina226 on zcu111
  arm64: zynqmp: Enable iio-hwmon for ina226 on zcu102
  arm64: zynqmp: Add label property to all ina226 on zcu102
  arm64: zynqmp: Enable iio-hwmon for ina226 on zcu106
  arm64: zynqmp: Add label property to all ina226 on zcu106

 .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    |   8 +-
 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 145 +++++++++++++++---
 .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 145 +++++++++++++++---
 .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    | 113 ++++++++++++--
 4 files changed, 360 insertions(+), 51 deletions(-)

-- 
2.24.0

