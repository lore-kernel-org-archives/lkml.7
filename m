Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2D5C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1183C21835
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569765739;
	bh=h7aXqYbuaeCQa/Wtp9rWH6rdp8pPeonuM38BRTgkl0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p0KUlY/f/kS/u3yEWlaPCG4pE5RuJeOIowJ/yhwSeuq29k3OphhiKHiKTL+AhjcI1
	 dvwX+P28DUsDtUlgdcETcOpVKVtLbTIJ9Y230/yQ5ov40ycbN5cWQZvQaKFvOrFy9u
	 Jsaz9eh+EWumn7G42JRFu2E3l9Z45boD2Emi1n84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfI2OCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 10:02:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730172AbfI2OCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 10:02:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73C1A2082F;
        Sun, 29 Sep 2019 14:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569765735;
        bh=h7aXqYbuaeCQa/Wtp9rWH6rdp8pPeonuM38BRTgkl0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jPcGluhmxr1nldyCNHKX/CsAd5r4pd1dQycW+9W6IxprEpeQ+Po/GMouinWYj4+Cv
         vdvGYX/v2xHQMcjtfyuNe9R/jl9Bct7x0d1MqrssLgs1WBsRiNLqaRMMx/hEcUpmao
         FWD17cdmrQnZIubalRjsiKkSto0CP0mkeG4a5rTc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+21b29db13c065852f64b@syzkaller.appspotmail.com,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 44/45] net_sched: check cops->tcf_block in tc_bind_tclass()
Date:   Sun, 29 Sep 2019 15:56:12 +0200
Message-Id: <20190929135034.757719891@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929135024.387033930@linuxfoundation.org>
References: <20190929135024.387033930@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 8b142a00edcf8422ca48b8de88d286efb500cb53 ]

At least sch_red and sch_tbf don't implement ->tcf_block()
while still have a non-zero tc "class".

Instead of adding nop implementations to each of such qdisc's,
we can just relax the check of cops->tcf_block() in
tc_bind_tclass(). They don't support TC filter anyway.

Reported-by: syzbot+21b29db13c065852f64b@syzkaller.appspotmail.com
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_api.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 04faee7ccbce6..1047825d9f48d 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1920,6 +1920,8 @@ static void tc_bind_tclass(struct Qdisc *q, u32 portid, u32 clid,
 	cl = cops->find(q, portid);
 	if (!cl)
 		return;
+	if (!cops->tcf_block)
+		return;
 	block = cops->tcf_block(q, cl, NULL);
 	if (!block)
 		return;
-- 
2.20.1



