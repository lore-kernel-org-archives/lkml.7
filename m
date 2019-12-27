Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FD7C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455BB21582
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577470513;
	bh=tZgV55XFfhtQ/L/J3NIPWWile7ruquWvp9IYF3wQGMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DvpPqFxTbTu4r6ugMaSxoD+c6KYKRVR7XE+5xikzjuNam/VeCAsEtrlAOw/8j0B+1
	 YJWDk+/NDy6V0RjYQ+sFWaTrZJT90jETTKapi+nW74XkyTnL9sZ9LQ7Qf8DjxV1ErA
	 YERMrVDgXZRtK46+TwzxUq0eVGRreIrjMDYYLVjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfL0SPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 13:15:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:39712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727733AbfL0SPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 13:15:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20A6F208C4;
        Fri, 27 Dec 2019 18:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577470504;
        bh=tZgV55XFfhtQ/L/J3NIPWWile7ruquWvp9IYF3wQGMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kx2r3xN+nyo+sdCjQIljetVHNNrm6M52SZOWMkmtclRk/Tu07teImYfU7ZxhC4gR1
         dvJm8S1QWvhgVw2s+/1qTlCz7osH8c08DRQbL4lwlgIFI9x4qFj8fKM0lEU7gh7y6L
         qaaTVpqtxTJA47oMxwulMYiZX3VzCEiewoKMPEpM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Taehee Yoo <ap420073@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>,
        osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 23/38] gtp: avoid zero size hashtable
Date:   Fri, 27 Dec 2019 13:14:20 -0500
Message-Id: <20191227181435.7644-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227181435.7644-1-sashal@kernel.org>
References: <20191227181435.7644-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit 6a902c0f31993ab02e1b6ea7085002b9c9083b6a ]

GTP default hashtable size is 1024 and userspace could set specific
hashtable size with IFLA_GTP_PDP_HASHSIZE. If hashtable size is set to 0
from userspace,  hashtable will not work and panic will occur.

Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/gtp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 1d2fc81dc714..c2898718b593 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -677,10 +677,13 @@ static int gtp_newlink(struct net *src_net, struct net_device *dev,
 	if (err < 0)
 		goto out_err;
 
-	if (!data[IFLA_GTP_PDP_HASHSIZE])
+	if (!data[IFLA_GTP_PDP_HASHSIZE]) {
 		hashsize = 1024;
-	else
+	} else {
 		hashsize = nla_get_u32(data[IFLA_GTP_PDP_HASHSIZE]);
+		if (!hashsize)
+			hashsize = 1024;
+	}
 
 	err = gtp_hashtable_new(gtp, hashsize);
 	if (err < 0)
-- 
2.20.1

