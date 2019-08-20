Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A546C3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90122087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566308732;
	bh=kXSeYWt+bD1ow5Uhihen5Xi5cjzvPtkAfZ/Go6Tj6Bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ldO/voKvwjLo54Fy5WnKsg+lWZ8lPVQ47jPgub6JwFEeBzs5n3wfV/O1K7vGiJTBW
	 A06a5zx57p+UALoANcleRpc3sx/7BKgu2xaqKmjWzxFKjRVV54JloI/uu4GwO3RiJl
	 coHWbgKzJGZgb4FI1QsxGWTRabeUavjEjckIes84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbfHTNmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:42:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730667AbfHTNmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:42:35 -0400
Received: from sasha-vm.mshome.net (unknown [12.236.144.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3670122DA9;
        Tue, 20 Aug 2019 13:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566308554;
        bh=kXSeYWt+bD1ow5Uhihen5Xi5cjzvPtkAfZ/Go6Tj6Bg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KqWdsLrO+S0+LOOHyMrit/i7vRXH6MCg14TdxCiWMeE3q0xWXpN2NVINLLk5MDVoa
         mzxdxu+oBZYtZggOO0Xis8JITBLDcCg6KK/6E59O4rtTIr+aj4QaPxn5KmwtQ9C5hc
         Pv7ylpMLtQUgH2ArYTL68qlmyME2FsOmqBoMipvw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 18/27] usb: gadget: composite: Clear "suspended" on reset/disconnect
Date:   Tue, 20 Aug 2019 09:42:04 -0400
Message-Id: <20190820134213.11279-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190820134213.11279-1-sashal@kernel.org>
References: <20190820134213.11279-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

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

