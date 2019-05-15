Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7353C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850BA20657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="SlWMkZO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbfEOMA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:00:26 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46178 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbfEOLOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:14:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id h21so2095439ljk.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 04:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JZxB086EqwggOhFxHexHkttok94oso/OJUjNF3aMwEw=;
        b=SlWMkZO0NyRYv7qICWGSh++5Zi8+7R3oKxXcZ9+KhhZYU250CR11qNBwz+rXDAuT6C
         Xqu672PFvC2GjahgiNoNuW+NQAwUkaUTgGxzrlrecppsg7v28PIxURdyOha350W1tksj
         zKE1GmGYlXMObrHbnO30DZmUh7BaDiLjkOG3X5UWf69H30F/JLN0wdHtBgUdBXZmwln8
         Uz+Mab6mr7ZAbsBtc26f6leQ04LYBFoERfXP59q4K+v/msGokMRFwTAXxd3ZpX4+5byX
         gwKrcrnZthl7A/VN02W/Vg+0tQd/xsUh5qkvLvU7bhS5U7nLl1SwcTuT9vnG2j+yvgGE
         7ueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JZxB086EqwggOhFxHexHkttok94oso/OJUjNF3aMwEw=;
        b=W+jNvZyJvkreqsHDuL0M8ZIXbwfHBPROmOjcYsEiYCXPIiSyJqSG229RF60isEbVJL
         1V/7znkuBDfgTneCisnNH7whSwcePD/r1XGGn6PmeWY3SpGY+OOY3LmiYhVHeTju/yXr
         IrR1r9MS+V3KG48AxO1/kmZ9CMz07IyqHIF2yGFA/93KLSILWJkvvNkD0hM9t0ACWnlZ
         CKa+6cLbo1mcfK1sfl55Y6TU6Mt3cAgyPJ0FjrvgG+9IiY3RR6F47AB5KxAlW8NXH0nX
         hhmFxNSq/CviSdrlOeC/zRpNHBLG04tOk3KUQzFqynRdI/22ImlQ62ROKfR7DIxmstTr
         Bx8Q==
X-Gm-Message-State: APjAAAX1T1kfHuG9aQEpdzQGyirnUdA3KbarhOD2BrenUayi67I680cI
        /YjarzHaH2Gkbm7B7eOy3JK14w==
X-Google-Smtp-Source: APXvYqzsq1cLndnKfy+6j5tMGL0/yPrXCABoyJowsorG4ompSJaSfGcWbabzviCRJp1SQmcaFCE9Zw==
X-Received: by 2002:a2e:85c9:: with SMTP id h9mr7217175ljj.110.1557918885495;
        Wed, 15 May 2019 04:14:45 -0700 (PDT)
Received: from roman-VirtualBox.synapse.com ([195.238.92.107])
        by smtp.gmail.com with ESMTPSA id q26sm376027lfd.54.2019.05.15.04.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 04:14:44 -0700 (PDT)
From:   roman.stratiienko@globallogic.com
To:     a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Roman Stratiienko <roman.stratiienko@globallogic.com>
Subject: [PATCH] rtc: test: enable wakeup flags
Date:   Wed, 15 May 2019 14:14:36 +0300
Message-Id: <20190515111436.14513-1-roman.stratiienko@globallogic.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

Alarmtimer interface uses only the RTC with wekeup flags enabled.
Allow to use rtc-test driver with alarmtimer interface.

Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
---
 drivers/rtc/rtc-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-test.c b/drivers/rtc/rtc-test.c
index 6c5f09c815e8..c839ae575c77 100644
--- a/drivers/rtc/rtc-test.c
+++ b/drivers/rtc/rtc-test.c
@@ -123,6 +123,8 @@ static int test_probe(struct platform_device *plat_dev)
 
 	platform_set_drvdata(plat_dev, rtd);
 
+	device_init_wakeup(&plat_dev->dev, 1);
+
 	rtd->rtc = devm_rtc_allocate_device(&plat_dev->dev);
 	if (IS_ERR(rtd->rtc))
 		return PTR_ERR(rtd->rtc);
-- 
2.17.1

