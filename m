Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CF3C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF1D21655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498420;
	bh=lktJg6oZYRM1OuKK64MTCqPEC28QSDejLyJt+Z57NN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zdpxXM3TOh5antafEqpdVW8fmCJlY9q43xKLqdKnuPs5BgTTDcl+4gDPN0vNdhooi
	 bACoSYZk1aBaI9m5ab08MSSBeS0icD55ipAGAev23XXXJZQAPxfQLA3kPWaS/lCvi8
	 cUYM487uOx5rivr4aKajFtIfk5YUN15OyvOPksi0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfKKSxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:53:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:48396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728555AbfKKSxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:53:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18C12214E0;
        Mon, 11 Nov 2019 18:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498413;
        bh=lktJg6oZYRM1OuKK64MTCqPEC28QSDejLyJt+Z57NN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vJizKnYpncqmxIRh3qXqIns0kS7bfK2wVCgkbBPPtwSJ3ahQbldoYk/qpBzalxGs+
         Lm7TgosLKiUniNJFVBXJHjC/neIfiy7VJq9LFPEUtQOyeJI067aBCrwa2R8D7K6zqW
         ktVFnK5EgIUbkMfsNOq1+WIDZ9mIjjns6Koai66o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bernd Krumboeck <b.krumboeck@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Johan Hovold <johan@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.3 072/193] can: usb_8dev: fix use-after-free on disconnect
Date:   Mon, 11 Nov 2019 19:27:34 +0100
Message-Id: <20191111181506.420910786@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
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
@@ -996,9 +996,8 @@ static void usb_8dev_disconnect(struct u
 		netdev_info(priv->netdev, "device disconnected\n");
 
 		unregister_netdev(priv->netdev);
-		free_candev(priv->netdev);
-
 		unlink_all_urbs(priv);
+		free_candev(priv->netdev);
 	}
 
 }


