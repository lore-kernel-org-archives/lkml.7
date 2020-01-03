Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00934C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB1120848
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ipk1BrcW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgACIaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 03:30:23 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5522 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgACIaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 03:30:22 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e0efb8e0000>; Fri, 03 Jan 2020 00:30:06 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 03 Jan 2020 00:30:22 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 03 Jan 2020 00:30:22 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 3 Jan
 2020 08:30:21 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 3 Jan 2020 08:30:21 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.108.118]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e0efb9c0004>; Fri, 03 Jan 2020 00:30:21 -0800
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v1 0/2] enable Tegra194 fuse
Date:   Fri, 3 Jan 2020 16:30:16 +0800
Message-ID: <20200103083018.10575-1-jckuo@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578040206; bh=kX3fTq+aStHADaUG+D7GLbhXTX9qCanrmxwhAMebcC0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=ipk1BrcWSBjWM6I7vd6ucZDy8I7LpWP12kizRshWgJOnQT3osTZUtHDHX+/trqLcb
         K2hmNc0h8F/5FiEJKrVay0lp2zXflAl6hC+6kJiog5R5MQtArNqQQJbNNUE3rUMeLt
         eVVYdE1o0S6w/bM77L5firu/H9aLxOYF4ZRxhYx7uEyPh4KAhowyBW5DKpD/Tct1xa
         rXV4E60FT2Y661F0/BKQ/Kv/n5t6X+x4Q4Mr3oR2B5JC1UDhJU5D7fw8pnQTbEpty3
         406bYeBYdU2LtNbZ7dn1ySUCpUIptD2ZFTuXx/7hHBk+9gXZy+I+dr3nX8vDunbp2Q
         dZEAcijmAdrvQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enables Tegra194 fuse registers access.

JC Kuo (2):
  soc/tegra: fuse: Add Tegra194 support
  arm64: tegra: Add fuse/apbmisc node on Tegra194

 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 13 +++++++++++
 drivers/soc/tegra/fuse/fuse-tegra.c      |  3 +++
 drivers/soc/tegra/fuse/fuse-tegra30.c    | 29 ++++++++++++++++++++++++
 drivers/soc/tegra/fuse/fuse.h            |  4 ++++
 drivers/soc/tegra/fuse/tegra-apbmisc.c   |  1 +
 5 files changed, 50 insertions(+)

-- 
2.17.1

