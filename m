Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27506C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF14120881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="iPhqIpdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfEOOUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 10:20:40 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44377 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfEOOUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 10:20:40 -0400
Received: by mail-lj1-f196.google.com with SMTP id e13so2661897ljl.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 07:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=YMwQpxiUwj2cT4FqUrUHXV80PQdmZFxXDMY3ylf0go4=;
        b=iPhqIpdqqX9dUqy4uUKArSPUkyXqjPd1GOQr/5AaYIOa4vMVTRPhiV4Jm1OEc5JW9K
         FmUr9U2FuzrTf4oXQbcSlXq+gvWbserHTyxMjTdR6G5y597mnGg9mkczEw12ekmtbnm7
         MG0QsErF1v8fNuPIEpD5Nl/NyFz7m3kHa1M9aLlsFmq6+rBlfy9+HiqVFi0/I6RcPxMC
         7N85aASBxWA79/QdZZQZ4W5CfBxOyyDliMPgJMo+kGEeFLBosxpVoX8uyJ21m6zA5oKf
         f1cW6vVQRPSzwfTgFQiDi/M735jTbDrJ70TjUBWtRES5+9jmG7N1ntJor8aji8txkna9
         zXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YMwQpxiUwj2cT4FqUrUHXV80PQdmZFxXDMY3ylf0go4=;
        b=A47WJ3oThIAXyvW8O/0ZNtlZdp9u3msymDLTWeryR6xpeAYxdV02SfXC8yhFO9e1mY
         jciZr7vO7jHwKO5BfNoeIxRE6iqUk1apcK86xr0rBqky03SVc526aSlkorVZWYnVgXL7
         CVG0l5JwwoWKutpgLAxTtnxq7wvYyfLMVt2sI0y6Zdn0Tpae8W17ihJbEqJSm6aBqL0h
         0CK/kfBVTnN7XtQNIgHKGGeo7ca4xgUMEmrjO/5nAjhVO8125iXrUmaP6XGQYXZ3VIor
         5uHSOvtgpUlX+EzcawBh9DJSVNw7NzMcY8lNrypl/wh+5nu14e4Ffio90EWRZCGLm8m1
         Rr1Q==
X-Gm-Message-State: APjAAAVi1mBrw2vR9LNamaaiMt09SLipzfE+xwa8RzwfHMz34IMWAeD5
        sAbC2KU45ixxU8THOiTQhGtL9g==
X-Google-Smtp-Source: APXvYqxLD/Xz/XOt80cJ7YXHPOP+mYypFxg9knaqEMHMXEygAeuW2r8l1jyoq+xHXe44xruKXkwNkA==
X-Received: by 2002:a2e:9142:: with SMTP id q2mr1086173ljg.18.1557930038264;
        Wed, 15 May 2019 07:20:38 -0700 (PDT)
Received: from roman-VirtualBox.synapse.com ([195.238.92.107])
        by smtp.gmail.com with ESMTPSA id h11sm414592lfh.8.2019.05.15.07.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 07:20:37 -0700 (PDT)
From:   roman.stratiienko@globallogic.com
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Roman Stratiienko <roman.stratiienko@globallogic.com>
Subject: [PATCH v2] rtc: test: enable wakeup flags
Date:   Wed, 15 May 2019 17:20:22 +0300
Message-Id: <20190515142022.15019-1-roman.stratiienko@globallogic.com>
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
Changes in v2:

Wakeup flags applied only for the RTCs with alarm support

 drivers/rtc/rtc-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-test.c b/drivers/rtc/rtc-test.c
index 6c5f09c815e8..473bbb30bc1c 100644
--- a/drivers/rtc/rtc-test.c
+++ b/drivers/rtc/rtc-test.c
@@ -133,6 +133,7 @@ static int test_probe(struct platform_device *plat_dev)
 		break;
 	default:
 		rtd->rtc->ops = &test_rtc_ops;
+		device_init_wakeup(&plat_dev->dev, 1);
 	}
 
 	timer_setup(&rtd->alarm, test_rtc_alarm_handler, 0);
-- 
2.17.1

