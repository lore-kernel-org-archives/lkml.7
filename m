Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE47CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542FA222CC
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tkump4dk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410146AbfJRM4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:56:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40985 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408410AbfJRM4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:56:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id p4so6151502wrm.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 05:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RI1bFjYRN5JoMtaeqs26PN1sSu7fROvvqss/8HZl7T4=;
        b=Tkump4dkVHciY3EeN1den7fHXElV+9LPol0+LGG3Z7MWtrr7yGuf5RVZ41hMkz6dL7
         pQDq79k4nyRfYaA1srfAPUUjnTfnixSxG/3HVivTenEJ1j+axHw4aH9c3ZleE1gp7cQf
         DrZWH2k2B12+nwMszZ5/5W7wHgoITM5o+D8IVlOdJrE7lFGvHcjP31AoaUprRjTU3XyB
         t7sm2PpXhN4LLXJPIYLbVz7vh7qVTByPvW24Iid7J8l6L+YZ5OEVulRWRaIcWLQVxj/Y
         yLvz2i2tfSl6U88FWJPSqnspRFwayraj9hJakM3sJQFRaBIAjORWXkWMfgOnq6qUtDqQ
         3ErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RI1bFjYRN5JoMtaeqs26PN1sSu7fROvvqss/8HZl7T4=;
        b=tpwp0YEJT8+j0FDTDIuYShLbVeOL+VUVLjoLgx/UsHahEeJpNXP9sBXOernxIHRkED
         ENH0Z6Vw6rURljO8WrMJEgIc6a8eWtQRuWxeUcLY3AzgceyEb4Qku/zT9igKgBGfeEli
         MUHavXuNARzR+GL2AL8v+A2QPMWaafsmWrxroVuI9gJ56UZIPlUxa30krgeOotdnG5Yc
         ZBJYSobqh7OVtRSEUEvOu5hSxaer0UebD1V1MvRs5a3pJV6b92/HkyfcE3ixDbAkF4+4
         7RC6e0en8/8iVrULNaiP4euHRguvcA7HUa2zAs6v3Icqkj+mrV5lcN4xe5AD7A9vL7bq
         PVMA==
X-Gm-Message-State: APjAAAUZ1WWRipBawG1h7WD9LcH6HjckrYKTbxyEojN7lRSqstHZnK/c
        X5+c4qkf4iS7Q5ZZnfZZ+hSq8Q==
X-Google-Smtp-Source: APXvYqxviqehwQj2KMJTxb29i2NMIz5kZ16QzwRcaK4PH4t57iD2gSga5z/RCWxme78LpO7Yl7arYg==
X-Received: by 2002:adf:e292:: with SMTP id v18mr7628000wri.190.1571403371768;
        Fri, 18 Oct 2019 05:56:11 -0700 (PDT)
Received: from localhost.localdomain ([95.149.164.47])
        by smtp.gmail.com with ESMTPSA id q14sm6058491wre.27.2019.10.18.05.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 05:56:11 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, linus.walleij@linaro.org,
        daniel.thompson@linaro.org, arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dilinger@queued.net, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/4] mfd: cs5535-mfd: Use PLATFORM_DEVID_* defines and tidy error message
Date:   Fri, 18 Oct 2019 13:56:05 +0100
Message-Id: <20191018125608.5362-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018125608.5362-1-lee.jones@linaro.org>
References: <20191018125608.5362-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In most contexts '-1' doesn't really mean much to the casual observer.
In almost all cases, it's better to use a human readable define.  In
this case PLATFORM_DEVID_* defines have already been provided for this
purpose.

While we're here, let's be specific about the 'MFD devices' which
failed.  It will help when trying to distinguish with of the 2 sets of
sub-devices we actually failed to register.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/cs5535-mfd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
index f1825c0ccbd0..2c47afc22d24 100644
--- a/drivers/mfd/cs5535-mfd.c
+++ b/drivers/mfd/cs5535-mfd.c
@@ -127,10 +127,11 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
 		cs5535_mfd_cells[i].id = 0;
 	}
 
-	err = mfd_add_devices(&pdev->dev, -1, cs5535_mfd_cells,
+	err = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, cs5535_mfd_cells,
 			      ARRAY_SIZE(cs5535_mfd_cells), NULL, 0, NULL);
 	if (err) {
-		dev_err(&pdev->dev, "MFD add devices failed: %d\n", err);
+		dev_err(&pdev->dev,
+			"Failed to add CS5532 sub-devices: %d\n", err);
 		goto err_disable;
 	}
 
-- 
2.17.1

