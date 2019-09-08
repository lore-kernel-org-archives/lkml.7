Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8FFC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC65216C8
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947473;
	bh=2qd5XuxST3w2t01MawjYozqJlGP8gqw1nAIGoR8AAVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UTl11T9l8/tmsb5Z/O/tdKMAY3GWt3z67GYqYcaCazi5qRS0xDMNG+rlJsEjOVOKm
	 g0D8/JZj0gCXH6P/AYq6bIDEtiI7C/2DGY+zSSqmrdgniAZcQ177WRdSNPemJd04/C
	 qn7WWViCOeSLJQQmjo4GlbC17cdkhCWcfhVM2slw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfIHM5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:57:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbfIHMrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:47:51 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59202218AC;
        Sun,  8 Sep 2019 12:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946870;
        bh=2qd5XuxST3w2t01MawjYozqJlGP8gqw1nAIGoR8AAVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c+Q1Cvjbo6E+IIkYC97NWIKOEC9M71NaH4f1FnQZFimufIBeYS3G7/vcBKMJdaCMo
         Q2fFpyHJFcMc6X99cikvTrRCdDUGhJz7UsyKya8ii9lY1RFd4ijyxNpm0KYe8tExoB
         da+ZTFfaZaq1AeYmgauVeuDZXXyPpuAoSPZ91FKs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 30/57] lan78xx: Fix memory leaks
Date:   Sun,  8 Sep 2019 13:41:54 +0100
Message-Id: <20190908121137.305197779@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121125.608195329@linuxfoundation.org>
References: <20190908121125.608195329@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b9cbf8a64865b50fd0f4a3915fa00ac7365cdf8f ]

In lan78xx_probe(), a new urb is allocated through usb_alloc_urb() and
saved to 'dev->urb_intr'. However, in the following execution, if an error
occurs, 'dev->urb_intr' is not deallocated, leading to memory leaks. To fix
this issue, invoke usb_free_urb() to free the allocated urb before
returning from the function.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/lan78xx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 8d140495da79d..e20266bd209e2 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3799,7 +3799,7 @@ static int lan78xx_probe(struct usb_interface *intf,
 	ret = register_netdev(netdev);
 	if (ret != 0) {
 		netif_err(dev, probe, netdev, "couldn't register the device\n");
-		goto out3;
+		goto out4;
 	}
 
 	usb_set_intfdata(intf, dev);
@@ -3814,12 +3814,14 @@ static int lan78xx_probe(struct usb_interface *intf,
 
 	ret = lan78xx_phy_init(dev);
 	if (ret < 0)
-		goto out4;
+		goto out5;
 
 	return 0;
 
-out4:
+out5:
 	unregister_netdev(netdev);
+out4:
+	usb_free_urb(dev->urb_intr);
 out3:
 	lan78xx_unbind(dev, intf);
 out2:
-- 
2.20.1



