Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1966C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9774720661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050150;
	bh=diNUHzRjnEbFUzOSL4muGj0Wqg1P/1H88ZysThsYrR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dP/337LuyE9mmE4BmVjzbUGZwn7RzruCogw3XJa3BsNSIXjcCeY9rqLvN5lbZhQkr
	 P7Sr6CRS+yZ+wfCJmvRSkTYYQq/bKF2iOC22WsFenUg97YIyx3U81yYHQqB7YTVwEo
	 e3TmVncq1lVABJX8CMcBLrHQuodw6RI7D2+IuIqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbfCHM76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:59:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:36666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727622AbfCHM7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:59:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B55E220449;
        Fri,  8 Mar 2019 12:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049994;
        bh=diNUHzRjnEbFUzOSL4muGj0Wqg1P/1H88ZysThsYrR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wzN+rXhZFM08NCWutbMv8XaReVGI/OiZKlJPlujpgRWjFQaI8CK8hB32a/6eteb+e
         ViT9QYl46BL3zpFQjE1GAI6V5yC29VqFCt0yUVpWJf5jOZKBrKfpNom55lttO1450g
         FE66Jm6mj6M2Udmgy5lLbqpaL0CfMlS5p7MOfAA4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 51/68] net/sched: act_skbedit: fix refcount leak when replace fails
Date:   Fri,  8 Mar 2019 13:50:21 +0100
Message-Id: <20190308124913.165040294@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
References: <20190308124910.696595153@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit 6191da98062d25276a3b88fb2a94dcbcfb3ea65d ]

when act_skbedit was converted to use RCU in the data plane, we added an
error path, but we forgot to drop the action refcount in case of failure
during a 'replace' operation:

 # tc actions add action skbedit ptype otherhost pass index 100
 # tc action show action skbedit
 total acts 1

         action order 0: skbedit  ptype otherhost pass
          index 100 ref 1 bind 0
 # tc actions replace action skbedit ptype otherhost drop index 100
 RTNETLINK answers: Cannot allocate memory
 We have an error talking to the kernel
 # tc action show action skbedit
 total acts 1

         action order 0: skbedit  ptype otherhost pass
          index 100 ref 2 bind 0

Ensure we call tcf_idr_release(), in case 'params_new' allocation failed,
also when the action is being replaced.

Fixes: c749cdda9089 ("net/sched: act_skbedit: don't use spinlock in the data path")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_skbedit.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/sched/act_skbedit.c
+++ b/net/sched/act_skbedit.c
@@ -191,8 +191,7 @@ static int tcf_skbedit_init(struct net *
 
 	params_new = kzalloc(sizeof(*params_new), GFP_KERNEL);
 	if (unlikely(!params_new)) {
-		if (ret == ACT_P_CREATED)
-			tcf_idr_release(*a, bind);
+		tcf_idr_release(*a, bind);
 		return -ENOMEM;
 	}
 


