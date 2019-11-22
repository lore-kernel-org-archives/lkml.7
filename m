Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB662C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9709D20708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419027;
	bh=GAknvF9Xra1VDxZSBLEx+eB5pfkKd1dvyjA3FwvGZAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XI0EeyL0cm0GzJ92Pp6NzZ/MQUvYGfGu4vsBVL5A91iQv4jFYGhZj52QL9GgpdKkx
	 ogJueI8vlCyfZPHh8bJV3vanFY1vtMZZNcuC96lvlgLv9MA4J9pPCm1C5b9E2OOiQq
	 mxC1FO2KixU+E+5wfnsTc7+rpRtFm2ridHQNDwrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfKVKhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:37:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:37972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727142AbfKVKhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:37:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 829C52071C;
        Fri, 22 Nov 2019 10:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419024;
        bh=GAknvF9Xra1VDxZSBLEx+eB5pfkKd1dvyjA3FwvGZAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iU2KeyUKvVpEV1icHnD4tFzHxoGVhcE/zc+5plfSZ6v8OnbRogx7blat5/pwrQLx0
         dTbraHKIcjlopNg6rzuLdv05QFwwVS/In7P+CoaXhAPN2gAfh49IjV+wh3shx+HOF/
         v92mW0n9Z7Q4svFmrqYK6GFqrxOqNpoKdncNWtXY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 132/159] USB: serial: cypress_m8: fix interrupt-out transfer length
Date:   Fri, 22 Nov 2019 11:28:43 +0100
Message-Id: <20191122100834.189827261@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 56445eef55cb5904096fed7a73cf87b755dfffc7 ]

Fix interrupt-out transfer length which was being set to the
transfer-buffer length rather than the size of the outgoing packet.

Note that no slab data was leaked as the whole transfer buffer is always
cleared before each transfer.

Fixes: 9aa8dae7b1fa ("cypress_m8: use usb_fill_int_urb where appropriate")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/serial/cypress_m8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index 244acb1299a95..e92cd1eceefa2 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -773,7 +773,7 @@ static void cypress_send(struct usb_serial_port *port)
 
 	usb_fill_int_urb(port->interrupt_out_urb, port->serial->dev,
 		usb_sndintpipe(port->serial->dev, port->interrupt_out_endpointAddress),
-		port->interrupt_out_buffer, port->interrupt_out_size,
+		port->interrupt_out_buffer, actual_size,
 		cypress_write_int_callback, port, priv->write_urb_interval);
 	result = usb_submit_urb(port->interrupt_out_urb, GFP_ATOMIC);
 	if (result) {
-- 
2.20.1



