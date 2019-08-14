Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B91C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56EEA208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565803062;
	bh=8xpq1kUpLr93vF53RBiQDurISld0SNEozVxZw8bXAiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MEU+WrAsg/fjGjq/V2lNcJhuzQPPM7tRByFTOCDWu2Oq1PEgwyFGeZvqVPxcNINR6
	 QWt4VFHlTLIz1zhHpcs5LxeIwL5yGWBOB4Z5VUhrqdiEultCFnc+GqAznfuVYTQ9Vu
	 A/kKlAFW8cskqjPikxbmdMTrAm7wY+Z8mN4Ju5G8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbfHNRNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:13:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730817AbfHNRND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:13:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9393B2063F;
        Wed, 14 Aug 2019 17:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802782;
        bh=8xpq1kUpLr93vF53RBiQDurISld0SNEozVxZw8bXAiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oaHW9v0U3rWgngZ6jwuthAOKwsECD1xCrDASspalJo8Ep/sKsYg/Fog8+bh8GXJZ0
         x59aj+ry7gmLPGjQDCoesRqDEABJDmaFptz4BI1+Oc7yu/0HBKmHWEhagAXDSHqJn/
         1HG3/GzCWOgdnp2jwGl64/6PJ0/VYHF0a2J6xoNU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.14 24/69] can: peak_usb: fix potential double kfree_skb()
Date:   Wed, 14 Aug 2019 19:01:22 +0200
Message-Id: <20190814165747.121465841@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165744.822314328@linuxfoundation.org>
References: <20190814165744.822314328@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Grosjean <s.grosjean@peak-system.com>

commit fee6a8923ae0d318a7f7950c6c6c28a96cea099b upstream.

When closing the CAN device while tx skbs are inflight, echo skb could
be released twice. By calling close_candev() before unlinking all
pending tx urbs, then the internal echo_skb[] array is fully and
correctly cleared before the USB write callback and, therefore,
can_get_echo_skb() are called, for each aborted URB.

Fixes: bb4785551f64 ("can: usb: PEAK-System Technik USB adapters driver core")
Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -594,16 +594,16 @@ static int peak_usb_ndo_stop(struct net_
 	dev->state &= ~PCAN_USB_STATE_STARTED;
 	netif_stop_queue(netdev);
 
+	close_candev(netdev);
+
+	dev->can.state = CAN_STATE_STOPPED;
+
 	/* unlink all pending urbs and free used memory */
 	peak_usb_unlink_all_urbs(dev);
 
 	if (dev->adapter->dev_stop)
 		dev->adapter->dev_stop(dev);
 
-	close_candev(netdev);
-
-	dev->can.state = CAN_STATE_STOPPED;
-
 	/* can set bus off now */
 	if (dev->adapter->dev_set_bus) {
 		int err = dev->adapter->dev_set_bus(dev, 0);


