Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC87C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B5D2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="WmJP8/un"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfDOLQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:16:55 -0400
Received: from smtp89.iad3a.emailsrvr.com ([173.203.187.89]:52519 "EHLO
        smtp89.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727257AbfDOLQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:16:53 -0400
Received: from smtp36.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp36.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id E09C4541B;
        Mon, 15 Apr 2019 07:10:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1555326627;
        bh=uSeEVU7rJlvklSrJqjry2LIAdpd1ggCtpzpbdxhauVc=;
        h=From:To:Subject:Date:From;
        b=WmJP8/unfbk/0AlL1OrQjlgLi+1klYCGaZFQ1QEeN2nJfmwa/B34xO2oMNtnCWYh+
         1DF9H27kEgRMbxyuwPiWcsPizSR3m+Fu00H+L2mJzjEwL0NnTynpWWqY6myUKBjA05
         kqmpt45UcHanWnjUUbgCzpCJwihTNfXckiWP7SdQ=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp36.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 293C85407;
        Mon, 15 Apr 2019 07:10:27 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from ian-deb.inside.mev.co.uk (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256)
        by 0.0.0.0:465 (trex/5.7.12);
        Mon, 15 Apr 2019 07:10:27 -0400
From:   Ian Abbott <abbotti@mev.co.uk>
To:     devel@driverdev.osuosl.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: comedi: vmk80xx: Fix possible double-free of ->usb_rx_buf
Date:   Mon, 15 Apr 2019 12:10:15 +0100
Message-Id: <20190415111015.8257-3-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190415111015.8257-1-abbotti@mev.co.uk>
References: <20190415111015.8257-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`vmk80xx_alloc_usb_buffers()` is called from `vmk80xx_auto_attach()` to
allocate RX and TX buffers for USB transfers.  It allocates
`devpriv->usb_rx_buf` followed by `devpriv->usb_tx_buf`.  If the
allocation of `devpriv->usb_tx_buf` fails, it frees
`devpriv->usb_rx_buf`,  leaving the pointer set dangling, and returns an
error.  Later, `vmk80xx_detach()` will be called from the core comedi
module code to clean up.  `vmk80xx_detach()` also frees both
`devpriv->usb_rx_buf` and `devpriv->usb_tx_buf`, but
`devpriv->usb_rx_buf` may have already been freed, leading to a
double-free error.  Fix it by removing the call to
`kfree(devpriv->usb_rx_buf)` from `vmk80xx_auto_attach()`, relying on
`vmk80xx_detach()` to free the memory.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/staging/comedi/drivers/vmk80xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/comedi/drivers/vmk80xx.c b/drivers/staging/comedi/drivers/vmk80xx.c
index b035d662390b..65dc6c51037e 100644
--- a/drivers/staging/comedi/drivers/vmk80xx.c
+++ b/drivers/staging/comedi/drivers/vmk80xx.c
@@ -682,10 +682,8 @@ static int vmk80xx_alloc_usb_buffers(struct comedi_device *dev)
 
 	size = usb_endpoint_maxp(devpriv->ep_tx);
 	devpriv->usb_tx_buf = kzalloc(size, GFP_KERNEL);
-	if (!devpriv->usb_tx_buf) {
-		kfree(devpriv->usb_rx_buf);
+	if (!devpriv->usb_tx_buf)
 		return -ENOMEM;
-	}
 
 	return 0;
 }
-- 
2.20.1

