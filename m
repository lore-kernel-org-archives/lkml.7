Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9C0C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E3B225AD
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573354170;
	bh=hdjgwnbCXaX75t0UDxSR3kAVZIU9Y421d0mh+DbJK0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xVwTLAwJFMua0zQPPq92E5+LACV7dfTWJya//gsBsq0R93n8uv0bv0aTXdyxObXVq
	 WpNA2kLmqjcbkN/4vcZiQ0TJufizEbyZGJSNuEacAdBE8s/GHlvp9+QIZ4P6CLR007
	 1c0BWp+FgjcLwvB922z72Qx8dFe7tr4nCcNrX+ms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbfKJCt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:49:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:58166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728520AbfKJCtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:49:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D2D6225AD;
        Sun, 10 Nov 2019 02:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573354158;
        bh=hdjgwnbCXaX75t0UDxSR3kAVZIU9Y421d0mh+DbJK0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GLkvVpWxcHSuIfpPspY/JzQfQRr/z8U/wEgci0ehaOdIjcyqCpRdnIabsujTNyjXE
         y8F6Oq8lucfv4iIqB83G0Jpv4gZ6/xcWcCPpc1Hz3y5IGwLV1Pnr0UAorWzP9MYsy+
         yfj7e22BIcXWXvaR7O/GVHyAbqfE2RmSpbDWkokk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicolas Adell <nicolas.adell@actia.fr>,
        Peter Chen <peter.chen@nxp.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 15/66] usb: chipidea: imx: enable OTG overcurrent in case USB subsystem is already started
Date:   Sat,  9 Nov 2019 21:47:54 -0500
Message-Id: <20191110024846.32598-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024846.32598-1-sashal@kernel.org>
References: <20191110024846.32598-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 20d02a5e418d9..c6577f489d0f6 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -273,6 +273,8 @@ static int usbmisc_imx6q_init(struct imx_usbmisc_data *data)
 	} else if (data->oc_polarity == 1) {
 		/* High active */
 		reg &= ~(MX6_BM_OVER_CUR_DIS | MX6_BM_OVER_CUR_POLARITY);
+	} else {
+		reg &= ~(MX6_BM_OVER_CUR_DIS);
 	}
 	writel(reg, usbmisc->base + data->index * 4);
 
-- 
2.20.1

