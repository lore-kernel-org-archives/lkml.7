Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3875C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2C022DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566308627;
	bh=9OlZB1SIM25pkJE3ga0tEXXnJrGZCPZFO/05WK6Pi9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fe7kRgJL9/igSW0yz4F2t6jL7rJQWYsxRQpm75JjbI4X265cN/tgqztl1ia2pd4PL
	 VJrRrg1FShf3vnzrEpffHPqxbhZMvNWCOAamtT7mO1qRUwlIU1Ro9ubcJcsHkyJxWH
	 aGevjyszZfq9/5zcQjKRsftkQ275Qxq7ChHC1bMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbfHTNnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:43:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730861AbfHTNn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:43:29 -0400
Received: from sasha-vm.mshome.net (unknown [12.236.144.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D55A22DBF;
        Tue, 20 Aug 2019 13:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566308608;
        bh=9OlZB1SIM25pkJE3ga0tEXXnJrGZCPZFO/05WK6Pi9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HCTmKqQXu5D1KyBhSmrNH8JYtvEcFdXllv4EEJtVwhirMzqX+MvWZWAP6g1oefIsH
         ZAOS88iD7IMheAhh1sY9jHbnLDYo89rW1nIcXfB/YFy5GOtzjyWo2oR8DPETyDbCb7
         t0wIDYv/fLIdxzEjk9+3DzIY181ABv9jRnz6BojU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 2/4] usb: gadget: composite: Clear "suspended" on reset/disconnect
Date:   Tue, 20 Aug 2019 09:43:23 -0400
Message-Id: <20190820134325.11825-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190820134325.11825-1-sashal@kernel.org>
References: <20190820134325.11825-1-sashal@kernel.org>
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
index 8bf54477f4724..351a406b97af7 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1889,6 +1889,7 @@ void composite_disconnect(struct usb_gadget *gadget)
 	 * disconnect callbacks?
 	 */
 	spin_lock_irqsave(&cdev->lock, flags);
+	cdev->suspended = 0;
 	if (cdev->config)
 		reset_config(cdev);
 	if (cdev->driver->disconnect)
-- 
2.20.1

