Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B5FECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1A8205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569948087;
	bh=vj/qwHHiJ4il+2uRSoB+681GnRxxk7xj4r+VUN9DvNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BGDmL6o6ogKQ8fWzsTHzlADvMmtepvQQGRLu6VB5tBi2WsCfGLyYrcs/lVYyjdJ5J
	 RghrCbDd6Asj63Bmee0S3OhVgj4gXfQUV98u8zFL89JBZnOYE5UYGukG7CUQxiEUPe
	 GBNN1e5FVzI7iV1uqRPNHYmcOwtt3kfcLEpF52/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730995AbfJAQlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:41:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730896AbfJAQlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:41:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CB132168B;
        Tue,  1 Oct 2019 16:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948081;
        bh=vj/qwHHiJ4il+2uRSoB+681GnRxxk7xj4r+VUN9DvNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s4CRyY+6yAqwlsgF5b9vmNLjJITPk/nNyYvw41jzgyk4EX7cuF/HjMAhgWhsdhVGG
         a5iVE6nkwHPd3nyVHm+jsOQk0gnOejp6au95BZqWc3JQp5iWUg8fzfsxfihNoWLQjv
         ZuAl1w05dJ5dx1m58x9C2SV9+JH+ElUfyxVV4hf8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 70/71] sch_netem: fix a divide by zero in tabledist()
Date:   Tue,  1 Oct 2019 12:39:20 -0400
Message-Id: <20191001163922.14735-70-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001163922.14735-1-sashal@kernel.org>
References: <20191001163922.14735-1-sashal@kernel.org>
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
index b17f2ed970e29..f5cb35e550f8d 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -777,7 +777,7 @@ static int get_dist_table(struct Qdisc *sch, struct disttable **tbl,
 	struct disttable *d;
 	int i;
 
-	if (n > NETEM_DIST_MAX)
+	if (!n || n > NETEM_DIST_MAX)
 		return -EINVAL;
 
 	d = kvmalloc(sizeof(struct disttable) + n * sizeof(s16), GFP_KERNEL);
-- 
2.20.1

