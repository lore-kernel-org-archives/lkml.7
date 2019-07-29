Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C94C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17222054F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564430311;
	bh=S0HiX7B0+lIMuMWQZ6udeWmH4rTbPlb9ZFOIJcx6aVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cZZ5ulqctszKnfNqWd+cVJjrqBbhp0uZfm+N4zK0ZqDm0qLKKkmoUPOQsYbHXM5cR
	 3EyLv4xT26JyCd6HWitVoNWZqxAzX7jIuD0ad+MVg10PSGCyc0KgU02keHHbYULAof
	 ylAK2C9057cu7HOBVsOIEg4HouOkiV8H12IkjU58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404177AbfG2T62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:58:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403841AbfG2Txn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:53:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1C21217D4;
        Mon, 29 Jul 2019 19:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564430022;
        bh=S0HiX7B0+lIMuMWQZ6udeWmH4rTbPlb9ZFOIJcx6aVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lo1nThcBrVPn8XDomtnPch5DA4MqFhAAaPckkJ2yWdTfLyo+1MVN/SNspG3F4xuFg
         VvN3e3sZVmJt+3iYIupWjNuemLOQODZEn9Satzl6b4v2GQIYyGaeJD0a87M3MZ/ML6
         n/j3uE9jajKO0oOH5UYOBuQf4/7fCCFCrOqO5aqc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 5.2 172/215] Revert "usb: usb251xb: Add US port lanes inversion property"
Date:   Mon, 29 Jul 2019 21:22:48 +0200
Message-Id: <20190729190809.726019480@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190739.971253303@linuxfoundation.org>
References: <20190729190739.971253303@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

commit 79f6fafad4e2a874015cb67d735f9f87f1834367 upstream.

This property isn't needed and not yet used anywhere. The swap-dx-lanes
property is perfectly fine for doing the swap on the upstream port
lanes.

CC: stable@vger.kernel.org #5.2
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Link: https://lore.kernel.org/r/20190719084407.28041-2-l.stach@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/usb251xb.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/usb/misc/usb251xb.c
+++ b/drivers/usb/misc/usb251xb.c
@@ -574,8 +574,6 @@ static int usb251xb_get_ofdata(struct us
 	hub->port_swap = USB251XB_DEF_PORT_SWAP;
 	usb251xb_get_ports_field(hub, "swap-dx-lanes", data->port_cnt,
 				 &hub->port_swap);
-	if (of_get_property(np, "swap-us-lanes", NULL))
-		hub->port_swap |= BIT(0);
 
 	/* The following parameters are currently not exposed to devicetree, but
 	 * may be as soon as needed.


