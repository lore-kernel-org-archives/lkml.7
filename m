Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D668DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E2E20659
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573499288;
	bh=qcPbvtM5qo4M4GqJ3W/AShFZvu0AH5WXdRDV5Xr6KZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2NEazdYY4BjNRH+5bdQth2OpADwc9YvBO9aJTjjXN846yrJ9/c2DfxOcmjahJ1VG8
	 gaOKj6zzE86m5sqAMKINzRhWqgP8PF3/bK1SZXX0/1NAdPMsOFzpN7Q93khiklJeud
	 vcl71YkLbaYT5MtTDVdDQ5M2KBVEY+F3Kv60KVzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfKKTIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 14:08:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:54968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728094AbfKKSgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:36:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D25EF214E0;
        Mon, 11 Nov 2019 18:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497395;
        bh=qcPbvtM5qo4M4GqJ3W/AShFZvu0AH5WXdRDV5Xr6KZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SyasF9SvyehqFCdVnQJzArRIffG272Y0a2SjeF3ge2+TcjiQw+U3BNTh8RI0/wHqf
         hA5KaG13+Rp2p/I8GiPZYR+S+lBouz9vJKzcfCeVieJm/vWGGg21gvih8GYt2Kap3a
         IlBaXixioDb70ja7imylhhBQn0kaCz3ZD+F5u4vQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Remigiusz=20Ko=C5=82=C5=82=C4=85taj?= 
        <remigiusz.kollataj@mobica.com>,
        syzbot+e29b17e5042bbc56fae9@syzkaller.appspotmail.com,
        Johan Hovold <johan@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.14 038/105] can: mcba_usb: fix use-after-free on disconnect
Date:   Mon, 11 Nov 2019 19:28:08 +0100
Message-Id: <20191111181439.574228969@linuxfoundation.org>
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

commit 4d6636498c41891d0482a914dd570343a838ad79 upstream.

The driver was accessing its driver data after having freed it.

Fixes: 51f3baad7de9 ("can: mcba_usb: Add support for Microchip CAN BUS Analyzer")
Cc: stable <stable@vger.kernel.org>     # 4.12
Cc: Remigiusz Kołłątaj <remigiusz.kollataj@mobica.com>
Reported-by: syzbot+e29b17e5042bbc56fae9@syzkaller.appspotmail.com
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/usb/mcba_usb.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/can/usb/mcba_usb.c
+++ b/drivers/net/can/usb/mcba_usb.c
@@ -887,9 +887,8 @@ static void mcba_usb_disconnect(struct u
 	netdev_info(priv->netdev, "device disconnected\n");
 
 	unregister_candev(priv->netdev);
-	free_candev(priv->netdev);
-
 	mcba_urb_unlink(priv);
+	free_candev(priv->netdev);
 }
 
 static struct usb_driver mcba_usb_driver = {


