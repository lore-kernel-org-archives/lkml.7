Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C701CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969C92087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lFGu56uc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kI2sLTGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfCHIbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 03:31:43 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35868 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfCHIbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 03:31:38 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4465C602BA; Fri,  8 Mar 2019 08:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552033898;
        bh=a24jmQoPWqyDJptJlj3oRA4mUTzWhIfrj+Q4I+O9kSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lFGu56ucBAn7Ajv2VDEFhDpIfhMLSmRholwws22G99noC2oFZTH/1Osqfe+oq99IY
         cUUwutmxkohNwBOE4W7EaB8Il+ft5N7DLvtH+02uPxajncdBhfd/V/tGGMmM4xcDDr
         tswzTbr/aONPjjq8PsfCrjSYh1/BZ8ZmKQNQNeUg=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 492D461195;
        Fri,  8 Mar 2019 08:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552033897;
        bh=a24jmQoPWqyDJptJlj3oRA4mUTzWhIfrj+Q4I+O9kSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kI2sLTGYmJ1dKyqppG9aVCwEQoh83TleGta3FS/McKAtyHP5cRcW36TPGcikMelsU
         xjFQFNVNzHqECUzQaKegIvoVOZRQcFauefNe5E1PBMp6TaFGxCrFgLPrw6IX432dX6
         dn+ENlP719b7m3KZDfRM/V2CTozuPa4EenLTOKfQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 492D461195
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     vinholikatti@gmail.com, alim.akhtar@samsung.com,
        pedrom.Sousa@synopsys.com
Cc:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH 3/3] scsi: ufs: qcom: Remove unnecessary runtime pm calls
Date:   Fri,  8 Mar 2019 14:00:53 +0530
Message-Id: <20190308083053.30631-4-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190308083053.30631-1-rnayak@codeaurora.org>
References: <20190308083053.30631-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doing a runtime pm get/put as part of ufs_qcom_testbus_config()
seems completely unnecessary, since this is called only early
during ufs_qcom_init() when the runtime operations are not
completely setup for ufs runtime suspend/resume to even work.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/scsi/ufs/ufs-qcom.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index 3aeadb14aae1..3590741eea2f 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -1558,7 +1558,6 @@ int ufs_qcom_testbus_config(struct ufs_qcom_host *host)
 	}
 	mask <<= offset;
 
-	pm_runtime_get_sync(host->hba->dev);
 	ufshcd_hold(host->hba, false);
 	ufshcd_rmwl(host->hba, TEST_BUS_SEL,
 		    (u32)host->testbus.select_major << 19,
@@ -1573,7 +1572,6 @@ int ufs_qcom_testbus_config(struct ufs_qcom_host *host)
 	 */
 	mb();
 	ufshcd_release(host->hba);
-	pm_runtime_put_sync(host->hba->dev);
 
 	return 0;
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

