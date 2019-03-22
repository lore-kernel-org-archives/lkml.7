Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B5EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B510218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbfCVO0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:26:43 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:51365 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbfCVO0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:26:42 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1McH1Q-1gZ7MZ0ZbA-00chgM; Fri, 22 Mar 2019 15:25:59 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hannes Reinecke <hare@suse.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: lpfc: avoid uninitialized variable warning
Date:   Fri, 22 Mar 2019 15:25:49 +0100
Message-Id: <20190322142557.929966-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PGU9lVKj/dKXmiqHlrV8Bly73FjLI9kdmgn+Cziu7tOV08Qy6Ev
 bxGqn4M0D7NkQhxZbGIBSOh3kb0D0dyd8ox1ZvRwR89OKiiodHUeod8pLCmGZ5ugw+AS7mz
 V0KLOHxiZo3so2lWDA6LsALzA6EdoVW0KETNKzrzI6Ag8MvfN18MF28KSZvJ4jeRGQuK4AJ
 TElZLVpn31dAeQKxdfTeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MVlH0d45pZk=:sI1gMV387Mc4/wy6tiGfV+
 5Gpgvlx5nuQLJmBewGdZNG8GTVNoPN/xleIqA0xs/IvmYq7ybEc0q8QokvFuCOS9Bls68sqjq
 4KFavIKumrPyawteq/dJqgUnciiZcV6HdzMt1MaRcnHdyOo4XRtBFrpq5BxcFlykRiqg5vpTp
 kUDSLAIcSrDnMa9FkfWR77br0qdZdW2cetjFwKDFAVWo1H3jNp6iOxxXkIpTda1rY3DBcxk6h
 5D96uuEKMC4KDP/X1Izld5kznIAYLFBFxcYwBBNh0coDXN/t1xLgcnzXideaFmvwY66ywffpZ
 bFzPWKUVHFMotUo/UAYeTeE2z6+HsxKP1hmatl8U3kTGMppJsCJz5RpXS+WVe0emGLzxUpMIV
 TKOTFYJxZrX8sNMzsxNk52neksdHcHaAD+a0j2uHof0jwvaje8Bt0n9MF53e2Ue9VFSEmKnpt
 iDNwEitR4bBs/+sKXMz6PqO3gunnVmemc6MjmVnyvO5/ZV8Fdw+skOzvdH2MMyNifecK2H349
 pSrOiZIMw6mF3RRrZnsrONG+Gp3P8Jaml9rzlJwCLGhSdfvfjp9xu5awaEIUifiPUFHYOBBU2
 UZ0StH9QjaU4lOKO55RdTZBWV9dCaE1mET2EMVMPFMKmZDR7N8B5mclJE1fQYM1sB36ZOkJYZ
 Ug00Wpc8WgUTKTuJyGPsm4Un04AJYhR4AssaxPaahdwVHy6iFCZGXG6ici0qhkCDtIfqiX4MB
 iAGzPk+zx3fFgcaEIYLhFdWIIut/FIddQduYhw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang -Wuninitialized incorrectly sees a variable being used without
initialization:

drivers/scsi/lpfc/lpfc_nvme.c:2102:37: error: variable 'localport' is uninitialized when used here
      [-Werror,-Wuninitialized]
                lport = (struct lpfc_nvme_lport *)localport->private;
                                                  ^~~~~~~~~
drivers/scsi/lpfc/lpfc_nvme.c:2059:38: note: initialize the variable 'localport' to silence this warning
        struct nvme_fc_local_port *localport;
                                            ^
                                             = NULL
1 error generated.

This is clearly in dead code, as the condition leading up to it is
always false when CONFIG_NVME_FC is disabled, and the variable
is always initialized when nvme_fc_register_localport() got
called successfully.

Change the preprocessor conditional to the equivalent C construct,
which makes the code more readable and gets rid of the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/lpfc/lpfc_nvme.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 1aa00d2c3f74..9defff711884 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -2080,15 +2080,15 @@ lpfc_nvme_create_localport(struct lpfc_vport *vport)
 		lpfc_nvme_template.max_hw_queues =
 			phba->sli4_hba.num_present_cpu;
 
+	if (!IS_ENABLED(CONFIG_NVME_FC))
+		return ret;
+
 	/* localport is allocated from the stack, but the registration
 	 * call allocates heap memory as well as the private area.
 	 */
-#if (IS_ENABLED(CONFIG_NVME_FC))
+
 	ret = nvme_fc_register_localport(&nfcp_info, &lpfc_nvme_template,
 					 &vport->phba->pcidev->dev, &localport);
-#else
-	ret = -ENOMEM;
-#endif
 	if (!ret) {
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME | LOG_NVME_DISC,
 				 "6005 Successfully registered local "
-- 
2.20.0

