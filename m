Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD69C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0B12189E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565291331;
	bh=L6QgowxSqMxevoEUkmc7YuDBPjP+ihl/U1fmkymryIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BmbChzef1EHjijGdKRk96ylkGue2quyHwQe6IMXmyaQgQ5VBrs9tWk1wnTNybBDeU
	 zUtA71ej1ixJYLnKnnuzPyasLBh8xmFbi+QZ6lSZ9I+KSQMdF0sazruhhU+dwH9Gx+
	 BOBZN9NXDZOQzereND1C0peqPz20m9lMYQRovp3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404986AbfHHTIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:08:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404509AbfHHTIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:08:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B82F92184E;
        Thu,  8 Aug 2019 19:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565291318;
        bh=L6QgowxSqMxevoEUkmc7YuDBPjP+ihl/U1fmkymryIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gYR57TnzP7l62gi/b168AzLPizLlFiIZ67jbuyDg0PpPY6o1TYtxgHv10YFnwpOf+
         0MmQ3xgIyA5cBkKlgp8rSP+zM8rQV7VqWhtHXW7lDrg73NW8UyULv6Hau4fY07oVnX
         QXAHpwxMy7TAm1GTCMltUniAwtks4iLEuRzD0ehY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+fbb5b288c9cb6a2eeac4@syzkaller.appspotmail.com,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 14/45] ife: error out when nla attributes are empty
Date:   Thu,  8 Aug 2019 21:05:00 +0200
Message-Id: <20190808190454.554649781@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808190453.827571908@linuxfoundation.org>
References: <20190808190453.827571908@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit c8ec4632c6ac9cda0e8c3d51aa41eeab66585bd5 ]

act_ife at least requires TCA_IFE_PARMS, so we have to bail out
when there is no attribute passed in.

Reported-by: syzbot+fbb5b288c9cb6a2eeac4@syzkaller.appspotmail.com
Fixes: ef6980b6becb ("introduce IFE action")
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_ife.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -484,6 +484,11 @@ static int tcf_ife_init(struct net *net,
 	int ret = 0;
 	int err;
 
+	if (!nla) {
+		NL_SET_ERR_MSG_MOD(extack, "IFE requires attributes to be passed");
+		return -EINVAL;
+	}
+
 	err = nla_parse_nested(tb, TCA_IFE_MAX, nla, ife_policy, NULL);
 	if (err < 0)
 		return err;


