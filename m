Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FBAC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27F020879
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558640189;
	bh=Txk2PSjLgxSvt8X5OqjDK4/o+waZ0lc5+u5/6q8hk84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ndWMV7OUDambixqp9kD+oCu4xbSORaUBdCqwVSs+xH2HmRvKxx9q9DTMvVarCM7No
	 uZ/Z1osXTFJHQPOPY9IX30XHrKTf5lDZVslsYbpr85vde5M4ZKQFiBdmuO56ZU22hD
	 8j4hxbbzaCcVH3rwwysjNvRm1L6Qu2NkHU2tjnX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391155AbfEWTg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:36:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391105AbfEWTZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:25:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CA302054F;
        Thu, 23 May 2019 19:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639532;
        bh=Txk2PSjLgxSvt8X5OqjDK4/o+waZ0lc5+u5/6q8hk84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IaI1IPh7kJpcdm2hri0z106nYOq5JYTIxgnpKZx9N833U2tPTBFN/7lqhoA5AiOsM
         KggsiQzBLEs6kWUkvHwegnaS6HEauosp8Ertm4YJ/nBlg60ndsJkvfl3O2bEcanfSR
         gWR554PxiXNAC7KAh19MmVybDc0LSDUDGQTJtPgY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        skidnik <skidnik@gmail.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 130/139] i2c: designware: ratelimit transfer when suspended errors
Date:   Thu, 23 May 2019 21:06:58 +0200
Message-Id: <20190523181736.083048246@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181720.120897565@linuxfoundation.org>
References: <20190523181720.120897565@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 6bac9bc273cdab6157ad7a2ead09400aabfc445b ]

There are two problems with dev_err() here. One: It is not ratelimited.
Two: We don't see which driver tried to transfer something with a
suspended adapter. Switch to dev_WARN_ONCE to fix both issues. Drawback
is that we don't see if multiple drivers are trying to transfer while
suspended. They need to be discovered one after the other now. This is
better than a high CPU load because a really broken driver might try to
resend endlessly.

Link: https://bugs.archlinux.org/task/62391
Fixes: 275154155538 ("i2c: designware: Do not allow i2c_dw_xfer() calls while suspended")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reported-by: skidnik <skidnik@gmail.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: skidnik <skidnik@gmail.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-designware-master.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index bb8e3f1499796..d464799e40a30 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -426,8 +426,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	pm_runtime_get_sync(dev->dev);
 
-	if (dev->suspended) {
-		dev_err(dev->dev, "Error %s call while suspended\n", __func__);
+	if (dev_WARN_ONCE(dev->dev, dev->suspended, "Transfer while suspended\n")) {
 		ret = -ESHUTDOWN;
 		goto done_nolock;
 	}
-- 
2.20.1



