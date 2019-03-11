Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB12DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0E520657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Q3+WaJIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfCKGx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:53:26 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:54636 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfCKGxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:53:23 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id E566EA93
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:53:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nHUFfuHgEJjl for <linux-kernel@vger.kernel.org>;
        Mon, 11 Mar 2019 01:53:21 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id BAD88B5B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 01:53:21 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id n15so3507375ioc.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 23:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BwclKcHlyNokEmZBkCixxXn65ldk71jtuuiFi/oNrYc=;
        b=Q3+WaJIzerhOigmCWcgB/aTx364zg2qKFDEjtT/cE3LR1owhn96WRUCc4HDZ3hi4W3
         N78Kt7QGA/iHfKsEu0/CumO0EPGhEzRSV3PGy/6lx9lWAOq3Cwi0UuIMgoAlBgh7cu4j
         5iFxyr98g1nNuyy/WPrmjE98Mlaaw+kByQ5F8T9E8GxWf1JSRiqmeU9J9CN34ZrlihTS
         fhew+u3/or2glIvU6PuMz+5yrEYsxdGqclJAGg+NXGdTl79pvOgr0URXIwkXu/rLyQlM
         I5CnIiyKeA+YU3BsfAG9se8A/PsuXDDNGZc3/ZahfxqtYssUUbMAYU4DG64dn8a2pzGf
         W86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BwclKcHlyNokEmZBkCixxXn65ldk71jtuuiFi/oNrYc=;
        b=k7hSEgtLqwP9iq1qXzgCGQNaHtw2U1IxiXBFUSuzJxGBD5uEfXBa0qCXBbJd/DgXBy
         HX5raeBn6X4t/662spJokUhwBCHZFLApvW+I85ck2gCnsaiFhXsoHHBHiVAsvmNnSaPn
         wgCh/9X7f+JvWyK/uLkVHN7caroWUm+oVutOohIVQpm8amMjqATYM++rA7Gbbs0KJTKN
         pHJof22Z6J0144MSmH0RGZXNgVQIFlJo0u+i9RP2tEbiAMTw1U114mrrngFQUgVWbsI4
         N5dO08m38Wtdgev/937QrihubVXsaQhwUvauF1fWaXAX1uT9dGw+zP7UvugFTeC+yjiH
         /t6w==
X-Gm-Message-State: APjAAAWaouFbw2TOjqTrotDlD5x61wt+rBCo3LbNE1RxXld6oZZp+a/9
        r1cp+FIyG+9s7WGbPfrUMVlfvN1MKr93XvvkPabCpGIWPUCnBaMRnK/Ggof+Wr48T/HTovl0ViR
        YXNr3sQbhx47lWE/5K5LOXUJERVlo
X-Received: by 2002:a24:ac58:: with SMTP id m24mr14148951iti.129.1552287201367;
        Sun, 10 Mar 2019 23:53:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqySMLxmimw8rqqTlemL7xujLWZeSRaLcbQoudPjUhxGq30LpTpDiI7B7+YWUsISdmEXIxlnuA==
X-Received: by 2002:a24:ac58:: with SMTP id m24mr14148941iti.129.1552287201166;
        Sun, 10 Mar 2019 23:53:21 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id p18sm7713571itp.10.2019.03.10.23.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 23:53:20 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Manish Chopra <manishc@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: qlge: fix a potential NULL pointer dereference
Date:   Mon, 11 Mar 2019 01:53:15 -0500
Message-Id: <20190311065315.23070-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case alloc_ordered_workqueue fails, the fix returns
-ENOMEM to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/qlogic/qlge/qlge_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qlge/qlge_main.c b/drivers/net/ethernet/qlogic/qlge/qlge_main.c
index 096515c27263..07e1c623048e 100644
--- a/drivers/net/ethernet/qlogic/qlge/qlge_main.c
+++ b/drivers/net/ethernet/qlogic/qlge/qlge_main.c
@@ -4681,6 +4681,11 @@ static int ql_init_device(struct pci_dev *pdev, struct net_device *ndev,
 	 */
 	qdev->workqueue = alloc_ordered_workqueue("%s", WQ_MEM_RECLAIM,
 						  ndev->name);
+	if (!qdev->workqueue) {
+		err = -ENOMEM;
+		goto err_out2;
+	}
+
 	INIT_DELAYED_WORK(&qdev->asic_reset_work, ql_asic_reset_work);
 	INIT_DELAYED_WORK(&qdev->mpi_reset_work, ql_mpi_reset_work);
 	INIT_DELAYED_WORK(&qdev->mpi_work, ql_mpi_work);
-- 
2.17.1

