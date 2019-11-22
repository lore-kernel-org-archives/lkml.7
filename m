Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DC5C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129A02070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574452413;
	bh=+P2nX06dAGulJqQcn7qVK/Higgjr+iMrFKm6gdTyc2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2WGrZ3PCq5E/XIcMJssWQWop6eJEW9zGyqLz4ZwcTJa2lfTXfx7WCTY+Gv2IQyBpy
	 Ib6yprRicFKEtPVJP+5J3wkLfJktWsTvAfRGd0733jbhcmJypW2j4cU8Pjwl9bp8iE
	 F8I9DGRK3AMfqKqn45IO2ZAhoixfKvMi+6IxlVGk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfKVTtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:49:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:48984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727372AbfKVTtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 14:49:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 490F92071F;
        Fri, 22 Nov 2019 19:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574452164;
        bh=+P2nX06dAGulJqQcn7qVK/Higgjr+iMrFKm6gdTyc2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fW3F/oAIK/k+rnelFMg+Huhym2FVE9BvFEk65Nt0H8cuq6fA80+HCH6FvoG9MMLbV
         akduIBLScwUZNOtVCUqy0Rpp7KcxRoztdAEAHiQO1ibQ7/SFW9DZAI5AfC+7+TRC6O
         D7rC5qzECMexw70XHBeuoJcPqkEFZbd60Mb4h6F4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oliver Neukum <oneukum@suse.com>,
        syzbot+a8d4acdad35e6bbca308@syzkaller.appspotmail.com,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 20/25] ax88172a: fix information leak on short answers
Date:   Fri, 22 Nov 2019 14:48:53 -0500
Message-Id: <20191122194859.24508-20-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122194859.24508-1-sashal@kernel.org>
References: <20191122194859.24508-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

[ Upstream commit a9a51bd727d141a67b589f375fe69d0e54c4fe22 ]

If a malicious device gives a short MAC it can elicit up to
5 bytes of leaked memory out of the driver. We need to check for
ETH_ALEN instead.

Reported-by: syzbot+a8d4acdad35e6bbca308@syzkaller.appspotmail.com
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/ax88172a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/ax88172a.c b/drivers/net/usb/ax88172a.c
index 501576f538546..914cac55a7ae7 100644
--- a/drivers/net/usb/ax88172a.c
+++ b/drivers/net/usb/ax88172a.c
@@ -208,7 +208,7 @@ static int ax88172a_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	/* Get the MAC address */
 	ret = asix_read_cmd(dev, AX_CMD_READ_NODE_ID, 0, 0, ETH_ALEN, buf, 0);
-	if (ret < 0) {
+	if (ret < ETH_ALEN) {
 		netdev_err(dev->net, "Failed to read MAC address: %d\n", ret);
 		goto free;
 	}
-- 
2.20.1

