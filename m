Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E75C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722E5205ED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483688;
	bh=8m/MqRha1T/Gf1VwXx+GBM1pGru1K/qiMgwuwyeqJvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IJ2aFVgAYyH1wN2HQOgWfrlYtCXiffaHMd6mWe3oI8sZfXnf4AKUqAFQqEwFv83cO
	 es9CUbqWvdN3jb48FTM49GLi9vSxe+QjNUGcQ9i2ad53VYnoiXLTp4DW+eFu8noa57
	 Jm9u2f6gsMcJGqynLWTqmEHIPeylKY/hOq/rGEFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbfLDSGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:06:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:55268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729976AbfLDSGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:06:38 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68BBA20674;
        Wed,  4 Dec 2019 18:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482797;
        bh=8m/MqRha1T/Gf1VwXx+GBM1pGru1K/qiMgwuwyeqJvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RTeOLKVe0+HqPJSgcbGhNLbUrFXOHEF30K8Uej6Pmx60vb7SBXeFlAF1pcUQgXxFI
         iWMDJd/LJxwLSf6lUrucisA5hrnf5Jx77StnJvp+d03xwQYs28TnsOm/IXLzzCuUhM
         GIzXeWsqDTU9I+Mr+cgLNjjDYOTEtAHNE7/6r0vo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 136/209] net/smc: prevent races between smc_lgr_terminate() and smc_conn_free()
Date:   Wed,  4 Dec 2019 18:55:48 +0100
Message-Id: <20191204175332.612859920@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index f04a037dc9677..0de788fa43e95 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -103,6 +103,8 @@ static void smc_lgr_unregister_conn(struct smc_connection *conn)
 	struct smc_link_group *lgr = conn->lgr;
 	int reduced = 0;
 
+	if (!lgr)
+		return;
 	write_lock_bh(&lgr->conns_lock);
 	if (conn->alert_token_local) {
 		reduced = 1;
@@ -431,6 +433,8 @@ int smc_conn_create(struct smc_sock *smc, __be32 peer_in_addr,
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



