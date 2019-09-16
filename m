Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3AEC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338BE206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nmAL6ZHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfIPSMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 14:12:48 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39031 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729750AbfIPSMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 14:12:48 -0400
Received: by mail-io1-f66.google.com with SMTP id a1so1238611ioc.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 11:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N+PGY/OYnqAAb1/FHqUnx7n0Mo3lWfpgw5A8ZrHtWr4=;
        b=nmAL6ZHFAGaEG+Ah6SB9aapmquoRG60kXOcXblBjrlnFg0WHJWsswPgndye8cwHWGD
         6xi6NFHjRPyMUkJ7Dsm0S8fx1h3MT8sP0Ik4Ja3vATA6JxDojlnNSUFp7k1HBDREZdvN
         2LaKaZb9kLcXlfukzQpwUYxvWar/qBQ3azbSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N+PGY/OYnqAAb1/FHqUnx7n0Mo3lWfpgw5A8ZrHtWr4=;
        b=mlnUqGglJnioS1+imzYjUQ2d26rlZLokBK2DkDGHwTSkm0v1CM/WDgj8sjhrvHDUr2
         CJDBEQn2jQezC7JSa0/hdFKTRRgDEOrUCRoP2Rn/FTE8ddpvGfW7A90+m2YaQ/CxjrQX
         Mkjuo00S4pPOCQ3/yTjb9hfX0fFr8lUgZ868cK5TRZiAGZG+DB0mZNTN2OWesHn0QAHc
         U/0LJ/iZggFlU+jmVbKtEuSWZtBHBUM4F1jOLL1PBDWtB3PgF9HJZwKN5/Ci9OIVwu97
         pdwuhjneQlpL7Yh38xGrIC5sNK4gVgsTzk/XfyAurA6gyNJwzB4sEOzz2SmHr4am9AgP
         w7dg==
X-Gm-Message-State: APjAAAVt5Yh8KcGEudgMEqefhgnVsGMBbDhLAcJjWu1gSV0Prrrv7NgN
        igT0722RJ16t8jeufyuDpIBi2w==
X-Google-Smtp-Source: APXvYqyM5rJURp2zNjktmEjiyFqnor/SDwNY3MqemTBs1O2L7/odDz3Z01cIpfiSr73Z8w1kvVLoAg==
X-Received: by 2002:a02:80d:: with SMTP id 13mr1383668jac.50.1568657567299;
        Mon, 16 Sep 2019 11:12:47 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:cb43:2cd4:65f5:5c84])
        by smtp.gmail.com with ESMTPSA id t9sm10889188iop.86.2019.09.16.11.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Sep 2019 11:12:46 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     bleung@chromium.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     enric.balletbo@collabora.com, linux-kernel@vger.kernel.org,
        dlaurie@chromium.org, Nick Crews <ncrews@chromium.org>
Subject: [PATCH v2 1/2] rtc: wilco-ec: Remove yday and wday calculations
Date:   Mon, 16 Sep 2019 12:12:15 -0600
Message-Id: <20190916181215.501-1-ncrews@chromium.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tm_yday and tm_wday fields are not used by userspace,
so since they aren't needed within the driver, don't
bother calculating them. This is especially needed since
the rtc_year_days() call was crashing if the HW returned
an invalid time.

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 drivers/rtc/rtc-wilco-ec.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/rtc/rtc-wilco-ec.c b/drivers/rtc/rtc-wilco-ec.c
index 8ad4c4e6d557..e84faa268caf 100644
--- a/drivers/rtc/rtc-wilco-ec.c
+++ b/drivers/rtc/rtc-wilco-ec.c
@@ -110,10 +110,6 @@ static int wilco_ec_rtc_read(struct device *dev, struct rtc_time *tm)
 	tm->tm_mday	= rtc.day;
 	tm->tm_mon	= rtc.month - 1;
 	tm->tm_year	= rtc.year + (rtc.century * 100) - 1900;
-	tm->tm_yday	= rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
-
-	/* Don't compute day of week, we don't need it. */
-	tm->tm_wday = -1;
 
 	return 0;
 }
-- 
2.21.0

