Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FF0C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4A92339E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567102395;
	bh=eF5DfDYj7vzJJwsDctZbpjiYwWB/aovBZTyRp1T5PMk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=efBpajB+ufXLmJGK26n6+RLi9yh23UJUJjI+x5qqEeR/0XEe6hfX7DaQaGjhKczoK
	 sY3RIEr+JDD1lCieJBguljmf+PoVL9GlB6n4LX2l9ImJ8mQSchsCVgz93dqhpCf1Oa
	 zDEgLdoT7NH+6fFUBdw1yps7FGiBoqkVNnVpJFTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbfH2SNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:13:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfH2SNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:13:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 307E521874;
        Thu, 29 Aug 2019 18:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102393;
        bh=eF5DfDYj7vzJJwsDctZbpjiYwWB/aovBZTyRp1T5PMk=;
        h=From:To:Cc:Subject:Date:From;
        b=VqD7Uf5BeVR8hNnKS695qezuXsuaSrUwMnGxFsCigvfuoI87La7FAStI9fabVdBSH
         Abeqlci+iYFB1ZHBJsHvccFSxs3p4up/AUw6eYL5fACmNPINSn3HZlX3SzBSV1STLe
         UPKWJq/LNgtZQO/tD8N0Kuc8axs+d/iXW88Ro7vQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 01/76] batman-adv: Fix netlink dumping of all mcast_flags buckets
Date:   Thu, 29 Aug 2019 14:11:56 -0400
Message-Id: <20190829181311.7562-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Eckelmann <sven@narfation.org>

[ Upstream commit fa3a03da549a889fc9dbc0d3c5908eb7882cac8f ]

The bucket variable is only updated outside the loop over the mcast_flags
buckets. It will only be updated during a dumping run when the dumping has
to be interrupted and a new message has to be started.

This could result in repeated or missing entries when the multicast flags
are dumped to userspace.

Fixes: d2d489b7d851 ("batman-adv: Add inconsistent multicast netlink dump detection")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/multicast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index ec54e236e3454..50fe9dfb088b6 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -1653,7 +1653,7 @@ __batadv_mcast_flags_dump(struct sk_buff *msg, u32 portid,
 
 	while (bucket_tmp < hash->size) {
 		if (batadv_mcast_flags_dump_bucket(msg, portid, cb, hash,
-						   *bucket, &idx_tmp))
+						   bucket_tmp, &idx_tmp))
 			break;
 
 		bucket_tmp++;
-- 
2.20.1

