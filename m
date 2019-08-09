Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35751C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0930F21773
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565358449;
	bh=mB+dTMD97KK0efMVecvR9WZv83DDYzoda9HRh63++3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ya0xLriJnFIUqkkSuntSTPh0oQpaCof4zNSjp+S8e89WjZuLz1NqC6AEkDTNk4xAM
	 IKHzvji0q/wVRp44rEo+42rIa3gxeE3kwksNPQhV+ZtQJ+cI4CNxteoPLgg7dwmqhs
	 dTOAZ79tze1IXWl9TUe40hX50ScgdC1QrLNaIcU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407251AbfHINr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 09:47:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407227AbfHINrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 09:47:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BADDD214C6;
        Fri,  9 Aug 2019 13:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565358438;
        bh=mB+dTMD97KK0efMVecvR9WZv83DDYzoda9HRh63++3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UWEki2F3ijzuvfjWt+7wGXv47MVMnlXYcxuCPO3GAZKqxISZeViH1RIOAJrQ3Tms8
         cXhTtRwS+qEBJTneInrzNYF8XonWAq1Q4AEdV6bIVFXKwte1/GQC1z/8pFpYl3chBN
         8d1WZFt9D4s9Z1EbBw5tDhZNHSliSMqZInRwuV7A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+fbb5b288c9cb6a2eeac4@syzkaller.appspotmail.com,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 24/32] ife: error out when nla attributes are empty
Date:   Fri,  9 Aug 2019 15:45:27 +0200
Message-Id: <20190809133923.713962083@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190809133922.945349906@linuxfoundation.org>
References: <20190809133922.945349906@linuxfoundation.org>
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
 net/sched/act_ife.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -477,6 +477,9 @@ static int tcf_ife_init(struct net *net,
 	int ret = 0;
 	int err;
 
+	if (!nla)
+		return -EINVAL;
+
 	err = nla_parse_nested(tb, TCA_IFE_MAX, nla, ife_policy);
 	if (err < 0)
 		return err;


