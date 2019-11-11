Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1686EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12532184C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497386;
	bh=Wr+QOl9fx70tvSuUnMOSAVArjRVbhH+B/hgCt7RzL2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pW5fvARXmcuec+YF04hd12qegqgJER/lMQRRC9AjaZhsPbNVjAT/gV4P3Ev8h5f4c
	 Cd5+Bo5ss+pHT4sC5jl8sXFvu4Ds3wI3LqyOehS3PhYKf4sX/mJ2Cnjo8FDjODoH7D
	 3vJ97J3chdS7/aUvlyyuJ1Ii9iBTaKSDYEbx85UE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfKKSgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:36:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:54600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728701AbfKKSgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:36:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 058562184C;
        Mon, 11 Nov 2019 18:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497380;
        bh=Wr+QOl9fx70tvSuUnMOSAVArjRVbhH+B/hgCt7RzL2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lefi1gxcsa1NGs8ad5kYlriRSYKxD46M6C91FIdr+Rag+jbEH7fTa4xtLBUwbp36i
         HRqgQlhlFdnPNSobYs3ob42KjLmi/fxziKh3QLr/uIeSDArBbcVxtZ+9PqnNidSKcg
         78SLLtJXCkCK95oZycCBWiWlBQde4adEyJVKo9mY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bernd Krumboeck <b.krumboeck@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Johan Hovold <johan@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.14 033/105] can: usb_8dev: fix use-after-free on disconnect
Date:   Mon, 11 Nov 2019 19:28:03 +0100
Message-Id: <20191111181438.542525502@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181421.390326245@linuxfoundation.org>
References: <20191111181421.390326245@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 3759739426186a924675651b388d1c3963c5710e upstream.

The driver was accessing its driver data after having freed it.

Fixes: 0024d8ad1639 ("can: usb_8dev: Add support for USB2CAN interface from 8 devices")
Cc: stable <stable@vger.kernel.org>     # 3.9
Cc: Bernd Krumboeck <b.krumboeck@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/usb/usb_8dev.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/can/usb/usb_8dev.c
+++ b/drivers/net/can/usb/usb_8dev.c
@@ -1007,9 +1007,8 @@ static void usb_8dev_disconnect(struct u
 		netdev_info(priv->netdev, "device disconnected\n");
 
 		unregister_netdev(priv->netdev);
-		free_candev(priv->netdev);
-
 		unlink_all_urbs(priv);
+		free_candev(priv->netdev);
 	}
 
 }


