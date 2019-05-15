Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E70C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1894C2053B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557920143;
	bh=f+/E2dM8tseZgOi6tp1gOUPwluA21xqL5ItupbIbfPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mccHy8krVLnBVEFh50wIGRoFXJPsgy8aNf+uVoVUve3Czk1xRiXJsz15BDfuc9ddI
	 APjp0hZivO/N5NHQWi9c21BCkfR/kl3G8wR5IMd9B3JQsLTkIJU05jaIFmTx2/bpOQ
	 /z1DcTp2GhwxSj8kk4r9JGBbmxCZMaoi+Bm/JohQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732891AbfEOLdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:33:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733156AbfEOLdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:33:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D319E2084A;
        Wed, 15 May 2019 11:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919989;
        bh=f+/E2dM8tseZgOi6tp1gOUPwluA21xqL5ItupbIbfPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b3fCV9URAHaZBRgG6uXo6MTSPmJBbF53xAqgpBp+Ak1OmukRmW7hEhl2C4xJQSr6G
         utwxQ9a1T8i1Wq0+YOZiRvij1SU7jfSuBjKdR/0aZJ/J8RYbkzWax2k99Mgo2hlmdA
         d3trL2ZSjDTN7RnDUClNDaBXsgcNo/uWHS5ztFzo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 31/46] aqc111: fix double endianness swap on BE
Date:   Wed, 15 May 2019 12:56:55 +0200
Message-Id: <20190515090626.291728022@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090616.670410738@linuxfoundation.org>
References: <20190515090616.670410738@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

[ Upstream commit 2cf672709beb005f6e90cb4edbed6f2218ba953e ]

If you are using a function that does a swap in place,
you cannot just reuse the buffer on the assumption that it has
not been changed.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/aqc111.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/usb/aqc111.c
+++ b/drivers/net/usb/aqc111.c
@@ -1428,7 +1428,7 @@ static int aqc111_resume(struct usb_inte
 {
 	struct usbnet *dev = usb_get_intfdata(intf);
 	struct aqc111_data *aqc111_data = dev->driver_priv;
-	u16 reg16;
+	u16 reg16, oldreg16;
 	u8 reg8;
 
 	netif_carrier_off(dev->net);
@@ -1444,9 +1444,11 @@ static int aqc111_resume(struct usb_inte
 	/* Configure RX control register => start operation */
 	reg16 = aqc111_data->rxctl;
 	reg16 &= ~SFR_RX_CTL_START;
+	/* needs to be saved in case endianness is swapped */
+	oldreg16 = reg16;
 	aqc111_write16_cmd_nopm(dev, AQ_ACCESS_MAC, SFR_RX_CTL, 2, &reg16);
 
-	reg16 |= SFR_RX_CTL_START;
+	reg16 = oldreg16 | SFR_RX_CTL_START;
 	aqc111_write16_cmd_nopm(dev, AQ_ACCESS_MAC, SFR_RX_CTL, 2, &reg16);
 
 	aqc111_set_phy_speed(dev, aqc111_data->autoneg,


