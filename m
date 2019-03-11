Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB61DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA9220657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="bvRK435D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfCKGvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:51:09 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:54446 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfCKGvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:51:08 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 530B2B52
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:51:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id m0PGQk-YR4FY for <linux-kernel@vger.kernel.org>;
        Mon, 11 Mar 2019 01:51:07 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 20F6C989
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 01:51:07 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id v3so3527541iol.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 23:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=I0adBQm6SRwvdWTdamfcRPCdJqkyTewOxVjCdvmpccE=;
        b=bvRK435D6d1aqOQwRYQQORz8ujadKwnA+YPJSwO2d4zDICpFI7ww5KbWNTOxmsGy1f
         aJE5dT1+iJygTfzf/LYCBhk6eGvJWmgCuK8I5i6Iwr3q+/j65P7mYI5ez04PYFDf5iTs
         8xPCp2bFYy/u3S7PmfPq4oH2Ajql5u3T2MB/7imv+wF2S8GaRYHQYUBgM+6lvegu7VQs
         P1w1/en79oYbm1uFbds0bikqmeNrTA3AUgqYzRgoacz+gUJna3eTA+oNcklFzN0N+6XJ
         OC6ZXYcfpbiKbQJ/c5c25IAlFRiGPKKypbjjWZxLmvEHRKSHoWAtGbZRQ62STEeZ5xno
         ajlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I0adBQm6SRwvdWTdamfcRPCdJqkyTewOxVjCdvmpccE=;
        b=gOLX/DWhv2o/wDi/HFo832clNGMM434uIE5Bwp0WMWB10/7SwCZfrdEgrnJqpz9xd1
         d7O0s2d2o4p/lpTSssqLLXWudCCKvhMNIqGjj8mmq2oEdRdk5LqLIR5pbQH7aXZqgarQ
         WBx4R8IzXLQm2nvnaJZcC8iGqBjx2VVyYC600RiwuygsNyl/bE6Ahw1JIQChv9FAVsTG
         zNEqKZjuixwjpEbf3NO21pPJMS25LWZYXR+TiEnT1Xd7qzb92UceF2qsELjYAbUSf6YD
         TKMfe7IPRYrYbYdfDhlnTAecxQAqDrDpdgl61S+xZzutnl0LWb5bFaaYXhilh4vUpqo2
         1dQA==
X-Gm-Message-State: APjAAAWjG6wyvKpl0RkOFEIBm3ne6TjBiyhOToat2xLqI+p6BAzX4iqa
        WDlkfnDyryq8UOW9x7n7fYfjhn8/SLS1boH373eTi1/tFOdqUfG3T1m6VYe/ehOIlCbzTo2Iv6h
        mB5irMwXZOF2WxIs/HihBXS7QZMX9
X-Received: by 2002:a24:2c11:: with SMTP id i17mr14509424iti.146.1552287066712;
        Sun, 10 Mar 2019 23:51:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxuj9yhYJ98d/3wGs4uFooZ2dEORG6f+DmAjCK+aduf6vpTnq3wt/Xu0dvOsX2MC7Z+YHtXig==
X-Received: by 2002:a24:2c11:: with SMTP id i17mr14509414iti.146.1552287066434;
        Sun, 10 Mar 2019 23:51:06 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id q8sm2123661ioj.72.2019.03.10.23.51.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 23:51:05 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, GR-Linux-NIC-Dev@marvell.com,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] next: qlogic: fix a potential NULL pointer dereference
Date:   Mon, 11 Mar 2019 01:51:00 -0500
Message-Id: <20190311065100.22203-1-kjlu@umn.edu>
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

