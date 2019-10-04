Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3A9C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB2021D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ky6yHwsm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbfJDO0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:26:18 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43005 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730803AbfJDO0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:26:17 -0400
Received: by mail-io1-f66.google.com with SMTP id n197so13879325iod.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 07:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2bQyhaQUr8TvOSgV5QjfNzwDgjUaiOuNFWU91AgXyWA=;
        b=ky6yHwsmLad6oYcifbJnyYwi8x8dg05hUkc7KgOHwOY6muINbt53lNl3IPP1KLIQNH
         g81LxwTrAToPheSYCWkHZk79aT7a+JNFLaEuyQfzX3bxw65IDLdifs/nx7xI/wEwn5sy
         5rWeH4FAzVk9mircHyal717eMoMGTEw+0ib1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2bQyhaQUr8TvOSgV5QjfNzwDgjUaiOuNFWU91AgXyWA=;
        b=mmE7ZnMTDCcFMh7CU9RUi0TcuYSOHKuk4JXon4oV+0Vm2MCTX2OTHMtozJ5pxemK7G
         eKuGE8MNvpQ3WD7QMT/U53cim5B+ArCVcWsmB4H7LyUU+DzyaLIGPOmVoSnoGyI7/Ao5
         Xk0Z8hIHghA2YTaYZRuRbTLKjLDvWiqfsSbW52Yq1dC76oljXNkHWfw/7ndE6vZQDb+q
         /OO6QHgs8gT882xCX0tDjAGucAEduCwhY0sHI7SCahNgiOt5BvkmBJ89IhHHGwM/6qPR
         NQb21G2Dpzt238dlSs2L56wHfuGB7fZp2R7EsPmuQeSrB3gl3moim2g0H5F3UvxQGh1k
         e3MA==
X-Gm-Message-State: APjAAAVaSPjga2MogVZPDTsvXS0Edu0b/XUIgL2CHRADBcHjPPpnsAkP
        aOU2hNJ9Draaw26LKgqzTGMNdw==
X-Google-Smtp-Source: APXvYqxtzAP/55XHsBk7FFZ7dGRUurYxb76/Kg8H3ULp2f/RY39bFYHe97CoJz39nk1we5lAnTIT/A==
X-Received: by 2002:a92:9198:: with SMTP id e24mr15795776ill.195.1570199176595;
        Fri, 04 Oct 2019 07:26:16 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:cb43:2cd4:65f5:5c84])
        by smtp.gmail.com with ESMTPSA id d6sm2041379iop.34.2019.10.04.07.26.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Oct 2019 07:26:15 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, enric.balletbo@collabora.com,
        bleung@chromium.org, dlaurie@chromium.org, djkurtz@chromium.org,
        dtor@google.com, campello@chromium.org,
        Nick Crews <ncrews@chromium.org>
Subject: [PATCH v4] rtc: wilco-ec: Handle reading invalid times
Date:   Fri,  4 Oct 2019 08:26:08 -0600
Message-Id: <20191004142608.170159-1-ncrews@chromium.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the RTC HW returns an invalid time, the rtc_year_days()
call would crash. This patch adds error logging in this
situation, and removes the tm_yday and tm_wday calculations.
These fields should not be relied upon by userspace
according to man rtc, and thus we don't need to calculate
them.

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 drivers/rtc/rtc-wilco-ec.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-wilco-ec.c b/drivers/rtc/rtc-wilco-ec.c
index 8ad4c4e6d557..ff46066a68a4 100644
--- a/drivers/rtc/rtc-wilco-ec.c
+++ b/drivers/rtc/rtc-wilco-ec.c
@@ -110,10 +110,12 @@ static int wilco_ec_rtc_read(struct device *dev, struct rtc_time *tm)
 	tm->tm_mday	= rtc.day;
 	tm->tm_mon	= rtc.month - 1;
 	tm->tm_year	= rtc.year + (rtc.century * 100) - 1900;
-	tm->tm_yday	= rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
+	/* Ignore other tm fields, man rtc says userspace shouldn't use them. */
 
-	/* Don't compute day of week, we don't need it. */
-	tm->tm_wday = -1;
+	if (rtc_valid_tm(tm)) {
+		dev_err(dev, "Time from RTC is invalid: %ptRr\n", tm);
+		return -EIO;
+	}
 
 	return 0;
 }
-- 
2.21.0

