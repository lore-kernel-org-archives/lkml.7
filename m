Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78446C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE202054F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570121060;
	bh=vBEmhhmIsaUgoODDW4Mr5/z4iIlJ7s5TnhyGP3zP5/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iqV3MtHbIZnZSbpRWOLnw5vsLgqYL9oaHgYgRKvne3opvpO7U333g6ZFqWyrAUsve
	 C4C6ZzUYLQAQn2eWNC6JWR2IW2Ix902XgWg9CK9P9prPiId+Hr1tqueM9i6ormC0/x
	 tw9Fafi3e/YdZUd/aqIO2WEJHLo7uOMoN2CFh5AI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405349AbfJCQoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:44:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392735AbfJCQoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:44:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AEB2206BB;
        Thu,  3 Oct 2019 16:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570121055;
        bh=vBEmhhmIsaUgoODDW4Mr5/z4iIlJ7s5TnhyGP3zP5/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AB59pLPn8jJc8HjFWHlGD2jVOSKLx3xsxOGQSfS9N0MRwD4ifG2vTkn0TtQt7LXMU
         sZYSLX8VRFroSPdx13yyRvopIjl5l13EcGQuGvjRmScYjYIbtJ3LU3xCKyYpvCyJp2
         bCvJNT+JhSQ2pUv+wtvCPk+rYFjLrt/uhyt8V+4E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Mike Christie <mchristi@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 136/344] nbd: add missing config put
Date:   Thu,  3 Oct 2019 17:51:41 +0200
Message-Id: <20191003154553.641309708@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Christie <mchristi@redhat.com>

[ Upstream commit 887e975c4172d0d5670c39ead2f18ba1e4ec8133 ]

Fix bug added with the patch:

commit 8f3ea35929a0806ad1397db99a89ffee0140822a
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Mon Jul 16 12:11:35 2018 -0400

    nbd: handle unexpected replies better

where if the timeout handler runs when the completion path is and we fail
to grab the mutex in the timeout handler we will leave a config reference
and cannot free the config later.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Mike Christie <mchristi@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index e21d2ded732b7..a69a90ad92088 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -357,8 +357,10 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 	}
 	config = nbd->config;
 
-	if (!mutex_trylock(&cmd->lock))
+	if (!mutex_trylock(&cmd->lock)) {
+		nbd_config_put(nbd);
 		return BLK_EH_RESET_TIMER;
+	}
 
 	if (config->num_connections > 1) {
 		dev_err_ratelimited(nbd_to_dev(nbd),
-- 
2.20.1



