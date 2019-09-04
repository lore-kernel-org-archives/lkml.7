Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F10C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8E72087E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="R9iz+KFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbfIDEnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 00:43:17 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6717 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfIDEnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 00:43:17 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d6f40e70000>; Tue, 03 Sep 2019 21:43:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 03 Sep 2019 21:43:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 03 Sep 2019 21:43:16 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Sep
 2019 04:43:16 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 4 Sep 2019 04:43:16 +0000
Received: from kyarlagadda-linux.nvidia.com (Not Verified[10.19.64.169]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d6f40e10000>; Tue, 03 Sep 2019 21:43:15 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <ldewangan@nvidia.com>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH V2 00/12] serial: tegra: Tegra186 support and fixes
Date:   Wed, 4 Sep 2019 10:12:55 +0530
Message-ID: <1567572187-29820-1-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567572199; bh=vXVb3IqOb8IeCePcjBDApMcMqHad1mRF64AQp6H9w1w=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=R9iz+KFHZowI9sOkuAHOfm5OwwReCTNrB8/sYlpsogXPRMPCvwgueusEM1koTAOtp
         M5uQN1KQJn6Aw0pa+a+VgCYNX3yrBXolX10XqsZ//71K4Q1XP2GkwsQYZ0CysB4niP
         B3FkPxh95rhhmyC7QDvkD1c+VygRt/av9n3sjN00BFlxPUwQgs+S80XXoqm9OYuZRL
         CyOOPq4mMxd/ws3wtQWhbr4/t/SfSbfnS12+bpwPcf1WlCycGCNS/8aSQNMFA3pPer
         WeRFTDaIPGlkdMjtmBmvABH13+cS9o+C0A5vX6ff4ZMh0owPPnnlH/Dwxvs+edhDLm
         DbIw0VGRO2SnA==
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

Changes from V1:
Consistent spellings and few other cosmetic changes.
Do not ignore sysrq request when ignoring reads.
Remove WARN_ON for errors that are user triggered.
Fix max ports for Tegra186 and Tegra194
Register uart driver in init by reading max ports from dt.
Rename burst size and wait api for FIFO enable.


Ahung Cheng (1):
  serial: tegra: avoid reg access when clk disabled

Krishna Yarlagadda (9):
  serial: tegra: report error to upper tty layer
  dt-binding: serial: tegra: add new chips
  serial: tegra: check for FIFO mode enabled status
  serial: tegra: set maximum num of uart ports to 8
  serial: tegra: add support to use 8 bytes trigger
  serial: tegra: DT for Adjusted baud rates
  serial: tegra: add support to adjust baud rate
  serial: tegra: report clk rate errors
  serial: tegra: Add PIO mode support

Shardar Shariff Md (2):
  serial: tegra: add support to ignore read
  serial: tegra: flush the RX fifo on frame error

 .../bindings/serial/nvidia,tegra20-hsuart.txt      |  39 ++-
 drivers/tty/serial/serial-tegra.c                  | 374 ++++++++++++++++++---
 2 files changed, 368 insertions(+), 45 deletions(-)

-- 
2.7.4

