Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230CFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E633821900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256955;
	bh=sXxxyAoaMZVdr7gLa9anxiMDXOvX5OTWqkLJCR3McVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L0ypNuQflysTzrBynRBv5n17HInMB/frTy9jih1H67YFPmwP+/APSiFhqqn/KINM+
	 E1G2cZmXZMVDVtk2HC0k7UTcGChGK1bUrW/w6li5NPLuFNML5wxpYSfPFxO2mtESTl
	 DNoSS3UzvmaDnxVbqR4742QK1Wzidfo4FsiENdLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389915AbfCVMPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:15:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389966AbfCVMPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:15:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C3162083D;
        Fri, 22 Mar 2019 12:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256950;
        bh=sXxxyAoaMZVdr7gLa9anxiMDXOvX5OTWqkLJCR3McVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yUoZciM1nQgrf6wB87D29rgfZ7F0XhIWZr9vQD3vODbaOZcCLEKNNXSoMbDzaFrGf
         RBMg9Pi8hmf7vFhGpwC/sssqvXXr57wFFjL66+4ebhJtl0wQpgoLYrGmVGt7Ngb51/
         l0J9GNOWKvX1feYYG/ypB7sgTrYZ7HGUe2R/6mFg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <qtran@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.0 085/238] scsi: qla2xxx: Use complete switch scan for RSCN events
Date:   Fri, 22 Mar 2019 12:15:04 +0100
Message-Id: <20190322111303.603613617@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <qtran@marvell.com>

commit 1560bafdff9ed54857ac3a03c4c8d8f10d791ba6 upstream.

This patch removes unnecessary code to handle RSCN, instead performs full
scan everytime driver receives RSCN

Fixes: d4f7a16aeca6f ("scsi: qla2xxx: Remove ASYNC GIDPN switch command")
Cc: stable@vger.kernel.org #4.19
Signed-off-by: Quinn Tran <qtran@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_init.c |   86 ----------------------------------------
 1 file changed, 86 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1474,29 +1474,6 @@ int qla24xx_fcport_handle_login(struct s
 	return 0;
 }
 
-static
-void qla24xx_handle_rscn_event(fc_port_t *fcport, struct event_arg *ea)
-{
-	fcport->rscn_gen++;
-
-	ql_dbg(ql_dbg_disc, fcport->vha, 0x210c,
-	    "%s %8phC DS %d LS %d\n",
-	    __func__, fcport->port_name, fcport->disc_state,
-	    fcport->fw_login_state);
-
-	if (fcport->flags & FCF_ASYNC_SENT)
-		return;
-
-	switch (fcport->disc_state) {
-	case DSC_DELETED:
-	case DSC_LOGIN_COMPLETE:
-		qla24xx_post_gpnid_work(fcport->vha, &ea->id);
-		break;
-	default:
-		break;
-	}
-}
-
 int qla24xx_post_newsess_work(struct scsi_qla_host *vha, port_id_t *id,
     u8 *port_name, u8 *node_name, void *pla, u8 fc4_type)
 {
@@ -1563,8 +1540,6 @@ static void qla_handle_els_plogi_done(sc
 
 void qla2x00_fcport_event_handler(scsi_qla_host_t *vha, struct event_arg *ea)
 {
-	fc_port_t *f, *tf;
-	uint32_t id = 0, mask, rid;
 	fc_port_t *fcport;
 
 	switch (ea->event) {
@@ -1577,10 +1552,6 @@ void qla2x00_fcport_event_handler(scsi_q
 	case FCME_RSCN:
 		if (test_bit(UNLOADING, &vha->dpc_flags))
 			return;
-		switch (ea->id.b.rsvd_1) {
-		case RSCN_PORT_ADDR:
-#define BIGSCAN 1
-#if defined BIGSCAN & BIGSCAN > 0
 		{
 			unsigned long flags;
 			fcport = qla2x00_find_fcport_by_nportid
@@ -1599,59 +1570,6 @@ void qla2x00_fcport_event_handler(scsi_q
 			}
 			spin_unlock_irqrestore(&vha->work_lock, flags);
 		}
-#else
-		{
-			int rc;
-			fcport = qla2x00_find_fcport_by_nportid(vha, &ea->id, 1);
-			if (!fcport) {
-				/* cable moved */
-				 rc = qla24xx_post_gpnid_work(vha, &ea->id);
-				 if (rc) {
-					 ql_log(ql_log_warn, vha, 0xd044,
-					     "RSCN GPNID work failed %06x\n",
-					     ea->id.b24);
-				 }
-			} else {
-				ea->fcport = fcport;
-				fcport->scan_needed = 1;
-				qla24xx_handle_rscn_event(fcport, ea);
-			}
-		}
-#endif
-			break;
-		case RSCN_AREA_ADDR:
-		case RSCN_DOM_ADDR:
-			if (ea->id.b.rsvd_1 == RSCN_AREA_ADDR) {
-				mask = 0xffff00;
-				ql_dbg(ql_dbg_async, vha, 0x5044,
-				    "RSCN: Area 0x%06x was affected\n",
-				    ea->id.b24);
-			} else {
-				mask = 0xff0000;
-				ql_dbg(ql_dbg_async, vha, 0x507a,
-				    "RSCN: Domain 0x%06x was affected\n",
-				    ea->id.b24);
-			}
-
-			rid = ea->id.b24 & mask;
-			list_for_each_entry_safe(f, tf, &vha->vp_fcports,
-			    list) {
-				id = f->d_id.b24 & mask;
-				if (rid == id) {
-					ea->fcport = f;
-					qla24xx_handle_rscn_event(f, ea);
-				}
-			}
-			break;
-		case RSCN_FAB_ADDR:
-		default:
-			ql_log(ql_log_warn, vha, 0xd045,
-			    "RSCN: Fabric was affected. Addr format %d\n",
-			    ea->id.b.rsvd_1);
-			qla2x00_mark_all_devices_lost(vha, 1);
-			set_bit(LOOP_RESYNC_NEEDED, &vha->dpc_flags);
-			set_bit(LOCAL_LOOP_UPDATE, &vha->dpc_flags);
-		}
 		break;
 	case FCME_GNL_DONE:
 		qla24xx_handle_gnl_done_event(vha, ea);
@@ -1712,11 +1630,7 @@ void qla_rscn_replay(fc_port_t *fcport)
                ea.event = FCME_RSCN;
                ea.id = fcport->d_id;
                ea.id.b.rsvd_1 = RSCN_PORT_ADDR;
-#if defined BIGSCAN & BIGSCAN > 0
                qla2x00_fcport_event_handler(fcport->vha, &ea);
-#else
-               qla24xx_post_gpnid_work(fcport->vha, &ea.id);
-#endif
 	}
 }
 


