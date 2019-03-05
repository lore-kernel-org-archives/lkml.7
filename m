Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8B6C10F09
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9D82082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mY0KvB+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfCEVEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 16:04:31 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44862 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbfCEVEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 16:04:31 -0500
Received: by mail-pg1-f194.google.com with SMTP id j3so6472292pgm.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 13:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wm1VWzWYbhOsBYcDP2ujuuWSjZicHrsDWkC2dWj8kb4=;
        b=mY0KvB+ZMnSrpf9QxJdzYBnZ1bi35Ht7/+GsaPVNj4T36M/auinztjPFEW+gr85tWd
         OUferI2idVzb+OJGwQUTIiDAwiT0H5eMJC0E81t7ld2vEFVwQut4wN+xZxumOa2ayv2q
         l37Iyq15PfNkpV84GtB1i3hf0N//8ck5YKllM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wm1VWzWYbhOsBYcDP2ujuuWSjZicHrsDWkC2dWj8kb4=;
        b=R+tCRtcGC9pmegF0NPm+0wHxZQ0fScAS1dmiCq4O/lW+6dPWnfKOns8YhI3FvdWYx7
         /6w8s8oxwIjpGi/JDn5xUEn64U/zvc7NlfxdAdKPMkfLFxWeih0/m2zvqSUM7CcOHNQm
         5sgQMQAphwvRdNdYuo+sgqiJtPtueCz99HBwbWiqck4Ybo2r98dbprQ3ZfY7KYIdU+cR
         smNTnEzCjKL7dTR2t/Lc+p3P2DAqNxV2Ct9/of/z0eL80tfzaGcnC1S5UK8PNEunF75e
         Oi8LY12ZX0L069ZyrRksdLdscVEhjNktHXpF2tWC/zY2j3f03FFbSI99eD2jOjqcZLHr
         +I5Q==
X-Gm-Message-State: APjAAAU7SVjatKnBM48+hM5I86H4mDshq5ztHRsHdlL6M1tqHJO6tvSr
        EbW6J33E3TG5c77C8dDT8ZQ9ww==
X-Google-Smtp-Source: APXvYqwxFOjUaE+Vd60yhCYXxvZZlT4tw70MOhcYJFeA7GNHq+nOH6dUCgJoY1llvgZQrveiHNasHA==
X-Received: by 2002:a62:a504:: with SMTP id v4mr3852949pfm.22.1551819870485;
        Tue, 05 Mar 2019 13:04:30 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id l79sm19791320pfb.102.2019.03.05.13.04.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 13:04:29 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] Bluetooth: hci_qca: Remove redundant initializations to zero
Date:   Tue,  5 Mar 2019 13:04:12 -0800
Message-Id: <20190305210412.98323-1-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qca_data structure is allocated with kzalloc() and hence
zero-initialized. Remove a bunch of unnecessary explicit
initializations of struct members to zero.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/bluetooth/hci_qca.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 237aea34b69f1..8dccbb934e384 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -480,26 +480,7 @@ static int qca_open(struct hci_uart *hu)
 	qca->tx_ibs_state = HCI_IBS_TX_ASLEEP;
 	qca->rx_ibs_state = HCI_IBS_RX_ASLEEP;
 
-	/* clocks actually on, but we start votes off */
-	qca->tx_vote = false;
-	qca->rx_vote = false;
-	qca->flags = 0;
-
-	qca->ibs_sent_wacks = 0;
-	qca->ibs_sent_slps = 0;
-	qca->ibs_sent_wakes = 0;
-	qca->ibs_recv_wacks = 0;
-	qca->ibs_recv_slps = 0;
-	qca->ibs_recv_wakes = 0;
 	qca->vote_last_jif = jiffies;
-	qca->vote_on_ms = 0;
-	qca->vote_off_ms = 0;
-	qca->votes_on = 0;
-	qca->votes_off = 0;
-	qca->tx_votes_on = 0;
-	qca->tx_votes_off = 0;
-	qca->rx_votes_on = 0;
-	qca->rx_votes_off = 0;
 
 	hu->priv = qca;
 
-- 
2.21.0.352.gf09ad66450-goog

