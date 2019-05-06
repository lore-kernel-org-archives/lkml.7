Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDB4C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416B22053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153919;
	bh=xNJS3Z9UgUqOenpoe5QyhRpsXLh5282+tmmL3AgQYPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G0/RFE8OMYsLLJE0Kh1alacngqfOvRTYs2EcvRHQQiMMH+qHrjlmm0TBmzg2Y0hTh
	 0mwE5g17839QEXP3g6SnnDilos1Ij72NGnhaNna8DTnO2S7OJTFrPqLETF3mz5T9Or
	 e4y7KAaSxDXOSt4rksMxKe4MirLuw6UdjNYmD+dw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfEFOpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:45:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728920AbfEFOpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:45:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D934B2087F;
        Mon,  6 May 2019 14:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153915;
        bh=xNJS3Z9UgUqOenpoe5QyhRpsXLh5282+tmmL3AgQYPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KCCjt+JRRStYYXM6dbNyWF6kuoPvTHU7yRhPqjOo4SmA3JXGwJsNRnjzlQDScY5v0
         INnmowW0t1sy0ZmSQquRZlB0qVnmsTp+lv8HMMsQ5clyF5lh+ULahOPNV8RpE5C+W3
         oHqDZl9ZTHTEdRk/oOEJv39tg7jHbpcUDNiKNGoE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 42/75] rtc: da9063: set uie_unsupported when relevant
Date:   Mon,  6 May 2019 16:32:50 +0200
Message-Id: <20190506143057.019504365@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143053.287515952@linuxfoundation.org>
References: <20190506143053.287515952@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 882c5e552ffd06856de42261460f46e18319d259 ]

The DA9063AD doesn't support alarms on any seconds and its granularity is
the minute. Set uie_unsupported in that case.

Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-da9063.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/rtc/rtc-da9063.c b/drivers/rtc/rtc-da9063.c
index f85cae240f12..7e92e491c2e7 100644
--- a/drivers/rtc/rtc-da9063.c
+++ b/drivers/rtc/rtc-da9063.c
@@ -480,6 +480,13 @@ static int da9063_rtc_probe(struct platform_device *pdev)
 	da9063_data_to_tm(data, &rtc->alarm_time, rtc);
 	rtc->rtc_sync = false;
 
+	/*
+	 * TODO: some models have alarms on a minute boundary but still support
+	 * real hardware interrupts. Add this once the core supports it.
+	 */
+	if (config->rtc_data_start != RTC_SEC)
+		rtc->rtc_dev->uie_unsupported = 1;
+
 	irq_alarm = platform_get_irq_byname(pdev, "ALARM");
 	ret = devm_request_threaded_irq(&pdev->dev, irq_alarm, NULL,
 					da9063_alarm_event,
-- 
2.20.1



