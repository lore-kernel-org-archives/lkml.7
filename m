Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37661C282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 18:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F052147C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 18:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="eiZm1PcY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="wtxx1nV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfDTSz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 14:55:59 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:54636 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726251AbfDTSz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 14:55:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7F2FD8EE0CC;
        Sat, 20 Apr 2019 11:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1555786558;
        bh=7ZSLBPCeXo+8E9FosbVGQAaHgh6pbrSM286HihIARBY=;
        h=Subject:From:To:Cc:Date:From;
        b=eiZm1PcYI7lv74g8rMdvtcYZC4W4Fm42qvUf98IgNmjQCq8noS4sWCMb3vKqhRJnt
         NQAYjGmPL710F4vCjThTHLoZbnr03tkwln1iCndyls9eM10UqsCiAUt4GQ5UexipHp
         ZUy2ZDR5tbfAAQtwLFCT2d/9mL5/oEX0jvV4cRd8=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hnDopo7e8kdL; Sat, 20 Apr 2019 11:55:57 -0700 (PDT)
Received: from jarvis (host109-155-185-12.range109-155.btcentralplus.com [109.155.185.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C6B1D8EE0AB;
        Sat, 20 Apr 2019 11:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1555786557;
        bh=7ZSLBPCeXo+8E9FosbVGQAaHgh6pbrSM286HihIARBY=;
        h=Subject:From:To:Cc:Date:From;
        b=wtxx1nV7ZiP/cDz3EOF/u95zjWL36zGj+HfTccvQls1gqqNAY+hv8F59S2FdRES0L
         hWj08jiUtQX17Q8Bm1+OwtOXrgt0jsiZplV5HCi4HgAXi6NgaA5pTB9VJ0gEqQvXPT
         ydpHwD1CA6YTcMkaVp0NomyjoZE7pnPKgjuu/W7k=
Message-ID: <1555786552.2830.3.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.1-rc5
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 20 Apr 2019 19:55:52 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three minor fixes: two obvious ones in drivers and a fix to the SG_IO
path to correctly return status on error.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Christoph Hellwig (1):
      scsi: aic7xxx: fix EISA support

Jaesoo Lee (1):
      scsi: core: set result when the command cannot be dispatched

Saurav Kashyap (1):
      Revert "scsi: fcoe: clear FC_RP_STARTED flags when receiving a LOGO"

And the diffstat:

 drivers/scsi/aic7xxx/aic7770_osm.c     |  1 +
 drivers/scsi/aic7xxx/aic7xxx.h         |  1 +
 drivers/scsi/aic7xxx/aic7xxx_osm.c     | 10 ++++------
 drivers/scsi/aic7xxx/aic7xxx_osm_pci.c |  1 +
 drivers/scsi/libfc/fc_rport.c          |  1 -
 drivers/scsi/scsi_lib.c                |  6 +++++-
 6 files changed, 12 insertions(+), 8 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/aic7xxx/aic7770_osm.c b/drivers/scsi/aic7xxx/aic7770_osm.c
index 3d401d02c019..bdd177e3d762 100644
--- a/drivers/scsi/aic7xxx/aic7770_osm.c
+++ b/drivers/scsi/aic7xxx/aic7770_osm.c
@@ -91,6 +91,7 @@ aic7770_probe(struct device *dev)
 	ahc = ahc_alloc(&aic7xxx_driver_template, name);
 	if (ahc == NULL)
 		return (ENOMEM);
+	ahc->dev = dev;
 	error = aic7770_config(ahc, aic7770_ident_table + edev->id.driver_data,
 			       eisaBase);
 	if (error != 0) {
diff --git a/drivers/scsi/aic7xxx/aic7xxx.h b/drivers/scsi/aic7xxx/aic7xxx.h
index 5614921b4041..88b90f9806c9 100644
--- a/drivers/scsi/aic7xxx/aic7xxx.h
+++ b/drivers/scsi/aic7xxx/aic7xxx.h
@@ -943,6 +943,7 @@ struct ahc_softc {
 	 * Platform specific device information.
 	 */
 	ahc_dev_softc_t		  dev_softc;
+	struct device		  *dev;
 
 	/*
 	 * Bus specific device information.
diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
index 3c9c17450bb3..d5c4a0d23706 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -860,8 +860,8 @@ int
 ahc_dmamem_alloc(struct ahc_softc *ahc, bus_dma_tag_t dmat, void** vaddr,
 		 int flags, bus_dmamap_t *mapp)
 {
-	*vaddr = pci_alloc_consistent(ahc->dev_softc,
-				      dmat->maxsize, mapp);
+	/* XXX: check if we really need the GFP_ATOMIC and unwind this mess! */
+	*vaddr = dma_alloc_coherent(ahc->dev, dmat->maxsize, mapp, GFP_ATOMIC);
 	if (*vaddr == NULL)
 		return ENOMEM;
 	return 0;
@@ -871,8 +871,7 @@ void
 ahc_dmamem_free(struct ahc_softc *ahc, bus_dma_tag_t dmat,
 		void* vaddr, bus_dmamap_t map)
 {
-	pci_free_consistent(ahc->dev_softc, dmat->maxsize,
-			    vaddr, map);
+	dma_free_coherent(ahc->dev, dmat->maxsize, vaddr, map);
 }
 
 int
@@ -1123,8 +1122,7 @@ ahc_linux_register_host(struct ahc_softc *ahc, struct scsi_host_template *templa
 
 	host->transportt = ahc_linux_transport_template;
 
-	retval = scsi_add_host(host,
-			(ahc->dev_softc ? &ahc->dev_softc->dev : NULL));
+	retval = scsi_add_host(host, ahc->dev);
 	if (retval) {
 		printk(KERN_WARNING "aic7xxx: scsi_add_host failed\n");
 		scsi_host_put(host);
diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c b/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
index 0fc14dac7070..717d8d1082ce 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
@@ -250,6 +250,7 @@ ahc_linux_pci_dev_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 	}
 	ahc->dev_softc = pci;
+	ahc->dev = &pci->dev;
 	error = ahc_pci_config(ahc, entry);
 	if (error != 0) {
 		ahc_free(ahc);
diff --git a/drivers/scsi/libfc/fc_rport.c b/drivers/scsi/libfc/fc_rport.c
index dfba4921b265..5bf61431434b 100644
--- a/drivers/scsi/libfc/fc_rport.c
+++ b/drivers/scsi/libfc/fc_rport.c
@@ -2162,7 +2162,6 @@ static void fc_rport_recv_logo_req(struct fc_lport *lport, struct fc_frame *fp)
 		FC_RPORT_DBG(rdata, "Received LOGO request while in state %s\n",
 			     fc_rport_state(rdata));
 
-		rdata->flags &= ~FC_RP_STARTED;
 		fc_rport_enter_delete(rdata, RPORT_EV_STOP);
 		mutex_unlock(&rdata->rp_mutex);
 		kref_put(&rdata->kref, fc_rport_destroy);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 601b9f1de267..07dfc17d4824 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1706,8 +1706,12 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 			ret = BLK_STS_DEV_RESOURCE;
 		break;
 	default:
+		if (unlikely(!scsi_device_online(sdev)))
+			scsi_req(req)->result = DID_NO_CONNECT << 16;
+		else
+			scsi_req(req)->result = DID_ERROR << 16;
 		/*
-		 * Make sure to release all allocated ressources when
+		 * Make sure to release all allocated resources when
 		 * we hit an error, as we will never see this command
 		 * again.
 		 */
