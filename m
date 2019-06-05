Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FB5C28D18
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA5620883
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="z/jx0n6r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfFEUWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:22:54 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46799 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfFEUWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 16:22:54 -0400
Received: by mail-qt1-f196.google.com with SMTP id z19so10249qtz.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 13:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=QJQbMka1MXUwYIt/ZO5sWq6DO1jrK8MhlctrAEsYl7o=;
        b=z/jx0n6rsGTbQSFzvt5ikx9wlxvOJwDIcrBdGcbuAJ/vYaJszYqgNGBH/ysXQVLZ9V
         8Oq41zXAr8lov85dQndkojs6gARfWDm/dnN46Kzi/+47f94ktklVlvO4lfn/4dmqBz6e
         415MTiIZ57QU/NAdAz5Ty0gXI4jQN05qF/kQ0Fe8rrLAbBZTkI1695u8eh4+qjhq41j2
         5UsawJrak9nMB1MHo45kAXNfidWNFXSeTpuUu36BkKQIi3JimeYc4To6UromjR6erZsJ
         s8pVmhGSRnZazsg41G6BxAv3om6f5TdgWuHTSmOP1j93bQX9FetCg9b3PNZq4cyxclpl
         ZrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QJQbMka1MXUwYIt/ZO5sWq6DO1jrK8MhlctrAEsYl7o=;
        b=gVVZW2HYcl4OBm6LlcQIhwSeF7OVCo98Hvw0xzXr6JptmDVCnl3XlCjOQubHijooxI
         +fTGKQtb+wIhO4ytMovVn/XF2zAOrPH42JHAtLpwZQFleNgGNLOR4P2jYgqH+k6p53Et
         E29/Tg5LTl/0qxjGIZzi7fpFR7TQLsT4Vuma0WCweyySm31HY6hym7ZIdQsI2iHqYTvQ
         WMY58xonUrK7vJqB2gy/YU1SLkflAVVvxEwCzjXjfPQFc5MqF4+QK2RLnWDC30Aj/sME
         /yUvGrZ1MVf5A24SKiOZDO7zqt3atjOan63xOdfV6wyjZwNpjW76Ds67Eqz7R9U1AJwE
         l28Q==
X-Gm-Message-State: APjAAAUVXTjuAZLAkC0zVLz0kwM2nbRKXXe564CMsTAaOzany58WmnKa
        AT7fUdb2JGNn5SkULB+DuOEijw==
X-Google-Smtp-Source: APXvYqz/pc+6CZnS6Ffj6aSGLxLVCXIV4qPrJdrKC4gzOOijyHDtYguQjYVphUllVM9vfHQKIaUIMA==
X-Received: by 2002:aed:378a:: with SMTP id j10mr37083052qtb.6.1559766173362;
        Wed, 05 Jun 2019 13:22:53 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id d38sm7565318qtb.95.2019.06.05.13.22.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 13:22:52 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org (open list:QUALCOMM VENUS VIDEO ACCELERATOR
        DRIVER),
        linux-arm-msm@vger.kernel.org (open list:QUALCOMM VENUS VIDEO
        ACCELERATOR DRIVER), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Revert "media: hfi_parser: don't trick gcc with a wrong expected size"
Date:   Wed,  5 Jun 2019 16:19:40 -0400
Message-Id: <20190605201941.4150-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit ded716267196862809e5926072adc962a611a1e3.

This change doesn't make any sense and breaks the driver.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/media/platform/qcom/venus/hfi_helper.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
index 34ea503a9842..15804ad7e65d 100644
--- a/drivers/media/platform/qcom/venus/hfi_helper.h
+++ b/drivers/media/platform/qcom/venus/hfi_helper.h
@@ -569,7 +569,7 @@ struct hfi_capability {
 
 struct hfi_capabilities {
 	u32 num_capabilities;
-	struct hfi_capability *data;
+	struct hfi_capability data[1];
 };
 
 #define HFI_DEBUG_MSG_LOW	0x01
@@ -726,7 +726,7 @@ struct hfi_profile_level {
 
 struct hfi_profile_level_supported {
 	u32 profile_count;
-	struct hfi_profile_level *profile_level;
+	struct hfi_profile_level profile_level[1];
 };
 
 struct hfi_quality_vs_speed {
-- 
2.17.1

