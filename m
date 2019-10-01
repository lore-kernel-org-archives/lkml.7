Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8D7C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D32820673
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569948361;
	bh=lM3s+irMFNzqa9XyylWt6mj++/lJaQnnIA+xn6KRqk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NqV+3KuKddo9QliVL0OinJGGI7aU0NhmdNKl6fE4qX25Z0R+cs2VKJarSPJwn9nz7
	 QhJbTiifWE4fqMmBSyoqMbcpLGSJCQg1h7MI9v16a/6O40wxCywF8shgfxt4zOkGk7
	 m+8QGHo0Tk7thxtSZO3oWJwz9rKwzFrmY+p1aBZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390460AbfJAQqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:46:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390427AbfJAQpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:45:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C65082190F;
        Tue,  1 Oct 2019 16:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948353;
        bh=lM3s+irMFNzqa9XyylWt6mj++/lJaQnnIA+xn6KRqk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jsc5DPKpe/5rMefHH48hNGk9gi1L++/Ta3q5hUBjl4CC47Y5yGUGtWCPdh4Nyr770
         T2+mkywv13XCBNti2eegdKFUi0fbiOT1RYXIVMuVTn85L+lgNvbKYTYV7/1Se3UrWM
         FKSwzEfT5LZADIdOBLYng8QduYIclfPzdovBvY9k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 15/15] sch_netem: fix a divide by zero in tabledist()
Date:   Tue,  1 Oct 2019 12:45:33 -0400
Message-Id: <20191001164533.16915-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001164533.16915-1-sashal@kernel.org>
References: <20191001164533.16915-1-sashal@kernel.org>
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
index 7acf1f2b8dfc3..2a431628af591 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -713,7 +713,7 @@ static int get_dist_table(struct Qdisc *sch, const struct nlattr *attr)
 	int i;
 	size_t s;
 
-	if (n > NETEM_DIST_MAX)
+	if (!n || n > NETEM_DIST_MAX)
 		return -EINVAL;
 
 	s = sizeof(struct disttable) + n * sizeof(s16);
-- 
2.20.1

