Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8655C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4FF20721
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142757;
	bh=5WJiAT5XHNPt7tsfOK7uUb9wu5fkg7bQm1JKF/rfFXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OjNyUzNSluR+eFlw2GkvYZp+rXHG3yohmqJt2x3w75U3dtCjwcLbc8m5xx/qIM/Ml
	 tsikNY8vrgfr3cv+5L5ld3z5KQHclg2krGS3Xq+IbrRoi9V/EYll4la9onvvneHDn5
	 NpT6HQJ2408Vmtrmh+c0AeSX+clt6E1zJE9g+cvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731921AbfKSFwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:52:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:50192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731910AbfKSFw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:52:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46CE720721;
        Tue, 19 Nov 2019 05:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142746;
        bh=5WJiAT5XHNPt7tsfOK7uUb9wu5fkg7bQm1JKF/rfFXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b4BK/dZDKme5aY2wp/OdB7kRKppazbA+WkwdkrPIKFVFvOkBSzzFyaiMpIx28f7CG
         w8tk5ZjlhjE+X/TyPwz235GP03LegUm5TZiR5+0Fv2yO3hE9vTfQHEKCXYnF1cgR+u
         rvabx/aMQWZ0u+RBIeFZ2lK9jktNZ08JlmWvdimQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 187/239] phy: renesas: rcar-gen3-usb2: fix vbus_ctrl for role sysfs
Date:   Tue, 19 Nov 2019 06:19:47 +0100
Message-Id: <20191119051335.261452229@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

[ Upstream commit 09938ea9d136243e8d1fed6d4d7a257764f28f6d ]

This patch fixes and issue that the vbus_ctrl is disabled by
rcar_gen3_init_from_a_peri_to_a_host(), so a usb host cannot
supply the vbus.

Note that this condition will exit when the otg irq happens
even if we don't apply this patch.

Fixes: 9bb86777fb71 ("phy: rcar-gen3-usb2: add sysfs for usb role swap")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index e8fe80312820d..7f5e36bfeee8d 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -195,7 +195,7 @@ static void rcar_gen3_init_from_a_peri_to_a_host(struct rcar_gen3_chan *ch)
 	val = readl(usb2_base + USB2_OBINTEN);
 	writel(val & ~USB2_OBINT_BITS, usb2_base + USB2_OBINTEN);
 
-	rcar_gen3_enable_vbus_ctrl(ch, 0);
+	rcar_gen3_enable_vbus_ctrl(ch, 1);
 	rcar_gen3_init_for_host(ch);
 
 	writel(val | USB2_OBINT_BITS, usb2_base + USB2_OBINTEN);
-- 
2.20.1



