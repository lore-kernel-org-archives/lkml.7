Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F0BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 21:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C647218A1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 21:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="VG20XdPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfCPVqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 17:46:17 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:38358 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbfCPVqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 17:46:15 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 6A257CD5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 21:46:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SgtTOh5_ShQl for <linux-kernel@vger.kernel.org>;
        Sat, 16 Mar 2019 16:46:13 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 37598CC1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 16:46:13 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id p17so10078236ios.8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 14:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CPadDO1VqpT3JKzUg/A5BP2/PeNz2poG0NUIuTIheCU=;
        b=VG20XdPwAcr0rOZrtOGNSqZXSEhGwe1op774j9/7xsOj9WcQX/yxYsDxnaw+xhovHk
         fQXOHWVh9K79Hu8hw7KYWUQqFTo9UNPuFAZKE4S0ihtihvA0NDW4m7G6sCl07liadJFO
         BhBQ/flMYu0G7lFM88x4iRhby7gaQmfJl/uQHB1qapwX1bcxbXOiHaVzu2S2X9q6CyBV
         LRqt8VPoHCidF8sim275DDF43V+iYqmceBeIO6BKW9c0zn6Vp9ySwnwOv3yleh1gm04p
         ITK6Cly+8/P4g87sxdWl+v3P/A5yw8zk8O1p67eHKykP24hbA7Of/0TT7YedhE/e6Ki7
         hvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CPadDO1VqpT3JKzUg/A5BP2/PeNz2poG0NUIuTIheCU=;
        b=TNW5AEZL2hS0t+KzlTzRCEkjXBRGiwyB/tWXBD8osjFyCc9h3aaGkTsPbsahg++vZb
         uG2dyKTDhldYlOF4KUH3ujBG+QyGjhNTbvcDNnZfA072WWTkDZYoGbz/FauubEeYQt5i
         H6Ntx92xDQI6xiCdhjUcMv4BoPpg86gcpVql0P4GybC8ZT1ZINNgtt53cjZaaHMCo3Yu
         ZobsfvtYP3saGhY8c9WmVYLRD/u41G6jxzxi0PjlHxeGbzbNy+X1S54aFimYx3SKg/n8
         +ijogkqV9SnUd1WEOiAz0sk0+IRiFB4u8uGLaH9keMMpgDBd+serIE9kQQSoVAGFHNf5
         bEfA==
X-Gm-Message-State: APjAAAWydPqaUrWInYX544Rvu8JiInXKMg3brmfx7G8dg1fnEfwXn0Wo
        EXVKknYIreNESi8eTjoaqssZ6oQdWa41eUyVliKt+Kk73Y0V2yrU5EZy1ZvfQsRdxubDvxWTEpc
        /nJwju+SciY6sDpt77SQpPK5861GD
X-Received: by 2002:a02:56d4:: with SMTP id u81mr6442527jad.1.1552772772850;
        Sat, 16 Mar 2019 14:46:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqycdaC6T8gWJj2DUcMJhhnCildRK+56fDdXcUj6PBoBw5qTKhamgnjLxuxf3xSHEKO31Jv9kQ==
X-Received: by 2002:a02:56d4:: with SMTP id u81mr6442520jad.1.1552772772638;
        Sat, 16 Mar 2019 14:46:12 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id t25sm2358602ioc.37.2019.03.16.14.46.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 14:46:11 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] net: tipc: fix a missing check for nla_nest_start
Date:   Sat, 16 Mar 2019 16:46:05 -0500
Message-Id: <20190316214605.24304-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190316.113724.2004153142144465456.davem@davemloft.net>
References: <20190316.113724.2004153142144465456.davem@davemloft.net>
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

