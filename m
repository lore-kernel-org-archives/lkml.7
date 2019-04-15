Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDCBC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACC02070D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="drjx/JKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbfDOVam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:30:42 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9334 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfDOVam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 17:30:42 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb4f7fe0000>; Mon, 15 Apr 2019 14:30:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 15 Apr 2019 14:30:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 15 Apr 2019 14:30:41 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Apr
 2019 21:30:40 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Apr
 2019 21:30:40 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 15 Apr 2019 21:30:40 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.167.253]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cb4f7fe0001>; Mon, 15 Apr 2019 14:30:40 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V3 0/9] bug fixes and more features to Tegra SPI
Date:   Mon, 15 Apr 2019 14:30:25 -0700
Message-ID: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555363838; bh=irLqmDsEskLEYyTvJn9l0k9bNOUBEg7ana8OjVK+2Kk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=drjx/JKer/gNWcsCgqhY/UPOqHXJ2pdJEeszdxMHDQkr/LxHc9lY5HTbaqxJ8vfLS
         Od/Z6V8/M3zNKrTaFhsYSOBDF+yVWu+KgRxC4lCYsi3XrKBNbA5+G8FsA0G9/FjzLd
         4Cfo3OLJ34pOMoIo0NphvENncYnI3l0OpGU3DD1hvNm279cklm4S5LJhOhgMPlTcv6
         1gphnJtxXuGLVcn/A5064uhhs3AIO2fOqL62zfsIVHQ1dXkcFEUL8InvfkfOU34vjG
         ktxiFbfIZT0m+2bHR2tV/RLhChW9kHuSNzaUlNVrGcGTN2HKvcCmJr6n4GSU9wgv1B
         Z2tGrUFZ6hfCg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[V3] : This patch series version includes
	- only patches that are not applied from V2.
	- splitted expanding mode and adding LSByte First support
	  in separate patches and removed DT property for selecting
	  LSByte First.
	- Updated GPIO based chip select control to use spi_set_cs
	  from SPI core.
	- HW based chip select implementation is same as V2 but V3
	  has this patch updated to be on top of above changes.
	- HW CS timing implementation is same as V2 but V3
	  has this patch updated to be on top of above changes.
	- support for TX and RX trimmers implementation is same as V2
	  but V3 has this patch updated to be on top of above changes
	  and updated commit description.

[V2] : This patch series version includes
	- only patches that are not applied from V1.
	- changed order of patches to include all fixes prior to new features
	  support.
	- Removed HW CS timing from DT properties and created set_cs_timing
	  SPI master optional method for SPI controllers to implement and
	  created API spi_cs_timing for SPI client drivers to request CS
	  setup, hold and inactive delay timing configuration.
	- Fixed HW based CS decision to be based on single transfer and
	  cs_change. Remove selection of HW based CS through DT.

Sowjanya Komatineni (9):
  spi: tegra114: fix PIO transfer
  spi: expand mode support
  spi: add SPI_LSBYTE_FIRST mode
  spi: tegra114: add support for Tegra SPI LSBYTE_FIRST
  spi: export spi core function spi_set_cs
  spi: tegra114: add support for gpio based CS
  spi: tegra114: add support for hw based cs
  spi: tegra114: add support for HW CS timing
  spi: tegra114: add support for TX and RX trimmers

 drivers/spi/spi-tegra114.c | 175 ++++++++++++++++++++++++++++++++++++++++-----
 drivers/spi/spi.c          |  21 +++---
 include/linux/spi/spi.h    |   8 ++-
 3 files changed, 174 insertions(+), 30 deletions(-)

-- 
2.7.4

