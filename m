Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE855C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 05:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0AB2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 05:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="hGk3uUZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfCOFHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 01:07:22 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:58318 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfCOFHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 01:07:22 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id C078CD42
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 05:07:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BLgxiUrHvNIq for <linux-kernel@vger.kernel.org>;
        Fri, 15 Mar 2019 00:07:20 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 9395ED1D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 00:07:20 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id s24so2332289ioe.17
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 22:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MH76t9kyzCAYqgMIcgO6OuxcOMmte5MRyPGol0wrWyk=;
        b=hGk3uUZ+BAEgvh3z3ErlGCyL5arnj25cJRzutdAe5oCIrX/d95usy4n8P57QB8Slbc
         T7iT944cmOSrUtpNbrIgJKw7iCLgUBkJDbR0IV6DXVKYa8lILJodRlLJEDcYjwzyDirV
         XODVDwAs17tnPX0PvyAVuuoeLJLtjM5TDaZ45lvdlpAducAfW9cP90ZKosUPlfbYwuBZ
         Tn87bGj6Vzp6QBeJdBysrPEiW5TZJfT93/5TWn9LhfCcjSHITxxHRNMnlY1FYBwJmToo
         shs4p0ojbYBF+VZL9szEkyv1ZZurV6UJPHAPDcfxWWyRuSHHpA7S83f8a+nLqa9s5awR
         KQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MH76t9kyzCAYqgMIcgO6OuxcOMmte5MRyPGol0wrWyk=;
        b=WFB0mNjkhkz9+kL82BEJpmEehoLjz5ymBfjwHuFxstN/FBC7dJd0nZk6PBfjUfaDz3
         /I1M8pSQ0OmbTHCAdMzEBwRyT5kE3EXByfeRypIxGUlI4H7WkrDdGYbnmpGp9aw4BNZB
         yp/ENO57OO8YXh/PsTlIdlLSc1pYBmqQaH28sjcMq8eew3hrPNgwfob6YrAoreJ5f+4+
         zUQ2zmZnYvqxuRB3nto3s1WQK3yauHSddtx1decj5mj7FXN6jNySfEXDaVVtAU32dpaG
         MI0NQjEsaqmsV4bpLn1z8f39gsReGmjZ66FXy3ph+/tucVgvRthQA7l5W2jyEiG8kS+w
         GGew==
X-Gm-Message-State: APjAAAUclIlAfbSqzo5oxWjFvpLr2NIHsiQmsr0AJM3XX2rnDSJhovH8
        Qre7WiBLq3BDdbCvRUIQLeWIK1DVHeC3FH5zftJgFBEOggGfLk/fpnO61SnE4+12XODkXqgTqk6
        4lcf00b8ZO2CvgUdSqdEnhkfeA2KO
X-Received: by 2002:a24:2546:: with SMTP id g67mr794200itg.18.1552626440222;
        Thu, 14 Mar 2019 22:07:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyKTt5B0MhdRiezIvucSKFXhY46yQaUIp6UuZi+YyVa6ogQQRUNHWrjaZSoDvbJWsA0ZUiIJg==
X-Received: by 2002:a24:2546:: with SMTP id g67mr794191itg.18.1552626439984;
        Thu, 14 Mar 2019 22:07:19 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id 22sm489974ioc.28.2019.03.14.22.07.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 22:07:19 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pci: endpoint: fix a potential NULL pointer dereference
Date:   Fri, 15 Mar 2019 00:07:10 -0500
Message-Id: <20190315050711.8652-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case alloc_workqueue, the fix returns -ENOMEM to avoid
potential NULL pointer dereferences.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 3e86fa3c7da3..dc610eb1543a 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -570,6 +570,10 @@ static int __init pci_epf_test_init(void)
 
 	kpcitest_workqueue = alloc_workqueue("kpcitest",
 					     WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
+	if (unlikely(!kpcitest_workqueue)) {
+		pr_err("Failed to allocate the kpcitest work queue\n");
+		return -ENOMEM;
+	}
 	ret = pci_epf_register_driver(&test_driver);
 	if (ret) {
 		pr_err("Failed to register pci epf test driver --> %d\n", ret);
-- 
2.17.1

