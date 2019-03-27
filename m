Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B72C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7AE205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712668;
	bh=LBejFdLkkw8UNczc16Yv+pzUbtLCDmGTxG7s8oVCd5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bh4zgWsvYFYY8OTnyQukhAP2MS2ksLGjqRbi0ZCa1aw2Y8MB6rqr/eriei5BMJU3t
	 u4NdYJpIlG3D+Z/Gg8urMpx/KBN4SttqL2shGLcKWNyy2fjnW+N6gF5cFVXY4FSbSu
	 S/db9nUaJUrNguCkCebdtVdYV9fYrRynoKMQUh/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390771AbfC0SvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:51:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390433AbfC0SSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:18:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBB7A2087C;
        Wed, 27 Mar 2019 18:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710683;
        bh=LBejFdLkkw8UNczc16Yv+pzUbtLCDmGTxG7s8oVCd5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LgUjfkLPBGBar0NMwiNDbXUbtVMYeInWkhW1HyG7J+EOCLUWZ8DEVeCxosP6vOPcH
         ZjRiF/hXLIG2iiHAe09cMHkAwbVBmeJwNfH8r4Y4VpWoysavtLtIJoROVRRIsPUh+z
         jLhaft3A7/syMKiozIdF6qZ3IGIoTpdiSunVT2Ps=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 053/123] scsi: fcoe: make use of fip_mode enum complete
Date:   Wed, 27 Mar 2019 14:15:17 -0400
Message-Id: <20190327181628.15899-53-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sedat Dilek <sedat.dilek@gmail.com>

[ Upstream commit 8beb90aaf334a6efa3e924339926b5f93a234dbb ]

commit 1917d42d14b7 ("fcoe: use enum for fip_mode") introduces a separate
enum for the fip_mode that shall be used during initialisation handling
until it is passed to fcoe_ctrl_link_up to set the initial fip_state.  That
change was incomplete and gcc quietly converted in various places between
the fip_mode and the fip_state enum values with implicit enum conversions,
which fortunately cannot cause any issues in the actual code's execution.

clang however warns about these implicit enum conversions in the scsi
drivers. This commit consolidates the use of the two enums, guided by
clang's enum-conversion warnings.

This commit now completes the use of the fip_mode: It expects and uses
fip_mode in {bnx2fc,fcoe}_interface_create and fcoe_ctlr_init, and it calls
fcoe_ctrl_set_set() with the correct values in fcoe_ctlr_link_up().  It
also breaks the association between FIP_MODE_AUTO and FIP_ST_AUTO to
indicate these two enums are distinct.

Link: https://github.com/ClangBuiltLinux/linux/issues/151
Fixes: 1917d42d14b7 ("fcoe: use enum for fip_mode")
Reported-by: Dmitry Golovin <dima@golovin.in>
Original-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC: Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC: Nick Desaulniers <ndesaulniers@google.com>
CC: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Suggested-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c  | 2 +-
 drivers/scsi/fcoe/fcoe.c           | 2 +-
 drivers/scsi/fcoe/fcoe_ctlr.c      | 7 +++++--
 drivers/scsi/fcoe/fcoe_transport.c | 2 +-
 drivers/scsi/qedf/qedf_main.c      | 2 +-
 include/scsi/libfcoe.h             | 4 ++--
 6 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
index 89f09b122135..116a56f0af01 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -1445,7 +1445,7 @@ static struct bnx2fc_hba *bnx2fc_hba_create(struct cnic_dev *cnic)
 static struct bnx2fc_interface *
 bnx2fc_interface_create(struct bnx2fc_hba *hba,
 			struct net_device *netdev,
-			enum fip_state fip_mode)
+			enum fip_mode fip_mode)
 {
 	struct fcoe_ctlr_device *ctlr_dev;
 	struct bnx2fc_interface *interface;
diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index 85f9a3eba387..99b46dc87a37 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -390,7 +390,7 @@ static int fcoe_interface_setup(struct fcoe_interface *fcoe,
  * Returns: pointer to a struct fcoe_interface or NULL on error
  */
 static struct fcoe_interface *fcoe_interface_create(struct net_device *netdev,
-						    enum fip_state fip_mode)
+						    enum fip_mode fip_mode)
 {
 	struct fcoe_ctlr_device *ctlr_dev;
 	struct fcoe_ctlr *ctlr;
diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 03019e07abb9..bd61bf4e2da2 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -147,7 +147,7 @@ static void fcoe_ctlr_map_dest(struct fcoe_ctlr *fip)
  * fcoe_ctlr_init() - Initialize the FCoE Controller instance
  * @fip: The FCoE controller to initialize
  */
-void fcoe_ctlr_init(struct fcoe_ctlr *fip, enum fip_state mode)
+void fcoe_ctlr_init(struct fcoe_ctlr *fip, enum fip_mode mode)
 {
 	fcoe_ctlr_set_state(fip, FIP_ST_LINK_WAIT);
 	fip->mode = mode;
@@ -454,7 +454,10 @@ void fcoe_ctlr_link_up(struct fcoe_ctlr *fip)
 		mutex_unlock(&fip->ctlr_mutex);
 		fc_linkup(fip->lp);
 	} else if (fip->state == FIP_ST_LINK_WAIT) {
-		fcoe_ctlr_set_state(fip, fip->mode);
+		if (fip->mode == FIP_MODE_NON_FIP)
+			fcoe_ctlr_set_state(fip, FIP_ST_NON_FIP);
+		else
+			fcoe_ctlr_set_state(fip, FIP_ST_AUTO);
 		switch (fip->mode) {
 		default:
 			LIBFCOE_FIP_DBG(fip, "invalid mode %d\n", fip->mode);
diff --git a/drivers/scsi/fcoe/fcoe_transport.c b/drivers/scsi/fcoe/fcoe_transport.c
index 375c536cbc68..f5ed2d6cc70c 100644
--- a/drivers/scsi/fcoe/fcoe_transport.c
+++ b/drivers/scsi/fcoe/fcoe_transport.c
@@ -870,7 +870,7 @@ static int fcoe_transport_create(const char *buffer, struct kernel_param *kp)
 	int rc = -ENODEV;
 	struct net_device *netdev = NULL;
 	struct fcoe_transport *ft = NULL;
-	enum fip_state fip_mode = (enum fip_state)(long)kp->arg;
+	enum fip_mode fip_mode = (enum fip_mode)kp->arg;
 
 	mutex_lock(&ft_mutex);
 
diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index 56bcdd412d26..7756901f99da 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -1382,7 +1382,7 @@ static struct libfc_function_template qedf_lport_template = {
 
 static void qedf_fcoe_ctlr_setup(struct qedf_ctx *qedf)
 {
-	fcoe_ctlr_init(&qedf->ctlr, FIP_ST_AUTO);
+	fcoe_ctlr_init(&qedf->ctlr, FIP_MODE_AUTO);
 
 	qedf->ctlr.send = qedf_fip_send;
 	qedf->ctlr.get_src_addr = qedf_get_src_mac;
diff --git a/include/scsi/libfcoe.h b/include/scsi/libfcoe.h
index 722d3264d3bf..a4e41444f5fe 100644
--- a/include/scsi/libfcoe.h
+++ b/include/scsi/libfcoe.h
@@ -79,7 +79,7 @@ enum fip_state {
  * It must not change after fcoe_ctlr_init() sets it.
  */
 enum fip_mode {
-	FIP_MODE_AUTO = FIP_ST_AUTO,
+	FIP_MODE_AUTO,
 	FIP_MODE_NON_FIP,
 	FIP_MODE_FABRIC,
 	FIP_MODE_VN2VN,
@@ -250,7 +250,7 @@ struct fcoe_rport {
 };
 
 /* FIP API functions */
-void fcoe_ctlr_init(struct fcoe_ctlr *, enum fip_state);
+void fcoe_ctlr_init(struct fcoe_ctlr *, enum fip_mode);
 void fcoe_ctlr_destroy(struct fcoe_ctlr *);
 void fcoe_ctlr_link_up(struct fcoe_ctlr *);
 int fcoe_ctlr_link_down(struct fcoe_ctlr *);
-- 
2.19.1

