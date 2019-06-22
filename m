Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34103C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 15:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00FFD205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 15:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="p72xwm+x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ALNjQzy7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfFVPbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 11:31:52 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51274 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726138AbfFVPbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 11:31:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3FBA88EE105;
        Sat, 22 Jun 2019 08:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1561217511;
        bh=T65+vk73Z2CaX9Tc5+vGvjBb20vMTuCAgO9aJXpwF4Q=;
        h=Subject:From:To:Cc:Date:From;
        b=p72xwm+xQ+vBm3M1v+K5P/Nu1txCJNxGl2N36mk3KCkE5j6UypR4Thb0EU9mipNfx
         sNsevNE9ZWTwl0Jy45+occEVyy9FNAM8ypxLvTwbw5DiLzjnFP59FWUj0aT8HAknwf
         h/9mCEd7/NbMDR9wETMqlo+/NgLY3V0qFxcoA9uA=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id emMTLkq_VslB; Sat, 22 Jun 2019 08:31:51 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id BD77D8EE0D7;
        Sat, 22 Jun 2019 08:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1561217510;
        bh=T65+vk73Z2CaX9Tc5+vGvjBb20vMTuCAgO9aJXpwF4Q=;
        h=Subject:From:To:Cc:Date:From;
        b=ALNjQzy7sKBavhitCPabl8p/5nFr775EgND8esZd5m1Ee80LVQA3aISlAw1A0UwAj
         +CPcbtIjuUmU3KNQQA6ysDhpCBZIgbpWjGWr1TO9nTnErLbXzXURgr434WI42zbcCT
         vpX5ZUTzr/PELiBRv20myxjZrIzH4D17e7O8UjAg=
Message-ID: <1561217509.3260.5.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.2-rc5
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 22 Jun 2019 08:31:49 -0700
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three driver fixes (and one version number update): a suspend hang in
ufs, a qla hard lock on module removal and a qedi panic during
discovery.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Arun Easi (1):
      scsi: qla2xxx: Fix hardlockup in abort command during driver remove

Nilesh Javali (2):
      scsi: qedi: update driver version to 8.37.0.20
      scsi: qedi: Check targetname while finding boot target information

Stanley Chu (1):
      scsi: ufs: Avoid runtime suspend possibly being blocked forever


And the diffstat:

 drivers/scsi/qedi/qedi_main.c    |  3 +++
 drivers/scsi/qedi/qedi_version.h |  6 +++---
 drivers/scsi/qla2xxx/qla_os.c    |  2 +-
 drivers/scsi/ufs/ufshcd-pltfrm.c | 11 ++++-------
 4 files changed, 11 insertions(+), 11 deletions(-)

With full diff below

James

---

diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index e5db9a9954dc..a6ff7be0210a 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -990,6 +990,9 @@ static int qedi_find_boot_info(struct qedi_ctx *qedi,
 		if (!iscsi_is_session_online(cls_sess))
 			continue;
 
+		if (!sess->targetname)
+			continue;
+
 		if (pri_ctrl_flags) {
 			if (!strcmp(pri_tgt->iscsi_name, sess->targetname) &&
 			    !strcmp(pri_tgt->ip_addr, ep_ip_addr)) {
diff --git a/drivers/scsi/qedi/qedi_version.h b/drivers/scsi/qedi/qedi_version.h
index 41bcbbafebd4..2c17544c7785 100644
--- a/drivers/scsi/qedi/qedi_version.h
+++ b/drivers/scsi/qedi/qedi_version.h
@@ -7,8 +7,8 @@
  * this source tree.
  */
 
-#define QEDI_MODULE_VERSION	"8.33.0.21"
+#define QEDI_MODULE_VERSION	"8.37.0.20"
 #define QEDI_DRIVER_MAJOR_VER		8
-#define QEDI_DRIVER_MINOR_VER		33
+#define QEDI_DRIVER_MINOR_VER		37
 #define QEDI_DRIVER_REV_VER		0
-#define QEDI_DRIVER_ENG_VER		21
+#define QEDI_DRIVER_ENG_VER		20
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 172ef21827dd..d056f5e7cf93 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1731,8 +1731,8 @@ static void qla2x00_abort_srb(struct qla_qpair *qp, srb_t *sp, const int res,
 	     !test_bit(ABORT_ISP_ACTIVE, &vha->dpc_flags) &&
 	     !qla2x00_isp_reg_stat(ha))) {
 		sp->comp = &comp;
-		rval = ha->isp_ops->abort_command(sp);
 		spin_unlock_irqrestore(qp->qp_lock_ptr, *flags);
+		rval = ha->isp_ops->abort_command(sp);
 
 		switch (rval) {
 		case QLA_SUCCESS:
diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
index 8a74ec30c3d2..d7d521b394c3 100644
--- a/drivers/scsi/ufs/ufshcd-pltfrm.c
+++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
@@ -430,24 +430,21 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
 		goto dealloc_host;
 	}
 
-	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
-
 	ufshcd_init_lanes_per_dir(hba);
 
 	err = ufshcd_init(hba, mmio_base, irq);
 	if (err) {
 		dev_err(dev, "Initialization failed\n");
-		goto out_disable_rpm;
+		goto dealloc_host;
 	}
 
 	platform_set_drvdata(pdev, hba);
 
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	return 0;
 
-out_disable_rpm:
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_set_suspended(&pdev->dev);
 dealloc_host:
 	ufshcd_dealloc_host(hba);
 out:
