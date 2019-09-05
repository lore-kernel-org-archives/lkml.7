Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A58C3A5AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48EDB2173B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EwzpcT2k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731696AbfIEHEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 03:04:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34677 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfIEHEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 03:04:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so887060pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 00:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Jk8OtQyC7ASzQuT3gwno2aJBZd/Wr2XR1pUFK3wHd3w=;
        b=EwzpcT2kLlxQ63gQwptMLqydZC7lBG4Rs8vCHXv0O4fSZU/tqtwApoCrOkVT21++jA
         Y0hBE6HG6snXmASCYmt24V3txbhIFoqPlY3Acnq3VVGLKHaG12an/T9lA1knMXVehnGV
         wKVUzEbL0hy9iG5uOAVVjibuH7tPg/L6ZuodlzDtj8RrrP1umaPZlHmUQhDKuYuvR/3a
         j6dn28jVUUJlAbc/6X1xLzC41kuAAEn4KrKJRacx0USPZvVnoXhBy2QHniidYNBv3F+x
         gNcb5IIyawkcOMXeHbCLoICDtOfOBC67G4ClWViR9RIVYsTq3HV3QubJw0u4tb80twi6
         7SyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Jk8OtQyC7ASzQuT3gwno2aJBZd/Wr2XR1pUFK3wHd3w=;
        b=HNm857ylqN1MkwNEnKaMhF84c6TCjOLKMOrvsoN0W8BWN72eH36d/lD5is27bM85sM
         JzxABdYunudhCVrKdY1YsjzuJNx89fv+2t796+cWGxfqGOi8d8oBST34cBr87/9d5pyW
         bL3VxcONf1jq6YQSR/9nDvGdJ3yXXzMdaTk8EtN2J7Zf416XO3sFtkXfmdWiJpT+isv8
         0M+6o6feZSHomDwDnV8EINUTaSxnoAYfVhv1QWp5eknSBHHK2hU58pzsVBGcZW+jsK3m
         pkCcq6LrxeuoWPUz0lFXAHHgim5czGa4jad0INhieOMAvYgYMlHzpyXdJVGRoZ3Ju//U
         IAfA==
X-Gm-Message-State: APjAAAXhD+AA/L8krM+b812z9zW1g4HZ6JoS7u2ZyYcpqWBJLIQcVkcI
        9jNXtyrZmQeah14tmWpD5Vm9fQ==
X-Google-Smtp-Source: APXvYqyyioWj/opXO19pgiufG8XN2Gni+a7Tmlkk88KRfLt5o1cTywDMzRT7jjvAkDCwZzV2w3Elng==
X-Received: by 2002:a63:fc09:: with SMTP id j9mr1713158pgi.377.1567667070935;
        Thu, 05 Sep 2019 00:04:30 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id e129sm1014471pfa.92.2019.09.05.00.04.28
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Sep 2019 00:04:30 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        baolin.wang@linaro.org
Subject: [PATCH] rtc: sc27xx: Remove clearing SPRD_RTC_POWEROFF_ALM_FLAG flag
Date:   Thu,  5 Sep 2019 15:03:30 +0800
Message-Id: <1f75310242de75b14d8973538bf96efffb395daf.1567666894.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPRD_RTC_POWEROFF_ALM_FLAG flag is used to indicate if a poweroff alarm
is set, which can power on the system when system in power-off status.

And the bootloader will validate this flag to check if the booting mode is
alarm booting mode, thus we should not clear this flag in kernel, instead
bootloader will clear this flag after checking the booting mode.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/rtc/rtc-sc27xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-sc27xx.c b/drivers/rtc/rtc-sc27xx.c
index b4eb3b3..46646aa 100644
--- a/drivers/rtc/rtc-sc27xx.c
+++ b/drivers/rtc/rtc-sc27xx.c
@@ -138,7 +138,7 @@ static int sprd_rtc_lock_alarm(struct sprd_rtc *rtc, bool lock)
 	if (ret)
 		return ret;
 
-	val &= ~(SPRD_RTC_ALMLOCK_MASK | SPRD_RTC_POWEROFF_ALM_FLAG);
+	val &= ~SPRD_RTC_ALMLOCK_MASK;
 	if (lock)
 		val |= SPRD_RTC_ALM_LOCK;
 	else
-- 
1.7.9.5

