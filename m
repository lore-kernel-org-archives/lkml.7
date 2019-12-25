Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A27C2D0C8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 05:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CEE820722
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 05:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfLYFhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 00:37:00 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:60365 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725798AbfLYFhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 00:37:00 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TlsqoyK_1577252212;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0TlsqoyK_1577252212)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Dec 2019 13:36:57 +0800
From:   Hui Zhu <teawater@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Hui Zhu <teawater@gmail.com>, Hui Zhu <teawaterz@linux.alibaba.com>
Subject: [RFC] memcg: Add swappiness to cgroup2
Date:   Wed, 25 Dec 2019 13:36:48 +0800
Message-Id: <1577252208-32419-1-git-send-email-teawater@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if cgroup2 has swap.max, swappiness is still a very useful config.
This commit add swappiness to cgroup2.

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 mm/memcontrol.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c5b5f74..e966396 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7143,6 +7143,11 @@ static struct cftype swap_files[] = {
 		.file_offset = offsetof(struct mem_cgroup, swap_events_file),
 		.seq_show = swap_events_show,
 	},
+	{
+		.name = "swappiness",
+		.read_u64 = mem_cgroup_swappiness_read,
+		.write_u64 = mem_cgroup_swappiness_write,
+	},
 	{ }	/* terminate */
 };
 
-- 
2.7.4

