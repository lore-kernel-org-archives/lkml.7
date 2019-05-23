Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC6FC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D4520879
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558640212;
	bh=I3em34TPw1tOqm1IGSJ9vZptuF9O8eyUf6JBcohdZxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WigFs36HUEt1AWWjZ1BuOqUlLlOoQh+jANXH5Otbpe6nQOONI4yzl5MeiLRLOCYX7
	 ekEnVtXFPeRtBLR6KEUXHqocr2QxsE7UHoDDESk4JMvhXYCvvEjEQ3T0W12H7dJ7ue
	 JmXDARmuxQxqSMK/ovQ+WyRz0DvM4+pdG1MNPlhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391453AbfEWTgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:36:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389800AbfEWTZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:25:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 100712133D;
        Thu, 23 May 2019 19:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639516;
        bh=I3em34TPw1tOqm1IGSJ9vZptuF9O8eyUf6JBcohdZxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UCTBcOhtFzWEGxnlM4VyNbWBP7tWwCKMnn0zFcrA/ANORjudmYWdN2p4jd9el1p+R
         f97bkDX//oB15tLiH/kP6XXFjg5+MQ0UTr+7oSx7t/+kpf9LcYznrVtDN62dLsnkb7
         iTnLUbA+VjqNzVJzHOkUdww/onfpdXSGyW/GhIrA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bhagavathi Perumal S <bperumal@codeaurora.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 117/139] mac80211: Fix kernel panic due to use of txq after free
Date:   Thu, 23 May 2019 21:06:45 +0200
Message-Id: <20190523181734.966207237@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181720.120897565@linuxfoundation.org>
References: <20190523181720.120897565@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f1267cf3c01b12e0f843fb6a7450a7f0b2efab8a ]

The txq of vif is added to active_txqs list for ATF TXQ scheduling
in the function ieee80211_queue_skb(), but it was not properly removed
before freeing the txq object. It was causing use after free of the txq
objects from the active_txqs list, result was kernel panic
due to invalid memory access.

Fix kernel invalid memory access by properly removing txq object
from active_txqs list before free the object.

Signed-off-by: Bhagavathi Perumal S <bperumal@codeaurora.org>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/iface.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 4a6ff1482a9ff..02d2e6f11e936 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1908,6 +1908,9 @@ void ieee80211_if_remove(struct ieee80211_sub_if_data *sdata)
 	list_del_rcu(&sdata->list);
 	mutex_unlock(&sdata->local->iflist_mtx);
 
+	if (sdata->vif.txq)
+		ieee80211_txq_purge(sdata->local, to_txq_info(sdata->vif.txq));
+
 	synchronize_rcu();
 
 	if (sdata->dev) {
-- 
2.20.1



