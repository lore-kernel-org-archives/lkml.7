Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDF0C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3EAE20833
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573919068;
	bh=cgHiA7DDTWxGxz5X7SG64ZBTuO5N5bph52IcLJ9ZLyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WdGOy/oE3wI9Hz/y+ZrYkkgaszmmT43bMKrnJzJjpNp6UJWCqScXjSnwFtlnGz8HR
	 wbBASI7wXWutDr9Ct8GxmJMvP/jHowul6ZW/6Ox1FiZYKUTIQ/XKdEDigW5CLx3Jcc
	 yEulWU9KMt93eLyqXTNU+uBPpFoMQcjp/fFIyimU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfKPPo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:44:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:49152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727880AbfKPPoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:44:24 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60A832072D;
        Sat, 16 Nov 2019 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919063;
        bh=cgHiA7DDTWxGxz5X7SG64ZBTuO5N5bph52IcLJ9ZLyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MhIRfMLC+U4vkLRgXNKPXrJZIiXYt3XEWFpZLNCpYaRheOTIvGn2C715vTwbCXVd1
         ehwOITNUKqCdaOh+MuOy1KiOHxS7PAQvr+PlOfsZTopYzYIvHek8trJSsbg3keSbAO
         SGd/bIJEN/IOoN/Cy/Liw0LkJSrKAN7CZSDQoP0Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sabrina Dubroca <sd@queasysnail.net>,
        Radu Rendec <radu.rendec@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 135/237] macsec: let the administrator set UP state even if lowerdev is down
Date:   Sat, 16 Nov 2019 10:39:30 -0500
Message-Id: <20191116154113.7417-135-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 07bddef9839378bd6f95b393cf24c420529b4ef1 ]

Currently, the kernel doesn't let the administrator set a macsec device
up unless its lower device is currently up. This is inconsistent, as a
macsec device that is up won't automatically go down when its lower
device goes down.

Now that linkstate propagation works, there's really no reason for this
limitation, so let's remove it.

Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Reported-by: Radu Rendec <radu.rendec@gmail.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/macsec.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 50acd8c9d7f53..10a8ef2d025a1 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -2813,9 +2813,6 @@ static int macsec_dev_open(struct net_device *dev)
 	struct net_device *real_dev = macsec->real_dev;
 	int err;
 
-	if (!(real_dev->flags & IFF_UP))
-		return -ENETDOWN;
-
 	err = dev_uc_add(real_dev, dev->dev_addr);
 	if (err < 0)
 		return err;
-- 
2.20.1

