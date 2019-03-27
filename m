Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E06C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBACB2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714235;
	bh=aPY0rBGrMUzlRsHQR5wqW6K7ZTdvr/YLHu9e0LxRRck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P79mYUs5PFfVR6UGpBJ0ZzvweojUwSQsDjDBxd5HNtaDPsI7ropRQ0CMROliwMsG3
	 /cNrIyeXo6v2TleKZrDPor+Kp/38h3vhkyDrGb/3Vh9H1nLhCxbH4Gr40wbXvoJp5S
	 voZ6hIJ6AfS+34f7HrofU+oQheWFUa9ciifLtQ9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388641AbfC0TRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:17:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388429AbfC0SIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:08:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F5CB2183E;
        Wed, 27 Mar 2019 18:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710132;
        bh=aPY0rBGrMUzlRsHQR5wqW6K7ZTdvr/YLHu9e0LxRRck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aKR53w/Sx6v1J6O1DwUPsV+m3O0Gye5V/1XgroKL0tOubCzqFKJn5eLUecyOD5+oz
         33bCTPfSipyzVz5QCj2LW2HJ/SEJy2sp/IEo37P+I8lurLmJY16jyX3qApn3GY9amW
         XAvMHW8YBFFF6R9F2/NsXDhNW/XVpo17Ua3X0PqA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Roger Quadros <rogerq@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 210/262] usb: dwc3: gadget: Fix OTG events when gadget driver isn't loaded
Date:   Wed, 27 Mar 2019 14:01:05 -0400
Message-Id: <20190327180158.10245-210-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roger Quadros <rogerq@ti.com>

[ Upstream commit 169e3b68cadb5775daca009ced4faf01ffd97dcf ]

On v3.10a in dual-role mode, if port is in device mode
and gadget driver isn't loaded, the OTG event interrupts don't
come through.

It seems that if the core is configured to be OTG2.0 only,
then we can't leave the DCFG.DEVSPD at Super-speed (default)
if we expect OTG to work properly. It must be set to High-speed.

Fix this issue by configuring DCFG.DEVSPD to the supported
maximum speed at gadget init. Device tree still needs to provide
correct supported maximum speed for this to work.

This issue wasn't present on v2.40a but is seen on v3.10a.
It doesn't cause any side effects on v2.40a.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 6c9b76bcc2e1..8d1dbe36db92 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3339,6 +3339,8 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 		goto err4;
 	}
 
+	dwc3_gadget_set_speed(&dwc->gadget, dwc->maximum_speed);
+
 	return 0;
 
 err4:
-- 
2.19.1

