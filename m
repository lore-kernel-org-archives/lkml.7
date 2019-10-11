Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E499BC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 19:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A8E2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 19:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REQ9n4XT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbfJKTAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 15:00:14 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40009 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728603AbfJKTAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 15:00:14 -0400
Received: by mail-ot1-f67.google.com with SMTP id y39so8858492ota.7;
        Fri, 11 Oct 2019 12:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XVzDAbcWZXdsDHTskHlN8zvp0OFOMZiiZvVTqyfK5oQ=;
        b=REQ9n4XT5uYJfOAt1+orGDMyhg6WGHfDuJEeLvDDO4/MDCtIqfiE5UKnIbXTkSUIdo
         wTDvve84sMTKhuPtVZIVJF6cPXzRQB36Wbcf4w90zEsN57NoO7CjmH1S7wcREdGz1BlV
         GmCUGScx8p0Da3hcjC+Hempl1kr+Q6DjJ7TC2HOX20FMVHqe7zCjqpOI3HK6JXB/FTp1
         pjEIdCJ8apXKars5B1BRIvZCqOT6bSvcov7k9JTtKuGS7wNzygFKR4ppaOo2BALgYYYC
         aIZf3KZ6MJxQEvO1HUPxl+L7ZxYoy2BgduTWbr/oVb5PfEyUvGE8xnAqXAc79Wpp+PZ2
         b0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XVzDAbcWZXdsDHTskHlN8zvp0OFOMZiiZvVTqyfK5oQ=;
        b=VSf96EROhCy6br2wmM1gMiP6Vx65xt5ycGEdeqteQUWHuAZ0DNb9K0xr9GKRPOuXd4
         JUO48boIj/yjn5DmFYA9AqAp2qlQCRla8y/27inYubulrf0/zJch94Wra56Eyz1/dPii
         F4uHV0t+a5k+yWR/E+UCxXWISlb4p3YHg0QM1Mu1/dd2FfaomRhMzktd+YYDam1QR5gG
         VirgQJD88TVp+C+/sv8/GroTajc7Ht9+X1fIgC6Tvq74hCpaU32ncc+JiyLpXnBPvIYE
         9oMFOBlX3I6lpcXo8oftweVHgkReemyTOqVKLXJg0blwA6591DuBTdJgI6XavsjTNvvv
         rc5A==
X-Gm-Message-State: APjAAAVOr2yGsnW9okK2b6VruuNMzp2h9jtdCGq4OZib136aw/jfFFXs
        oFnX/t7mLQiJeNwVlx+eSL8=
X-Google-Smtp-Source: APXvYqxS4oNRrteuzDW9YVSqdV0G2YAQXYVv2QQCjhlTgH68PPgJwN8VSyesKZWAz5+MV66mdeQ9iA==
X-Received: by 2002:a9d:67d7:: with SMTP id c23mr14470404otn.0.1570820413034;
        Fri, 11 Oct 2019 12:00:13 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id 67sm3037688otq.34.2019.10.11.12.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 12:00:12 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] USB: host: ohci-at91: Remove unused variable regs in at91_stop_hc
Date:   Fri, 11 Oct 2019 11:59:50 -0700
Message-Id: <20191011185950.1470-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/usb/host/ohci-at91.c:118:28: warning: unused variable 'regs'
[-Wunused-variable]
        struct ohci_regs __iomem *regs = hcd->regs;
                                  ^
1 warning generated.

Fixes: 9c4567fa0a44 ("USB: host: ohci-at91: completely shutdown the controller in at91_stop_hc()")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/usb/host/ohci-at91.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 513e48397743..b635c6a1b1a9 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -115,7 +115,6 @@ static void at91_start_hc(struct platform_device *pdev)
 static void at91_stop_hc(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
-	struct ohci_regs __iomem *regs = hcd->regs;
 	struct ohci_at91_priv *ohci_at91 = hcd_to_ohci_at91_priv(hcd);
 
 	dev_dbg(&pdev->dev, "stop\n");
-- 
2.23.0

