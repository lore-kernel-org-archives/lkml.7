Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAECC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22F320578
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557428097;
	bh=7wpS8JYjS9GcZiEDHPbPi/nxLw0FODqaTLwbfGZT1Is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yLl94NH6dt7iYEOkSLxIyFAhwyi1rUry5GY/GntuDIh920dbXTHjLdAZi6sUuvX98
	 nVwbnj/E7BKdWAziItWganyTR5JVAdgosuDAZUoDEa1dMoFFrM8vM0HJF66OtjIDGN
	 5XMVPGWkB63nXJijrdJ/cHtIVByusehgjEBKA4MA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfEISy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:54:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727700AbfEISyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:54:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A02E7217D7;
        Thu,  9 May 2019 18:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557428089;
        bh=7wpS8JYjS9GcZiEDHPbPi/nxLw0FODqaTLwbfGZT1Is=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bzqrS4j7rOc9PIn/4mfvjysD60U2HuBXDaIfLqwgLZx+pWVizhFIvWkJHktgdv2Ar
         oBuIJGL4s6jFi4V2tKwLE3Y9I7zDzGpIpNk300VpWG3TjNerEsn+NcEK3lokujI7G6
         p5iyWdLp8wSvElylzcnybhmyrXhaJEZWQdIsY10Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <qtran@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.1 21/30] scsi: qla2xxx: Fix device staying in blocked state
Date:   Thu,  9 May 2019 20:42:53 +0200
Message-Id: <20190509181255.452950137@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181250.417203112@linuxfoundation.org>
References: <20190509181250.417203112@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quinn Tran <qtran@marvell.com>

commit 2137490f2147a8d0799b72b9a1023efb012d40c7 upstream.

This patch fixes issue reported by some of the customers, who discovered
that after cable pull scenario the devices disappear and path seems to
remain in blocked state. Once the device reappears, driver does not seem to
update path to online. This issue appears because of the defer flag
creating race condition where the same session reappears.  This patch fixes
this issue by indicating SCSI-ML of device lost when
qlt_free_session_done() is called from qlt_unreg_sess().

Fixes: 41dc529a4602a ("qla2xxx: Improve RSCN handling in driver")
Signed-off-by: Quinn Tran <qtran@marvell.com>
Cc: stable@vger.kernel.org #4.19
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_target.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -980,6 +980,8 @@ void qlt_free_session_done(struct work_s
 		sess->send_els_logo);
 
 	if (!IS_SW_RESV_ADDR(sess->d_id)) {
+		qla2x00_mark_device_lost(vha, sess, 0, 0);
+
 		if (sess->send_els_logo) {
 			qlt_port_logo_t logo;
 
@@ -1160,8 +1162,6 @@ void qlt_unreg_sess(struct fc_port *sess
 	if (sess->se_sess)
 		vha->hw->tgt.tgt_ops->clear_nacl_from_fcport_map(sess);
 
-	qla2x00_mark_device_lost(vha, sess, 0, 0);
-
 	sess->deleted = QLA_SESS_DELETION_IN_PROGRESS;
 	sess->disc_state = DSC_DELETE_PEND;
 	sess->last_rscn_gen = sess->rscn_gen;


