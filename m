Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D364BC4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE182067B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947579;
	bh=Nh49n9ilO5Cbv6t5OZ2rdENYqLyCobUsY0/dRk0rxEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wr42urqgTGIu2gAjm/zOLyYYvmhaLBy+y78/MRs99IchaMvwPSkM8Lui+e6qt5BP7
	 wYRPWXQ9+ai7tsB1KtK4NmCvlHH6B34G0hDqnqgF5PjhF+GYXf7UtBOYEIMbIe7WBx
	 AZ3LDuiuRm3ZOuBZ4B8QO4PfHDiPvyDIXN993dfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbfIHMpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:45:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730105AbfIHMpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:45:35 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C121216C8;
        Sun,  8 Sep 2019 12:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946735;
        bh=Nh49n9ilO5Cbv6t5OZ2rdENYqLyCobUsY0/dRk0rxEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OU4BUEJm3KaIPDnw5xmc3kNIMGHkxXSt/acvPsKrBl7uToSfyGGt9seVdLvJrwmQp
         ogxzFk1KE61MCPXWpaF/zChtcmsTpMhGQPdoOwSXyrUHV5nrcDiOh78dYAGp4thbvx
         j7z0/wOECLYmtODz+Re/VwKNTphl4ZMKIE276Mms=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 21/40] Input: hyperv-keyboard: Use in-place iterator API in the channel callback
Date:   Sun,  8 Sep 2019 13:41:54 +0100
Message-Id: <20190908121122.749934074@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121114.260662089@linuxfoundation.org>
References: <20190908121114.260662089@linuxfoundation.org>
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
index 55288a026e4e2..c137ffa6fdec8 100644
--- a/drivers/input/serio/hyperv-keyboard.c
+++ b/drivers/input/serio/hyperv-keyboard.c
@@ -245,40 +245,17 @@ static void hv_kbd_handle_received_packet(struct hv_device *hv_dev,
 
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



