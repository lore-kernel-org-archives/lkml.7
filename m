Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C398BC2D0D1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90241206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641575;
	bh=q2qlQ1zu1e9Jtr0J4QDuk2XSaGdWhQDJ2Xa9AyyGR54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WdAZPDVz4/60/RPlIVfX7vwn6/D1qw8TsLdW+0Rn/mBfL4Mn+ormukOZ/NF1heZ1K
	 f0B0aqTCLo1IqTM3yVdb/Voxo+uOqN1oU7ITAkIuVWLR5NwEB1SSg9ny/kX/YTR24g
	 +ARZOmwTR9eVzbTMBRi4O7pj+MN7qFKmoOdlY5jI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731037AbfL2RqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:46:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730206AbfL2RqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:46:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 675E521744;
        Sun, 29 Dec 2019 17:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641566;
        bh=q2qlQ1zu1e9Jtr0J4QDuk2XSaGdWhQDJ2Xa9AyyGR54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SA3d8t1Iy+8TE6Q/WUFmvnTYHVwSuBpuhm4vD7zZJ4J3aHTCaTd2TXKRNkCH9Bahy
         nP3WBSOA8be+3F4aMdKplRXWxhpz2VKvTKapeIWpNrhCR0I26AvZxOufiNNTb0TsrV
         mrW8SW3e8yiiZ2vO9BqxV01AWZWPD6rwarhPa9e4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ursula Braun <ubraun@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 120/434] net/smc: increase device refcount for added link group
Date:   Sun, 29 Dec 2019 18:22:53 +0100
Message-Id: <20191229172709.661650133@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 2ba97ff325a5..0c5fcb8ed404 100644
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



