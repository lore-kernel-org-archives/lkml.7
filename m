Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEBFC2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3BB4206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521618;
	bh=Bcyfsom547QGU5e7VQvQpY+Cvi9D3GQGIU6yVL4/iB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MwGtzFX0Au5yPBMBRr05QgWEw6gNwMsgv6QXH7Qu1QM/3aYD/EL/jJUVzYZj3cP/v
	 QNSPW4oa0BcCpiHH4q7Z77Cd63M35n2WRWbqf6PZMX/aqaQg+gA5QsOEuZKjo81esa
	 SbF+i++CgxiZsbWvb7My05EciyDdkflTL4htcgx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbfLPSCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:02:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:38114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729314AbfLPSCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:02:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE996207FF;
        Mon, 16 Dec 2019 18:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519338;
        bh=Bcyfsom547QGU5e7VQvQpY+Cvi9D3GQGIU6yVL4/iB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bxd7ewy0kW5ihCTyEQE10DyGax/8orY95WuxXCgkKpqUWzD0ybg1wbO2760QbwWXi
         sekZTwJOWTergMk5JCLqQr6gIYr8/xbbKL5tdN0Kv8aXSAcEWdhWJTRjy1QkzHXJJJ
         OSIjxNvKxfUjCVn7A0QUeAIPKzELCI407XybhH2U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.19 026/140] USB: adutux: fix interface sanity check
Date:   Mon, 16 Dec 2019 18:48:14 +0100
Message-Id: <20191216174757.164784224@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174747.111154704@linuxfoundation.org>
References: <20191216174747.111154704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 3c11c4bed02b202e278c0f5c319ae435d7fb9815 upstream.

Make sure to use the current alternate setting when verifying the
interface descriptors to avoid binding to an invalid interface.

Failing to do so could cause the driver to misbehave or trigger a WARN()
in usb_submit_urb() that kernels with panic_on_warn set would choke on.

Fixes: 03270634e242 ("USB: Add ADU support for Ontrak ADU devices")
Cc: stable <stable@vger.kernel.org>     # 2.6.19
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20191210112601.3561-3-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/adutux.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/misc/adutux.c
+++ b/drivers/usb/misc/adutux.c
@@ -671,7 +671,7 @@ static int adu_probe(struct usb_interfac
 	init_waitqueue_head(&dev->read_wait);
 	init_waitqueue_head(&dev->write_wait);
 
-	res = usb_find_common_endpoints_reverse(&interface->altsetting[0],
+	res = usb_find_common_endpoints_reverse(interface->cur_altsetting,
 			NULL, NULL,
 			&dev->interrupt_in_endpoint,
 			&dev->interrupt_out_endpoint);


