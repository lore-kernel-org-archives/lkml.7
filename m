Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2224C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE902089E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MiALhfML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfEVNQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 09:16:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41205 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbfEVNQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 09:16:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id f12so1066360plt.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 06:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CDSHlZ4R9H1PhFEC6NVmtI65PCR+1fnOjrUw3HlFSmY=;
        b=MiALhfMLLB3ZUtSYw73WM0Ok//GbWWrp0nbqOMCtuKJQ27dI+r5EonhedPoCt5M2Cj
         hD52ITjt5Jrq43aNFM3WoDws0AeEvgmljbydK0yKHzwrnrAsOE6GmEaqrFsWrbKkUP8R
         pVi7wVyE5NWJxnBVacA7dUKpF6Hgwq5yuz6z6c5ExDhOSMxqU23ocdiKrdl5fBafoMV/
         Vl0h/fgYjiHBYRwzzusSNkCoggfd+Ih7bAaHgjgZk9NoEWk4wrJjvB+RjtF5sbW0XJrn
         73yDzmzOzsN5EU4uXC/89XTe3sY0Go60tV+f7/eum49OJFXX6Li2kYtrEIklt6rP6jFZ
         ohaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CDSHlZ4R9H1PhFEC6NVmtI65PCR+1fnOjrUw3HlFSmY=;
        b=ejjJ25ILlAqwz8BqwC9HPUOWftyQjtP7OuKMpnVp1u7AhCw80lo5Ve1NOVELLkurjH
         Zj5LEzM0NHmzOHJSLgcOVJ4HZm/s3eLIVVVWFzcGa4zI524MwgJw42o35tA/UqI3ZAwV
         zHGxd/5lGfFZK1yZdZWTNpUc6bnunGjy6tH7zVgVKJmrxU9BWUY60RyMUgB0jYwOGNkZ
         DbfcCG9hayCVum+MIFpOuhD3uROg+NvcyDpbj6+ImkenJxiJGdfI48APiDxzn9nBwRlz
         17BPmv1tbinvd+ZW1FWEfgao6eQNCTfAWR2RQKP8eRMmGRVMYLkRiw9pIzIBeR1QeBU9
         s9uQ==
X-Gm-Message-State: APjAAAXuFt2L5JxbAQ047/WkkbKDI1ZjxEaA/Pb95XfTb3MXdET2YzUu
        2zCp+UQzFPXJ2mPQGjS2kD0U
X-Google-Smtp-Source: APXvYqyK18MyeSBgTUuExrOuAFSNAl/gMnvHsGeTTCkCfMwqa4pggff8/j3VsWwJv9AoLKltHBe3mQ==
X-Received: by 2002:a17:902:e104:: with SMTP id cc4mr89824069plb.254.1558530974800;
        Wed, 22 May 2019 06:16:14 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:73c4:1ab0:ac45:9c21:7eb3:888a])
        by smtp.gmail.com with ESMTPSA id b7sm22273565pgq.71.2019.05.22.06.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 06:16:13 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, pbrobinson@gmail.com,
        yossi@novtech.com, nazik@novtech.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/2] Add 96Boards Meerkat96 board support
Date:   Wed, 22 May 2019 18:45:48 +0530
Message-Id: <20190522131550.9034-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds board support for 96Boards Meerkat96 board from
Novtech. This board is one of the Consumer Edition boards of the 96Boards
family based on i.MX7D SoC. Following are the currently supported
features of the board:
 
* uSD
* WiFi/BT
* USB
    
More information about this board can be found in 96Boards product page:
https://www.96boards.org/product/imx7-96/

Thanks,
Mani

Manivannan Sadhasivam (2):
  dt-bindings: arm: Document 96Boards Meerkat96 devicetree binding
  ARM: dts: Add support for 96Boards Meerkat96 board

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/imx7d-meerkat96.dts         | 396 ++++++++++++++++++
 3 files changed, 398 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx7d-meerkat96.dts

-- 
2.17.1

