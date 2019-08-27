Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0D0C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBBD2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566893071;
	bh=2dRn00LojGwN73Wm1vY5kKOfWzzN/D+7+cAGbm5UDzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TSLjxiobyDrZhmNl48gkA5buhOyPEZWiMCbGNQP+GMtRjYFfkq0z5IcYIxbVFapT3
	 s/ed0Le83UBU8Zq2GrOe8iH9VXRrAA/cXA86GrIh+C6pLsyyiwlZEmDugEPoGPT4Vy
	 ZPfyiOXbqBFxvXVNyjROy2LBnb9dzlWWHbafWI8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732576AbfH0IE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:04:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732091AbfH0IE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:04:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F3A521883;
        Tue, 27 Aug 2019 08:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566893066;
        bh=2dRn00LojGwN73Wm1vY5kKOfWzzN/D+7+cAGbm5UDzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xzooVQAprR24IWJ1wk733ws3+edn/K4XOa+4oeOLm2v6/t4WOsUNmR3wpI9gFLbFI
         +wSxFiDIZPGLhOyCvbWAZNgwljX0q8fO4ceUNZU5/uhBnWWSvVKiOl/nID5J0w6cBl
         duVY7Vsx8dpm8RFhx01CaDMh9/hrsJc4YOH1oeMU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wang Xiayang <xywang.sjtu@sjtu.edu.cn>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 067/162] can: peak_usb: force the string buffer NULL-terminated
Date:   Tue, 27 Aug 2019 09:49:55 +0200
Message-Id: <20190827072740.483247514@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072738.093683223@linuxfoundation.org>
References: <20190827072738.093683223@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e787f19373b8a5fa24087800ed78314fd17b984a ]

strncpy() does not ensure NULL-termination when the input string size
equals to the destination buffer size IFNAMSIZ. The output string is
passed to dev_info() which relies on the NULL-termination.

Use strlcpy() instead.

This issue is identified by a Coccinelle script.

Signed-off-by: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 22b9c8e6d040a..65dce642b86b5 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -855,7 +855,7 @@ static void peak_usb_disconnect(struct usb_interface *intf)
 
 		dev_prev_siblings = dev->prev_siblings;
 		dev->state &= ~PCAN_USB_STATE_CONNECTED;
-		strncpy(name, netdev->name, IFNAMSIZ);
+		strlcpy(name, netdev->name, IFNAMSIZ);
 
 		unregister_netdev(netdev);
 
-- 
2.20.1



