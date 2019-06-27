Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FBBC48BDA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F852064A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jg5+pYiH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfF0ReK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:34:10 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33507 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfF0ReJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:34:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so1680440plo.0;
        Thu, 27 Jun 2019 10:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3Q1DOtpxKXxdLlIaVV5P8yRJkk+jSj7Y5f1KvRCeIfE=;
        b=jg5+pYiHcCq27XQS48zsVfhUq56ANhhJPbeuOQfPHraYiCQEv2RGRak94LOg72w4AT
         79VuIzmcytbt+Azr+BLRMVY9DDh81N542Q1E7RMGfS9ZurgOrxEFq2PzfGqsn4qDd3L4
         Ce80DKS/azjxS1KuGNaaLcsenzMMOjfFC/S1gR2tpx+XkIPJf4g3ib181u5YAQwrs0TN
         F+91l0Um1Ok1GntG6clWgAQ8T67IW0EopRXq9CEMfey9blk8dcKx6O+sh2eFm1/XKXSy
         4u2B/idvPlds3VfRTBJLvJ58Tef6cKzvRnFchX6ML4fnNU7U4DtM+TJqCGn35deJShcL
         lpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3Q1DOtpxKXxdLlIaVV5P8yRJkk+jSj7Y5f1KvRCeIfE=;
        b=OIp5+3OzzYd4wuoCDpl+1dlEpa+ei4+XRLHedJTnABSqbsdu3zJt/WKonIon/eCEej
         Zvd1KehqnRDJZnqnQ7OYTxIc/ZAPHLYp/V1KKchgbUIzFuXoK33pidmuQgFMb0g+mVee
         b0WJW2Dz8TzBLmFWc6wTtcwwKX5PVTL7sp9kkm1g24Mo1pTzbkPicX/PvNMjXXgB4vQF
         95F8v1vwNx8eTGfe6yh2p149DgJdttrs9pRSmIndwT7FLPv2Sluvp9IvaNKXO81sv16w
         Zr/JlsLonHX7r7tvAWWHT75UbPEWi276ANn9I21mEDhzA47BYqtdM/fCOwUYasgMYm/L
         PyfA==
X-Gm-Message-State: APjAAAWRFjXSH14kFsP8VzEkIWaWPV79vErqxoEtOZS38hbL+elYhz30
        iFhD+P/VSgusQE/ZmEfAcBE=
X-Google-Smtp-Source: APXvYqyqdsATYg0k1ntVHN/E6qa3sEGiIXa2nZM+quCieZmr1Q9jOsi+pJDg1drWIrEhqxuKHMGDEw==
X-Received: by 2002:a17:902:b7c1:: with SMTP id v1mr5948505plz.85.1561656848980;
        Thu, 27 Jun 2019 10:34:08 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id 25sm3453041pfp.76.2019.06.27.10.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:34:08 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/87] ata: libahci: Remove call to memset after dmam_alloc_coherent
Date:   Fri, 28 Jun 2019 01:34:01 +0800
Message-Id: <20190627173401.1985-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dmam_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/ata/libahci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 0984c4b76d7e..e4c45d3cca79 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2365,7 +2365,6 @@ static int ahci_port_start(struct ata_port *ap)
 	mem = dmam_alloc_coherent(dev, dma_sz, &mem_dma, GFP_KERNEL);
 	if (!mem)
 		return -ENOMEM;
-	memset(mem, 0, dma_sz);
 
 	/*
 	 * First item in chunk of DMA memory: 32-slot command table,
-- 
2.11.0

