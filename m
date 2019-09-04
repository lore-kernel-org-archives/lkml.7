Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B8BC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653A92339E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620327;
	bh=ewCJZV8Vixq4xGts43VedgHqguAgWQMen+I8V0h/bS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uG0EJg/n5iQJLUJGhsPHTZF3LrKwaAJG4L/Hg83i6eI40rL14Ue8s0o13lMCxeDoM
	 CKtxg+wzURZwW/FvKl6lcbPeWH5zol22Y5lXx51f4yEjDyAtJ5NAAdvIsKELMa2Tyb
	 5pnrObOFAzNs19zvRpj/msoHKocGnl2h2SNb+MwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389258AbfIDSF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:05:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389249AbfIDSFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:05:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DC1923401;
        Wed,  4 Sep 2019 18:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620323;
        bh=ewCJZV8Vixq4xGts43VedgHqguAgWQMen+I8V0h/bS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qto2UubHxonkD9StQq5spXCZFUtf/crTrUHuq6SH/FJkuzR8WxUoiGBH4CUiHA+nV
         /lYLrNrL3SFvNH8fWD/vjRwBs/1acMouRfI8sg3d0c2YApMQE89b8jfLABDq15B83O
         ytedU0OUWR0r043BLtlnYGEnKDF5tzc2bjcxa978=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 16/93] usb: gadget: composite: Clear "suspended" on reset/disconnect
Date:   Wed,  4 Sep 2019 19:53:18 +0200
Message-Id: <20190904175304.656174371@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175302.845828956@linuxfoundation.org>
References: <20190904175302.845828956@linuxfoundation.org>
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
index b8a15840b4ffd..dfcabadeed01b 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1976,6 +1976,7 @@ void composite_disconnect(struct usb_gadget *gadget)
 	 * disconnect callbacks?
 	 */
 	spin_lock_irqsave(&cdev->lock, flags);
+	cdev->suspended = 0;
 	if (cdev->config)
 		reset_config(cdev);
 	if (cdev->driver->disconnect)
-- 
2.20.1



