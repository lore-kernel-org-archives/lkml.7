Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BDCC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BD22339E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620039;
	bh=Ob8Ez63TgL5DoYruVm64lr3oMt7wdyGs8zfXlq9eOEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oru0vWgihpnWj+2Pn6ycmFEgdOz3dniaFZmivJqlt2wO71KD9KtBzJCsGupaYvBJS
	 /hr+5vhovU4Scx5OPd5z5Rgf7U2hfATRBs+ZgO2pj2ns64cF++Vv7G76yLW64+SEjy
	 1sZ8my3iw6u3w8soxz5kGInB+hmogFj5vCcRBsN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388424AbfIDSAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:00:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388416AbfIDSAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:00:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7603622CF7;
        Wed,  4 Sep 2019 18:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620034;
        bh=Ob8Ez63TgL5DoYruVm64lr3oMt7wdyGs8zfXlq9eOEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hpg/dLqFBgK9wz/STlUiGnAeFGSDz09x2wPDrbvQQ5FVT64HODoJ2uzlDfmBQvHmk
         VtPGnWLmDFxkjFsJdPEZ7sm47HzXabWctV6t56YT4XmlNByYsTJgf2LWnl1c/5xg7c
         +JB8h8N8c1OK4FhyxLHClmNVzL1eRWlk761ZOBQE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 48/83] usb: gadget: composite: Clear "suspended" on reset/disconnect
Date:   Wed,  4 Sep 2019 19:53:40 +0200
Message-Id: <20190904175308.057462359@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175303.488266791@linuxfoundation.org>
References: <20190904175303.488266791@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 602fda17c7356bb7ae98467d93549057481d11dd ]

In some cases, one can get out of suspend with a reset or
a disconnect followed by a reconnect. Previously we would
leave a stale suspended flag set.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/composite.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 2c022a08f1638..9fa168af847b5 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -2000,6 +2000,7 @@ void composite_disconnect(struct usb_gadget *gadget)
 	 * disconnect callbacks?
 	 */
 	spin_lock_irqsave(&cdev->lock, flags);
+	cdev->suspended = 0;
 	if (cdev->config)
 		reset_config(cdev);
 	if (cdev->driver->disconnect)
-- 
2.20.1



