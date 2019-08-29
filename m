Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A61FC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447742166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567102733;
	bh=Ogyck2ZoGhJppzSaw6fv33s60/hJwU3KTj2pLWwGsJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I0a+X8XrxEYlTlQynJCZrntXnzttvE8RdZ2CGI11ODI/GhKcezDu7O7d4CZ43QmMj
	 P9ZJV1F/AGYCkrRa5hhxO7zc779bZlEghofWrEQkT5qFXwjwaccBRNsVkr6eAudao6
	 RtNsQvDNxccf4olxDWgp02b5pMrSdiFMAGvkbcEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbfH2SSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:18:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730334AbfH2SSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:18:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1668920828;
        Thu, 29 Aug 2019 18:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102689;
        bh=Ogyck2ZoGhJppzSaw6fv33s60/hJwU3KTj2pLWwGsJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RzBBLu3lXV+SaOtvYtfs7pE6bOYJ33Cp+W1oWe2cWcWDQYP6zeqIi3bkJ6BTuAl8S
         i3bsegbKZFOfRLgMcLoUAfbYWsUQ/6WITAAy5CmItFkSvwu293chDWfKN6X3e3hZFu
         S727CPewruqAKD8tOfcJ8qwD9iohFDquuAkSvclI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wenwen Wang <wenwen@cs.uga.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 06/15] cxgb4: fix a memory leak bug
Date:   Thu, 29 Aug 2019 14:17:53 -0400
Message-Id: <20190829181802.9619-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181802.9619-1-sashal@kernel.org>
References: <20190829181802.9619-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

[ Upstream commit c554336efa9bbc28d6ec14efbee3c7d63c61a34f ]

In blocked_fl_write(), 't' is not deallocated if bitmap_parse_user() fails,
leading to a memory leak bug. To fix this issue, free t before returning
the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
index 4269944c5db53..129d6095749a4 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
@@ -2673,8 +2673,10 @@ static ssize_t blocked_fl_write(struct file *filp, const char __user *ubuf,
 		return -ENOMEM;
 
 	err = bitmap_parse_user(ubuf, count, t, adap->sge.egr_sz);
-	if (err)
+	if (err) {
+		kvfree(t);
 		return err;
+	}
 
 	bitmap_copy(adap->sge.blocked_fl, t, adap->sge.egr_sz);
 	t4_free_mem(t);
-- 
2.20.1

