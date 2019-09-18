Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869F1C4CECE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D95221920
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568787707;
	bh=zqnBRzTtYB/0T/hE8i8xYasAQntEJx5++76H/peYRq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C/PfgmCR0HNHSJF7XIsmr7umTRwt/4r4H/QCFSm+p8uUMBONyoCGEFqNQaTVYojR5
	 l4EebmGRR8Ht6V8s8tISVhaDtmZ69Gqexd+TvDQtvou1SPk8pbiTu9aJ2LlbAc4Cb3
	 LsuMOhAgcRT4ogXFHF9bTItlIU5ZjLXLjBI1pLhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbfIRGVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:21:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729197AbfIRGVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:21:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AEBA21924;
        Wed, 18 Sep 2019 06:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568787702;
        bh=zqnBRzTtYB/0T/hE8i8xYasAQntEJx5++76H/peYRq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U9yXHdudXNl3nnvvniJvJoTefmLQxbZUuOIoKaart9bx8KWkI+eiHHcv7xxT5p8j4
         PSRvTMvyWvsiNsutI8FFl/ipuCx4lGgRZLfEs1dqAvLaJiUZNexe99q0T3bN05qnZt
         WcdAIKdRUpgU6AV5vaSsKMDg5WULasqrlQUIBDxQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Alejandro Hernandez <ajhernandez@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: [PATCH 4.14 40/45] firmware: ti_sci: Always request response from firmware
Date:   Wed, 18 Sep 2019 08:19:18 +0200
Message-Id: <20190918061227.712028794@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061222.854132812@linuxfoundation.org>
References: <20190918061222.854132812@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew F. Davis <afd@ti.com>

commit 66f030eac257a572fbedab3d9646d87d647351fd upstream.

TI-SCI firmware will only respond to messages when the
TI_SCI_FLAG_REQ_ACK_ON_PROCESSED flag is set. Most messages already do
this, set this for the ones that do not.

This will be enforced in future firmware that better match the TI-SCI
specifications, this patch will not break users of existing firmware.

Fixes: aa276781a64a ("firmware: Add basic support for TI System Control Interface (TI-SCI) protocol")
Signed-off-by: Andrew F. Davis <afd@ti.com>
Acked-by: Nishanth Menon <nm@ti.com>
Tested-by: Alejandro Hernandez <ajhernandez@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/firmware/ti_sci.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -471,9 +471,9 @@ static int ti_sci_cmd_get_revision(struc
 	struct ti_sci_xfer *xfer;
 	int ret;
 
-	/* No need to setup flags since it is expected to respond */
 	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_VERSION,
-				   0x0, sizeof(struct ti_sci_msg_hdr),
+				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				   sizeof(struct ti_sci_msg_hdr),
 				   sizeof(*rev_info));
 	if (IS_ERR(xfer)) {
 		ret = PTR_ERR(xfer);
@@ -601,9 +601,9 @@ static int ti_sci_get_device_state(const
 	info = handle_to_ti_sci_info(handle);
 	dev = info->dev;
 
-	/* Response is expected, so need of any flags */
 	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_GET_DEVICE_STATE,
-				   0, sizeof(*req), sizeof(*resp));
+				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				   sizeof(*req), sizeof(*resp));
 	if (IS_ERR(xfer)) {
 		ret = PTR_ERR(xfer);
 		dev_err(dev, "Message alloc failed(%d)\n", ret);


