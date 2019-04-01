Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76873C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D81E21929
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138336;
	bh=KjLzLBfuQ2nPaUjm5LYO5Yja9gtR3dXnjiZFOrhbc4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1onpNa6B2CwlWHXHm7HJleWCLfHCPYv3bArnfdmp/5lh5Ug5E4bd9+Qe9uKwxURaI
	 uPPAmaiu2GM0wGHfxoYmyUKaT1sdV+/gPKx+2Shq3+kTNoCvrPY+V9uxu3gHqLjyxB
	 TpcCBbAy9QntPQEi51/UmBm9VAyhhsk7xURUSyeg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbfDARFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:05:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbfDARFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:05:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F89721929;
        Mon,  1 Apr 2019 17:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138333;
        bh=KjLzLBfuQ2nPaUjm5LYO5Yja9gtR3dXnjiZFOrhbc4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qq43wv6+bNYfAl2M9pypwrRDwo8eKJGKZbL2T4sVnCg8FEnFn+Nhsroy1DTSuTqp+
         V/X1usx62i/eNDyYg0rR8W8tSdC9sLkJZnSDMowWJXPVs5v6SGgM6NJpfg0bWAjwVs
         eERIXGKgiafN/nCiZLCg7TOoM7j3iEXmfdUsDla4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bartosz Skrzypczak <barteks2x@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 034/146] r8169: fix cable re-plugging issue
Date:   Mon,  1 Apr 2019 19:00:46 +0200
Message-Id: <20190401170051.392648960@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 23c78343ec36990709b636a9e02bad814f4384ad ]

Bartek reported that after few cable unplug/replug cycles suddenly
replug isn't detected any longer. His system uses a RTL8106, I wasn't
able to reproduce the issue with RTL8168g. According to his bisect
the referenced commit caused the regression. As Realtek doesn't
release datasheets or errata it's hard to say what's the actual root
cause, but this change was reported to fix the issue.

Fixes: 38caff5a445b ("r8169: handle all interrupt events in the hard irq handler")
Reported-by: Bartosz Skrzypczak <barteks2x@gmail.com>
Suggested-by: Bartosz Skrzypczak <barteks2x@gmail.com>
Tested-by: Bartosz Skrzypczak <barteks2x@gmail.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -6435,7 +6435,7 @@ static irqreturn_t rtl8169_interrupt(int
 		set_bit(RTL_FLAG_TASK_RESET_PENDING, tp->wk.flags);
 	}
 
-	if (status & RTL_EVENT_NAPI) {
+	if (status & (RTL_EVENT_NAPI | LinkChg)) {
 		rtl_irq_disable(tp);
 		napi_schedule_irqoff(&tp->napi);
 	}


