Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CA3C4D2DA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D3B24784
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efbOog/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbfLMUAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 15:00:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37205 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbfLMUAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 15:00:35 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so37547wru.4;
        Fri, 13 Dec 2019 12:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=akaMhhNafypMcnWQLyODE4BRgRfGddqizBHDrWxFNdU=;
        b=efbOog/WskF5WvsX/TQETNPh+NYOs7lPXVUnQDmByDNAqYOaoc3CERdK15vSZG98Ro
         IF9UKf2/7ZbCWJ4QjS49SfMJsIS9qFKiqDSo5QnPPw7DiNyNDiDsOH0YCUyP7ofkJS9S
         It911+bLXhRZMhTTMvBunFUmPcEIfO78ifWkXMsF02wMUk5DrcFmb+tsBt5FBB43Nq/t
         0KsaZCAxCKTwAzDlS5r3KVZKu6/c9ww4KGLKPO/Ie3QRpk4iV+o+g7aZLwhIuCaSq4/t
         6ZLQg3guvVRqzVasgzD3iCxfiiPDph7/T0Y7fIahwPMxD/6NuAekSVdEEfxXwS2oiO0I
         qScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=akaMhhNafypMcnWQLyODE4BRgRfGddqizBHDrWxFNdU=;
        b=CthDYgaAe0TSxcbUQU87cXXuDFCEV68/y4RLgAOETiDN4wq50aAPp+5fzErW9GBgyd
         OqGyShMLhaMZIVBbBLNfpfpPTlAZwrGan6f+bNOePU/64rt0Q1fpq1LP+TKRXmiJyoVL
         AguyK1G8m7o3xbHn078893HxZv5oICU4vW3MMQZl5n7tY46PoS23keCfBWZe8B8BQWkJ
         h61FpZQ1aUsUCPDzR8o/+3l2Lh61ttZGcKTk6c4CYTt+T9By6l8+kW6UOmGWzoI3q0e7
         FaJdJme0iobbOpkKbInffV7WqdnJGk/uSXNccZKYsc8in1J9RxWb6ySCcH3S68GRIX4n
         OTGw==
X-Gm-Message-State: APjAAAXgNHM8yil7OkI8gstk3CsK4oagcxB+54BWitKz16RB1hxThPjn
        w6JEDOPU80BFCQU4SnDDDooWuTfz
X-Google-Smtp-Source: APXvYqxJd5XiL6lmgm/o87WE1QgbFt5mgEBHgT0f1GnpqQ+UEIS7FfBi3gr4LTXtRvWnocppmStftA==
X-Received: by 2002:adf:f2d0:: with SMTP id d16mr15267300wrp.314.1576267232899;
        Fri, 13 Dec 2019 12:00:32 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e16sm10926331wrs.73.2019.12.13.12.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 12:00:32 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net: dsa: b53: Fix egress flooding settings
Date:   Fri, 13 Dec 2019 12:00:27 -0800
Message-Id: <20191213200027.20803-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were several issues with 53568438e381 ("net: dsa: b53: Add support for port_egress_floods callback") that resulted in breaking connectivity for standalone ports:

- both user and CPU ports must allow unicast and multicast forwarding by
  default otherwise this just flat out breaks connectivity for
  standalone DSA ports
- IP multicast is treated similarly as multicast, but has separate
  control registers
- the UC, MC and IPMC lookup failure register offsets were wrong, and
  instead used bit values that are meaningful for the
  B53_IP_MULTICAST_CTRL register

Fixes: 53568438e381 ("net: dsa: b53: Add support for port_egress_floods callback")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 36828f210030..edacacfc9365 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -347,7 +347,7 @@ static void b53_set_forwarding(struct b53_device *dev, int enable)
 	 * frames should be flooded or not.
 	 */
 	b53_read8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, &mgmt);
-	mgmt |= B53_UC_FWD_EN | B53_MC_FWD_EN;
+	mgmt |= B53_UC_FWD_EN | B53_MC_FWD_EN | B53_IPMC_FWD_EN;
 	b53_write8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, mgmt);
 }
 
@@ -526,6 +526,8 @@ int b53_enable_port(struct dsa_switch *ds, int port, struct phy_device *phy)
 
 	cpu_port = dsa_to_port(ds, port)->cpu_dp->index;
 
+	b53_br_egress_floods(ds, port, true, true);
+
 	if (dev->ops->irq_enable)
 		ret = dev->ops->irq_enable(dev, port);
 	if (ret)
@@ -641,6 +643,8 @@ static void b53_enable_cpu_port(struct b53_device *dev, int port)
 	b53_write8(dev, B53_CTRL_PAGE, B53_PORT_CTRL(port), port_ctrl);
 
 	b53_brcm_hdr_setup(dev->ds, port);
+
+	b53_br_egress_floods(dev->ds, port, true, true);
 }
 
 static void b53_enable_mib(struct b53_device *dev)
@@ -1821,19 +1825,26 @@ int b53_br_egress_floods(struct dsa_switch *ds, int port,
 	struct b53_device *dev = ds->priv;
 	u16 uc, mc;
 
-	b53_read16(dev, B53_CTRL_PAGE, B53_UC_FWD_EN, &uc);
+	b53_read16(dev, B53_CTRL_PAGE, B53_UC_FLOOD_MASK, &uc);
 	if (unicast)
 		uc |= BIT(port);
 	else
 		uc &= ~BIT(port);
-	b53_write16(dev, B53_CTRL_PAGE, B53_UC_FWD_EN, uc);
+	b53_write16(dev, B53_CTRL_PAGE, B53_UC_FLOOD_MASK, uc);
+
+	b53_read16(dev, B53_CTRL_PAGE, B53_MC_FLOOD_MASK, &mc);
+	if (multicast)
+		mc |= BIT(port);
+	else
+		mc &= ~BIT(port);
+	b53_write16(dev, B53_CTRL_PAGE, B53_MC_FLOOD_MASK, mc);
 
-	b53_read16(dev, B53_CTRL_PAGE, B53_MC_FWD_EN, &mc);
+	b53_read16(dev, B53_CTRL_PAGE, B53_IPMC_FLOOD_MASK, &mc);
 	if (multicast)
 		mc |= BIT(port);
 	else
 		mc &= ~BIT(port);
-	b53_write16(dev, B53_CTRL_PAGE, B53_MC_FWD_EN, mc);
+	b53_write16(dev, B53_CTRL_PAGE, B53_IPMC_FLOOD_MASK, mc);
 
 	return 0;
 
-- 
2.17.1

