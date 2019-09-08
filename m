Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47848C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BC5218AF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567946611;
	bh=VKIhn3t5HKFT55uxxSW0rh1RrHK5MQdyDgOmvlyntj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1iUCjUZOgpSwAyOEzrELpUNjclPQmRkz1YpdpWuqKcbLL76BRryNPUGHj8VCvzXwe
	 YNT6i438XtI5HaF10j+J8xpK7s/qUKE9SunOUXpYEUw7FJCRggf78vYLGqVquN3pjp
	 vsKNzuSZcZJDIcG9oTsNyg2PeNYnXZGnS92E8Lvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfIHMna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:43:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729431AbfIHMnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:43:23 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C29E1218AE;
        Sun,  8 Sep 2019 12:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946602;
        bh=VKIhn3t5HKFT55uxxSW0rh1RrHK5MQdyDgOmvlyntj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KuWwnp5XAL4VzO30OKM2N+mayaYQgpIIlZlpbucWqhIJttcwyXWHBeycdNVwoPcsk
         AFQgGKOtDKZftUDk77J8eLbydwncdZ+0rDCxQeAlMUHQXd5/Sew2jP+dKPIbyLJoC6
         xbRmTEX0x0gzdv4Lyq/aSPTED0TIUfZCc2aNCQ6A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 08/23] cx82310_eth: fix a memory leak bug
Date:   Sun,  8 Sep 2019 13:41:43 +0100
Message-Id: <20190908121056.539096222@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121052.898169328@linuxfoundation.org>
References: <20190908121052.898169328@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1eca92eef18719027d394bf1a2d276f43e7cf886 ]

In cx82310_bind(), 'dev->partial_data' is allocated through kmalloc().
Then, the execution waits for the firmware to become ready. If the firmware
is not ready in time, the execution is terminated. However, the allocated
'dev->partial_data' is not deallocated on this path, leading to a memory
leak bug. To fix this issue, free 'dev->partial_data' before returning the
error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/cx82310_eth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/cx82310_eth.c b/drivers/net/usb/cx82310_eth.c
index 947bea81d9241..dfbdea22fbad9 100644
--- a/drivers/net/usb/cx82310_eth.c
+++ b/drivers/net/usb/cx82310_eth.c
@@ -175,7 +175,8 @@ static int cx82310_bind(struct usbnet *dev, struct usb_interface *intf)
 	}
 	if (!timeout) {
 		dev_err(&udev->dev, "firmware not ready in time\n");
-		return -ETIMEDOUT;
+		ret = -ETIMEDOUT;
+		goto err;
 	}
 
 	/* enable ethernet mode (?) */
-- 
2.20.1



