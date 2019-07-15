Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF77BC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B96205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563201675;
	bh=cqQv8bfThYISF8P9Pi2/GWnsOSkTKzvac3Gdm7ydH4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0b+kbJvbAtA6Q/ofEppJv7unYKvofgkciurkNPm3nm1SDUK/4it8J2L4izjGO4FV4
	 X56xLlFZef9xM4IXrg4TcGSSWW6amQ5/M/AnTYXar14PVFDW3+ZZImzsITU7U9hg1H
	 o5b0zHH4r9H5N68y15y4O5VFBpC/dSvZ3YJghPOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404858AbfGOOlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:41:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404844AbfGOOlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:41:09 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 243F420651;
        Mon, 15 Jul 2019 14:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563201668;
        bh=cqQv8bfThYISF8P9Pi2/GWnsOSkTKzvac3Gdm7ydH4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T6yEgSXtOuoJCcIpaR/bC9OMF+SYKNu1R4omCql0dOCGa7gB4FaWVXOn+rDpSTkY1
         p2dgI076d/KR4sRdOBt+8wWpI+FR08sUNxmKG57HV0w9Z2majn7lCu4xHKCi2Cn8+e
         o/NRyPgyDYg2V3o19p/r3Qn1Q5gFXaT7F5swlXc4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomas Bortoli <tomasbortoli@gmail.com>,
        syzbot+98162c885993b72f19c4@syzkaller.appspotmail.com,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 68/73] Bluetooth: hci_bcsp: Fix memory leak in rx_skb
Date:   Mon, 15 Jul 2019 10:36:24 -0400
Message-Id: <20190715143629.10893-68-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715143629.10893-1-sashal@kernel.org>
References: <20190715143629.10893-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomas Bortoli <tomasbortoli@gmail.com>

[ Upstream commit 4ce9146e0370fcd573f0372d9b4e5a211112567c ]

Syzkaller found that it is possible to provoke a memory leak by
never freeing rx_skb in struct bcsp_struct.

Fix by freeing in bcsp_close()

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+98162c885993b72f19c4@syzkaller.appspotmail.com
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_bcsp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index a2c921faaa12..34e04bf87a62 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -759,6 +759,11 @@ static int bcsp_close(struct hci_uart *hu)
 	skb_queue_purge(&bcsp->rel);
 	skb_queue_purge(&bcsp->unrel);
 
+	if (bcsp->rx_skb) {
+		kfree_skb(bcsp->rx_skb);
+		bcsp->rx_skb = NULL;
+	}
+
 	kfree(bcsp);
 	return 0;
 }
-- 
2.20.1

