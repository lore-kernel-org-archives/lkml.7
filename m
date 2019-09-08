Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EE6C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E192B21479
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947071;
	bh=aRAbFHpRb2erDfCo+7+WNnl1jZnuKdO2GYEvustH5XM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KcUnVW+UgCX8F1A3g/sHbw+b7kTyjgac4ZjZmvrsysY1/xudXJ/cGEuJKZe+8t+/N
	 kJu+pkPIVOaSZMdr95DUeYByUudqFUndHrQb38GqmCf1LeEjluIcL6Umr879DrpQJt
	 +f64awaqKEI93WkovHVDJq8c+FpqxDGOjTNIzakQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732481AbfIHMvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:51:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732443AbfIHMvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:51:05 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 317E420863;
        Sun,  8 Sep 2019 12:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567947063;
        bh=aRAbFHpRb2erDfCo+7+WNnl1jZnuKdO2GYEvustH5XM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gfLNFwX0WOilUtWKB9nYBJGbZiIU9kuafnhf7tId/NhooiMoKCjEW7o8PwdNMp3x4
         fXpVXIrmFECXI0NrCiC/ugkJSxStUXGi4WFij6vO6MJnGrzrvGFp1E4Y25InKWieI9
         f+fFkQcPXL93hpPOpnKmk7EnBVy75LOKSWeSX/bU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hayes Wang <hayeswang@realtek.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 10/94] Revert "r8152: napi hangup fix after disconnect"
Date:   Sun,  8 Sep 2019 13:41:06 +0100
Message-Id: <20190908121150.726876315@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121150.420989666@linuxfoundation.org>
References: <20190908121150.420989666@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hayes Wang <hayeswang@realtek.com>

[ Upstream commit 49d4b14113cae1410eb4654ada5b9583bad971c4 ]

This reverts commit 0ee1f4734967af8321ecebaf9c74221ace34f2d5.

The commit 0ee1f4734967 ("r8152: napi hangup fix after
disconnect") adds a check about RTL8152_UNPLUG to determine
if calling napi_disable() is invalid in rtl8152_close(),
when rtl8152_disconnect() is called. This avoids to use
napi_disable() after calling netif_napi_del().

Howver, commit ffa9fec30ca0 ("r8152: set RTL8152_UNPLUG
only for real disconnection") causes that RTL8152_UNPLUG
is not always set when calling rtl8152_disconnect().
Therefore, I have to revert commit 0ee1f4734967 ("r8152:
napi hangup fix after disconnect"), first. And submit
another patch to fix it.

Signed-off-by: Hayes Wang <hayeswang@realtek.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/r8152.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -3987,8 +3987,7 @@ static int rtl8152_close(struct net_devi
 #ifdef CONFIG_PM_SLEEP
 	unregister_pm_notifier(&tp->pm_notifier);
 #endif
-	if (!test_bit(RTL8152_UNPLUG, &tp->flags))
-		napi_disable(&tp->napi);
+	napi_disable(&tp->napi);
 	clear_bit(WORK_ENABLE, &tp->flags);
 	usb_kill_urb(tp->intr_urb);
 	cancel_delayed_work_sync(&tp->schedule);


