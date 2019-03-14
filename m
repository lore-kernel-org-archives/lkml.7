Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F05C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C5A2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="WW8oYVIF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfCNGnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:43:53 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:47764 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbfCNGnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:43:50 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id A3C14C6D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 06:37:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ooZkE993mkRV for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 01:37:56 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 7048EC65
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 01:37:56 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id w200so3789402itc.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 23:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UaqXkDyxPeS1Bl07tP9L2bvvIcJ1LhWTA5MLjIao2h0=;
        b=WW8oYVIF1wqGwnPWBs6OmKB9BqhkBd/fI4GWNK6+D1eFse+nXF0Ez0HcmePE2pogMH
         iKdv/nptXc3w4GeJAKMdm2Sjld8SCzB3VsJg1u0Gf39HXSakvDlStXX5KZQNUbydVtyg
         jWnBrMhpl3x0IwgbM39Fhb1Yini6TgLkUD7WgANlg8bYjI1inomxnlwVnsDD8dqsTqWu
         BNYnGDPN1bkd+dHepPbNI8TnjCTQbW/DpniO25YJX2tOMHhN+o5D1M/WaeQS4OwNtFh/
         tU/rUCoBYujTSqTA6RmueXLLxS/xPCy7igcnz5sN4aeF7Ko5ej7RAoNgcRdJPFG9eGSK
         knSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UaqXkDyxPeS1Bl07tP9L2bvvIcJ1LhWTA5MLjIao2h0=;
        b=afGUyTGQO/i+DUctebF0E82lkZC+rCdmxznpYi6BoQ4wHmEKv9f3o6MDrqgmpNTQaL
         rIwpPPMjMwSR4kfwaf+GBiTB9OYWKESQ0tNnrUaOqDhRYf/ipz/fKxOCT4GKxHFScEp+
         06vGg4KxXx6uMfQpJC2cFcgABoeHXVLHJmYwEGfZL3xD8KHnAC4DbR3xJG1LcIuEH0U+
         DsVj/IeuJS2cbgjouN8S4TIRm7m1okoDxj3MOCB1M2B3pOnefQdY6pQilFW1+P8NT1T1
         qnXb1v6idH0AXcZa97Rg761Bv+fJ7DlINLIxGhXhJQ45WCn8hKWriK7fDYIT4wpAxcii
         qrAQ==
X-Gm-Message-State: APjAAAX6Kq0SxztZlF+Wwec5j3RXaxxVSl3CeC8o4T1xkZBL1tKuAqtE
        5NJayDgs3rtrx1gNQUdI7EFOiye0h0X+94Udk9lFU/prnerPUUwILzjmWviftwHggQcPXkYgOsS
        pwPYIEokcbq150aQLWZ1jAu01EfOH
X-Received: by 2002:a24:f709:: with SMTP id x9mr1038285ith.149.1552545476052;
        Wed, 13 Mar 2019 23:37:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwfnnpc+uX4loqYu+VDrvxDMKD4OwchqvyXfecv20Gemc+4AmidRo/Fwlqzvp2VBMQoogR6BQ==
X-Received: by 2002:a24:f709:: with SMTP id x9mr1038276ith.149.1552545475800;
        Wed, 13 Mar 2019 23:37:55 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id y18sm5836101ioa.56.2019.03.13.23.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 23:37:54 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: ufs: fix a missing check of devm_reset_control_get
Date:   Thu, 14 Mar 2019 01:37:49 -0500
Message-Id: <20190314063749.13907-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_reset_control_get could fail, so the fix checks its
return value and pass the error code upstream in case it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/scsi/ufs/ufs-hisi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/ufs/ufs-hisi.c b/drivers/scsi/ufs/ufs-hisi.c
index 452e19f8fb47..ce9d7c40909f 100644
--- a/drivers/scsi/ufs/ufs-hisi.c
+++ b/drivers/scsi/ufs/ufs-hisi.c
@@ -544,6 +544,11 @@ static int ufs_hisi_init_common(struct ufs_hba *hba)
 	ufshcd_set_variant(hba, host);
 
 	host->rst  = devm_reset_control_get(dev, "rst");
+	if (IS_ERR(host->rst)) {
+		dev_err(dev, "%s: failed to get reset control\n",
+			__func__);
+		return PTR_ERR(host->rst);
+	}
 
 	ufs_hisi_set_pm_lvl(hba);
 
-- 
2.17.1

