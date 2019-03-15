Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C59DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C592184C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Nv579TjC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbfCOGEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 02:04:25 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:44206 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbfCOGEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 02:04:24 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 1F5BEB37
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 06:04:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KXMd68LccPkk for <linux-kernel@vger.kernel.org>;
        Fri, 15 Mar 2019 01:04:23 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id E8416A7B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 01:04:22 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id u22so6212318iof.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 23:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CPadDO1VqpT3JKzUg/A5BP2/PeNz2poG0NUIuTIheCU=;
        b=Nv579TjCxM6P3b2kTU4fZ8ILGrXq/C/rs01JHuYFyGRGm/NBFQNnJ42XLPd3sxuSkm
         kbrAevwE28jh6uoTjnlQKDAutv0nE8Gs1J7rgd7MCVlazfxCJxi+lMtfmb4REstiEisw
         hghwuq9JcyVUo3mEZkIuXWZAwXje6sKXwQF0naIYVr9aHS/T6o2Uru0eA1VKxDoRH6C8
         ym7/gWserpixGJRUbThyrL0clzb/rZI1yu5/JglsY+g782GubbZSghu1HwrSeXmTjpiw
         5d2CPjT7Sjbr12a3c6P+n5CN05hQR8f8JK6wP2OKLrxXLGTvs+PhZ+mTqWKFAxSrWOG+
         TU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CPadDO1VqpT3JKzUg/A5BP2/PeNz2poG0NUIuTIheCU=;
        b=l2m1PzFUiGgQI+5npzy7VE8WItBUj/G2s/AXuV16cBnM072Y5mLMpBxc95jPfLxdkK
         ZRms390Sp3IqzS+QVcCmpqb+81XZLNhn0E3+GlrH1HBmDz64Fm1bm4L9rdmsVh5NuZ3V
         9CdDJIg5ZXnCkPD5tnge8q/VgQ/umvC+h3FtG4AS/DqU3RTqueo+ugJpJrvXKFSNwyAC
         jF7GOTbV6nPe96id75t8XYJjSF42BJOomkEH3JE1zUkY4mlZ5WuZ38VPqJqW+Wdjsl1w
         +5PPPnJVDs8j5CR+AIc+AZj3GdS7Qb2rqAJ3yMQof8Opns2BN78EGyP/3LEegsWlyP74
         HwNQ==
X-Gm-Message-State: APjAAAX1EbYt/rZUR34D4E8zD00RpDoNttapijOneNrlwX2oUrZfOz3g
        3uu8DjR7AT6HQAVi7FbKxOJwHzrWoofR/T97b1P2Zjvl2g5Iq7DB6qSLIgveObxItiAhHBjjnVr
        0JJtl9wDYfpxD8p4HINepRcfIiLSv
X-Received: by 2002:a24:50d5:: with SMTP id m204mr975630itb.103.1552629862511;
        Thu, 14 Mar 2019 23:04:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyhdqmXgz616tZHm1fW+VxISkzq06UzbJAWve5l1gAxQng/BNc99cWXoTLPXf9oFFTsFWFjeQ==
X-Received: by 2002:a24:50d5:: with SMTP id m204mr975621itb.103.1552629862231;
        Thu, 14 Mar 2019 23:04:22 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id e12sm482862iod.6.2019.03.14.23.04.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 23:04:21 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] net: socket: fix a missing check for nla_nest_start
Date:   Fri, 15 Mar 2019 01:03:05 -0500
Message-Id: <20190315060305.12925-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nla_nest_start may fail. The fix check its status and returns
-EMSGSIZE in case it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 net/tipc/socket.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index e482b342bfa8..49ab8b27bde4 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -3255,6 +3255,8 @@ static int __tipc_nl_add_sk_con(struct sk_buff *skb, struct tipc_sock *tsk)
 	peer_port = tsk_peer_port(tsk);
 
 	nest = nla_nest_start(skb, TIPC_NLA_SOCK_CON);
+	if (!nest)
+		return -EMSGSIZE;
 
 	if (nla_put_u32(skb, TIPC_NLA_CON_NODE, peer_node))
 		goto msg_full;
-- 
2.17.1

