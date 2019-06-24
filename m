Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A9FC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2E8205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561370917;
	bh=fOvlLthS1MK46WfcNPVYkleqoAPilf+fyWhHYHhB55U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=spwNb/8g+SYsCIMa/6sNUKN6Rr3gLdUdTDuHZjuHJQhPU2MUhbOxo6Jmi0WwWPZQL
	 LZLX8hxrA5oyRc3erwDxucIPPCcn0BYP/2Y3Mt0INjeJJ4DKUoHYLcSU93d9E+PF5V
	 oqpFSm/zul4l4IVQQHwwycuIlgFBc4Qn72Lcjz2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbfFXKIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:08:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730404AbfFXKIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:08:09 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E355E205C9;
        Mon, 24 Jun 2019 10:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561370889;
        bh=fOvlLthS1MK46WfcNPVYkleqoAPilf+fyWhHYHhB55U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zNplICPL6mUyeThbWOr8DIgj+K2ZEuBh+r/tEXsZd5iG6JORxdmvpCCygaYlmc/i6
         n1HVa597Pb4WQr5odVtHPwlBQpLmS95U8w8VUP2LFHu6j+QVvMLFAhmAjTNUjrVN03
         qIVowgGUnJbd/5UPe/V8hygNGWbp2ph26bFN/fmM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stanley Chu <stanley.chu@mediatek.com>,
        Avri Altman <avri.altman@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.1 009/121] scsi: ufs: Avoid runtime suspend possibly being blocked forever
Date:   Mon, 24 Jun 2019 17:55:41 +0800
Message-Id: <20190624092321.121774629@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092320.652599624@linuxfoundation.org>
References: <20190624092320.652599624@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanley Chu <stanley.chu@mediatek.com>

commit 24e2e7a19f7e4b83d0d5189040d997bce3596473 upstream.

UFS runtime suspend can be triggered after pm_runtime_enable() is invoked
in ufshcd_pltfrm_init(). However if the first runtime suspend is triggered
before binding ufs_hba structure to ufs device structure via
platform_set_drvdata(), then UFS runtime suspend will be no longer
triggered in the future because its dev->power.runtime_error was set in the
first triggering and does not have any chance to be cleared.

To be more clear, dev->power.runtime_error is set if hba is NULL in
ufshcd_runtime_suspend() which returns -EINVAL to rpm_callback() where
dev->power.runtime_error is set as -EINVAL. In this case, any future
rpm_suspend() for UFS device fails because rpm_check_suspend_allowed()
fails due to non-zero
dev->power.runtime_error.

To resolve this issue, make sure the first UFS runtime suspend get valid
"hba" in ufshcd_runtime_suspend(): Enable UFS runtime PM only after hba is
successfully bound to UFS device structure.

Fixes: 62694735ca95 ([SCSI] ufs: Add runtime PM support for UFS host controller driver)
Cc: stable@vger.kernel.org
Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/ufs/ufshcd-pltfrm.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

--- a/drivers/scsi/ufs/ufshcd-pltfrm.c
+++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
@@ -340,24 +340,21 @@ int ufshcd_pltfrm_init(struct platform_d
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


