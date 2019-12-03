Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B563C43141
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D322C20656
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414329;
	bh=ifwruHAoHqHKLv+HjbF5JGJp7pgttRgm2PgncmfAWrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OPY/sNIvQmOFcvenMu7GtXF/TFNtu8SeCLEjLfIAqz4aGOpnYEkWpRua1gLY44DYg
	 mNaA4iTdb+wUtgjIn/YEg0cfhu3Yg4viKh9KWoKHBAeH2aAVP+m7cP9josIWjP24te
	 nwV/257WX39Ck+okLqMYqzt4yk6CfXehnL/6CjDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfLCWuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:50:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:41662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729709AbfLCWuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:50:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F04BC20656;
        Tue,  3 Dec 2019 22:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413410;
        bh=ifwruHAoHqHKLv+HjbF5JGJp7pgttRgm2PgncmfAWrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E5ATwxt3U9nExAcPozaFCfeUjqBfr1MlMKqF2Opy+j/yozm+8FGDwYm1aZtSCifEu
         5G349eM9TcEZXwwUEs/zh8oxM009Bvyof+aWl5WWPifQJ3I0JSzeujOH1ucCOZ3oGY
         Cbkwbo0DVrFFSpI/fI///NoVWOoxvE5OtCC474Eo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Ladislav Michl <ladis@linux-mips.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 116/321] usb: ehci-omap: Fix deferred probe for phy handling
Date:   Tue,  3 Dec 2019 23:33:02 +0100
Message-Id: <20191203223433.182056324@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roger Quadros <rogerq@ti.com>

[ Upstream commit 8dc7623bf608495b6e6743e805807c7840673573 ]

PHY model is being used on omap5 platforms even if port mode
is not OMAP_EHCI_PORT_MODE_PHY. So don't guess if PHY is required
or not based on PHY mode.

If PHY is provided in device tree, it must be required. So, if
devm_usb_get_phy_by_phandle() gives us an error code other
than -ENODEV (no PHY) then error out.

This fixes USB Ethernet on omap5-uevm if PHY happens to
probe after EHCI thus causing a -EPROBE_DEFER.

Cc: Johan Hovold <johan@kernel.org>
Cc: Ladislav Michl <ladis@linux-mips.org>
Reported-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/ehci-omap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 7e4c13346a1ee..7d20296cbe9f9 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -159,11 +159,12 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 		/* get the PHY device */
 		phy = devm_usb_get_phy_by_phandle(dev, "phys", i);
 		if (IS_ERR(phy)) {
-			/* Don't bail out if PHY is not absolutely necessary */
-			if (pdata->port_mode[i] != OMAP_EHCI_PORT_MODE_PHY)
+			ret = PTR_ERR(phy);
+			if (ret == -ENODEV) { /* no PHY */
+				phy = NULL;
 				continue;
+			}
 
-			ret = PTR_ERR(phy);
 			if (ret != -EPROBE_DEFER)
 				dev_err(dev, "Can't get PHY for port %d: %d\n",
 					i, ret);
-- 
2.20.1



