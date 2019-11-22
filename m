Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BA6C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631B720721
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420448;
	bh=3/Uq4ZXq7sa6LCZZyXYuOU63UAjEPvJQybSyyern0yY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sADerS4F+qpP9ake4tzQrVz5RDa7wVTx6YMDTehvLFcawqGOQUk8dqQDLFtOr/frW
	 qkKzSJr0iAoIfS9WiPunTcBMrj4PnRoWaOfYGEl5hAyx/oe+WnxVWwAJa7Wa584PuG
	 XJ5lRoC4IT8oLfPvce0hwRB1IXlfvLXNNGw3AwWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730789AbfKVLAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:00:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:53132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728932AbfKVLAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:00:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3969B20721;
        Fri, 22 Nov 2019 11:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420442;
        bh=3/Uq4ZXq7sa6LCZZyXYuOU63UAjEPvJQybSyyern0yY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KM0WrTuhIST3q5olYZBc0wyK3oeOZuEk5rTcLx0J6/Lyq0DyWz2cfrAFZdOMyaYkT
         peH9shnVrsuQFqST18EcMgZVKmr12+HRacrnu+JDXQWkq62CXYj4YSQC548A3RV0lW
         EnlWgiq1F+VkIJ9VNOR2IaMGp5bvMH3WlpUBhVik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 107/220] USB: serial: cypress_m8: fix interrupt-out transfer length
Date:   Fri, 22 Nov 2019 11:27:52 +0100
Message-Id: <20191122100920.470437477@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
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
index e0035c0231202..2c58649fd47a4 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -769,7 +769,7 @@ static void cypress_send(struct usb_serial_port *port)
 
 	usb_fill_int_urb(port->interrupt_out_urb, port->serial->dev,
 		usb_sndintpipe(port->serial->dev, port->interrupt_out_endpointAddress),
-		port->interrupt_out_buffer, port->interrupt_out_size,
+		port->interrupt_out_buffer, actual_size,
 		cypress_write_int_callback, port, priv->write_urb_interval);
 	result = usb_submit_urb(port->interrupt_out_urb, GFP_ATOMIC);
 	if (result) {
-- 
2.20.1



