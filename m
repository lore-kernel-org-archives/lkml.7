Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FD4C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36CD1206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdERt34D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfG2IYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:24:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36753 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfG2IYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:24:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so27635302pfl.3;
        Mon, 29 Jul 2019 01:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5h4/ngKO5Z/3jYbUIrlo9ndd3dT0JatjyXIXbot7yLw=;
        b=sdERt34DmzFr0UQhQetsEDm14B6xNQXoBVENQtYCg+qAb0s7oaHGeqKiFHgjec22Al
         34re5uJQFlGV8VbDZ5xy9GT7G1oNep3AWUPUIrXkOriiZ3rSkeUS93jcXQyU7YVq8+5w
         6osndCFT4aH2o/mQk63XHD7B/NOTBhxVp3EXpYcoedvLKzUj90JJCrMqD7RU5ClObjjM
         Gabs1d12FWK+qMCoxxtRVsa79KqdVp+OOniswIIcwnzYZ6haX4hRUU+n50f1SF3Lh0IH
         gj7cQ+14ptFQaQ2sogkEIoQiZ9G0ShEmRoqv1mexLklkIjTrNnIuA7urPYavejcpstNR
         AUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5h4/ngKO5Z/3jYbUIrlo9ndd3dT0JatjyXIXbot7yLw=;
        b=VzvFTI0iLFdqTGtIB0FZsZT3GbYe8c3P76vB29N/hKrwIiKMFbjR/ntXDG+oU3tf7+
         2syNawU94IxR6PbpEoprG+ktDlRwVdwHKHyPFi2BNEc+kwKbgjbfuT2RG1ZWMXOT4v5q
         RCk8MgBnMrA6i34kvnxWivNDpBOxCK8rQffXQufcdE4OR6xcYlFo5bGIFAiTEuWWS44E
         dgUHtbOSUjTwOtynG1ud37l+kJ15hl+9f7tLw/QeXnKenrp2OWorF/bHAZ5jVyg+wxfa
         li/ZtZZqt/jYASfH6Vox7fXr5DzKhuF5RYh/MLF5gFjqJsLIJYuC4YnTxzJJcW1fabRU
         UafA==
X-Gm-Message-State: APjAAAUW4PY7tXHaziL8i2G5zaVkkjIoMwg8Zm5J6CM3xGi/90rhAfs4
        Xpnh37nVQCMwTiestgkRAiA=
X-Google-Smtp-Source: APXvYqwNz3KiedDO1QC4ijV2xJptGJJTlsaZJV92tK7sZZD4GVvxeba7o1cppV9ofDbhXZAm/ZplZA==
X-Received: by 2002:a65:52ca:: with SMTP id z10mr53213874pgp.424.1564388688755;
        Mon, 29 Jul 2019 01:24:48 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id k3sm45689335pgq.92.2019.07.29.01.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 01:24:48 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH v3] net: sched: Fix a possible null-pointer dereference in dequeue_func()
Date:   Mon, 29 Jul 2019 16:24:33 +0800
Message-Id: <20190729082433.28981-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dequeue_func(), there is an if statement on line 74 to check whether
skb is NULL:
    if (skb)

When skb is NULL, it is used on line 77:
    prefetch(&skb->end);

Thus, a possible null-pointer dereference may occur.

To fix this bug, skb->end is used when skb is not NULL.

This bug is found by a static analysis tool STCheck written by us.

Fixes: 76e3cc126bb2 ("codel: Controlled Delay AQM")
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
* Add a fix tag.
  Thank Jiri Pirko for helpful advice.
v3:
* Use a correct fix tag.
  Thank Jiri Pirko for helpful advice.

---
 net/sched/sch_codel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index 25ef172c23df..30169b3adbbb 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -71,10 +71,10 @@ static struct sk_buff *dequeue_func(struct codel_vars *vars, void *ctx)
 	struct Qdisc *sch = ctx;
 	struct sk_buff *skb = __qdisc_dequeue_head(&sch->q);
 
-	if (skb)
+	if (skb) {
 		sch->qstats.backlog -= qdisc_pkt_len(skb);
-
-	prefetch(&skb->end); /* we'll need skb_shinfo() */
+		prefetch(&skb->end); /* we'll need skb_shinfo() */
+	}
 	return skb;
 }
 
-- 
2.17.0

