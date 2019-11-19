Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D589FC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C58920872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574143060;
	bh=ChU4/sQIlhrMtWXNKZFawHzXhtYBs37P5LZKj8KiEgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F7jeu/EfFFOQ4rsiTUoEFPVEfniSopH+n7C3Q8TKs7Zv3hfPJ2BUFy+YloUhzB3GM
	 O/dnBMFu7hfKBIT3FwBo4B1pwAHHtZTnwAhsQ36EzI7Uy0SA+qYBc8NohGLsG8txtr
	 9zw4/Z0FRyYYInoUADv3moSdECt8GYMDxCjK4Uus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731732AbfKSFvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:51:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:48362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730856AbfKSFvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:51:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B10C20862;
        Tue, 19 Nov 2019 05:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142661;
        bh=ChU4/sQIlhrMtWXNKZFawHzXhtYBs37P5LZKj8KiEgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I9lgThtJgDT7UbowH3hcMR4eez/rIpH5iE3fbw4ziH4B/pJWNP3Yiw5h41qrieVL2
         xWUGqfc5VPnBTeRbPTP0rAtSY2Im1HtllDvwWbwEwAsPD+D9Bupr2QFXqnKAIYcfAZ
         nqyrStlJUeSi1TrBwEfa77imI3sT1R6HFwFwAqJY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolas Adell <nicolas.adell@actia.fr>,
        Peter Chen <peter.chen@nxp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 156/239] usb: chipidea: imx: enable OTG overcurrent in case USB subsystem is already started
Date:   Tue, 19 Nov 2019 06:19:16 +0100
Message-Id: <20191119051333.071793617@linuxfoundation.org>
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

From: Nicolas Adell <nicolas.adell@actia.fr>

[ Upstream commit 1dedbdf2bbb1ede8d96f35f9845ecae179dc1988 ]

When initializing the USB subsystem before starting the kernel,
OTG overcurrent detection is disabled. In case the OTG polarity of
overcurrent is low active, the overcurrent detection is never enabled
again and events cannot be reported as expected. Because imx usb
overcurrent polarity is low active by default, only detection needs
to be enable in usbmisc init function.

Signed-off-by: Nicolas Adell <nicolas.adell@actia.fr>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/chipidea/usbmisc_imx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index 9f4a0185dd609..b7477fd4443a3 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -343,6 +343,8 @@ static int usbmisc_imx6q_init(struct imx_usbmisc_data *data)
 	} else if (data->oc_polarity == 1) {
 		/* High active */
 		reg &= ~(MX6_BM_OVER_CUR_DIS | MX6_BM_OVER_CUR_POLARITY);
+	} else {
+		reg &= ~(MX6_BM_OVER_CUR_DIS);
 	}
 	writel(reg, usbmisc->base + data->index * 4);
 
-- 
2.20.1



