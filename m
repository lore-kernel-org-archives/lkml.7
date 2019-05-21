Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653BAC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3CB216B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GR3zcVuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfEUIZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:25:22 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:9020 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfEUIZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1558427122; x=1589963122;
  h=from:to:cc:subject:date:message-id;
  bh=65KZ7sJTsRbX3pS79RSgjwLcSrvi8CtRoaxKAs9egSo=;
  b=GR3zcVuDLIABF+70CQkTr74sI9tQmK7NBj0vxQu23znknpGISwOwTlhE
   wFUrBkJpsg629DudQbndHv9rvY2vgnX2itxOodKtPM4FYcSf6jFwo2Ir6
   Ba3joB9/6tE2+W64dPUIxisMP68mXQZGbDY2hPVUQsjPOeoGwZsADvw1C
   dhqDtUamUjQdOvpjWIXceALmMIsWwZpIE7q0kNf5JV5fsd/qv1XYgUXPV
   X5VOR1bds+8gfFZ3FM4VuU71k7SYihNnQ5cMJRMUnvkUpfpZJG59u6k3f
   BnS+Zl00XOpBbuPuf3uaeX+XeZD3hjo3vBUjMKsY4qbha9+wh9YwTWPlg
   A==;
X-IronPort-AV: E=Sophos;i="5.60,494,1549900800"; 
   d="scan'208";a="109972692"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2019 16:25:22 +0800
IronPort-SDR: i8ZF7zt3gEWlhKEFYDT12J7gGPMZvlpKydiB9xnjZ7rXgiAbZmdegb8gECUMsVgaU8TC23LdkF
 CXynEHNVP3GBLws9vlQFA/Bki00YPmrSnK/xxbqeUuIcTUED6opb/P4DUC6VSIcQsP92TVm//L
 nVHCg1b/gph2sm4xEDmJwmsc0ts/rLLxcxNbifra+XJ+EpKIK0IXuw9ooNtoUbmIEghr8PDXT3
 HKwxVc9WJDfdop4X4BSBqDmO4xsoBtntdzdKZVjFIi9vi4RA/HV4coh9URc5n6OU6Cl0WVxJFb
 kNTP8uUQZnffQjaw1jJrnFoH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 21 May 2019 01:03:07 -0700
IronPort-SDR: 2qLVFTksDCcaCyDOkcRgkmxoYUEOCq5YBS+vbIVAhSPzggC3j98bUZKCEKxgbYH3rRaT9XqgbU
 JOghUtyTbQSL8Iei4OUmTweH3v5m7LW16k8M1mDNFI0HnFog3x+/INI5XsxYNoV8qDP8IzN+4I
 ItJmf+ZZH/DVqhf9ESr6ZSEUGeo3Lwjm3rq3bmK8FtgQPRtogFMMmV7JA0nHUamq/k+4j2rTJO
 gRoG9xR0D4+o6PafU+S4CEelvVtJWU0+iPnbfMYjzbbo2s1w47oY0KTinZe0uD78JgIz53QVZP
 aDg=
Received: from kfae422988.sdcorp.global.sandisk.com ([10.0.230.227])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 May 2019 01:25:18 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Bean Huo <beanhuo@micron.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH] scsi: ufs: Check that space was properly alloced in copy_query_response
Date:   Tue, 21 May 2019 11:24:22 +0300
Message-Id: <1558427062-5084-1-git-send-email-avri.altman@wdc.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct ufs_dev_cmd is the main container that supports device management
commands. In the case of a read descriptor request, we assume that the
proper space was allocated in dev_cmd to hold the returning descriptor.

This is no longer true, as there are flows that doesn't use dev_cmd
for device management requests, and was wrong in the first place.

fixes: d44a5f98bb49 (ufs: query descriptor API)

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/scsi/ufs/ufshcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 8c1c551..3fe3029 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1917,7 +1917,8 @@ int ufshcd_copy_query_response(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 	memcpy(&query_res->upiu_res, &lrbp->ucd_rsp_ptr->qr, QUERY_OSF_SIZE);
 
 	/* Get the descriptor */
-	if (lrbp->ucd_rsp_ptr->qr.opcode == UPIU_QUERY_OPCODE_READ_DESC) {
+	if (hba->dev_cmd.query.descriptor &&
+	    lrbp->ucd_rsp_ptr->qr.opcode == UPIU_QUERY_OPCODE_READ_DESC) {
 		u8 *descp = (u8 *)lrbp->ucd_rsp_ptr +
 				GENERAL_UPIU_REQUEST_SIZE;
 		u16 resp_len;
-- 
1.9.1

