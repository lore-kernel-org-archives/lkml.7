Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782CDC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5158221920
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947094;
	bh=1HgWfFEiXK+kna90PfsnfcU1m1Ld0CmnpIk7xow7eLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pVy6qQPtYR050OLiZB4PHcvKETypNx6+iMboa/u+wCEK9eX2/4E1P/n9dcE17MbH5
	 4u3yy8QqLiP9UDd1pWp2d1NA2b4gjr+Gcr2EGvIA8IcWQ0MZGg2i3RvOUW7w1FVNSV
	 1kvE2K+ikwmOqXzxoHSwfq/p1k9YK5GSS8daCK7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732660AbfIHMvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:51:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732577AbfIHMvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:51:22 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 709A320863;
        Sun,  8 Sep 2019 12:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567947081;
        bh=1HgWfFEiXK+kna90PfsnfcU1m1Ld0CmnpIk7xow7eLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rsRZtJTgB4xE8Hdqw0Au8OZGTd9V7HWi5s0eYBWaCF219DrOQx1cDwyY+qR6OdgJ7
         Q/0gViy7PS6LPGzcryvEc9thVYPtzPA309o8ewXhykBcgYRupOdUTXz+CtFR67FCAN
         dbIb9gmR9jxjBijQxE8IzGHjj+F31O5MQXSflOhk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Leandro Dorileo <leandro.maciel.dorileo@intel.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 12/94] taprio: Fix kernel panic in taprio_destroy
Date:   Sun,  8 Sep 2019 13:41:08 +0100
Message-Id: <20190908121150.784656515@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121150.420989666@linuxfoundation.org>
References: <20190908121150.420989666@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <olteanv@gmail.com>

taprio_init may fail earlier than this line:

	list_add(&q->taprio_list, &taprio_list);

i.e. due to the net device not being multi queue.

Attempting to remove q from the global taprio_list when it is not part
of it will result in a kernel panic.

Fix it by matching list_add and list_del better to one another in the
order of operations. This way we can keep the deletion unconditional
and with lower complexity - O(1).

Cc: Leandro Dorileo <leandro.maciel.dorileo@intel.com>
Fixes: 7b9eba7ba0c1 ("net/sched: taprio: fix picos_per_byte miscalculation")
Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_taprio.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -903,6 +903,10 @@ static int taprio_init(struct Qdisc *sch
 	 */
 	q->clockid = -1;
 
+	spin_lock(&taprio_list_lock);
+	list_add(&q->taprio_list, &taprio_list);
+	spin_unlock(&taprio_list_lock);
+
 	if (sch->parent != TC_H_ROOT)
 		return -EOPNOTSUPP;
 
@@ -920,10 +924,6 @@ static int taprio_init(struct Qdisc *sch
 	if (!opt)
 		return -EINVAL;
 
-	spin_lock(&taprio_list_lock);
-	list_add(&q->taprio_list, &taprio_list);
-	spin_unlock(&taprio_list_lock);
-
 	for (i = 0; i < dev->num_tx_queues; i++) {
 		struct netdev_queue *dev_queue;
 		struct Qdisc *qdisc;


