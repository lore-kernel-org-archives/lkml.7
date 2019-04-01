Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F536C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391AD20883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm2hAp+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfDAKky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:40:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36219 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfDAKky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:40:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id y13so11354931wrd.3;
        Mon, 01 Apr 2019 03:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=77ZznW4XlM/dVYM/OdVYzEcNUpVfZ7W0jzueY9iJrwA=;
        b=jm2hAp+bcAWCGPWtpXT1gczaE1Xw4RdMKOpB7/85b9Y6N17bxvoptJQHljOkGL/5s8
         YZEYmES5PwZelXlPkpt1DWbK3PCWgoiUQp8qrDJixFKaMS06uqFFXoPNJUuJoZ2MfOFo
         A3GN2ZmN5rJhNK2IvzAv1kAHzW05Zc25m7anudywjWcr7+SEv6m7wEssw4x86Bk33QNm
         0FziTzQNeP0spFZ5CF5Y24C3SZze8FGrRIXpQsNUQbfM/2z/O3cBzwvIECAjWN3OuHOq
         nAlLdoZnIzQayYyfIWo9JBnbIrDLqwSB8ajuUlignPhFzvOZoY9t9pb+iRgyER5d8jOt
         rnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=77ZznW4XlM/dVYM/OdVYzEcNUpVfZ7W0jzueY9iJrwA=;
        b=FsydVfyeZZkRJ7rofFvpVU4YwXM1Yw/FC5vLfvGiPQFrH40emFYoKifQ/pdx0R4HAz
         9Cp8nS02M8f6t5poR76dSHJs29rKx4Clx0358AFC67MgfYOJzwG4JVNLGqV+Uywx/Bal
         0fEet97zUxJneVipUTLxoT3gzjKaFU+JVtXKl+Z6mn798dxeDCmNbzv0bGiXo/yCfqbI
         PiNko4CTrgaHrfXpGj9kKoEqGNnZvm2vuqlaqmVITG5ny9Q1VNaipJx8t9Av23rR+U6X
         PfpAknx9g94XGnm9lCNx1qaTAz4N3C5xB9+KKtomi4noFISQcVTFGhoFeyyz1x7XCfKf
         xSYA==
X-Gm-Message-State: APjAAAWNtOi49M4R6h77yhUhMyBy6JLglzbdcKEYfYIQqk1KMzxnIt0P
        2BlNO4CbI3eMihxGr0DmsYc=
X-Google-Smtp-Source: APXvYqyGGgV031YeeMfSKu4OOB1aIM474eikFi5coPPj5kbxG77xCemXLX73/iP8tf2h4tbwiTBKLQ==
X-Received: by 2002:adf:fd86:: with SMTP id d6mr11966061wrr.15.1554115252205;
        Mon, 01 Apr 2019 03:40:52 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id g3sm7702280wmk.32.2019.04.01.03.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 03:40:51 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] usb: host: xhci-tegra: Add Tegra186 XUSB support
Date:   Mon,  1 Apr 2019 12:40:44 +0200
Message-Id: <20190401104050.31355-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Hi,

This series introduces support for XUSB to the Tegra186 SoC. This is
mostly the same as on earlier generations in that it provides an XHCI
compatible interface with a bit of vendor-specific glue. Perhaps the
most notable change is the removal of the IPFS wrapper. Patches for
the UPHY related changes that control the PHYs for the XUSB controller
were merged into v5.1.

This version is a rebase of the series posted here:

    http://patchwork.ozlabs.org/project/linux-tegra/list/?series=88193

There have been no code changes and I collected Reviewed-by and Acked-by
tags.

Greg, can you pick up patches 1-3 with Rob's and Mathias' Acked-by,
respectively? I'll pick up patches 4-6 into the Tegra tree.

Thanks,
Thierry

JC Kuo (2):
  usb: host: xhci-tegra: Selectively program IPFS
  usb: host: xhci-tegra: Add Tegra186 XUSB support

Thierry Reding (4):
  dt-bindings: usb: xhci-tegra: Add Tegra186 support
  arm64: tegra: Add XUSB and pad controller on Tegra186
  arm64: tegra: Enable XUSB on P2771
  arm64: tegra: Remove regulator hacks on Jetson TX2

 .../bindings/usb/nvidia,tegra124-xusb.txt     |   4 +
 .../boot/dts/nvidia/tegra186-p2771-0000.dts   | 115 +++++++++++++++
 .../arm64/boot/dts/nvidia/tegra186-p3310.dtsi |  42 ++----
 arch/arm64/boot/dts/nvidia/tegra186.dtsi      | 135 ++++++++++++++++++
 drivers/usb/host/xhci-tegra.c                 |  68 ++++++---
 5 files changed, 320 insertions(+), 44 deletions(-)

-- 
2.21.0

