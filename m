Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0D7C072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E199C214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdRwG4zq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfE1Nnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 09:43:39 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44726 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbfE1Nnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:43:37 -0400
Received: by mail-lj1-f193.google.com with SMTP id e13so17715613ljl.11;
        Tue, 28 May 2019 06:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SEeFPNZj/QO+Z5ptX7FeXaKpRH7B0reByetK9LT1X/k=;
        b=PdRwG4zq5zSdU3T15Hg5FQW72sJm9Xilyt6hLsn4kEJM4f8G9ZsQIBWFEv2q1wXmxf
         Y5aOr1J0fpIA3Jd2t8NSj4dhuCS+9JL7vYheNSB51MfKKwb5DyGDbz5bfhgrusxESLs+
         Azqu2GQY1yrMjlp3+aoWziNZGojdiyU+c2jRddwj7BnPjLGebPAjtJU18Sl2iFtehrAU
         TpnbTea6rHYys21N565ODk9QGgJplKZdwgVMdNZgQSMQo5c4eR/BCk7vX4NcmxtmGTyh
         n/1GFAyJS/uZdYr+NEI8YVU0IOP3ZKEICo36wVdDRd9t3rJ5VZ1TzAFMYWzdZVvYCt5l
         BXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SEeFPNZj/QO+Z5ptX7FeXaKpRH7B0reByetK9LT1X/k=;
        b=Xe2eJL1mu0rTOPMfonJaj5bPuTSOAsw0mPCG3TExmbUeJn0xc/57ztRb+a4nV1qKLg
         yqFMI5W786J6wXAF8MauBCT/jmciXv238Y19SVeROyxhUgiwvR/Zuy+bi61rEj5sQr8p
         PxrGmA/N+j4VYFs+hOBoVFtVdjnRX3kL51fWjleavdly93sQK6u+byUPpLLWH4ji5rmu
         g5rbyjIndR1U62U6qNAlFk1OezHTJgdP3qyXB6R1W4HlKTs8BLnTxXBmbk+q5ESGqcQe
         u9EQszit/CvAU/49nRjc7ptJB/gkmR8w/MPHkvozru0gwqm1DvM7uFoyf2NyG6CoQ9qc
         vvbQ==
X-Gm-Message-State: APjAAAUynyAGs+fqYW5YU5bOtwmhDhJQwoBJtsZe4RSTzVVmbu3t7mYN
        5P1Wr3zrUjVPdj1VhAh+H/E=
X-Google-Smtp-Source: APXvYqxStbxzyJFXJ5WkJVr2tAGR2m+ZHWj82uRBpgjE1M56nMKRDyDnsDLJ98QOztN5buJ/FSk9QQ==
X-Received: by 2002:a2e:3818:: with SMTP id f24mr38832479lja.13.1559051015719;
        Tue, 28 May 2019 06:43:35 -0700 (PDT)
Received: from debian-tom.home (2-111-15-75-dynamic.dk.customer.tdc.net. [2.111.15.75])
        by smtp.gmail.com with ESMTPSA id d2sm2237177lfj.0.2019.05.28.06.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 06:43:35 -0700 (PDT)
From:   Tomas Bortoli <tomasbortoli@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [PATCH] Bluetooth: hci_bcsp: Fix memory leak in rx_skb
Date:   Tue, 28 May 2019 15:42:58 +0200
Message-Id: <20190528134258.3743-1-tomasbortoli@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller found that it is possible to provoke a memory leak by
never freeing rx_skb in struct bcsp_struct.

Fix by freeing in bcsp_close()

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+98162c885993b72f19c4@syzkaller.appspotmail.com
---
 drivers/bluetooth/hci_bcsp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index 1a7f0c82fb36..550ab5b4c8be 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -759,6 +759,10 @@ static int bcsp_close(struct hci_uart *hu)
 	skb_queue_purge(&bcsp->rel);
 	skb_queue_purge(&bcsp->unrel);
 
+	if (bcsp->rx_skb) {
+		kfree_skb(bcsp->rx_skb); bcsp->rx_skb = NULL;
+	}
+
 	kfree(bcsp);
 	return 0;
 }
-- 
2.11.0

