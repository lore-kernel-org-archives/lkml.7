Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B081C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35888218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qCW9MV6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733021AbfB1Pp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:45:29 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35324 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfB1Pp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:45:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id j5so9916118pfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 07:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=q7jx3DNyDjtwyhvJ0sV9+ayDKT7k5uGfQqvdjYQ8iGE=;
        b=qCW9MV6IasFn96FeRZ2D6LStEOXzlT+xwPU40OiNjsfmV2qATcZYkT7lbWxALhUYxL
         bVzKeBDxq8zOGfgIHoe41ByXnxoZll6Xcduobi3sASCWzQyn7FbGLDY5Vlca+pUmj/hI
         dGbdmpl96h7XCWTNxs5inqVaEtPtOtpI/dpNqUPXzRM6TOOBNpeOxEVNqFvHiP+ZY75H
         5BfsApxLp+CzwOsZOKqNWRcJEtN1Xa7KW+K88MIKNkjcGV1LWgaYrAxkYu4LLtYW2unH
         ZAM6En9RVJwAYzRyY8FsNzPmzv0ih51cH6jhOb0yeOjQSgYuhSyC/hCGn6qYAv62cM+Y
         Da/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q7jx3DNyDjtwyhvJ0sV9+ayDKT7k5uGfQqvdjYQ8iGE=;
        b=uC3foswPJB2zxyP0vQRpTrprnXbvolG5UGNYuqz821GkoT1EXQ7hWMfEJwNuVjOUM6
         rncvwJrBckcG5gGYFlAyFOnZNy5lIEGpDyCcDd6IxBuXBEVOdXKCnQB/GwqWmRKfwdYL
         D0jc9vGK7YSeFviL8AHqY6Ct1+L+1SRE87QxjAHn+TxW0d/Iw6IbZR8ufmvg6V9xC/hk
         4vs9vjSTjzbXD7RuXIlo7zhueywo4wP+5BXTF6NJw4DtgVVPkLzNTCG+EikLB7OmzMbZ
         csQjMzI1S4ElirVckP82TRKG+HPDgSPq4ZrhQcWrcc3MTklqWeuekpIOur7ISHJp4Ht/
         x1Ow==
X-Gm-Message-State: AHQUAubMBCGVPU1bgk3H+/BYYvcx3XZpbSWaEMRuxHpAr4kJnYEyD8lR
        vPv7djjquzBHkLEB7OSCI2wB
X-Google-Smtp-Source: AHgI3IYudqV0sqK/9OLHv1hgnrPeM50Wkafi40740k2je4uy9e+5LkfSSg6MCP5Phg210NV7jvs4Pg==
X-Received: by 2002:a63:680a:: with SMTP id d10mr8843521pgc.46.1551368727665;
        Thu, 28 Feb 2019 07:45:27 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:905:9c3:2dd3:3db1:5145:4da9])
        by smtp.gmail.com with ESMTPSA id m13sm37485286pff.175.2019.02.28.07.45.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 07:45:26 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     xuwei5@hisilicon.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        amit.kucheria@linaro.org, guodong.xu@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/3] Add MMC controller support for HI3670 SoC
Date:   Thu, 28 Feb 2019 21:15:08 +0530
Message-Id: <20190228154511.17566-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds MMC controller support for HI3670 SoC. Since HI3670
SoC is architecturally same as the HI3660 SoC, HI3660 DWMMC driver is
reused here with DT compatible fallback approach. Also, SD and WiFi
supports are added for the HiKey970 board.

Wei:

Please apply this patchset along with the reset and UFS patches in the
following order:

1. Reset support patches
2. MMC support patches
3. UFS support patches

PS: Since there is no PMIC support available yet, fixed-regulator nodes
are used to get the driver working (regulators are enabled by bootloader).

Thanks,
Mani

Manivannan Sadhasivam (3):
  dt-bindings: mmc: Add HI3670 MMC controller binding
  arm64: dts: hisilicon: hi3670: Add MMC controller support
  arm64: dts: hisilicon: hikey970: Add SD and WiFi support

 .../devicetree/bindings/mmc/k3-dw-mshc.txt    |   2 +
 .../boot/dts/hisilicon/hi3670-hikey970.dts    |  75 ++++++++++++
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  37 ++++++
 .../boot/dts/hisilicon/hikey970-pinctrl.dtsi  | 115 ++++++++++++++++++
 4 files changed, 229 insertions(+)

-- 
2.17.1

