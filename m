Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE64C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5415C2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nW+VsH4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfDZSgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:36:42 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37010 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfDZSgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:36:41 -0400
Received: by mail-it1-f193.google.com with SMTP id u65so7301924itc.2;
        Fri, 26 Apr 2019 11:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=85fnnK5bfiR5WN6DW7WAGB8ZeLpOtCa3pDezC5i13RY=;
        b=nW+VsH4Rx+BWGCjMa2TX+NMRPc+3B388r3nUiR0AxBFSND8TZZ65sbIhRPL7BhdyOI
         EtB2ahEfSCdWDN/Mo1bYnDjh2I1UHOLCp+5mUwQWaFypvWuyLRq5JBaUSH01XvRRsgoK
         EdAxWtlB9Av8iNPs74WTecPQo7DSgHieu2sSbn3y8r4BHzpeduzHCTL4zJNevK+JmOzB
         2vv4FsvXaCT24cc9usOQRzFZcesj/ztKAZpDocP3SdQIj2B9sweKfH2O890UAK3lQ8+X
         oyIiSkHFDyQr0kNDQRKf5ohIbizp5vD/IHX393cLmwu8fkjwDkVvL8Bfn2IEdoCL5CcT
         /UUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=85fnnK5bfiR5WN6DW7WAGB8ZeLpOtCa3pDezC5i13RY=;
        b=mp90LNmlZUmOLHnJ7Syp8LDp0HUTBKUrtxcwzXJhfbkt4U+/QXQYExlijOST3tDwFA
         URlcokJ74KAzL1gI0MS9jL/ub9Hj/93AuMEqdI2dcMHhHb71B4e6a7vRKLhwsXkw2NxM
         HNKKVjCaKPJADNZG9NUkPlHs9DeVCt7wwyLuA1rY55FOGsWrl7FW7WSfENpCdJy+qb8X
         wmizv5aVqDZTtYwzI6DsB8MMB2vQnOdI+MhUFJQljngj7MQCZ5POew0iLDrOArc++Tx1
         wYCyjUYHfbbl7HAGZPs1YnzEAb+ogd0l85/jCtiswb3pEf50vbCePDOv6LZ5BDskuFiZ
         GZgw==
X-Gm-Message-State: APjAAAVexZgr7Ini03nqDfRIAldclsHPb8cEeIddZG80FXABRiJE7WcL
        BfJbOzCD1WuMr6n/pMvTOIGLZlBX
X-Google-Smtp-Source: APXvYqxRlszLrM7w6C1HA/XQstwsI4abUrQXlOfHsStD7kdhiAonH3C9o3O7JGuM70SJWOtd8MHPLQ==
X-Received: by 2002:a05:660c:586:: with SMTP id g6mr10748992itk.116.1556303801091;
        Fri, 26 Apr 2019 11:36:41 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id d143sm12730961itd.44.2019.04.26.11.36.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 11:36:40 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: 88pm860x: prevent use-after-free on device remove
Date:   Fri, 26 Apr 2019 14:36:35 -0400
Message-Id: <20190426183635.9477-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device's remove() attempts to shut down the delayed_work scheduled
on the kernel-global workqueue by calling flush_scheduled_work().

Unfortunately, flush_scheduled_work() does not prevent the delayed_work
from re-scheduling itself. The delayed_work might run after the device
has been removed, and touch the already de-allocated info structure.
This is a potential use-after-free.

Fix by calling cancel_delayed_work_sync() during remove(): this ensures
that the delayed work is properly cancelled, is no longer running, and
is not able to re-schedule itself.

This issue was detected with the help of Coccinelle.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/rtc/rtc-88pm860x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-88pm860x.c b/drivers/rtc/rtc-88pm860x.c
index d25282b4a7dd..73697e4b18a9 100644
--- a/drivers/rtc/rtc-88pm860x.c
+++ b/drivers/rtc/rtc-88pm860x.c
@@ -421,7 +421,7 @@ static int pm860x_rtc_remove(struct platform_device *pdev)
 	struct pm860x_rtc_info *info = platform_get_drvdata(pdev);
 
 #ifdef VRTC_CALIBRATION
-	flush_scheduled_work();
+	cancel_delayed_work_sync(&info->calib_work);
 	/* disable measurement */
 	pm860x_set_bits(info->i2c, PM8607_MEAS_EN2, MEAS2_VRTC, 0);
 #endif	/* VRTC_CALIBRATION */
-- 
2.17.1

