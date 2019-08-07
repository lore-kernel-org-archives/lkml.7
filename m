Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA2DC32754
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 18:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5256F2229C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 18:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VMsjrbJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389442AbfHGS65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 14:58:57 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33263 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388681AbfHGS65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 14:58:57 -0400
Received: by mail-pl1-f196.google.com with SMTP id c14so42065634plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 11:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XCzr1T0/DdxuLzB0miWs6nmo/kjr1O+wefDJdVCthWw=;
        b=VMsjrbJvk+g4nuenJH9gKjwL+nI/korDji0hz9wNkfoScVuH5bCVUSFxNq85n39JKG
         CeOFJppRsD0xS8+adGEHtdyDc6MxRCswVPkSRDSn1xokdW/+graOqWD42UoVNCNaomhJ
         7a21HU5a3LJiuXu9XV4qhkVyOw0cis6DQrK2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XCzr1T0/DdxuLzB0miWs6nmo/kjr1O+wefDJdVCthWw=;
        b=nPPMqhCKF1OanYj1BoKcZMtzl/SZCp37cFT0ID5H8z68tYWFZ9GjndW2CLTe+RDARi
         tTqQPbAQ4oZOJbAkw2jMz2aTrC3faKrmWVzsIiCSgxtyYEvgMLY5wfbcWkTLDZyE4Zuo
         e3/6D4VbaoATZ41LXPzFY1kD55bsdH3pyY5NkSctGtvMyV/U3168g0r/xw3gJ/qhPimA
         7JgHA4Ctg/tf7YRetzVylsqZpjNbKWm9Ytsph8noFwD01SDkC9iSZe1giWvzyze66ijp
         SOvIJIK158UQmRKDfku0+YzusU5zBbpmSbH3OgVJ8fHW1EDc6lQKWL2dhvm5ziiJXfxT
         IvnQ==
X-Gm-Message-State: APjAAAUQ+WnwmsMhNYkmeFG6yTqY3DpSf+gC43ZvA3yfLfJQEQKgRaw0
        HnmbCYu0C0m7RvD/zBudohR9gw==
X-Google-Smtp-Source: APXvYqye5Ih64EmIap1AvYJwGX0VY16CGMiYgufWLv/h2MA7+ghBeRgEVFZnXDKaQtUanldVqTOrPQ==
X-Received: by 2002:a63:2807:: with SMTP id o7mr9116751pgo.131.1565204336255;
        Wed, 07 Aug 2019 11:58:56 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id v14sm5588599pgi.79.2019.08.07.11.58.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 11:58:55 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Harish Bandi <c-hbandi@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] Bluetooth: hci_qca: Remove redundant initializations to zero
Date:   Wed,  7 Aug 2019 11:58:49 -0700
Message-Id: <20190807185849.253065-1-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
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
Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
just noticed that this patch fell through the cracks, resending a
rebased version.

Changes in v2:
- added 'Reviewed-by' tag from Balakrishna
- rebased on bluetooth-next/master

 drivers/bluetooth/hci_qca.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 16db6c00ae64..007e98c36e2f 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -499,26 +499,7 @@ static int qca_open(struct hci_uart *hu)
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
2.22.0.770.g0f2c4a37fd-goog

