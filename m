Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5519EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B8320854
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N8IwpfFg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EX9fb90B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfCHIbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 03:31:34 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35498 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfCHIbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 03:31:32 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 241AF6115D; Fri,  8 Mar 2019 08:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552033892;
        bh=j1iOA04Ibk3v4AjlnxxPfgJEJJzv6dGyDzSn6fvInw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N8IwpfFgApnZTkY/feOyX7NUSHh6WJ6EtFwUWsJXubE6RTQOOTdjBh7ARyakf5FKH
         ZxHSpVQG9jTtKTa0+zaAdP5z1RjDsOUfBNPmJPo5uDdImW7/UEfvIK/NAczipjWBrQ
         RputmITJIUedq/6DTA4KO9nwNM4ei2m/MLm0zfJs=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 01BE061155;
        Fri,  8 Mar 2019 08:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552033891;
        bh=j1iOA04Ibk3v4AjlnxxPfgJEJJzv6dGyDzSn6fvInw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EX9fb90BIN4TSlTo3AJ9bqbXn4EQDaikr3yBZ7ql6lHCx63UGTeoXtnZ929kWaLvK
         G1IuTWmU/RZOUeUNWamOgF4XxOd9rWaoiQhUskODvIAlKYc3QNisKDi8xwU6vXZ22i
         PgWsiRWTiSjXZzCMerIPF0Qb6JY8c44e7P7ItW9s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01BE061155
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     vinholikatti@gmail.com, alim.akhtar@samsung.com,
        pedrom.Sousa@synopsys.com
Cc:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH 1/3] scsi: ufs: Fix runtime pm handling in ufshcd-pltfrm
Date:   Fri,  8 Mar 2019 14:00:51 +0530
Message-Id: <20190308083053.30631-2-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190308083053.30631-1-rnayak@codeaurora.org>
References: <20190308083053.30631-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

runtime pm calls as part of ufshcd_init() can trigger a
ufshcd_runtime_suspend() which always fails until the point
we do a platform_set_drvdata(), setting the devices 'power.runtime_error'

Use pm_runtime_get_noresume()/pm_runtime_put_noidle() to prevent
this from happening.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd-pltfrm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
index 895a9b5ac989..974441fa4e75 100644
--- a/drivers/scsi/ufs/ufshcd-pltfrm.c
+++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
@@ -340,6 +340,7 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
 		goto dealloc_host;
 	}
 
+	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
@@ -352,12 +353,14 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
 	}
 
 	platform_set_drvdata(pdev, hba);
+	pm_runtime_put_noidle(&pdev->dev);
 
 	return 0;
 
 out_disable_rpm:
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
 dealloc_host:
 	ufshcd_dealloc_host(hba);
 out:
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

