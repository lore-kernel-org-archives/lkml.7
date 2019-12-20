Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2283AC2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC188218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576853299;
	bh=dLuiV+41+Zr+1JnYNmm/BP9Wr764/LiVgyFp/WrtiLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W8BwNMwV4NOgKsERWfHQJhmo1myKnzVfA7grQm2K314G8mjTIdPT0yFz3B+aNKa90
	 fjX1kYpLrpO6HDhizrksLOlbRXp0RvbmqyWZE+LdT+ikXwVv+cf9OH7kdqNIQaxJyu
	 tH2S40dlCaIBHL+fWbW1hmdXuYw4SnMxEihRR2DM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfLTOsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:48:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:46304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727874AbfLTOrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:47:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8335524683;
        Fri, 20 Dec 2019 14:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576853273;
        bh=dLuiV+41+Zr+1JnYNmm/BP9Wr764/LiVgyFp/WrtiLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=va58UXWsEtGrgf1tYAufLlKI3+1rJHZ0+XcuaEnSAqs46Tkr0sT3K/TsAGopYJeMh
         fdOHYraVXsR3x4UCO5h8Pv9jlLuWMnj0EFv1J1T/5CMnlMPVsXEy54C5X9EmXG+1aN
         9sLpaxVM7wwllq+7aQJRAtPxqDAEqOSGw8CH6nbQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     EJ Hsu <ejh@nvidia.com>, Peter Chen <peter.chen@nxp.com>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 07/11] usb: gadget: fix wrong endpoint desc
Date:   Fri, 20 Dec 2019 09:47:39 -0500
Message-Id: <20191220144744.10565-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220144744.10565-1-sashal@kernel.org>
References: <20191220144744.10565-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 7ad60ee419144..4ce19b8602897 100644
--- a/drivers/usb/gadget/function/f_ecm.c
+++ b/drivers/usb/gadget/function/f_ecm.c
@@ -625,8 +625,12 @@ static void ecm_disable(struct usb_function *f)
 
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
index e587767e374cb..e281af92e0844 100644
--- a/drivers/usb/gadget/function/f_rndis.c
+++ b/drivers/usb/gadget/function/f_rndis.c
@@ -619,6 +619,7 @@ static void rndis_disable(struct usb_function *f)
 	gether_disconnect(&rndis->port);
 
 	usb_ep_disable(rndis->notify);
+	rndis->notify->desc = NULL;
 }
 
 /*-------------------------------------------------------------------------*/
-- 
2.20.1

