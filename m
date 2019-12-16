Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074F5C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B3D206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521154;
	bh=sZYzOaNs38wQo5GUKCCaexcvEt1QQRuJfESUnu7g+jU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nBGlR904zXtxHOa7C2T+zZMYXprJ1Yc1g5OQhfzl9R5uZneoVmwZIO5X3ceh9EOJW
	 14R7Kt9fIqGpHtB7yfGKamvwvB1L64tZCD6Wd8dJP9hVgHJU4EzEgd5yMlSv6WPu6f
	 ena1g7JDpDAqmLm/ZCIw5VLqYzCOmhxNrDsUTp98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbfLPSKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:10:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:52946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730560AbfLPSKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:10:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69FC6206E0;
        Mon, 16 Dec 2019 18:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519805;
        bh=sZYzOaNs38wQo5GUKCCaexcvEt1QQRuJfESUnu7g+jU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=th9AzWJRHPcNSTiRo1XXpNliC/bZnSLK90aOPx+IjpQsKBBYTSDtb0IYLvICzKTBt
         FHzuVvRkvDVj6yVO7KBJAnQVNP0zMit9g6KpHOVR1GqWn0DvuTJxkDVcCzzwYuXtWG
         6KwQrKAOCH8etQUmi6koP1EQt85dHrTj6FYlXAtQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.3 035/180] USB: idmouse: fix interface sanity checks
Date:   Mon, 16 Dec 2019 18:47:55 +0100
Message-Id: <20191216174815.579218584@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174806.018988360@linuxfoundation.org>
References: <20191216174806.018988360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 59920635b89d74b9207ea803d5e91498d39e8b69 upstream.

Make sure to use the current alternate setting when verifying the
interface descriptors to avoid binding to an invalid interface.

Failing to do so could cause the driver to misbehave or trigger a WARN()
in usb_submit_urb() that kernels with panic_on_warn set would choke on.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20191210112601.3561-4-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/idmouse.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/misc/idmouse.c
+++ b/drivers/usb/misc/idmouse.c
@@ -337,7 +337,7 @@ static int idmouse_probe(struct usb_inte
 	int result;
 
 	/* check if we have gotten the data or the hid interface */
-	iface_desc = &interface->altsetting[0];
+	iface_desc = interface->cur_altsetting;
 	if (iface_desc->desc.bInterfaceClass != 0x0A)
 		return -ENODEV;
 


