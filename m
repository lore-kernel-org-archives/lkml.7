Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D08C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9837420854
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="jRvj2lI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbfCORMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:12:17 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:55322 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfCORMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:12:16 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 34DEA960
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 17:12:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id u_k8Ahu-d66g for <linux-kernel@vger.kernel.org>;
        Fri, 15 Mar 2019 12:12:15 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 02458CDB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 12:12:14 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id i63so8232581itb.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 10:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ppq+jOjQfaVe+0EvGu/B2tt3ryg7tgco2DiirhGxXeE=;
        b=jRvj2lI8zAqKCV4HqoFWHyWWePvrmUFEgrS8XT6M178mQOYZPrRIGp0UVFF7lIygFW
         MpHOF2+syqWlip6hwMJ1NmmVwEZbzqhDNXFWEhd6mg8e+B/jvIvOsoXPLLdjgW9ojHyY
         gsaqk43/TCPpgBv0d6cEoWRFNxd8lUgYJ7GqI7pVrj6UP6Zlld0ALAYYUMYgD5HKYyP+
         EUB+arh76cGiWQ9ZgZr9rLws8VgLDfIDoLoZolYo/xcNxGywKlSgXWCKxONwo2B9OS7f
         XkwTogwY9ltt70AmsSlCU4Sf2cQOEXmW/UFsrDr973VsLxOcVbHn8kJxOfunLEeuaMAv
         AuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ppq+jOjQfaVe+0EvGu/B2tt3ryg7tgco2DiirhGxXeE=;
        b=o8v0zK5LMFqt4BCQvQJjBMygSpBaIoOsOXxia6BUsJhuobbTQyREYHyTA+nugcdext
         tzGBqHWGuRybiudpcFAT0oRv/Ftik4yE0+6g2De+oVSHP9dPuitLS9dq2IAwWjEE98l1
         PerMVYY8b+yDuyCbqeSh0yw/Em3XAbAOzqEuaWwUqYzrmGshzBnvRqq2Vkw3w5j4jbsv
         qEy1yn3lY/qS3yMPGjfEpWIMB+hWj3kmT8uhXmqfrk53N94SlASHTr6KRXiPOQMq75Kp
         nwKNr8ILUJMLWe9H6hEaRtUDkZ+k23aJXCYxmA01bWaJ+Rs8IFB3c76zumAM/pJUQuCh
         6E2w==
X-Gm-Message-State: APjAAAXOBh6afetcPk9nnP/cIK9bHs/JxdSgZQ9aS7yd7z9RQPiKF4tu
        CkEnJ8YO8+KJwfVnOZgMuI+hqTK7IqhvQcz4bT5dbMSJpCVxjGjxatqDxfBekR7WtvLBCzXh66S
        4ERDJtPXxzG+UNCRb4iiVdXf+bWgN
X-Received: by 2002:a02:168a:: with SMTP id a132mr3162294jaa.101.1552669934605;
        Fri, 15 Mar 2019 10:12:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwFpo7G1D9IoruFFhTQUTzXdRh+24Z4zZAM7Cn5X4NOcM60cv6baLLER5Zb/82pQqeWOiTM/g==
X-Received: by 2002:a02:168a:: with SMTP id a132mr3162283jaa.101.1552669934382;
        Fri, 15 Mar 2019 10:12:14 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id m23sm977096ioh.29.2019.03.15.10.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 10:12:13 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] net: tipc: fix a missing check of nla_nest_start
Date:   Fri, 15 Mar 2019 12:11:59 -0500
Message-Id: <20190315171200.5269-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1d97622a-6404-6600-c06b-9450b225742b@cogentembedded.com>
References: <1d97622a-6404-6600-c06b-9450b225742b@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nla_nest_start could fail and requires a check. The fix returns
-EMSGSIZE if it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 net/tipc/group.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/tipc/group.c b/net/tipc/group.c
index 06fee142f09f..63f39201e41e 100644
--- a/net/tipc/group.c
+++ b/net/tipc/group.c
@@ -919,6 +919,9 @@ int tipc_group_fill_sock_diag(struct tipc_group *grp, struct sk_buff *skb)
 {
 	struct nlattr *group = nla_nest_start(skb, TIPC_NLA_SOCK_GROUP);
 
+	if (!group)
+		return -EMSGSIZE;
+
 	if (nla_put_u32(skb, TIPC_NLA_SOCK_GROUP_ID,
 			grp->type) ||
 	    nla_put_u32(skb, TIPC_NLA_SOCK_GROUP_INSTANCE,
-- 
2.17.1

