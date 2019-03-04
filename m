Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F11DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E24720823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551687844;
	bh=Bgk4qGU3EPODYFw93RImlC3rczIVcqT8f4/SQDGPns4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JeELxcVp/ZSQkK8zHLSjo0+Ht/Miz4tUkZsGy9OFsYnGQZm+w7212SmNQPAe3BRE4
	 ZDexYo9VEZ9j7H7A9AF1RLBchDAfrg/C/s7iMqVsPaTF1krj3H7WcJY5lANJ+SQu9p
	 T44c79/TNfUUGuDn63X/J8cd+/gbaPs/gdFA2iK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfCDIYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:24:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:41080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbfCDIX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:23:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D653C20823;
        Mon,  4 Mar 2019 08:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551687839;
        bh=Bgk4qGU3EPODYFw93RImlC3rczIVcqT8f4/SQDGPns4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0i/N9I6KNN3wlYE+QEw9w5OLeGNVcB9MhJimkmoPCCzoVWH+ZXSiRHtILFBAm6Qxz
         SWvEpdg16Y6IK0hTlXT0lB/VNpHXwujVKdjMbecg0M41U32vxmuHlzNL9MJvggDnZL
         bowP2csqW1vSn+AzPprlkv3vWa42E02NepYwIWp8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bo He <bo.he@intel.com>,
        Yu Wang <yu.y.wang@intel.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 09/32] usb: dwc3: gadget: synchronize_irq dwc irq in suspend
Date:   Mon,  4 Mar 2019 09:21:57 +0100
Message-Id: <20190304081602.976704195@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081602.307094059@linuxfoundation.org>
References: <20190304081602.307094059@linuxfoundation.org>
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
index ed6b9bfe37595..c481df18a5a1d 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3096,6 +3096,8 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 	dwc3_disconnect_gadget(dwc);
 	__dwc3_gadget_stop(dwc);
 
+	synchronize_irq(dwc->irq_gadget);
+
 	return 0;
 }
 
-- 
2.19.1



