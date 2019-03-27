Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9EEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF112147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710323;
	bh=12rsSA6qYPeZIEqANx+LbuSpBa6N+6DLyRpbn0/g5u8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HuC4wtR8pR3iozFRjUW1pw+Vf6+vStTXGqHN/Xbotpq3jScI1YA5w2K8xiWJ7WLFT
	 EtX3IqhS11Nr3HQpVWUiCKsGIZ9XRBOM0imYSqfJbUl7NA6F0AI3EMIDTb3TKA5xhM
	 4ejLkJAEqEPfAbRwAdBYLh/bCd76dhem92l4YRpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389127AbfC0SMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:12:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389115AbfC0SLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:11:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F6BC21738;
        Wed, 27 Mar 2019 18:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710314;
        bh=12rsSA6qYPeZIEqANx+LbuSpBa6N+6DLyRpbn0/g5u8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xp54kunlmrgynJLtQPrXQurFzlkBBlOdY2AREIahlr2v0HAZN8JEpfNYmWPfSZssU
         LnpuQKHIHhGLH21izm6W/suzrZIqW7HcynUJxS1NL9qElwtF99Gw+1KQtK9dg8xrO1
         IycojXhLR/mfTGSTxFB/7JofPQt0qO1uFkj3Lirk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Peter Chen <peter.chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 051/192] usb: chipidea: Grab the (legacy) USB PHY by phandle first
Date:   Wed, 27 Mar 2019 14:08:03 -0400
Message-Id: <20190327181025.13507-51-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

[ Upstream commit 68ef236274793066b9ba3154b16c0acc1c891e5c ]

According to the chipidea driver bindings, the USB PHY is specified via
the "phys" phandle node. However, this only takes effect for USB PHYs
that use the common PHY framework. For legacy USB PHYs, a simple lookup
based on the USB PHY type is done instead.

This does not play out well when more than one USB PHY is registered,
since the first registered PHY matching the type will always be
returned regardless of what the driver was bound to.

Fix this by looking up the PHY based on the "phys" phandle node.
Although generic PHYs are rather matched by their "phys-name" and not
the "phys" phandle directly, there is no helper for similar lookup on
legacy PHYs and it's probably not worth the effort to add it.

When no legacy USB PHY is found by phandle, fallback to grabbing any
registered USB2 PHY. This ensures backward compatibility if some users
were actually relying on this mechanism.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/chipidea/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 85fc6db48e44..159b897c5e80 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -935,8 +935,15 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	} else if (ci->platdata->usb_phy) {
 		ci->usb_phy = ci->platdata->usb_phy;
 	} else {
+		ci->usb_phy = devm_usb_get_phy_by_phandle(dev->parent, "phys",
+							  0);
 		ci->phy = devm_phy_get(dev->parent, "usb-phy");
-		ci->usb_phy = devm_usb_get_phy(dev->parent, USB_PHY_TYPE_USB2);
+
+		/* Fallback to grabbing any registered USB2 PHY */
+		if (IS_ERR(ci->usb_phy) &&
+		    PTR_ERR(ci->usb_phy) != -EPROBE_DEFER)
+			ci->usb_phy = devm_usb_get_phy(dev->parent,
+						       USB_PHY_TYPE_USB2);
 
 		/* if both generic PHY and USB PHY layers aren't enabled */
 		if (PTR_ERR(ci->phy) == -ENOSYS &&
-- 
2.19.1

