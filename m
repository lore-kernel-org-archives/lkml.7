Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963E5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D5A21874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMPXkd3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfCTTlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:41:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45428 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfCTTlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:41:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id v21so2630776pfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 12:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xlLl8gmcuOtT9vVEDhg/ZjHl4iM4TINg5K1uW0u+uKU=;
        b=AMPXkd3GUe2uTKsLqPue0HvJKi7ozu9soFysxix6mvBSmefBnrra7IrYq/S8kizaFI
         WFVCr9Ak+3NxuOlRVzdQfkQSw/nE8zL/GsYNlmStWVSpRJUYZpUQSezw55Daj2i3nmlc
         4Z9SN+ds0MQsmjyNW3KpROldy6LtzUOeuuJF0CdTId04QloqqOqVaPTyaLAMM+EOmlNv
         PaOaPCWGW/Zt4S8Jycn3U4yuQaRAW/toddAO37znMLbQ3LWv3ae6rIVCB9anzA0MBQrx
         +Q5RD21dZ3+2Q8WMaviVYsB69djCmbl8xxmiqp6kZXkkaV9G/EvK/R5MG4WaeJ3i6qxy
         eZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xlLl8gmcuOtT9vVEDhg/ZjHl4iM4TINg5K1uW0u+uKU=;
        b=ttJlJjTpyXW1Jq6n2BAQvnXGqV3THUgKgl0P9PyMDKuPLLWVjim9iiOAK6j15k4n8x
         x3S5OB2u/pSxY8VceQkZ2rMNnOCbBILRErgqExzY+6NNYIgHgg0M3uD0S8G7yg0jXFtN
         6TNgKJhv8bfXQWOgrOpQWzSy69Nj8Wgf2wvVjrRwe3Xj3ISmop1qelmSylohu0cU6kyT
         cAzr7ksg2XOvnguMAZLtoaQdPI4tuZI5+yBZJ6vVTdhVuO2KAdVm5EAX0vDpLqOvRABP
         AYtOUI52Owb7P82Lo/XQqNy2xu1gSqsmjWvA704CBc4Akmls1bDEnyG6kueZjIynqmb5
         tRqw==
X-Gm-Message-State: APjAAAXcjPSWvVudYr9naGfyTH7uIF9QOc+WGGB6/wrpnTwGmbkcpn3I
        hACaQDIBaIlEd85Gfl6uGM0=
X-Google-Smtp-Source: APXvYqwK0A1NNQq/E4cmgxq+iudccYC6ih9D6W2xkyQMaazFTKqjgq/hJNYJs8DyFPwOxCgL9lqupQ==
X-Received: by 2002:a17:902:2f43:: with SMTP id s61mr9825129plb.158.1553110862150;
        Wed, 20 Mar 2019 12:41:02 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id b8sm4423326pfi.129.2019.03.20.12.41.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 12:41:01 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     opendmb@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] bus: brcmstb_gisb: Remove print of base address
Date:   Wed, 20 Mar 2019 12:40:56 -0700
Message-Id: <20190320194057.23946-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
pointers are being hashed when printed. Displaying the virtual memory at
bootup time is not helpful, especially given we use a dev_info() which
already displays the platform device's address.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/bus/brcmstb_gisb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index f58ff67e97ac..12e7b418ce5d 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -407,8 +407,8 @@ static int __init brcmstb_gisb_arb_probe(struct platform_device *pdev)
 					       &gisb_panic_notifier);
 	}
 
-	dev_info(&pdev->dev, "registered mem: %p, irqs: %d, %d\n",
-			gdev->base, timeout_irq, tea_irq);
+	dev_info(&pdev->dev, "registered irqs: %d, %d\n",
+		 timeout_irq, tea_irq);
 
 	return 0;
 }
-- 
2.17.1

