Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668ECC2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379EE21D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576853257;
	bh=gqXR/b1oGgLkrgZkz7S69ccDbcOyCHNEvxnrt3O0anY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oMpi68kDGlKEocJ+O+NsFAhw66hQXoSm9bLalw2W5gRMpTTXPbeT+Sm1vwatGg8mX
	 uh8GrpppDK38yolq0zS6XgXcgrDXMa7wc2fPD6Cw9+h2ttHgWvlDjW2nnxkXDT1tK6
	 LziH3k+WtfZU+MH78GmWpfARVwAExp35z6ct9WoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfLTOrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:47:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:45322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727534AbfLTOrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:47:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFFA921D7E;
        Fri, 20 Dec 2019 14:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576853228;
        bh=gqXR/b1oGgLkrgZkz7S69ccDbcOyCHNEvxnrt3O0anY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WX2TVvigu4N881U6X9IKLXjWprUhpZyZKKiGvzwTl0EfydmAvwmidlhwqqglBso5f
         D74qQUQmT05gj7+aBU0mKZ3A2sWcKTuLiXCoX3mLsHsu/Zv+UEv3DAjyy7FeP9T2za
         UEcl+1E1kMze/XoqW55H+3ehMh2ENgK348zDOklI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     EJ Hsu <ejh@nvidia.com>, Peter Chen <peter.chen@nxp.com>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 07/14] usb: gadget: fix wrong endpoint desc
Date:   Fri, 20 Dec 2019 09:46:51 -0500
Message-Id: <20191220144658.10414-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220144658.10414-1-sashal@kernel.org>
References: <20191220144658.10414-1-sashal@kernel.org>
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
index 4c488d15b6f6e..dc99ed94f03d2 100644
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
index ba00cdb809d65..865cb070bf8b3 100644
--- a/drivers/usb/gadget/function/f_rndis.c
+++ b/drivers/usb/gadget/function/f_rndis.c
@@ -622,6 +622,7 @@ static void rndis_disable(struct usb_function *f)
 	gether_disconnect(&rndis->port);
 
 	usb_ep_disable(rndis->notify);
+	rndis->notify->desc = NULL;
 }
 
 /*-------------------------------------------------------------------------*/
-- 
2.20.1

