Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50982C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1289A214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369060;
	bh=BOUCe4qItu6MoKe6kgJI66qQLOyN/TTOqvTwEyFQjQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DuxJ/G1yfuQCOiFrPEgyXh4bckQKE2316qFqL222lxhds5uC2zMfk3oT19NoBAnwP
	 W0aFIDoUHBAV5rFgdv322f+Qw11QRqkWNiCR5zoD5WTp/lJgwp+d4Mk+Dl997e28nc
	 eDi2ewpR9vPZkvXc4JSHh4XuTG8VUb6m750YSb/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733098AbfDDJK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:10:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733086AbfDDJK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:10:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0332520693;
        Thu,  4 Apr 2019 09:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369055;
        bh=BOUCe4qItu6MoKe6kgJI66qQLOyN/TTOqvTwEyFQjQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lw2SVr3SGAcWtW4KakmaS3dUiokT/0OqflumjRmJH2tqy4qQGkDBjc4R/va1/OssX
         Q0/hJUEDFhpElHS250vAfFZU9raVK9tXxulNgRG6wGdBOYOgUoqQDiPvtsYlzhJA6U
         AgEdN1JNPmumd5n0W4Wvt/xIGG2s9GjvzzDObJX0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Peter Chen <peter.chen@nxp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 066/246] usb: chipidea: Grab the (legacy) USB PHY by phandle first
Date:   Thu,  4 Apr 2019 10:46:06 +0200
Message-Id: <20190404084621.462950971@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
index 7bfcbb23c2a4..016e4004fe9d 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -954,8 +954,15 @@ static int ci_hdrc_probe(struct platform_device *pdev)
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



