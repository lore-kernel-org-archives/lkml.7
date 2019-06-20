Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E244DC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9686A2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MA1ohhBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732156AbfFTOLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 10:11:20 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41165 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfFTOKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:10:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id s21so2838390lji.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 07:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=syCSLdZUygR2irP3Dt4dkGth8Ul25f2kR+nZnXbK8DA=;
        b=MA1ohhBK8KGIAK25zr5NT0CRUv9NEBlh+hw9VLz4EC0nPWvQDWYigbmaXAuzVWTsaQ
         Y8D2PKdtEVw2rW2VMw4SMDFC2bmz23GGSj1SrKlVXB6jdcMrpZJHMTbobvEsYMdAhQoT
         KyCr1WL9VdbM9NvxMhdcehNSFX35yeLb5VXNjLr3h5KK4kiT4RXCWnM2sTPCUx5l7vIA
         CF2Q1Zm5Ex4xbDotcvEJF5fyQV0S6isPhQgT/9GpAy2VFYPzOPJCp9VKthme7f3r5tYA
         7ZklfbpWgk7SOMPFUSA6br7/04OdplaedEE44//W5sggb5ZN2wPrMla5wj2s8KcGyx/O
         +LKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=syCSLdZUygR2irP3Dt4dkGth8Ul25f2kR+nZnXbK8DA=;
        b=iwQtCZEFRraJM4UiUs03RSHmP0tuLiiGmVjChO8i1w9r/H9j/uuPIZwC/P/BWWBdx1
         66BEnJ53A1Q46qdZBLPXUXLb00dGUKSg7fKJCM6IKPcRF+YYLzOm+0c9PX1ITwnGjgha
         ZR9QBQqs6/Ntqs02BNwqq1o844AI/Z/7Pslz4r1jy96Ry5cyEyCa6/EzNfh3n+aOzWW2
         iAhSNDGcQK9I7PYqRsM3dY5CPaxPy60JFb/uI7a6YAKJ5bl3CS9AiCbeD2idX9x58TOk
         VkB/TRwsvYl6cxc1z6pKuOCltcTR3cjgb7KDh3Dju/Ol++4Kk/9FJp6sDpZs7qvBLFSq
         4aKw==
X-Gm-Message-State: APjAAAXuGvJydlhk2t4es6eMhixcYyamZTfroERsxDSx02dsZbLnLhM1
        8nQyooZ41PS6lt8qErjgR2xuzU3c
X-Google-Smtp-Source: APXvYqzFGPs9ARb3IIZdxMHjSqtrguFuU75cNN2pDvTqdfKXt4gsO0aJL6Q1Fwg0VDeT1rXXxPVh8g==
X-Received: by 2002:a2e:5dc4:: with SMTP id v65mr60740590lje.138.1561039852768;
        Thu, 20 Jun 2019 07:10:52 -0700 (PDT)
Received: from localhost.localdomain (v902-804.aalto.fi. [130.233.11.55])
        by smtp.gmail.com with ESMTPSA id 27sm3524684ljw.97.2019.06.20.07.10.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 07:10:52 -0700 (PDT)
From:   Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 3/7] rslib: decode_rs: Fix length parameter check
Date:   Thu, 20 Jun 2019 17:10:35 +0300
Message-Id: <20190620141039.9874-4-ferdinand.blomqvist@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190620141039.9874-1-ferdinand.blomqvist@gmail.com>
References: <20190620141039.9874-1-ferdinand.blomqvist@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The length of the data load must be at least one. Or in other words,
there must be room for at least 1 data and nroots parity symbols after
shortening the RS code.

Signed-off-by: Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
---
 lib/reed_solomon/decode_rs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/reed_solomon/decode_rs.c b/lib/reed_solomon/decode_rs.c
index 3313bf944ff1..22006eaa41e6 100644
--- a/lib/reed_solomon/decode_rs.c
+++ b/lib/reed_solomon/decode_rs.c
@@ -39,7 +39,7 @@
 
 	/* Check length parameter for validity */
 	pad = nn - nroots - len;
-	BUG_ON(pad < 0 || pad >= nn);
+	BUG_ON(pad < 0 || pad >= nn - nroots);
 
 	/* Does the caller provide the syndrome ? */
 	if (s != NULL)
-- 
2.17.2

