Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BEBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F3420870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfDAMFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:05:20 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:43566 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726436AbfDAMFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:05:19 -0400
X-IronPort-AV: E=Sophos;i="5.60,296,1549897200"; 
   d="scan'208";a="11718073"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 01 Apr 2019 21:05:17 +0900
Received: from localhost.localdomain (unknown [10.166.17.210])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6566E401EA64;
        Mon,  1 Apr 2019 21:05:17 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 0/3] phy: renesas: rcar-gen3-usb2: enable/disable independent irqs
Date:   Mon,  1 Apr 2019 21:01:20 +0900
Message-Id: <1554120083-29990-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the previous code enabled/disabled the irqs both OHCI and EHCI,
it is possible to cause unexpected interruptions. To avoid this,
this patch creates multiple phy instances from phandle and
enables/disables independent irqs by the instances.

Yoshihiro Shimoda (3):
  dt-bindings: phy: rcar-gen3-phy-usb2: Revise #phy-cells property
  phy: renesas: rcar-gen3-usb2: Use pdev's device pointer on dev_vdbg()
  phy: renesas: rcar-gen3-usb2: enable/disable independent irqs

 .../devicetree/bindings/phy/rcar-gen3-phy-usb2.txt |   7 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           | 191 +++++++++++++++++----
 2 files changed, 168 insertions(+), 30 deletions(-)

-- 
2.7.4

