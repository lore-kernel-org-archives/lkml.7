Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B283FC4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86141218AF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567946877;
	bh=A9IErmwm/sY8MQkwbPXh+/Q0dPv8y4x2fUnBeVQcIVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fx2ZGsI8JPV8izXfivHc4EWPyv+mYS0QE8Pk3pb+Wv1HV7nL6WrJ5/M742zYzMako
	 h9KLS+DuuzthMQibuhvozSqhhuIl65/TZ14kJgpLXycfBHWYvIFvIoVshjjBiIdAcy
	 XgDWMcq8/yGn1pb699+lgOwl32CJcVsC1YcMeli8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbfIHMr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:47:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730787AbfIHMrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:47:49 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC0FD21927;
        Sun,  8 Sep 2019 12:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946868;
        bh=A9IErmwm/sY8MQkwbPXh+/Q0dPv8y4x2fUnBeVQcIVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1dcIke9dyjf43vYcuqd/+0HT94JQSkvCgswlVFJqxfJKT8ZYd5B+YTWmJdct5V6DF
         yKVq1N8qXJ0Pua1eOMf5dFz2gVoW9RHj2Xk+Uy4rQlN3YhUwp72RlO5zrQBGC7q3fT
         YKKSVDxggQRDljH47B5BXEEaXAjPPV/2w3QGf/7w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vlad Buslov <vladbu@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 03/57] net: sched: act_sample: fix psample group handling on overwrite
Date:   Sun,  8 Sep 2019 13:41:27 +0100
Message-Id: <20190908121127.301930233@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121125.608195329@linuxfoundation.org>
References: <20190908121125.608195329@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vlad Buslov <vladbu@mellanox.com>

[ Upstream commit dbf47a2a094edf58983265e323ca4bdcdb58b5ee ]

Action sample doesn't properly handle psample_group pointer in overwrite
case. Following issues need to be fixed:

- In tcf_sample_init() function RCU_INIT_POINTER() is used to set
  s->psample_group, even though we neither setting the pointer to NULL, nor
  preventing concurrent readers from accessing the pointer in some way.
  Use rcu_swap_protected() instead to safely reset the pointer.

- Old value of s->psample_group is not released or deallocated in any way,
  which results resource leak. Use psample_group_put() on non-NULL value
  obtained with rcu_swap_protected().

- The function psample_group_put() that released reference to struct
  psample_group pointed by rcu-pointer s->psample_group doesn't respect rcu
  grace period when deallocating it. Extend struct psample_group with rcu
  head and use kfree_rcu when freeing it.

Fixes: 5c5670fae430 ("net/sched: Introduce sample tc action")
Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/psample.h  |    1 +
 net/psample/psample.c  |    2 +-
 net/sched/act_sample.c |    5 ++++-
 3 files changed, 6 insertions(+), 2 deletions(-)

--- a/include/net/psample.h
+++ b/include/net/psample.h
@@ -12,6 +12,7 @@ struct psample_group {
 	u32 group_num;
 	u32 refcount;
 	u32 seq;
+	struct rcu_head rcu;
 };
 
 struct psample_group *psample_group_get(struct net *net, u32 group_num);
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -156,7 +156,7 @@ static void psample_group_destroy(struct
 {
 	psample_group_notify(group, PSAMPLE_CMD_DEL_GROUP);
 	list_del(&group->list);
-	kfree(group);
+	kfree_rcu(group, rcu);
 }
 
 static struct psample_group *
--- a/net/sched/act_sample.c
+++ b/net/sched/act_sample.c
@@ -99,7 +99,8 @@ static int tcf_sample_init(struct net *n
 	s->tcf_action = parm->action;
 	s->rate = rate;
 	s->psample_group_num = psample_group_num;
-	RCU_INIT_POINTER(s->psample_group, psample_group);
+	rcu_swap_protected(s->psample_group, psample_group,
+			   lockdep_is_held(&s->tcf_lock));
 
 	if (tb[TCA_SAMPLE_TRUNC_SIZE]) {
 		s->truncate = true;
@@ -107,6 +108,8 @@ static int tcf_sample_init(struct net *n
 	}
 	spin_unlock_bh(&s->tcf_lock);
 
+	if (psample_group)
+		psample_group_put(psample_group);
 	if (ret == ACT_P_CREATED)
 		tcf_idr_insert(tn, *a);
 	return ret;


