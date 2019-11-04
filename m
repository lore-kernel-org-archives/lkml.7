Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE29CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A285C204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572906244;
	bh=6abuT28sK6AoYiuBi3gJJhKE0CsBcX2cC6f2YW2v8ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bu7h1zb6Ax/5/KBoCUOb0zFYPV/fXThAJDWSlrKxvsY1ChxSmNPxytCikDYdqRy0c
	 lPetvlN89mSuwI/PGh0dxUCi0FVBkNt77dq6qgtpw+QiIxCTNWHGCm15B6NHzFu0qE
	 mNzcXyZxdC0EdZnbqpUk53AZ4BkxduHxoiAI6bXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730984AbfKDVx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:53:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:47310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730317AbfKDVxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:53:23 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDE112053B;
        Mon,  4 Nov 2019 21:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904402;
        bh=6abuT28sK6AoYiuBi3gJJhKE0CsBcX2cC6f2YW2v8ns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GfqAWHfGfBIQ11VlqezzpvmUNXEh0Gpa5Tgrj40lp/tCUszlbk+GaIaObD2Hr5KdI
         K4riKh7Cu8Co8CaWP5kBPgXrtQpaas1KTrTYpo6+47d1ZS/vAZXJmXlKlWMZm3+M8p
         8J2ejZ6T73OHkKgNwnU4EG14+yuoawNd7i8pgTFk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 33/95] HID: hyperv: Use in-place iterator API in the channel callback
Date:   Mon,  4 Nov 2019 22:44:31 +0100
Message-Id: <20191104212058.470315948@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212038.056365853@linuxfoundation.org>
References: <20191104212038.056365853@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

[ Upstream commit 6a297c90efa68b2864483193b8bfb0d19478600c ]

Simplify the ring buffer handling with the in-place API.

Also avoid the dynamic allocation and the memory leak in the channel
callback function.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-hyperv.c | 56 +++++++---------------------------------
 1 file changed, 10 insertions(+), 46 deletions(-)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index 5f1de24206ab2..220b3e5c9c39d 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -322,60 +322,24 @@ static void mousevsc_on_receive(struct hv_device *device,
 
 static void mousevsc_on_channel_callback(void *context)
 {
-	const int packet_size = 0x100;
-	int ret;
 	struct hv_device *device = context;
-	u32 bytes_recvd;
-	u64 req_id;
 	struct vmpacket_descriptor *desc;
-	unsigned char	*buffer;
-	int	bufferlen = packet_size;
-
-	buffer = kmalloc(bufferlen, GFP_ATOMIC);
-	if (!buffer)
-		return;
-
-	do {
-		ret = vmbus_recvpacket_raw(device->channel, buffer,
-					bufferlen, &bytes_recvd, &req_id);
-
-		switch (ret) {
-		case 0:
-			if (bytes_recvd <= 0) {
-				kfree(buffer);
-				return;
-			}
-			desc = (struct vmpacket_descriptor *)buffer;
-
-			switch (desc->type) {
-			case VM_PKT_COMP:
-				break;
-
-			case VM_PKT_DATA_INBAND:
-				mousevsc_on_receive(device, desc);
-				break;
-
-			default:
-				pr_err("unhandled packet type %d, tid %llx len %d\n",
-					desc->type, req_id, bytes_recvd);
-				break;
-			}
 
+	foreach_vmbus_pkt(desc, device->channel) {
+		switch (desc->type) {
+		case VM_PKT_COMP:
 			break;
 
-		case -ENOBUFS:
-			kfree(buffer);
-			/* Handle large packet */
-			bufferlen = bytes_recvd;
-			buffer = kmalloc(bytes_recvd, GFP_ATOMIC);
-
-			if (!buffer)
-				return;
+		case VM_PKT_DATA_INBAND:
+			mousevsc_on_receive(device, desc);
+			break;
 
+		default:
+			pr_err("Unhandled packet type %d, tid %llx len %d\n",
+			       desc->type, desc->trans_id, desc->len8 * 8);
 			break;
 		}
-	} while (1);
-
+	}
 }
 
 static int mousevsc_connect_to_vsp(struct hv_device *device)
-- 
2.20.1



