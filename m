Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1870DECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C198120659
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569948633;
	bh=wBX0BLKAxEJ4pgZQUvtIbB9dURc/CT3Dk0SqiZRMAMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M6BBns/mLl3iNMLi4srX+FPsLZYCuhhv9GcEZ35zhrFzPtbwImCmUYLv7lj/sKFuY
	 q2FFvwcnzzfK1MMns9D4U4yONvtyzDFyRBTXpn9RisYa+aSRj4q7Zc0yxV7FFogSRg
	 gALdNl/+y4uJbRMwTAb7ilpGOyUooKqx/C+RZYC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388202AbfJAQob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:44:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387834AbfJAQoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:44:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A47DB21855;
        Tue,  1 Oct 2019 16:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948262;
        bh=wBX0BLKAxEJ4pgZQUvtIbB9dURc/CT3Dk0SqiZRMAMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0fzcS7jzpy9Z5p1a1FhP95m+8et6J8/wXwuJ4qZFX9uX4sol0twFuVOnSLX5U6uZt
         2aUsXsZtBQHQ+qtGVDjseuJPewoDLCx2ci0Tmw0zhhJ4ETGgMayqnOocFTcVKYP+mN
         WSbgVGKGGaN3wcQJ5k2olJvYOiVQkvq5d7lFJb7o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 43/43] sch_netem: fix a divide by zero in tabledist()
Date:   Tue,  1 Oct 2019 12:43:11 -0400
Message-Id: <20191001164311.15993-43-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001164311.15993-1-sashal@kernel.org>
References: <20191001164311.15993-1-sashal@kernel.org>
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
index 4dfe10b9f96c8..86350fe5cfc8f 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -749,7 +749,7 @@ static int get_dist_table(struct Qdisc *sch, struct disttable **tbl,
 	struct disttable *d;
 	int i;
 
-	if (n > NETEM_DIST_MAX)
+	if (!n || n > NETEM_DIST_MAX)
 		return -EINVAL;
 
 	d = kvmalloc(sizeof(struct disttable) + n * sizeof(s16), GFP_KERNEL);
-- 
2.20.1

