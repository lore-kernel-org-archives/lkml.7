Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A07C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC092184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfDKKbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:31:43 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:26284 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726629AbfDKKbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:31:43 -0400
X-IronPort-AV: E=Sophos;i="5.60,337,1549897200"; 
   d="scan'208";a="12962286"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 11 Apr 2019 19:31:40 +0900
Received: from localhost.localdomain (unknown [10.166.17.210])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id C93F0402C055;
        Thu, 11 Apr 2019 19:31:40 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 0/3] phy: renesas: rcar-gen3-usb2: enable/disable independent irqs
Date:   Thu, 11 Apr 2019 19:27:33 +0900
Message-Id: <1554978456-20794-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is based on the latest linux-phy.git / next branch with
the following patch:
 https://patchwork.kernel.org/patch/10894105/
 https://patchwork.kernel.org/patch/10894113/

Since the previous code enabled/disabled the irqs both OHCI and EHCI,
it is possible to cause unexpected interruptions. To avoid this,
this patch creates multiple phy instances from phandle and
enables/disables independent irqs by the instances.

Changes from v1 [1]:
 - Rebased on the Biju-san's patch as above.
 - Revise typo on the commit log of patch 1.
 - Add deprecated value 0 on patch 1.
 - Add Reviewed-by tags from Simon-san and Fabrizio-san on patch 2 and 3.
 - Add Tested-by tag from Fabrizio-san on patch 3.
 - Use enum instead of definitions.
 - Add more a comment into rcar_gen3_get_dr_mode().
 - Change name of tmp to mode and move the prototype into the loop.

[1]
https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=99561):

Yoshihiro Shimoda (3):
  dt-bindings: phy: rcar-gen3-phy-usb2: Revise #phy-cells property
  phy: renesas: rcar-gen3-usb2: Use pdev's device pointer on dev_vdbg()
  phy: renesas: rcar-gen3-usb2: enable/disable independent irqs

 .../devicetree/bindings/phy/rcar-gen3-phy-usb2.txt |   8 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           | 195 ++++++++++++++++++---
 2 files changed, 173 insertions(+), 30 deletions(-)

-- 
2.7.4

