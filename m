Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9852C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D9920656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jdg/UCsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbfFTJRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 05:17:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34830 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfFTJRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 05:17:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id s27so1271067pgl.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 02:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H/N0qHE94BgVcSxh7Y7ddjnVY+VEqSIyYgrIMxgshDU=;
        b=Jdg/UCsKPmIjRfaapYt1gOM5GjjcSZvHtz8ONkgpvHrAWlb9vbnRJMNl4MW4FbYtEw
         8+YR65T2T2ap5Lwq5+sMJuahof/pFY9ZKkJuf2gUBIelzu163GN+7HW0H+Ku4aKkWBPN
         ITlXlxJGNrnau/yhcjNck0/pYz21gwLdhwooI29uqWwrbEgFPJe2wKt024dcE+KG+Vp+
         zf//1oOezxAGYjrucQmfBYcsUrUDteM5Mwu5XAcx8yY/eRJfguZs2eY1rj5MQEHgax5R
         RoxM3lbwpH2LrteXty6Tn/Mx5Gh42sZZi/AojBszBTgqvPti6KKt4QFtG1yVDu7GmCB1
         0krQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=H/N0qHE94BgVcSxh7Y7ddjnVY+VEqSIyYgrIMxgshDU=;
        b=hWlXRz9I6Mi88WTzn7JSX8H6K2MtBuPlVkXhn5l5JwBNcj3Yv/hna/zK/9Td+4xnLa
         4BDf63ZMDyn2bvmcGW4Qm/uNb1SP1hGbcxTKMdmpcVP5J4kUxxOXFtVQDlL+pQuJsyCl
         7AmuYTKxG8p/8oKdezsOf/DMjSdcvDrGkr7LVyYj0XvC2xXbzLfitPi2JVvwaJE9wDO7
         W9ZGIv+ay7Ai3RlsUUIQduj0gLNBxWTWfE9ifVxrPlyfExlXUQ7VFmOQYLMJgUN/KjYI
         3M4Xq8omRf+oybEf+sFgudYeMp0cjHCA5Q89dQepfKQNkDJ6R05+ZbXz/HoCv4wpGwXC
         nWBw==
X-Gm-Message-State: APjAAAW8bNS+3xPKJJA7SBs9rkQr1oMsNUBDsmNPN0dc+wF9R8VAVU/Y
        sSdiGf3hsfJ6fRXEvdNLNzs=
X-Google-Smtp-Source: APXvYqyjRU2XOSFHLaSw2NHSfqeinOcL6lcfQZPbUgKSsSNdlUUmXuhILPthF8TjGwD0ko3/VxzC9w==
X-Received: by 2002:a17:90a:e38f:: with SMTP id b15mr2075612pjz.85.1561022266727;
        Thu, 20 Jun 2019 02:17:46 -0700 (PDT)
Received: from voyager.ibm.com ([36.255.48.244])
        by smtp.gmail.com with ESMTPSA id j64sm32324138pfb.126.2019.06.20.02.17.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 02:17:46 -0700 (PDT)
From:   Joel Stanley <joel@jms.id.au>
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: aspeed: lpc-ctrl: Fix probe error handling
Date:   Thu, 20 Jun 2019 18:47:38 +0930
Message-Id: <20190620091738.14683-1-joel@jms.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc warns that a mising "flash" phandle node leads to undefined
behavior later:

drivers/soc/aspeed/aspeed-lpc-ctrl.c: In function 'aspeed_lpc_ctrl_probe':
drivers/soc/aspeed/aspeed-lpc-ctrl.c:201:18: error: '*((void *)&resm+8)' may be used uninitialized in this function [-Werror=maybe-uninitialized]

Only set the flash base and size if we find a phandle in the device
tree.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/soc/aspeed/aspeed-lpc-ctrl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-ctrl.c b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
index aca13779764a..eee26c2d8b52 100644
--- a/drivers/soc/aspeed/aspeed-lpc-ctrl.c
+++ b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
@@ -223,10 +223,11 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
 			dev_err(dev, "Couldn't address to resource for flash\n");
 			return rc;
 		}
+
+		lpc_ctrl->pnor_size = resource_size(&resm);
+		lpc_ctrl->pnor_base = resm.start;
 	}
 
-	lpc_ctrl->pnor_size = resource_size(&resm);
-	lpc_ctrl->pnor_base = resm.start;
 
 	dev_set_drvdata(&pdev->dev, lpc_ctrl);
 
-- 
2.20.1

