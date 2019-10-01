Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F881ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B5520659
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569948412;
	bh=uiHsB3meyPILAAZDTjLvMiCCFNR9pJuupii+/uI5/FA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RiOA4HrVyhaD35ZTYXHpcxXpbpaR0LUl/4XvKFUiptSotdc4A8PYPhLgCit+46kf2
	 tLLQeVvRBG9O8hHFJOpJ/5T7Xxg73ntL4kcXPtMZKVqSSMpttkxsaea+Jxxa2bryDe
	 QNU5iMYSscpNtGvIYTXnMCQ5JJdnE9ivUUK4bD08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390348AbfJAQpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:45:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390314AbfJAQpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:45:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1EA72190F;
        Tue,  1 Oct 2019 16:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948332;
        bh=uiHsB3meyPILAAZDTjLvMiCCFNR9pJuupii+/uI5/FA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CDzP/xyOYUJMPuoOUmg9ZRaO2Dw7K3TVjzTWi/NnV0Y0Se5PmHEHyTiV4WK7W9xF1
         ybqkGjK8Oz5p/l+u7dzMTm5PAErKb7Xu0HK5wh08arbJ1GHC4FTtmUvVnbNkBQGKyW
         SDFNV6AUjfINaUqYaliZ5pZOsu/Kgupx6bA/csb4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 19/19] sch_netem: fix a divide by zero in tabledist()
Date:   Tue,  1 Oct 2019 12:45:05 -0400
Message-Id: <20191001164505.16708-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001164505.16708-1-sashal@kernel.org>
References: <20191001164505.16708-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit b41d936b5ecfdb3a4abc525ce6402a6c49cffddc ]

syzbot managed to crash the kernel in tabledist() loading
an empty distribution table.

	t = dist->table[rnd % dist->size];

Simply return an error when such load is attempted.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_netem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index e9812e21dbc9b..12e3ae09c4ba1 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -711,7 +711,7 @@ static int get_dist_table(struct Qdisc *sch, const struct nlattr *attr)
 	int i;
 	size_t s;
 
-	if (n > NETEM_DIST_MAX)
+	if (!n || n > NETEM_DIST_MAX)
 		return -EINVAL;
 
 	s = sizeof(struct disttable) + n * sizeof(s16);
-- 
2.20.1

