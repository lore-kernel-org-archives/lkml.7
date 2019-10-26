Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C40CA9EBC
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055562070B
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572096873;
	bh=Erj0YtBMybGdaqN3l1d/8o3zG1P1aQifLZxJEmEjtgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q4GHnugZ4XcHHe0+iKE0nQWF/F/Tf2wmcbWx9RnuVvVK0+YrlUEnl/CPYL8chv7Z1
	 IG3m1yyNSmbL3O9GPgLTy6XeLhoecgmfBULPYPjcwjq0E40n2ufQhtYlcdWScfRzCV
	 dWtxmzKHuKVqhxli/KGrnY9h7yLyQZRfcVL0R0Ms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfJZNeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:34:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727450AbfJZNRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:17:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F24A821E6F;
        Sat, 26 Oct 2019 13:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572095860;
        bh=Erj0YtBMybGdaqN3l1d/8o3zG1P1aQifLZxJEmEjtgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xUXGG0BkdWBfMWuA9uZXELrdkvxXq0n8ipqyykNUinnZnpgp1fbqBuCStRH9oHhlW
         saHbuNF+GDd0CvqexQ6K3rB3oOgHgqSIJUutboUz/s1hP4WoWQfA47nXI7ggNnW0vE
         MwNlYb01zOVrLV/seDHjKkGQl7rVT/XWsumJx3fA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ursula Braun <ubraun@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 53/99] net/smc: fix SMCD link group creation with VLAN id
Date:   Sat, 26 Oct 2019 09:15:14 -0400
Message-Id: <20191026131600.2507-53-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026131600.2507-1-sashal@kernel.org>
References: <20191026131600.2507-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ursula Braun <ubraun@linux.ibm.com>

[ Upstream commit 29ee2701529e1905c0e948688f9688c68c8d4ea4 ]

If creation of an SMCD link group with VLAN id fails, the initial
smc_ism_get_vlan() step has to be reverted as well.

Fixes: c6ba7c9ba43d ("net/smc: add base infrastructure for SMC-D and ISM")
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 4ca50ddf8d161..88556f0251ab9 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -213,7 +213,7 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 	lgr = kzalloc(sizeof(*lgr), GFP_KERNEL);
 	if (!lgr) {
 		rc = SMC_CLC_DECL_MEM;
-		goto out;
+		goto ism_put_vlan;
 	}
 	lgr->is_smcd = ini->is_smcd;
 	lgr->sync_err = 0;
@@ -289,6 +289,9 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 	smc_llc_link_clear(lnk);
 free_lgr:
 	kfree(lgr);
+ism_put_vlan:
+	if (ini->is_smcd && ini->vlan_id)
+		smc_ism_put_vlan(ini->ism_dev, ini->vlan_id);
 out:
 	if (rc < 0) {
 		if (rc == -ENOMEM)
-- 
2.20.1

