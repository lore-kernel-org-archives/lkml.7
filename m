Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9EEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3891D218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfCVQSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:18:21 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:50465 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729578AbfCVQST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:18:19 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N0o7f-1gkDsW0R1h-00wn6V; Fri, 22 Mar 2019 17:17:49 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org, Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     kehuanlin <chgokhl@gmail.com>, kehuanlin <kehuanlin@pinecone.net>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maya Erez <merez@codeaurora.org>,
        Sujit Reddy Thumma <sthumma@codeaurora.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.14.y 1/8] scsi: ufs: fix wrong command type of UTRD for UFSHCI v2.1
Date:   Fri, 22 Mar 2019 17:17:16 +0100
Message-Id: <20190322161727.1153278-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322161727.1153278-1-arnd@arndb.de>
References: <20190322161727.1153278-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DQlMCpJq4PR8SX1i9vhvGY3ghVKzEGEX4UNI41mNwMXOlOUcY0e
 SfpgpjyUeBxjMOhfpHLrelxp/8KlGgS/kgcYAg42QMNrm7dkZOOlXWvN0mAiAejEGIgghXZ
 1+Zs5W00Wsyi04W0iRPQAmmHekXt3RL7A/sebYtWKNOm5sbZWDKTssDu/D194jSgKMjw5QA
 QvHfVD9hsGn0gKTjYNK+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ekf+x/GTjO8=:GM4+kKL4fwPtKRIPKs76/l
 unwfqjjdv2iaabjHDTMLcwTbpXcQq4mFMviJdssiG8OlOT1ErYPeDdp4rSydWm1x4HprtNBKL
 USkt9wFp0s7oIVSF3eQ1ygPSdGPDxUgc9VAIObcrmkVErUbw2TsNOn1b3pW252Ews6uBC6LyM
 a2+sa8XJ3LGbAKyqMiFciPlfEBCaE3z9JDHzjcWKumgI3/80xGNoPVjYbeRSXBDJeFt5K/izW
 gUpi3Py2ZLLS+XoPP+o4hzzzsP1+bAvDY0Av+yA+lpvwYZtQrKniKWTYv4yEe8jFgsq9AbMGW
 btyPOAqhKekVOpg3jZeMfEJmFZ+zQYPctOeYGDNrFwtZDRZX/mGjZEHPVszUCKPvy+Zhop/zR
 tizypOFHrOcCr5NCTTHCxEMfZUZ1FPrZ/JzgbpnKQbC6umtGSTa1z6aGX287regbzHewxIsPj
 2bVUokuKlZal/cb1cDcqKW7hO/vRd7rl7DvcdMCPz4G4JlSD/EzxR6E4mAQ65n4RzdF2ZmLhN
 vjpq9rJOliKWfg+ytCX3LZapnZBBjLoJ12p04DO9qzuYVNcqvDkUJAuVo3K5BNhm/u6lzIP6S
 JvhkT5wCgKmOiG9FBt0gn1tD2CYKnMxfACNxCH6fkiaedSRlAwZrb9UnEzsv0AsOVF6NBxI6P
 9degZBJRoTRzscs7AslRa06GJqQWzsrnoh2hbsAXKFYu2sJcr7HqBSzviECIYVu61qI9WlrcU
 13AxDMkgpgm14YBqGVg8necg0u0lhs9NOHZ7PA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kehuanlin <chgokhl@gmail.com>

Since the command type of UTRD in UFS 2.1 specification is the same with
UFS 2.0. And it assumes the future UFS specification will follow the
same definition.

Signed-off-by: kehuanlin <kehuanlin@pinecone.net>
Reviewed-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
(cherry picked from commit 83dc7e3dea76b77b6bcc289eb86c5b5c145e8dff)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/ufs/ufshcd.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 66540491839e..581571de2461 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -2195,10 +2195,11 @@ static int ufshcd_comp_devman_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 	u32 upiu_flags;
 	int ret = 0;
 
-	if (hba->ufs_version == UFSHCI_VERSION_20)
-		lrbp->command_type = UTP_CMD_TYPE_UFS_STORAGE;
-	else
+	if ((hba->ufs_version == UFSHCI_VERSION_10) ||
+	    (hba->ufs_version == UFSHCI_VERSION_11))
 		lrbp->command_type = UTP_CMD_TYPE_DEV_MANAGE;
+	else
+		lrbp->command_type = UTP_CMD_TYPE_UFS_STORAGE;
 
 	ufshcd_prepare_req_desc_hdr(lrbp, &upiu_flags, DMA_NONE);
 	if (hba->dev_cmd.type == DEV_CMD_TYPE_QUERY)
@@ -2222,10 +2223,11 @@ static int ufshcd_comp_scsi_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 	u32 upiu_flags;
 	int ret = 0;
 
-	if (hba->ufs_version == UFSHCI_VERSION_20)
-		lrbp->command_type = UTP_CMD_TYPE_UFS_STORAGE;
-	else
+	if ((hba->ufs_version == UFSHCI_VERSION_10) ||
+	    (hba->ufs_version == UFSHCI_VERSION_11))
 		lrbp->command_type = UTP_CMD_TYPE_SCSI;
+	else
+		lrbp->command_type = UTP_CMD_TYPE_UFS_STORAGE;
 
 	if (likely(lrbp->cmd)) {
 		ufshcd_prepare_req_desc_hdr(lrbp, &upiu_flags,
-- 
2.20.0

