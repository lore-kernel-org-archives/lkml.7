Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8716C10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDB12075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370799;
	bh=HR1VzXGtbQLdY+t2+71eRkxiipHU8QBl9EioLSiNEUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nZqvNSw/ElkcgP+XAx97tG5QKEzBUlyF0eH+kX6eCZ/lYS8RshM0zUcY3eocGYKBR
	 j/tfoyxRSLs5geD6h/fiKY5qsf4tmINzElj3BCkalNWFl4t6saFpC/CNin3wPBcxjQ
	 RLsnxorDYYv81aH6GloGGCuHF4O5QBYJyh2goiBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731739AbfDDJDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:03:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731726AbfDDJDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:03:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FAC821741;
        Thu,  4 Apr 2019 09:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368586;
        bh=HR1VzXGtbQLdY+t2+71eRkxiipHU8QBl9EioLSiNEUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1fWmIWWsGxm1nbP/ETu1HuYglgo+fUnoo4MN11VERA5xGLjaDCkBKu/8g2qlW5N2q
         bBhKbX3RQnkFOz7IMz8l9vO3jMNck/Px51nCvPFiATGWuKVohO94Kn8sIUxK1xAhKI
         A/eVezaxFTrbs6POfNx2apXHH6Rk062fn9UUEme0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Golovin <dima@golovin.in>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 078/187] scsi: fcoe: make use of fip_mode enum complete
Date:   Thu,  4 Apr 2019 10:46:55 +0200
Message-Id: <20190404084606.707572228@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 3f97ec4aac4b..780651c4fc0c 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -1445,7 +1445,7 @@ bind_err:
 static struct bnx2fc_interface *
 bnx2fc_interface_create(struct bnx2fc_hba *hba,
 			struct net_device *netdev,
-			enum fip_state fip_mode)
+			enum fip_mode fip_mode)
 {
 	struct fcoe_ctlr_device *ctlr_dev;
 	struct bnx2fc_interface *interface;
diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index f46b312d04bc..6768b2e8148a 100644
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
index 54da3166da8d..7dc4ffa24430 100644
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
index f4909cd206d3..f15d5e1d56b1 100644
--- a/drivers/scsi/fcoe/fcoe_transport.c
+++ b/drivers/scsi/fcoe/fcoe_transport.c
@@ -873,7 +873,7 @@ static int fcoe_transport_create(const char *buffer,
 	int rc = -ENODEV;
 	struct net_device *netdev = NULL;
 	struct fcoe_transport *ft = NULL;
-	enum fip_state fip_mode = (enum fip_state)(long)kp->arg;
+	enum fip_mode fip_mode = (enum fip_mode)kp->arg;
 
 	mutex_lock(&ft_mutex);
 
diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index 0a5dd5595dd3..cd61905ca2f5 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -1418,7 +1418,7 @@ static struct libfc_function_template qedf_lport_template = {
 
 static void qedf_fcoe_ctlr_setup(struct qedf_ctx *qedf)
 {
-	fcoe_ctlr_init(&qedf->ctlr, FIP_ST_AUTO);
+	fcoe_ctlr_init(&qedf->ctlr, FIP_MODE_AUTO);
 
 	qedf->ctlr.send = qedf_fip_send;
 	qedf->ctlr.get_src_addr = qedf_get_src_mac;
diff --git a/include/scsi/libfcoe.h b/include/scsi/libfcoe.h
index cb8a273732cf..bb8092fa1e36 100644
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



