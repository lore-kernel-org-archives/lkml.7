Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591F6C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2552D208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0tohVoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfE1MhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:37:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35654 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfE1MhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:37:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id t1so10929106pgc.2;
        Tue, 28 May 2019 05:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=T0rvoruj4EouBF2s9WLw8GruoH2nVQyED2DEWY5fc+4=;
        b=d0tohVoWy6jU64ypaoIOEg7BvHTwDuk6YaqYBG2SN1QxyYJIi8WcfUCImE28FbggbF
         2/LphM5WK9iBFK46QOmuI8woDuIoosCg2ziCSrZaKeiqElcrsyl0J1oR4MnBILpOZ4bO
         v+cm/3pvgGv5fMmZo+jXBwcc5mQntxZgWziP7OrAgwF6lkAoS7Pk9Kmaorb28q9WsCoJ
         Ifk0Tn279WzhcQNoWKozVuneA6WANSBwilph59yJiARLTUnB1yuyru1lJ1COW/6WTtlf
         klXQM83NNl6hmoCkCm2cfXZPUI4AsHc3nGAG/sZYjQIbD/jz7S5ut5pJiKNZIUPng1Xs
         nPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T0rvoruj4EouBF2s9WLw8GruoH2nVQyED2DEWY5fc+4=;
        b=Ggm3Vjg+V+8yu47A6+hfCIxq2jIIALIz1SEvkhVhwMvjOwq9R/5LZZT/zkz32CIjzN
         881VMumvCKr12N3Ee+erHnRc9y4s6yjmauYizB8OcYOHU/9FyiUsv1l6FpMWWnDgwTeQ
         GZuA2vQAtqG7vgWOTVZGLYn1FGvM7mM5dIrCnTOd//+hRhbMSfSEKAwgWDY5YTK/nm+c
         Ao0x8idHAZiM9pCgAJ+vvxOSbbw80OkXvkkLjrRGQ9nPTPj84ACbVv9Zp4wMHU/chORs
         WId+R0Akt3nCFdWa1AcwLdaQCAtWX5G9vafKKMg2pw0T4Wz3YYpTqB2a6YC4MnpZSuiI
         yFeA==
X-Gm-Message-State: APjAAAUIwgz7fgpCKZ7+pmqRXlbGSwCDt1DYBfYkvUR7i18LPFA8ATdw
        XFzF1VvoxbJ6sq+Zs59zK2Q=
X-Google-Smtp-Source: APXvYqxSouUWWJPCb6xj5BYUok7eIdvfja0nsQs3U+G601kQp1uLBVV0wPGeasTrI3bdLB/yQl8DaQ==
X-Received: by 2002:a62:65c1:: with SMTP id z184mr125482542pfb.130.1559047024583;
        Tue, 28 May 2019 05:37:04 -0700 (PDT)
Received: from xy-data.openstacklocal (ecs-159-138-22-150.compute.hwclouds-dns.com. [159.138.22.150])
        by smtp.gmail.com with ESMTPSA id o7sm18796067pfp.168.2019.05.28.05.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 May 2019 05:37:04 -0700 (PDT)
From:   Young Xiao <92siuyang@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Young Xiao <92siuyang@gmail.com>
Subject: [PATCH] cx231xx-dvb: fix memory leak in dvb_fini()
Date:   Tue, 28 May 2019 20:38:13 +0800
Message-Id: <1559047093-24235-1-git-send-email-92siuyang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dvb_init(), dev->dvb is allocated by kzalloc.
Therefore, it must be freed being set to NULL.

Signed-off-by: Young Xiao <92siuyang@gmail.com>
---
 drivers/media/usb/cx231xx/cx231xx-dvb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/usb/cx231xx/cx231xx-dvb.c b/drivers/media/usb/cx231xx/cx231xx-dvb.c
index 89357cb..89839c7 100644
--- a/drivers/media/usb/cx231xx/cx231xx-dvb.c
+++ b/drivers/media/usb/cx231xx/cx231xx-dvb.c
@@ -1159,6 +1159,7 @@ static int dvb_fini(struct cx231xx *dev)
 
 	if (dev->dvb) {
 		unregister_dvb(dev->dvb);
+		kfree(dev->dvb);
 		dev->dvb = NULL;
 	}
 
-- 
2.7.4

