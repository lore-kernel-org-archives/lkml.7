Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A42C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496B921738
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962136;
	bh=7rYj/+g1YhsbLdyz4Q8xGdqAbHLyEZLrYGWMfOQUH2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lCQdKu433Lx9RCtebwN0mqAj8je9PBOayhE+d0kI0PRHhcJfuy6kb8LzLNdSvnS5v
	 CvEWV8gLsEE3VnIMpJWpQ3C326nFiKkd7aoyUndXlJL2lvRUP4SXlHBNHNgnvaz3XD
	 dCgqhx14ISJOuJpwQqKu7JckWcccD9sfz/mXoX+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfDVTmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:42:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728292AbfDVTmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:42:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA646214AE;
        Mon, 22 Apr 2019 19:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962132;
        bh=7rYj/+g1YhsbLdyz4Q8xGdqAbHLyEZLrYGWMfOQUH2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jq0GmIKuTzehBbOhg4/KAwamMmWe8aaS7ZgTNklOJ+0p4KwtWAhS17ZLYpHn2xdYV
         eO5THrHbd71Splxdh4HpO+TlPcL6L5jMNAIS6qEFnAqDKQuM5S6X0Ie1bV5G3BvhnH
         /0u0JMzMGe+z5KWGqz7fD7z8J19kANT+xsSVQueg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 07/98] net: ieee802154: fix a potential NULL pointer dereference
Date:   Mon, 22 Apr 2019 15:40:34 -0400
Message-Id: <20190422194205.10404-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit 2795e8c251614ac0784c9d41008551109f665716 ]

In case alloc_ordered_workqueue fails, the fix releases
sources and returns -ENOMEM to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/ieee802154/adf7242.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index cd1d8faccca5..cd6b95e673a5 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -1268,6 +1268,10 @@ static int adf7242_probe(struct spi_device *spi)
 	INIT_DELAYED_WORK(&lp->work, adf7242_rx_cal_work);
 	lp->wqueue = alloc_ordered_workqueue(dev_name(&spi->dev),
 					     WQ_MEM_RECLAIM);
+	if (unlikely(!lp->wqueue)) {
+		ret = -ENOMEM;
+		goto err_hw_init;
+	}
 
 	ret = adf7242_hw_init(lp);
 	if (ret)
-- 
2.19.1

