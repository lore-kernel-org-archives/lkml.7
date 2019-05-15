Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13264C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D900B20843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWZQTkhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfEONPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 09:15:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36100 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfEONPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 09:15:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id v80so1367256pfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 06:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AyFACiWTp3aKjfUBwEnUu0WG1DOJlwF3PCOsQcuUqWA=;
        b=YWZQTkhWIqwZYS3NJiPxmflNVTDKBAgSM0ZG2CbE+UQZOeSt7jhlAR+znBPfjI6QmS
         wUlxiaK6skwmXDz5Rbv2RtDx+j5lyAZObR6S0CbC4T6h4baeF3fBEhRAReZUSpr1f2fI
         inYxaMfEBy8eAykUr2JXl78hAlpmvrYIvaTlVim3BzD3lR1WiyHT7Srf/q6HtIwnniJq
         TupTXlCE9dWa6PjctkfkPMQmfzj0WmekOEdOH7MUn3UVF/FUld/+AdVMVKySXOfx/vjx
         ErPmqVC9cSaI/2Nuq+05G+e7yXMKEdXh3p3mH04X3HT/BlE3R/rVKqSV4J5uChX94vlp
         hAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AyFACiWTp3aKjfUBwEnUu0WG1DOJlwF3PCOsQcuUqWA=;
        b=kQoXw2pV5LNX5u3fXMQqHywrSKYSD0ntvZ+YyocHhJ/mFLeb4a5zbOAqUTDsK9oCm1
         +FynrgPYssEblgtBuQ+uJVWyzhXp2dbpTLCzOwiVdLfXrKVDSyENdFk+piw7tTD9l26s
         EFCEeHFjJ++LEDuHG/jpEiN168fe2xaEgToUl6Ql/ubGnGidQps9BFiVzppy5JlR3MQ0
         p5Y4fRIh1/gv09BOD6ZeNZH57vicVFVYMQrYmiCO+cxXJ3iV7ICV5d8/5zqldp3VTjSM
         g7BzJw7q+ThSjVf4D3icT8gSsrTWucjrtkA6loTDes6vS8tDTcToDRQlM3YXCwG7ayvQ
         r7qA==
X-Gm-Message-State: APjAAAWInE8RFLOtJnlvP6//fckvUpxk2ZvqxHmky7HVHkJOajPOkZS4
        uW9M8j/pFzvNE1gQ/EuLoX0=
X-Google-Smtp-Source: APXvYqxmvof4fRRspg+ye1j0yVT94uaBDV/MGhX/xl4UG5qV7M2rzl3aePo6tL8fewaGSrtdb8PWDg==
X-Received: by 2002:a63:318b:: with SMTP id x133mr44446918pgx.297.1557926131728;
        Wed, 15 May 2019 06:15:31 -0700 (PDT)
Received: from hydra-Latitude-E5440.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id k26sm2687147pfi.136.2019.05.15.06.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 06:15:30 -0700 (PDT)
From:   parna.naveenkumar@gmail.com
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Naveen Kumar Parna <parna.naveenkumar@gmail.com>
Subject: [PATCH] bsr: do not use assignment in if condition
Date:   Wed, 15 May 2019 18:45:24 +0530
Message-Id: <20190515131524.26679-1-parna.naveenkumar@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naveen Kumar Parna <parna.naveenkumar@gmail.com>

checkpatch.pl does not like assignment in if condition

Signed-off-by: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
---
 drivers/char/bsr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/bsr.c b/drivers/char/bsr.c
index a6cef548e01e..2b00748b83d2 100644
--- a/drivers/char/bsr.c
+++ b/drivers/char/bsr.c
@@ -322,7 +322,8 @@ static int __init bsr_init(void)
 		goto out_err_2;
 	}
 
-	if ((ret = bsr_create_devs(np)) < 0) {
+	ret = bsr_create_devs(np);
+	if (ret  < 0) {
 		np = NULL;
 		goto out_err_3;
 	}
-- 
2.17.1

