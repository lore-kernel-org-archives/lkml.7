Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0AFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A1D20651
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="ks5GhSCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfCSRyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:54:06 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:37352 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfCSRyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:54:06 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id AB997C7A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 17:54:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id W0PjlnEYJYS2 for <linux-kernel@vger.kernel.org>;
        Tue, 19 Mar 2019 12:54:04 -0500 (CDT)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 755E2CAC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 12:54:04 -0500 (CDT)
Received: by mail-it1-f199.google.com with SMTP id i4so18044072itb.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 10:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K6nd7rHuf5jkq4Vkom/yzCR+WfV8SUCoSAXMWbiPRCk=;
        b=ks5GhSCjom+9cY8Xzi6+xcX2cIxRwD+I3USt1SkqZZWUAySjZ+7D3AwoOWGSuBDoBe
         GudjHENIqABCznBNrwvYBk0za7FxvfwtIiR0AsLqI1xPFEqMzyO3DE4vLJj9BaYNgfNY
         jigQmPiYUqUzYwkFi4MaX4ls66bpL2HPv3nmss+QWcBIHoZ0AylxNmlLn9ROg/Ok229m
         YAEYrOQOpfEvb1ITd9+rBCgq5K4Y/5eHzPB48YySXAOhN2DcKHovV2AR0c9eFZSMKFUD
         t7US+dMkxL+hEJ979JVrx8BA+7Sn/FZFv7ZeQMrlLJKbfQsDRfnyXmr8BmBJcqqC54bQ
         EAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K6nd7rHuf5jkq4Vkom/yzCR+WfV8SUCoSAXMWbiPRCk=;
        b=WAWx+rRhDi0us4UmEIyaeLAu1vLP8LQ8bP40lTuMysGEuUlTqHoao0IVcqYxEPsswS
         8v8a1vkGb+z/J3UdbXJ0wzB5KDDOSvpZDWGkMSfvQoqum17oWU0xCFmw17AhEb6KyKRD
         xIPvrmPPEfLeYo1bZ+0OM29mltiUVmZgwoPGlIqEsZFrTK17vCkqgr9jsAxNC22QKBiB
         KWVuZShwEh/Pd0R0nQZFc6F1/dOTxWn1ysdVg1MmGDrBuDlGpjuTMTr010kuvX4AL0vR
         AsbT7VGB4VVpJQwGTSD2WHg2DYIpMtlYTBSFpWgODJ/BCchHfbWzkX6oV9lX91Fa8QgT
         65JA==
X-Gm-Message-State: APjAAAUPXt/wXIC+yLJFHC3b5y986r0lzfJhRx6QQF7PW8iP3RxzDXlS
        iU8TFjHOgnT7LQKa1/yqBxrW6mgMpb2MKURJrNcgaYy+Yo4wCsU2gvTHvIwGko55ulmAV9K6c+F
        /lCUO/akghN1CI7wY+jGOkTmLANkz
X-Received: by 2002:a6b:7f49:: with SMTP id m9mr2381935ioq.288.1553018044072;
        Tue, 19 Mar 2019 10:54:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwF73fhVyakf/sSjEcNKkGHg115LOSwXYk89kzxJXQdt7PsXZK9px+0gGNtLniEpZiZw+Cwjw==
X-Received: by 2002:a6b:7f49:: with SMTP id m9mr2381917ioq.288.1553018043854;
        Tue, 19 Mar 2019 10:54:03 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id l8sm1879836itl.26.2019.03.19.10.53.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 10:53:50 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rapidio: fix a NULL pointer dereference when create_workqueue fails
Date:   Tue, 19 Mar 2019 12:53:45 -0500
Message-Id: <20190319175345.8082-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <002201d4dddc62129a02637ce0gmail.com>
References: <002201d4dddc62129a02637ce0gmail.com>
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

