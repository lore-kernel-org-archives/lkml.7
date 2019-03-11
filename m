Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E6EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5AC20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="WeTNqeGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfCKGFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:05:50 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:41416 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfCKGFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:05:49 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id EDC69909
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:05:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8Kkqp9StQRKH for <linux-kernel@vger.kernel.org>;
        Mon, 11 Mar 2019 01:05:47 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id C02C6953
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 01:05:47 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id d7so3377407ios.17
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 23:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=kXE9K1z7T3tHwy88mlN+3/viWz4O6VEjBCg7Hk6+9Zg=;
        b=WeTNqeGk7vRvIBkKzlpH8iU2mf2sKfD4A23iuIk/8WVJ0fGC2Nnkr7v/zCcPYoArO2
         ze5LHCqk9gvhWy4UXQRb/dCYRUT0GPoGKrEQmbdN3GUUrJgYs/GyZQju2FZ5LCriLyfT
         LTDjtk055wD3+ifnPS12VjliuUJusXno07Q7rEtcJLzoBV+py+dyqOjQ6K3upun4yKLk
         vaGEMzjUm2XBXvV0aDPqMYaxl1k6av0OIz0h3kFvWsyYAF8Wi8XDGiNbsO/eH4gYV9zZ
         oMY9CjFIuRytrNMwDqid2l49E6Y6PPMytISMGSLdVTuzgiZhQ2ksJb2yCLvM8foqpdza
         P4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kXE9K1z7T3tHwy88mlN+3/viWz4O6VEjBCg7Hk6+9Zg=;
        b=GeD1VPNBmeW5sIC3xs/8GQRj8mj1aVAOMJkMfbhwz+CSJV6x//hVgxmorzUlR8GDpk
         Xr4iBtOsDcvwqcfKOkOrJlUacH4bf6neEhjVx0suTskNJmAWkHsE7WTjmw1XC+UZE6xj
         dXArD5+dntv0d0zrvYdXLenQLcdB76o/xYpZmMGvptqHLT1eHWb5lAf6HPQ7u78wbxZW
         xQK2zkfoYrFIJslGX4PEsODb/MpgHytPEuGyglNfkG2wB50+6/JRsez/Q9D94qYKcMxX
         uNpPUee1yy+CArSKDQ576liDYWjbO1UaHLz9Uv3+bKM9K3jWHfGYOc0Lwpj/P1DrvkCD
         ACPw==
X-Gm-Message-State: APjAAAXzyVJiZQBN2buNZvhLlGUKLGj3Qgtei6YMx5cbkvSPm2hBHyn+
        mfeLS0Qnx1tAGPAsi1Kt4Jx+QmZ+XtgfitUnz4Z5yo3WMdLQ+e1ZC7WTipgP6b0Y81q5td0MQKy
        hYcvxww9e7NhuOhPB1FfbLGx1lojg
X-Received: by 2002:a5d:8d02:: with SMTP id p2mr16899821ioj.113.1552284347353;
        Sun, 10 Mar 2019 23:05:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwBeU/++XbWTXWW1NzZY3zpcfLI/yAAr/TJ8V9cD+bS/mhMGeNiGhaPKexCgMbBCOrfaeA0Eg==
X-Received: by 2002:a5d:8d02:: with SMTP id p2mr16899813ioj.113.1552284347093;
        Sun, 10 Mar 2019 23:05:47 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id s3sm1361095ioo.65.2019.03.10.23.05.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 23:05:46 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Sunil Goutham <sgoutham@cavium.com>,
        Robert Richter <rric@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: thunder: fix a potential NULL pointer dereference
Date:   Mon, 11 Mar 2019 01:05:41 -0500
Message-Id: <20190311060541.16287-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case alloc_ordered_workqueue fails, the fix reports the error
and returns -ENOMEM.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index 503cfadff4ac..aa2be4807191 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -2234,6 +2234,12 @@ static int nicvf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	nic->nicvf_rx_mode_wq = alloc_ordered_workqueue("nicvf_rx_mode_wq_VF%d",
 							WQ_MEM_RECLAIM,
 							nic->vf_id);
+	if (!nic->nicvf_rx_mode_wq) {
+		err = -ENOMEM;
+		dev_err(dev, "Failed to allocate work queue\n");
+		goto err_unregister_interrupts;
+	}
+
 	INIT_WORK(&nic->rx_mode_work.work, nicvf_set_rx_mode_task);
 	spin_lock_init(&nic->rx_mode_wq_lock);
 	mutex_init(&nic->rx_mode_mtx);
-- 
2.17.1

