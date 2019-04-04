Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16908C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7222184B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554367890;
	bh=OYd5Iltv+ble0Zc4yPMCmipK+YNiJYdaRjtdsR8eS9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hUUFgdnyArrKqaGEvKcLFetL7ThLr5oiEKqzP0BHuWnqHs6ZiNwOrYHgV8wX1BHNh
	 qAEIhVUnOsCYjAfQAiGIvwm2rvpXkAOm16fl9vSqU7+IwvNRdFDh3pQCL854/x0gDI
	 xWGPTSmZxejrcZh7oaaQgAXAhk9xrxEo7e4c9B4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbfDDIv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:51:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729363AbfDDIvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:51:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56A2D217D7;
        Thu,  4 Apr 2019 08:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554367884;
        bh=OYd5Iltv+ble0Zc4yPMCmipK+YNiJYdaRjtdsR8eS9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XoGTCrWNZVgJt9FzPprm1JZskP/MtFBcSMyz3UxhGVmL4rnSTq4ipdJCgir5qt1t7
         VCazX7o7s9TEk/nb1yPRekqZplXpRDgC/nr8HAM2wGg5kpHURoLvsrh8aOFa7MIiiN
         z0aPhcFQAq/w4OUERILVH2KjGHsL3WlFMZwjMshQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Peter Chen <peter.chen@nxp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 33/91] usb: chipidea: Grab the (legacy) USB PHY by phandle first
Date:   Thu,  4 Apr 2019 10:47:17 +0200
Message-Id: <20190404084537.381417961@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084535.450029272@linuxfoundation.org>
References: <20190404084535.450029272@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 64c6af2c8559..e96e3a5808b3 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -901,8 +901,15 @@ static int ci_hdrc_probe(struct platform_device *pdev)
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



