Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728B2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453A52070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582068;
	bh=FZDaCV1v2NXo0ANQib28qIv7UU0spYx4H9kGwLKxnzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kAByp3bYe9ofs8B5PLLA1wShrkeZvdELP/rjuUeEuaJI8wsSLn9C/q6cXSMeSkMva
	 2K6C6U5FPiyLS8P5/nWNTZfPRs6PIF2v6rugjjyyIP3Nz3F2vlFQZgRvpOyOi87XQ7
	 TCRcYHVLVSGDaseR9iB8n/REJTZu5NXZPNWhLA0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbfCZGe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:34:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731453AbfCZGeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:34:20 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7664206C0;
        Tue, 26 Mar 2019 06:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582059;
        bh=FZDaCV1v2NXo0ANQib28qIv7UU0spYx4H9kGwLKxnzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nq+F4Hm/pcgJc2xyYptQqEg+2DdTgqaO1py5pBwzz5Q3gtmrFF1t8J6vMruRcTe43
         qKFGEi97wX6cwP16nvgKyq7irk/EYHGB/nJMDG3Yt4d0eujYfiO6iexMnbwDSVIj1D
         arfWwwWicTchO6xvcX90EBVYNU3ZMb3S3N9FZNL8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kehuanlin <kehuanlin@pinecone.net>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.14 33/41] scsi: ufs: fix wrong command type of UTRD for UFSHCI v2.1
Date:   Tue, 26 Mar 2019 15:30:10 +0900
Message-Id: <20190326042651.700241293@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042649.889479098@linuxfoundation.org>
References: <20190326042649.889479098@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: kehuanlin <chgokhl@gmail.com>

commit 83dc7e3dea76b77b6bcc289eb86c5b5c145e8dff upstream.

Since the command type of UTRD in UFS 2.1 specification is the same with
UFS 2.0. And it assumes the future UFS specification will follow the
same definition.

Signed-off-by: kehuanlin <kehuanlin@pinecone.net>
Reviewed-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/ufs/ufshcd.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -2195,10 +2195,11 @@ static int ufshcd_comp_devman_upiu(struc
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
@@ -2222,10 +2223,11 @@ static int ufshcd_comp_scsi_upiu(struct
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


