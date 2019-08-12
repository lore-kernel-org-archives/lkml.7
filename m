Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0330C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3792085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="IHRRCekE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfHLL2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:28:37 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18368 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbfHLL2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:28:37 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d514d6f0000>; Mon, 12 Aug 2019 04:28:47 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 12 Aug 2019 04:28:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 12 Aug 2019 04:28:36 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 12 Aug
 2019 11:28:36 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 12 Aug 2019 11:28:36 +0000
Received: from kyarlagadda-linux.nvidia.com (Not Verified[10.19.64.169]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d514d610000>; Mon, 12 Aug 2019 04:28:36 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <ldewangan@nvidia.com>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 00/14] serial: tegra: Tegra186 support and fixes
Date:   Mon, 12 Aug 2019 16:58:09 +0530
Message-ID: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565609327; bh=IeA7TVzSY/j/yQ40dk+G66W/AzCRieQzDfzgCyYzZDQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=IHRRCekEJxQVEHEPjVwHWrMYSE2xITl1tZJ+fVOcsBXDaMq9ir5j7CBYN9mClJODW
         fgCxOPgjLhyuIVZB895aXlibIggpvR6kYCg19gfKA3XUaxs6HiAgwoGpTAM1GH4vVC
         Mz+4TGI8SfptcwqLvV1Gc5t1npuOADlk4eqfo63vTY0F6a3xVM4Zxhdj5EgYTKIGlO
         +UqfCTKaNwqLxory4XZaR46jDp50fSrMrKuB+dvh3T3E5AgdVpN8bAiOADiDvMxEUU
         afbeI5ClCp7Rtj9klAwn4qeV6rRr+itQunwTaKdxfvw2IH2kbQPJw1aUQS5FVTG1bN
         KTgYE2kXQq8kA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Series of patches adding enhancements to exising UART driver and adding
support for new chip Tegra186 and Tegra194.

Tegra186 uses GPCDMA for dma transfers which is still not available in
mainstream. However, it can work in PIO/FIFO mode and support added for it.
Also Tegra186 has a hardware issue where it does not meet tolernace +/-4% and
to work around it, device tree entries provided to adjust baud rate for a
particular range.

Ahung Cheng (2):
  serial: tegra: avoid reg access when clk disabled
  serial: tegra: protect IER against LCR.DLAB

Andreas Abel (1):
  serial: tegra: add internal loopback functionality

Krishna Yarlagadda (7):
  serial: tegra: report error to upper tty layer
  serial: tegra: add compatible for new chips
  serial: tegra: check for FIFO mode enabled status
  serial: tegra: DT for Adjusted baud rates
  serial: tegra: add support to adjust baud rate
  serial: tegra: report clk rate errors
  serial: tegra: Add PIO mode support

Shardar Shariff Md (4):
  serial: tegra: add support to ignore read
  serial: tegra: flush the RX fifo on frame error
  serial: tegra: set maximum num of uart ports to 8
  serial: tegra: add support to use 8 bytes trigger

 .../bindings/serial/nvidia,tegra20-hsuart.txt      |  35 +-
 drivers/tty/serial/serial-tegra.c                  | 405 ++++++++++++++++++---
 2 files changed, 385 insertions(+), 55 deletions(-)

-- 
2.7.4

