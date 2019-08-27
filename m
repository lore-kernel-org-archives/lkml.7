Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D26C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1281206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566893726;
	bh=qXVSr0YLceTXHfH0UDfxs8Fkzg59EqLQSN1g3fRdwZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wCBJMd3T9XYPTHqTYB5EbDEvobsSR2BA7/q7xpvlhd8Boupc4ad+EIK8RjNn3w2zb
	 l1P9pHPIiXveSq1qHc6KV4lLQikW2wzbOeNI3xeSJvBZLUW442GSEsopOipkVaN3ql
	 ZEF+YDHD1GfM7NOJJC21fnLrkYq9/Gp9RI/g+s4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbfH0IP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:15:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730318AbfH0HzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:55:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87DAD206BF;
        Tue, 27 Aug 2019 07:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892521;
        bh=qXVSr0YLceTXHfH0UDfxs8Fkzg59EqLQSN1g3fRdwZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rb2QELoSX4GyoLNGkentA4A3Jn04E0HNBrUxkXyKa04b0GI5N1rvU7goTuQb53gdY
         o8T8zXzTqzS6cbNHcrRLbEbrmeUoG62skzB4e8qo2TYzYJdL/pDdnyiFLed4mlexoJ
         tosMxwHDaaodjOGbZexfeypkJ3/Be0yXoFOfaf24=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 22/98] mac80211_hwsim: Fix possible null-pointer dereferences in hwsim_dump_radio_nl()
Date:   Tue, 27 Aug 2019 09:50:01 +0200
Message-Id: <20190827072719.418541337@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072718.142728620@linuxfoundation.org>
References: <20190827072718.142728620@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b55f3b841099e641bdb2701d361a4c304e2dbd6f ]

In hwsim_dump_radio_nl(), when genlmsg_put() on line 3617 fails, hdr is
assigned to NULL. Then hdr is used on lines 3622 and 3623:
    genl_dump_check_consistent(cb, hdr);
    genlmsg_end(skb, hdr);

Thus, possible null-pointer dereferences may occur.

To fix these bugs, hdr is used here when it is not NULL.

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Link: https://lore.kernel.org/r/20190729082332.28895-1-baijiaju1990@gmail.com
[put braces on all branches]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mac80211_hwsim.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 7cd428c0af433..ce2dd06af62e8 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3502,10 +3502,12 @@ static int hwsim_dump_radio_nl(struct sk_buff *skb,
 		hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
 				  cb->nlh->nlmsg_seq, &hwsim_genl_family,
 				  NLM_F_MULTI, HWSIM_CMD_GET_RADIO);
-		if (!hdr)
+		if (hdr) {
+			genl_dump_check_consistent(cb, hdr);
+			genlmsg_end(skb, hdr);
+		} else {
 			res = -EMSGSIZE;
-		genl_dump_check_consistent(cb, hdr);
-		genlmsg_end(skb, hdr);
+		}
 	}
 
 done:
-- 
2.20.1



