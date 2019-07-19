Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4FCC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC9D21872
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1U2qPAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbfGSQ2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 12:28:19 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35577 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfGSQ2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 12:28:18 -0400
Received: by mail-lj1-f196.google.com with SMTP id x25so31388163ljh.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 09:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GiZf959HZ3A37xqXOdAxD5KnSAGfW75UgSwQJmcWv6U=;
        b=B1U2qPAtMcTl5JVYQ2Kh0zNE+RSvZudBLf1FiM8TZnHia47fblzbS3PAwaNI0TV7Cv
         Yr2gA3TTiLkaeS4IrHAT9rFB3Sfuv1mzVXKlmvkG88D6e3cTv5/yhDw4jMFz0OzZBUb3
         b4R8uD66yybX/ovmCy/re6o6FAv2JrbAoMLSgwiD852weFSq2ojtWy6qyN6Z+z7rmmIb
         Ns+cWzc7xsja4viJDIJJiU9r9U1vBLafV4+rQnxptnlj3UiRTO30nsY0NmODG4Np/X4K
         JxgYlmjKlBYj894qruQDTYJH/6dEs1vNF3UZcVUWQFLQKOgPnqf2rirmB+6EjFnlq6sN
         HfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GiZf959HZ3A37xqXOdAxD5KnSAGfW75UgSwQJmcWv6U=;
        b=TvKwJiATYShlxq4C+AaX6KkINIxwVNfyT5ZWcODl8EqgmIv01bK4BMDIcmUXpRBTsJ
         bhMAZ1+INOnHaAVapErlwS6nDjktcMzvLRmakde/QicK3PxOE2py9o+Qg6k6OPCXycp9
         axj9zrsiX/70q7XUxb4ckbGIzHq77BaFSdBkt0GCDmM9Z/Sb78t4kTWFlA3orZdcyN3l
         vLUlANaMpxWrXtD1oxkW8APCA73AJRVeXC/B6CvZGAQn2NySpl4EY/QiA0Iu9HY/t+rH
         vAieNSjlOTu5Z3+y/eocCK6s1L2S3AOoa3FVESRDUtY1MXaxEJHlq5JTt5EEHYH/tlKP
         zgtg==
X-Gm-Message-State: APjAAAV7I7JO+QWBnPJreBIGqHyllvWKxwj13BRXJeIJtBO4dyLF1dW3
        eTM5aszrKjoSrLpNU4g7Xek=
X-Google-Smtp-Source: APXvYqyyLWh5wutS8q/ShDpLnpwK+/hZS4PxsMNx1pR3GinVpJ/0QfYJDvazydyAMiLUsS4UORbifg==
X-Received: by 2002:a2e:5b94:: with SMTP id m20mr27681115lje.7.1563553696626;
        Fri, 19 Jul 2019 09:28:16 -0700 (PDT)
Received: from ul001888.eu.tieto.com ([91.198.246.10])
        by smtp.gmail.com with ESMTPSA id h78sm5826325ljf.88.2019.07.19.09.28.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 09:28:15 -0700 (PDT)
From:   Vasyl Gomonovych <gomonovych@gmail.com>
To:     myungjoo.ham@samsung.com, cw00.choi@samsung.com
Cc:     Vasyl Gomonovych <gomonovych@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] extcon: sm5502: Add IRQ_ONESHOT
Date:   Fri, 19 Jul 2019 18:28:06 +0200
Message-Id: <20190719162806.1926-1-gomonovych@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not fire irq again until thread done

Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
---
Can you please look on this from false positives point of view
---
 drivers/extcon/extcon-sm5502.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
index 98e4f616b8f1..dc43847ad2b0 100644
--- a/drivers/extcon/extcon-sm5502.c
+++ b/drivers/extcon/extcon-sm5502.c
@@ -597,7 +597,7 @@ static int sm5022_muic_i2c_probe(struct i2c_client *i2c,
 
 		ret = devm_request_threaded_irq(info->dev, virq, NULL,
 						sm5502_muic_irq_handler,
-						IRQF_NO_SUSPEND,
+						IRQF_NO_SUSPEND | IRQF_ONESHOT,
 						muic_irq->name, info);
 		if (ret) {
 			dev_err(info->dev,
-- 
2.17.1

