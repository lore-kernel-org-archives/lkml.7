Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845FCC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562572184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565291362;
	bh=QDL8BVyypXe/oKSzuncJPHEodeCrkNt9VjGOsONMVKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TOmR2iKl2lDiVZWEulYzIkIm/vj69yQa7O+q2AUXTNEiYdu6axxlpedan5783+1QB
	 vO4kA3zNiC23W/vZhMCyLtDTInP03tA0GmUo+XVgjLUlwFzKotRWKxTNjEztBf9Yku
	 Rn0YoX10gWCO62njxKIFjdrjogPkJtSj2T6gd/As=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404314AbfHHTJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405089AbfHHTJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:09:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE6AC2184E;
        Thu,  8 Aug 2019 19:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565291357;
        bh=QDL8BVyypXe/oKSzuncJPHEodeCrkNt9VjGOsONMVKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L9/6q89itXEkYOl3Bg42yqMWcUN6Le8RJL7n9LR4bes52rJpRKLobczm6xIoROSTo
         T/hKkY4lSNL6eXZeYubKk6okCGNRq7OM3YufpmQmjE8cZqXvbGCQuqFd+NkMv+4Kos
         oNBa+SsnwmQJpEojU/KAdHzEz17OCY/4qZLgnxyM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roman Mashak <mrv@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 29/45] net sched: update vlan action for batched events operations
Date:   Thu,  8 Aug 2019 21:05:15 +0200
Message-Id: <20190808190455.374963381@linuxfoundation.org>
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

From: Roman Mashak <mrv@mojatatu.com>

[ Upstream commit b35475c5491a14c8ce7a5046ef7bcda8a860581a ]

Add get_fill_size() routine used to calculate the action size
when building a batch of events.

Fixes: c7e2b9689 ("sched: introduce vlan action")
Signed-off-by: Roman Mashak <mrv@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_vlan.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -296,6 +296,14 @@ static int tcf_vlan_search(struct net *n
 	return tcf_idr_search(tn, a, index);
 }
 
+static size_t tcf_vlan_get_fill_size(const struct tc_action *act)
+{
+	return nla_total_size(sizeof(struct tc_vlan))
+		+ nla_total_size(sizeof(u16)) /* TCA_VLAN_PUSH_VLAN_ID */
+		+ nla_total_size(sizeof(u16)) /* TCA_VLAN_PUSH_VLAN_PROTOCOL */
+		+ nla_total_size(sizeof(u8)); /* TCA_VLAN_PUSH_VLAN_PRIORITY */
+}
+
 static struct tc_action_ops act_vlan_ops = {
 	.kind		=	"vlan",
 	.type		=	TCA_ACT_VLAN,
@@ -305,6 +313,7 @@ static struct tc_action_ops act_vlan_ops
 	.init		=	tcf_vlan_init,
 	.cleanup	=	tcf_vlan_cleanup,
 	.walk		=	tcf_vlan_walker,
+	.get_fill_size	=	tcf_vlan_get_fill_size,
 	.lookup		=	tcf_vlan_search,
 	.size		=	sizeof(struct tcf_vlan),
 };


