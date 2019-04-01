Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBB2C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0B0208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140156;
	bh=LYgqD5wYLO2NLFIaK4v86siK5AVdzfQ3DsLgM4LqBfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fmzW/EVIJ89BwWHC1eAfXysQ3uzhzmVy/IjRRCiB0NSif+oJ79ZcmPoXNqYFggsBk
	 JToaA/ByMwwyRy5J66vk8JiP3KJD9BighsSUm7HLDDhYoZVWbj/iAL//QdxN8Ko5jx
	 zPwK+0m9x2sLXU5RuN6gfT1cSGOxcxT0psAywUII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387955AbfDARfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:35:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387585AbfDARfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:35:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53DEF20896;
        Mon,  1 Apr 2019 17:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140149;
        bh=LYgqD5wYLO2NLFIaK4v86siK5AVdzfQ3DsLgM4LqBfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n8U7usstpfDl0yGuf2i9pKzTlcsw3Ri0RgOIm/RAjbryf2Vd2dS4aTxcQ6xcFA9U9
         bB0VCQOjz+n+NvOBONRCj3kDf7HijF3OgFQKEaSuBCST8C5xvmM/QvSpuOmzOL+c/2
         PLJNzR0CnY4R6SNSN4yM7ddx8Wv26N09QbUxKh4I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rajkumar Raghupathy <raghup@codeaurora.org>,
        Xerox Lin <xerox_lin@htc.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 083/131] usb: gadget: rndis: free response queue during REMOTE_NDIS_RESET_MSG
Date:   Mon,  1 Apr 2019 19:02:33 +0200
Message-Id: <20190401170059.049855572@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 207707d8fd48ebc977fb2b2794004a020e1ee08e ]

When rndis data transfer is in progress, some Windows7 Host PC is not
sending the GET_ENCAPSULATED_RESPONSE command for receiving the response
for the previous SEND_ENCAPSULATED_COMMAND processed.

The rndis function driver appends each response for the
SEND_ENCAPSULATED_COMMAND in a queue. As the above process got corrupted,
the Host sends a REMOTE_NDIS_RESET_MSG command to do a soft-reset.
As the rndis response queue is not freed, the previous response is sent
as a part of this REMOTE_NDIS_RESET_MSG's reset response and the Host
block any more Rndis transfers.

Hence free the rndis response queue as a part of this soft-reset so that
the correct response for REMOTE_NDIS_RESET_MSG is sent properly during the
response command.

Signed-off-by: Rajkumar Raghupathy <raghup@codeaurora.org>
Signed-off-by: Xerox Lin <xerox_lin@htc.com>
[AmitP: Cherry-picked this patch and folded other relevant
        fixes from Android common kernel android-4.4]
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/rndis.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/gadget/function/rndis.c b/drivers/usb/gadget/function/rndis.c
index 70d3917cc003..2582db38d6a6 100644
--- a/drivers/usb/gadget/function/rndis.c
+++ b/drivers/usb/gadget/function/rndis.c
@@ -680,6 +680,12 @@ static int rndis_reset_response(struct rndis_params *params,
 {
 	rndis_reset_cmplt_type *resp;
 	rndis_resp_t *r;
+	u8 *xbuf;
+	u32 length;
+
+	/* drain the response queue */
+	while ((xbuf = rndis_get_next_response(params, &length)))
+		rndis_free_response(params, xbuf);
 
 	r = rndis_add_response(params, sizeof(rndis_reset_cmplt_type));
 	if (!r)
-- 
2.19.1



