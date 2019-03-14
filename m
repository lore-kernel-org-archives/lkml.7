Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58694C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F0C2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="fQ50pq/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfCNGK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:10:29 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:41582 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfCNGK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:10:29 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id D3326C3B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 06:10:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6OpQg2sMzHPh for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 01:10:27 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id AAA52C01
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 01:10:27 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id r21so3472578iod.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 23:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=K6nd7rHuf5jkq4Vkom/yzCR+WfV8SUCoSAXMWbiPRCk=;
        b=fQ50pq/mAoJhRZBxW1WT/+kkqv72QiPbRCKOHrcxfifAnqdC2eGsOMGWrj0AbfCGyp
         O3fp/mwPY4GoJJ3tToSbRtWkqWkwqJrZD2AH/0hfUAEV2exJzMaSvlXO1rUDqPoB9P8Q
         dAF0R+wnM5KY8I5LO/z4xUxm4ZeGVNytwiiM+aQhj8VAJ1JLgwcAtx98OFfDH1aRZls5
         rlmnHUJRvpbln6nMB5ILfaQGZGD41PB9UJucFPUDlg9zOH9603Fs4Nxr/jiUE4x7y2R2
         YHZIr+25Dqi1z6X1WcXViolxhbR+ed9bhwdJl0fxGRTENuZdZ1I2b60W9xXJMiqvxf3z
         fSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K6nd7rHuf5jkq4Vkom/yzCR+WfV8SUCoSAXMWbiPRCk=;
        b=GbjNVOW5LmpJRKbPeMX1Cui4J6yH0i6Fp0hdOf5G+XgRCxyT7vm9ShWyBlQ9x1kINe
         Fy/o+7lxoeboaYZCcEuTetC0WCnkgRoRh9K9qvD7EUx1TxDTLNXC9hPbHN34cm0Ftuc0
         vVjp9enJ/fRa2eOxr7toaXHU7rRv7AnTgxTZ9CbGgPmNbiKBEb0mwi66QMYDxpvCwWAc
         mNCTLE8cMMzCeLFjc1HOYoN/R3MRmbdA82kTkm5MWWcqvhOrk3VMu6UpJ9fcT8+g1OII
         CWHW38Kz2ngbh2awjo4Q4RhGmn093g6XToHUAd4CpFnRZJIZYV6bCnXiV1DN3icY75Dc
         hjrQ==
X-Gm-Message-State: APjAAAU7ZSUK12aepRjIC+SxdEZtc/5pPMTLE2zowSMFwZuOfTSlSJWM
        ZMH5aTLLMO0bqVfSykIc/V57XjjMI0BQ5ENTvXybU19za5YIBOEufVmW6Od7O4wHs1Sj/Jtf3iw
        GaIUGpTpXhToSAjuCWmIzJYHjbn+n
X-Received: by 2002:a24:908:: with SMTP id 8mr1041866itm.155.1552543827053;
        Wed, 13 Mar 2019 23:10:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy69bnGvdqC8kII8Eu9FrbqUDdrNdnO6u/517zVUySms8RfzLmCdjYJmD9+V71d8hbxKUYUzg==
X-Received: by 2002:a24:908:: with SMTP id 8mr1041854itm.155.1552543826824;
        Wed, 13 Mar 2019 23:10:26 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id l11sm6110763ion.52.2019.03.13.23.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 23:10:25 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rapidio: fix a NULL pointer derefenrece when create_workqueue fails
Date:   Thu, 14 Mar 2019 01:10:15 -0500
Message-Id: <20190314061015.11291-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case create_workqueue fails, the fix releases resources and
returns -ENOMEM to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/rapidio/rio_cm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
index cf45829585cb..b29fc258eeba 100644
--- a/drivers/rapidio/rio_cm.c
+++ b/drivers/rapidio/rio_cm.c
@@ -2147,6 +2147,14 @@ static int riocm_add_mport(struct device *dev,
 	mutex_init(&cm->rx_lock);
 	riocm_rx_fill(cm, RIOCM_RX_RING_SIZE);
 	cm->rx_wq = create_workqueue(DRV_NAME "/rxq");
+	if (!cm->rx_wq) {
+		riocm_error("failed to allocate IBMBOX_%d on %s",
+			    cmbox, mport->name);
+		rio_release_outb_mbox(mport, cmbox);
+		kfree(cm);
+		return -ENOMEM;
+	}
+
 	INIT_WORK(&cm->rx_work, rio_ibmsg_handler);
 
 	cm->tx_slot = 0;
-- 
2.17.1

