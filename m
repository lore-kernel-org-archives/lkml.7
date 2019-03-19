Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CCDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B47B20651
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="FSWfcCdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfCSRya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:54:30 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:38010 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfCSRya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:54:30 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id AE0D89B7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 17:54:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id f1jHTbzMr8Ky for <linux-kernel@vger.kernel.org>;
        Tue, 19 Mar 2019 12:54:28 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 62D6BCA6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 12:54:28 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id i4so18044980itb.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 10:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3fJr7CYIWAIuCwF2YPSemsHiI7aKe0WGtBY6/le+AN8=;
        b=FSWfcCdYX34FTYAAfrprrJb95ZAZiO3nmLCvcq0AuP88U7ELNkJ5zre2p30vjurs36
         TSmBE8vK7PSGOZSTU1q8vCd3EHaDvBN+rvpMYLV5Cz/CL/EuFkb1vfCrC1zsSfnxBZc5
         ZukpfFa8D8dUChsjPWf89QMauNgE0Fcl7USBuIvWlRHP7ZESXTCfzKtzZ2mMdE6EGrtX
         jGJxPNP8yPh0G6Vv0RT90zrnQmSRccQMDHQtB1bjGdKWa+blZa6Rqy2IAH5lNcE9xZtp
         oueyxwk7bB1hS/Ct+dhkJwtEr9wkaUqB/wJJsUxekOt18HrWwzg9A+mZUU6mx/YkvJd/
         mWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3fJr7CYIWAIuCwF2YPSemsHiI7aKe0WGtBY6/le+AN8=;
        b=TnpdvHbuhNHtS95KhCWJwAjGf5zzpRsFLwQjsh3KxlG5Wjrvhwe2jX60gzZ7Qp4Yvy
         uercReddhZwasi5PNfur4wcGAoexbkZ+SXbSf3C2WhRFGRJJY6ReoPoNvJkjyOkiclMh
         QT54YUHGg/lMc8Tj+ubT/RvLg0QHYqHO1+c2v2wR1Ax/5kd0IK8PP/G7HjzeCjildh3X
         V4pkG8h1ZMMEv7xirXDnWiz4WQpbi0HUMPhb5rgKHQ1+oFwPlcBsTwXM6CkfHbAktNLa
         10vjYsx7j9ltT6bJ0FLw9QqRrgiMx9HFHCh78CoVmeERcf3zWgSQ1D3WSOmN5qYuNI8l
         IFtg==
X-Gm-Message-State: APjAAAV5hyfc2QM+XX7mAE9AFqZFDNGxgRDtW+4/qzgtuF36LdrmNTp5
        bOZo0O//eooW0rc+1fKyEuWX1+1qDlCV5e0gExAqze2d8PJkIuQrYGSkkOj0loUCzrngUIj/vOd
        49/SSDWw7UJdckTHtyiAIvLyxNpHh
X-Received: by 2002:a02:8a4a:: with SMTP id e10mr2372288jal.120.1553018067993;
        Tue, 19 Mar 2019 10:54:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzyX+snOhFXV5M1wUHGrtMcH1ivVKbgflboyulxRBAE6H59sBCoqDLbNdXeC6nkxPvZYBrdJg==
X-Received: by 2002:a02:8a4a:: with SMTP id e10mr2372261jal.120.1553018067807;
        Tue, 19 Mar 2019 10:54:27 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id u66sm6040113ioe.74.2019.03.19.10.54.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 10:54:27 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Sharabi <ohad.sharabi@wdc.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: ufs: Fix to check the return value of alloc_ordered_workqueue
Date:   Tue, 19 Mar 2019 12:54:22 -0500
Message-Id: <20190319175423.13724-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ufshcd_init_clk_gating, alloc_ordered_workqueue may fail and return
NULL. The patch handles error consistent with other invocations in this
module.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/scsi/ufs/ufshcd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index e040f9dd9ff3..701b2da25f09 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1791,6 +1791,8 @@ static void ufshcd_init_clk_gating(struct ufs_hba *hba)
 		 hba->host->host_no);
 	hba->clk_gating.clk_gating_workq = alloc_ordered_workqueue(wq_name,
 							   WQ_MEM_RECLAIM);
+	if (!hba->clk_gating.clk_gating_workq)
+		dev_err(hba->dev, "Failed to allocate work queue\n");
 
 	hba->clk_gating.is_enabled = true;
 
-- 
2.17.1

