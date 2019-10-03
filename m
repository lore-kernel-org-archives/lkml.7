Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383D8C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FA621783
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118899;
	bh=OBw4N9b4a5/LHABcdH3FNTdMUO8hc2WEP536ITLH9+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mY7GTCCSop80rfwEVUFzvZVBkn6b404bSAjESVtRjqKjkXSPjdcmKvnX4gMQ9smN9
	 NMpDS1XiBQMVmBi+2JCFZGyZDQTxKeYYpMrt3vVV+lMzaZGY0cfpuGyIqJFLyCbOrI
	 dS6RFwYc7G8l4V1kIXnDxTvJYXb/5seWBGsdQg5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733248AbfJCQIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:08:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733218AbfJCQIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:08:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C62FC207FF;
        Thu,  3 Oct 2019 16:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118890;
        bh=OBw4N9b4a5/LHABcdH3FNTdMUO8hc2WEP536ITLH9+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IAZP49ZEQ+9fF81lL5Fx1xTes5K58bzKAOnw49Pkrtw8cUhEJ1uEalWRGQjbBK6ej
         iv/RuPenWVDak4sCVGPeDp6F4iLbbu/E6Q/7VnPQuxeNxVmRQT/CKCmb/Zn0xYsPU3
         f32xN+fx9FTuCQ5LxAwYuw3ZsU8B6Hrxb+SqNIHU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        syzbot+618aacd49e8c8b8486bd@syzkaller.appspotmail.com
Subject: [PATCH 4.14 040/185] net_sched: add max len check for TCA_KIND
Date:   Thu,  3 Oct 2019 17:51:58 +0200
Message-Id: <20191003154446.810304929@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
References: <20191003154437.541662648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 62794fc4fbf52f2209dc094ea255eaef760e7d01 ]

The TCA_KIND attribute is of NLA_STRING which does not check
the NUL char. KMSAN reported an uninit-value of TCA_KIND which
is likely caused by the lack of NUL.

Change it to NLA_NUL_STRING and add a max len too.

Fixes: 8b4c3cdd9dd8 ("net: sched: Add policy validation for tc attributes")
Reported-and-tested-by: syzbot+618aacd49e8c8b8486bd@syzkaller.appspotmail.com
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_api.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1217,7 +1217,8 @@ check_loop_fn(struct Qdisc *q, unsigned
  */
 
 const struct nla_policy rtm_tca_policy[TCA_MAX + 1] = {
-	[TCA_KIND]		= { .type = NLA_STRING },
+	[TCA_KIND]		= { .type = NLA_NUL_STRING,
+				    .len = IFNAMSIZ - 1 },
 	[TCA_RATE]		= { .type = NLA_BINARY,
 				    .len = sizeof(struct tc_estimator) },
 	[TCA_STAB]		= { .type = NLA_NESTED },


