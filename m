Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AB4C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2856E2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578432012;
	bh=UtDLfCiZ9OSzj/tTpVIGP/rWN4T/vbiXkOGjmBqs1AM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OKi41Z2AJ+lkCjOZHCQGsRK3hzq6Vt36wJbrtvSuB1etqP2jq3Z4riX5TxZNdhNRJ
	 T52mpnLiWNQaYPtUAQmXdmTV6Xze88rh+VirI9RS+duqyQpS6LGBh5s+Y7dMB1+y6G
	 LHob/Qo8WtU7ZfHpkr1ngBOknbimD6jOWsM2jSTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgAGVUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:20:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:49304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728912AbgAGVEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:04:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86B81208C4;
        Tue,  7 Jan 2020 21:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431078;
        bh=UtDLfCiZ9OSzj/tTpVIGP/rWN4T/vbiXkOGjmBqs1AM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qu8Ij76onTex+Tz8BENoija4KG/kdBdcR/U6cR2k+PvI96cRNmZYc96hECDcdsbad
         +WFuEKpm4UG+dlauhkYbkqlq4z1yVrt+ZXGYmSmhkMsYAqIV/O1Sg1y/IzyQ82nzaz
         acFZoY7KsAZWeQ2mt0ovx2xcUWtLFOXEAy9//vqA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        EJ Hsu <ejh@nvidia.com>, Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 024/115] usb: gadget: fix wrong endpoint desc
Date:   Tue,  7 Jan 2020 21:53:54 +0100
Message-Id: <20200107205257.034992085@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205240.283674026@linuxfoundation.org>
References: <20200107205240.283674026@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: EJ Hsu <ejh@nvidia.com>

[ Upstream commit e5b5da96da50ef30abb39cb9f694e99366404d24 ]

Gadget driver should always use config_ep_by_speed() to initialize
usb_ep struct according to usb device's operating speed. Otherwise,
usb_ep struct may be wrong if usb devcie's operating speed is changed.

The key point in this patch is that we want to make sure the desc pointer
in usb_ep struct will be set to NULL when gadget is disconnected.
This will force it to call config_ep_by_speed() to correctly initialize
usb_ep struct based on the new operating speed when gadget is
re-connected later.

Reviewed-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: EJ Hsu <ejh@nvidia.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_ecm.c   | 6 +++++-
 drivers/usb/gadget/function/f_rndis.c | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_ecm.c b/drivers/usb/gadget/function/f_ecm.c
index 6ce044008cf6..460d5d7c984f 100644
--- a/drivers/usb/gadget/function/f_ecm.c
+++ b/drivers/usb/gadget/function/f_ecm.c
@@ -621,8 +621,12 @@ static void ecm_disable(struct usb_function *f)
 
 	DBG(cdev, "ecm deactivated\n");
 
-	if (ecm->port.in_ep->enabled)
+	if (ecm->port.in_ep->enabled) {
 		gether_disconnect(&ecm->port);
+	} else {
+		ecm->port.in_ep->desc = NULL;
+		ecm->port.out_ep->desc = NULL;
+	}
 
 	usb_ep_disable(ecm->notify);
 	ecm->notify->desc = NULL;
diff --git a/drivers/usb/gadget/function/f_rndis.c b/drivers/usb/gadget/function/f_rndis.c
index d48df36622b7..0d8e4a364ca6 100644
--- a/drivers/usb/gadget/function/f_rndis.c
+++ b/drivers/usb/gadget/function/f_rndis.c
@@ -618,6 +618,7 @@ static void rndis_disable(struct usb_function *f)
 	gether_disconnect(&rndis->port);
 
 	usb_ep_disable(rndis->notify);
+	rndis->notify->desc = NULL;
 }
 
 /*-------------------------------------------------------------------------*/
-- 
2.20.1



