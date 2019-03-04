Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37969C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06C420823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688040;
	bh=eK11qoZhUAhE42mY1zI40rxi7D/GgiMPrK+oLjFFgKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y+tw5tnrXHvv7vWNz5wY3MxqyALvXPmnl2J8x3+qNpToumecQH9+1lpPUBnyw4NXQ
	 HZ60uu9RQ/AyLBeBEyZXbrCvVdB2YgNBi/wje3LAkX1rF/BXYRJV5e7BfyZuNlYGer
	 LpN80Z0v6OT0n7iRlTSTlqNs0LgQzjUihs2bl2oo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfCDI1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:27:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:50242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbfCDI1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:27:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 330F920823;
        Mon,  4 Mar 2019 08:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688032;
        bh=eK11qoZhUAhE42mY1zI40rxi7D/GgiMPrK+oLjFFgKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wTUwLEqckeYc6++XyeJ61eChdkoR3w/4d8HiIhEHjpwNfitA5/hWlZ2D1x7bRnjDr
         vYAWiHCDBQDkNl+gN26gwn8+AFPgE4WMddU43gxTiDsRmEp3mXtExRvbLu31pzcYbg
         YTIRxqqj6j1vMrOvekKfNGvQ1ya8WUlOX3tEmvYI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bo He <bo.he@intel.com>,
        Yu Wang <yu.y.wang@intel.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 13/52] usb: dwc3: gadget: synchronize_irq dwc irq in suspend
Date:   Mon,  4 Mar 2019 09:22:11 +0100
Message-Id: <20190304081617.875786412@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081617.159014799@linuxfoundation.org>
References: <20190304081617.159014799@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 01c10880d24291a96a4ab0da773e3c5ce4d12da8 ]

We see dwc3 endpoint stopped by unwanted irq during
suspend resume test, which is caused dwc3 ep can't be started
with error "No Resource".

Here, add synchronize_irq before suspend to sync the
pending IRQ handlers complete.

Signed-off-by: Bo He <bo.he@intel.com>
Signed-off-by: Yu Wang <yu.y.wang@intel.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 2f96d2d0addd1..5da078bf5f76a 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3327,6 +3327,8 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 	dwc3_disconnect_gadget(dwc);
 	__dwc3_gadget_stop(dwc);
 
+	synchronize_irq(dwc->irq_gadget);
+
 	return 0;
 }
 
-- 
2.19.1



