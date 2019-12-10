Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802F0C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4806A20828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576014602;
	bh=g6eNLtioeTvZiQR34XhoVgzDNwVEsrxhj/qqSpUxFW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0srtwzygtbaz12Gv8sPg+J0yjBWPHYb2CtSjXpWwQw1pFovMxc1qWMVFjB6lEUu1s
	 nVJJjmbtOL93QJKJ8aCqlFXhC28aWFR0KZohOFTHxuo3e6aVGUrRtMmbpp/uANtzJu
	 dglpd1U/WC/uParcZG5+9m1FYFuR77ru5Sg+LIf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfLJVuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:50:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:55896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727193AbfLJVI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:08:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 300C924680;
        Tue, 10 Dec 2019 21:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012109;
        bh=g6eNLtioeTvZiQR34XhoVgzDNwVEsrxhj/qqSpUxFW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oLPHKO/9mRsNd5n5fb4ad12w2YjI/w1tjHP8laDwHnk17XRHneDPNG3K6KTbI7XNp
         hIaQJyIpcTu3fH3PIUHK5a2UOKY7/F0MdnvOJd36zJ7ewMQW9E6K4ZkjJBjXUItx+J
         U4I+PVJyMhwmhoBFeaFzGkZ/USlchgUfVcEvg1D4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ursula Braun <ubraun@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 082/350] net/smc: increase device refcount for added link group
Date:   Tue, 10 Dec 2019 16:03:07 -0500
Message-Id: <20191210210735.9077-43-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ursula Braun <ubraun@linux.ibm.com>

[ Upstream commit b3cb53c05f20c5b4026a36a7bbd3010d1f3e0a55 ]

SMCD link groups belong to certain ISM-devices and SMCR link group
links belong to certain IB-devices. Increase the refcount for
these devices, as long as corresponding link groups exist.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 2ba97ff325a5d..0c5fcb8ed404d 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -231,10 +231,12 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 	lgr->conns_all = RB_ROOT;
 	if (ini->is_smcd) {
 		/* SMC-D specific settings */
+		get_device(&ini->ism_dev->dev);
 		lgr->peer_gid = ini->ism_gid;
 		lgr->smcd = ini->ism_dev;
 	} else {
 		/* SMC-R specific settings */
+		get_device(&ini->ib_dev->ibdev->dev);
 		lgr->role = smc->listen_smc ? SMC_SERV : SMC_CLNT;
 		memcpy(lgr->peer_systemid, ini->ib_lcl->id_for_peer,
 		       SMC_SYSTEMID_LEN);
@@ -433,10 +435,13 @@ static void smc_lgr_free_bufs(struct smc_link_group *lgr)
 static void smc_lgr_free(struct smc_link_group *lgr)
 {
 	smc_lgr_free_bufs(lgr);
-	if (lgr->is_smcd)
+	if (lgr->is_smcd) {
 		smc_ism_put_vlan(lgr->smcd, lgr->vlan_id);
-	else
+		put_device(&lgr->smcd->dev);
+	} else {
 		smc_link_clear(&lgr->lnk[SMC_SINGLE_LINK]);
+		put_device(&lgr->lnk[SMC_SINGLE_LINK].smcibdev->ibdev->dev);
+	}
 	kfree(lgr);
 }
 
-- 
2.20.1

