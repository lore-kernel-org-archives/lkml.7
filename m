Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A62C76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9104A20665
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="e+XQ/rbT";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="c3j6wxew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387539AbfGXOwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:52:37 -0400
Received: from node.akkea.ca ([192.155.83.177]:58482 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbfGXOwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:52:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 1BF4F4E201A;
        Wed, 24 Jul 2019 14:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1563979956; bh=wbREU2PXYP3BimKIGdJ+8+mufWeuQ6DUecgOt308UMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=e+XQ/rbTf9nzotbVkwnZn+U6TbFHPJTXq2D5w3yUor0JoDNmpcjGWdfEgFDY9TyMt
         iAKnMHQvoSPHWNaZ48anfdgbyUdDtqHdOyDGi3jBCwjs3WP73CUAF4ekB9hodIFqhu
         U8gsefs+PPjRALgFnBZbydH5aTRfDArgr4xI3ceg=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kVgEbh35hGlH; Wed, 24 Jul 2019 14:52:35 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 59EC34E2006;
        Wed, 24 Jul 2019 14:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1563979955; bh=wbREU2PXYP3BimKIGdJ+8+mufWeuQ6DUecgOt308UMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=c3j6wxewZQbfLpmnxmX2ThRR+FHXFiw7i3hR6hWstC4ppd+xOW2J27fS3LLUclYT6
         QWtsZPgSUh2NdvkJRgkTFNWwlUyZ4qw4XH0+Q1t9HEs7QLB2WFyZd/EalaPlaLLXBH
         orYphVvSW4leg03zTEKMhMHJEo3hWfoM2b2xa6Xw=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     kernel@puri.sm
Cc:     =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bob Ham <bob.ham@puri.sm>,
        Angus Ainslie <angus@akkea.ca>
Subject: [PATCH 1/2] usb: serial: option: Add the BroadMobi BM818 card
Date:   Wed, 24 Jul 2019 07:52:26 -0700
Message-Id: <20190724145227.27169-2-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190724145227.27169-1-angus@akkea.ca>
References: <20190724145227.27169-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Ham <bob.ham@puri.sm>

Add a VID:PID for the BroadModi BM818 M.2 card

Signed-off-by: Bob Ham <bob.ham@puri.sm>
Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index c1582fbd1150..674a68ee9564 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1975,6 +1975,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(4) | RSVD(5) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0105, 0xff),			/* Fibocom NL678 series */
 	  .driver_info = RSVD(6) },
+	{ USB_DEVICE(0x2020, 0x2060),						/* BroadMobi  */
+	  .driver_info = RSVD(4) },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
-- 
2.17.1

