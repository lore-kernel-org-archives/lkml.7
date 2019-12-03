Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EB8C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A642064B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414364;
	bh=v6CWCIDmY/jllLV2uivZ+MJ32Cm9zV+Rz3VmAy4p4M0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UIGYer2GsyTwFhzBvKpTlOju5pctZezi8xM5Wo0FqRXk1ZRJpowryd8kTYMRiBuQ/
	 h/kHl5ihdHHA74J3WXOLalS8CnMPjNbW8smMX2luvxO+aTLvOIx5VRD49OukPfZMbX
	 2lNf0HN1m07otY/EcwV4LpJ0qGNlajhV/vHiqSls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbfLCWtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:49:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728916AbfLCWtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:49:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ABDC20656;
        Tue,  3 Dec 2019 22:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413370;
        bh=v6CWCIDmY/jllLV2uivZ+MJ32Cm9zV+Rz3VmAy4p4M0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L2Q+LgGMlxzp7ZEQ+QdZpFYCqF7b3MQgeqS6aTC7mrNHMeFI0dK80Bge2khuWp4NI
         ERGarAez+3IKBFyHssHpoQjFXfowy1DZ1wd+RR8S0e6Rop4MicBg/u5Wywab551GQ8
         3q2gKrd7SwnUGu6DnP6sxzX3UotqQtpFRlB8vhog=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Giridhar Malavali <gmalavali@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 085/321] scsi: qla2xxx: Fix for FC-NVMe discovery for NPIV port
Date:   Tue,  3 Dec 2019 23:32:31 +0100
Message-Id: <20191203223431.578092382@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giridhar Malavali <gmalavali@marvell.com>

[ Upstream commit 835aa4f2691e4ed4ed16de81f3cabf17a87a164f ]

This patch fixes NVMe discovery by setting SKIP_PRLI flag, so that PRLI is
driven by driver and is retried when the NPIV port is detected to have NVMe
capability.

Signed-off-by: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_attr.c |  2 ++
 drivers/scsi/qla2xxx/qla_init.c | 10 ++++------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index 15d493f30810f..3e9c49b3184f1 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -2161,6 +2161,8 @@ qla24xx_vport_delete(struct fc_vport *fc_vport)
 	    test_bit(FCPORT_UPDATE_NEEDED, &vha->dpc_flags))
 		msleep(1000);
 
+	qla_nvme_delete(vha);
+
 	qla24xx_disable_vp(vha);
 	qla2x00_wait_for_sess_deletion(vha);
 
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 653d535e3052f..f7dd289779b14 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -242,15 +242,13 @@ qla2x00_async_login(struct scsi_qla_host *vha, fc_port_t *fcport,
 	qla2x00_init_timer(sp, qla2x00_get_async_timeout(vha) + 2);
 
 	sp->done = qla2x00_async_login_sp_done;
-	if (N2N_TOPO(fcport->vha->hw) && fcport_is_bigger(fcport)) {
+	if (N2N_TOPO(fcport->vha->hw) && fcport_is_bigger(fcport))
 		lio->u.logio.flags |= SRB_LOGIN_PRLI_ONLY;
-	} else {
+	else
 		lio->u.logio.flags |= SRB_LOGIN_COND_PLOGI;
 
-		if (fcport->fc4f_nvme)
-			lio->u.logio.flags |= SRB_LOGIN_SKIP_PRLI;
-
-	}
+	if (fcport->fc4f_nvme)
+		lio->u.logio.flags |= SRB_LOGIN_SKIP_PRLI;
 
 	ql_dbg(ql_dbg_disc, vha, 0x2072,
 	    "Async-login - %8phC hdl=%x, loopid=%x portid=%02x%02x%02x "
-- 
2.20.1



