Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87623C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8F12053B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403600;
	bh=ePJ2pkZNK2a4mQjfJXGV5Pv+SMUz7DMtBlOvjCi1n7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XdFRQwR6MY8e+xwuiTeIp6lTQgaMBwT+ozR1vRUxAzILoagppVPc2Eb/qheoJriU0
	 PqI+3U9WJfdbNdmvpdvK0oWLPyENsXsoa/COs2cj4gwHFxvZgpFJWEOr5I7N3SnG/r
	 ExgoA5oii3aifFIhg6Tih5siKxwo+i+vM5SuSy2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbfKVFws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:52:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:58454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728617AbfKVFwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:52:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D4A72071F;
        Fri, 22 Nov 2019 05:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401958;
        bh=ePJ2pkZNK2a4mQjfJXGV5Pv+SMUz7DMtBlOvjCi1n7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C7n3M9KkLNHLdJa8OmwOGM/laX+CcSrKZd1jVNAPUS4ajQAfwMc+Hzu8Va3HQLvDf
         /PXEPVDDaLssgvxK7SUo9WfhaNs079fX6z8r364+Q32J02pv3qBpfw8/SmJnXGSzNR
         U6u9jkdT7lwcYzxq0381bFfd5kBHXEnnckY5nn00=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Karsten Graul <kgraul@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 180/219] net/smc: prevent races between smc_lgr_terminate() and smc_conn_free()
Date:   Fri, 22 Nov 2019 00:48:32 -0500
Message-Id: <20191122054911.1750-173-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Karsten Graul <kgraul@linux.ibm.com>

[ Upstream commit 77f838ace755d2f466536c44dac6c856f62cd901 ]

To prevent races between smc_lgr_terminate() and smc_conn_free() add an
extra check of the lgr field before accessing it, and cancel a delayed
free_work when a new smc connection is created.
This fixes the problem that free_work cleared the lgr variable but
smc_lgr_terminate() or smc_conn_free() still access it in parallel.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 18daebcef1813..2c9baf8bf1189 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -128,6 +128,8 @@ static void smc_lgr_unregister_conn(struct smc_connection *conn)
 {
 	struct smc_link_group *lgr = conn->lgr;
 
+	if (!lgr)
+		return;
 	write_lock_bh(&lgr->conns_lock);
 	if (conn->alert_token_local) {
 		__smc_lgr_unregister_conn(conn);
@@ -612,6 +614,8 @@ int smc_conn_create(struct smc_sock *smc, bool is_smcd, int srv_first_contact,
 			local_contact = SMC_REUSE_CONTACT;
 			conn->lgr = lgr;
 			smc_lgr_register_conn(conn); /* add smc conn to lgr */
+			if (delayed_work_pending(&lgr->free_work))
+				cancel_delayed_work(&lgr->free_work);
 			write_unlock_bh(&lgr->conns_lock);
 			break;
 		}
-- 
2.20.1

