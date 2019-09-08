Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1C4C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26BB21924
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947132;
	bh=L00edrtZWVd9YpYNckfbTijs1oIMYJPX5ORCFygJC/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EaK4hCuakNOmLCM4ogsv53LgCisJmDX1jbaBY6+P+vkNRMazONPIwuFgA5RhuALvU
	 0j0AQpDpN/vMSWM4hPY7pAeTfNybeB7JzCyKYkNFADn1byp7NW+vAAq5DdomEbRNxU
	 U0YA4ZQCYQRRLaRFAmh26vNE/o+7kaH1AQwSlWHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732926AbfIHMwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:52:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732787AbfIHMv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:51:59 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C819921924;
        Sun,  8 Sep 2019 12:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567947118;
        bh=L00edrtZWVd9YpYNckfbTijs1oIMYJPX5ORCFygJC/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H2k9XXNbtIxgvZ7Tt+2ObGqVAC7KnvBjpKnJsOGD1eXHiQCayVrjqwsBGFoZP2r5u
         FFKAlERCGdFsFoYFsTDEo5UOp61n4YwSzMEKyfsn1lcQLfhM4JHYL8OU09WOuh8I6g
         zsC3WQVUtrT/m18l0cBbips+2iyArG0LcEzHqn+A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 69/94] Input: hyperv-keyboard: Use in-place iterator API in the channel callback
Date:   Sun,  8 Sep 2019 13:42:05 +0100
Message-Id: <20190908121152.408878459@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121150.420989666@linuxfoundation.org>
References: <20190908121150.420989666@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d09bc83640d524b8467a660db7b1d15e6562a1de ]

Simplify the ring buffer handling with the in-place API.

Also avoid the dynamic allocation and the memory leak in the channel
callback function.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/serio/hyperv-keyboard.c | 35 +++++----------------------
 1 file changed, 6 insertions(+), 29 deletions(-)

diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
index 8e457e50f837e..770e36d0c66fb 100644
--- a/drivers/input/serio/hyperv-keyboard.c
+++ b/drivers/input/serio/hyperv-keyboard.c
@@ -237,40 +237,17 @@ static void hv_kbd_handle_received_packet(struct hv_device *hv_dev,
 
 static void hv_kbd_on_channel_callback(void *context)
 {
+	struct vmpacket_descriptor *desc;
 	struct hv_device *hv_dev = context;
-	void *buffer;
-	int bufferlen = 0x100; /* Start with sensible size */
 	u32 bytes_recvd;
 	u64 req_id;
-	int error;
 
-	buffer = kmalloc(bufferlen, GFP_ATOMIC);
-	if (!buffer)
-		return;
-
-	while (1) {
-		error = vmbus_recvpacket_raw(hv_dev->channel, buffer, bufferlen,
-					     &bytes_recvd, &req_id);
-		switch (error) {
-		case 0:
-			if (bytes_recvd == 0) {
-				kfree(buffer);
-				return;
-			}
-
-			hv_kbd_handle_received_packet(hv_dev, buffer,
-						      bytes_recvd, req_id);
-			break;
+	foreach_vmbus_pkt(desc, hv_dev->channel) {
+		bytes_recvd = desc->len8 * 8;
+		req_id = desc->trans_id;
 
-		case -ENOBUFS:
-			kfree(buffer);
-			/* Handle large packet */
-			bufferlen = bytes_recvd;
-			buffer = kmalloc(bytes_recvd, GFP_ATOMIC);
-			if (!buffer)
-				return;
-			break;
-		}
+		hv_kbd_handle_received_packet(hv_dev, desc, bytes_recvd,
+					      req_id);
 	}
 }
 
-- 
2.20.1



