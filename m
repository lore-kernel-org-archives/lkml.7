Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995C0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C35214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="pwW1Fq3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfCLHHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:07:06 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:58712 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbfCLHHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 03:07:06 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 91E339D9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 07:07:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jhgiaA9XVOxr for <linux-kernel@vger.kernel.org>;
        Tue, 12 Mar 2019 02:07:04 -0500 (CDT)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 63B69B29
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 02:07:04 -0500 (CDT)
Received: by mail-it1-f199.google.com with SMTP id 127so1416353itk.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 00:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=I0adBQm6SRwvdWTdamfcRPCdJqkyTewOxVjCdvmpccE=;
        b=pwW1Fq3s7DBbNn7yHjOSa9+XUl1jo58MtWIPJ1Nlo061Dtry+kB6HfnDVeZZCgj5rw
         4LKZgcLihtw7PUQYFFKlv1SrT7n8vu91YSF1H1kcisxMKo85Iru7oghr0IpV/R6QfhGp
         2HUITK/Lltz1Xpsoudm1SoCbH4xSvjb7fKsBnBeKL5AW8VycE5yLRjuGF2JIEe1XGoEC
         BdR6GzzyIRWdwVQ8923YiqZ31nUBSGgXD/oqZYBIDC+w4up4rB2JHtz9iIKm0HAeToYE
         oxdFmxEEkCSd4Z34V/GpLlmfZB+KjOlx/0nV7dEODwqM2fwRrra3Da8/aD+jheotrBo1
         96RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I0adBQm6SRwvdWTdamfcRPCdJqkyTewOxVjCdvmpccE=;
        b=ZDL6wKFrhfGJ9pX7SjONe7LqcfDdx8aQLv47FA1CTtNHL67/cbJsuRZhpc/Km+394x
         Ja439LSj4FG1N+Yz6b+xgGSEkBatqnEqEMVCS0tAxcRYGWtc/fRsTlE6IM8XkXl6aA0w
         1gAWAuLz5XLdGw/gdX7+pcAsz9DLKms0ntf3vPY8lm6zFkasSR9Jo6yCV3aChHN03Q5f
         Zqf9dnTTIl/0Ngzlx0HTmTJ8SnKbX/NqUisBnsJGIoYCoRxQtJ2wJ8voWkRArpsLbpdN
         i40Y2OsQaA04421dA1jkr7rNFMF8T+gmgukJXCSnwRt5A0JQQ/yOV4J0HTwOgeD4DLin
         W7ng==
X-Gm-Message-State: APjAAAXhdASylRt6Z18J8TJ4CRgtZFNzN0GIr/9hnZ8OsAbO4mgaP8hB
        4jyWwbuYPVOM765NW/6IDZCq/gIK4uiwr/kgkqU4MdFx2gFUK3BOuygg4LCC1II4ozZKIOtUEgR
        8DmyjiHvH9VfWpUao+6ROt1IHCUKo
X-Received: by 2002:a02:85ec:: with SMTP id d99mr12021320jai.116.1552374423975;
        Tue, 12 Mar 2019 00:07:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzPFjrwasrk0dvfIHCziGlK/LKctjbPevuagozk2jEfKtll673tEMJou5ZHDR/C/iHTVwE+oA==
X-Received: by 2002:a02:85ec:: with SMTP id d99mr12021308jai.116.1552374423731;
        Tue, 12 Mar 2019 00:07:03 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id e11sm3253138iog.79.2019.03.12.00.07.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 00:07:03 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, GR-Linux-NIC-Dev@marvell.com,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: qlogic: fix a potential NULL pointer dereference
Date:   Tue, 12 Mar 2019 02:06:47 -0500
Message-Id: <20190312070647.20844-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case create_singlethread_workqueue fails, the fix returns
-ENOMEM to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/qlogic/qla3xxx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet/qlogic/qla3xxx.c
index 10b075bc5959..b61b88cbc0c7 100644
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -3886,6 +3886,12 @@ static int ql3xxx_probe(struct pci_dev *pdev,
 	netif_stop_queue(ndev);
 
 	qdev->workqueue = create_singlethread_workqueue(ndev->name);
+	if (!qdev->workqueue) {
+		unregister_netdev(ndev);
+		err = -ENOMEM;
+		goto err_out_iounmap;
+	}
+
 	INIT_DELAYED_WORK(&qdev->reset_work, ql_reset_work);
 	INIT_DELAYED_WORK(&qdev->tx_timeout_work, ql_tx_timeout_work);
 	INIT_DELAYED_WORK(&qdev->link_state_work, ql_link_state_machine_work);
-- 
2.17.1

