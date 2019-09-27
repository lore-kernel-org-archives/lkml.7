Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CACC388F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A539D206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoZr4wlZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfI0MP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 08:15:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40003 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfI0MP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 08:15:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so3395724pgj.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 05:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=M41dMSj8YsUC09fTHA1984IazgNH9432TVv2qcwf7GY=;
        b=aoZr4wlZ/vB6NcUL28PpX4kyb84Dr46XYL5B8uLKuOD0lADCkKL1gI1R9FDcvQy0sr
         efTDA76X/+eROw2VMl8YQ4gfEgIG38YrWzzk2qPyDh+V/k5L+yyKfVorTAb3NtEYiwZZ
         KHg+0sUSdbSN3b8lCN1GhKclh5KV6cua4nLenxUwaRxEOwtVKiGOgthSjGa+qw8bUDRa
         YVZqH4uaiTPZNY0sBBkeSxH8gZu0RxX+6VqCuxsWduSYmIB/03yonpmLtW1tEbRh4vVx
         QVpoMlQ094XNyj9nu035cX8wSJHLsP9L0rvclOp5FikjgK2Z6yFFHCYyHyIxO978uifl
         A+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M41dMSj8YsUC09fTHA1984IazgNH9432TVv2qcwf7GY=;
        b=F3+bB4aJqkWcGeAAFGh4jaVAqgrbE9BBE4j/+beJl6lDH7S+7EKtUt62cZqwRyg7oq
         ck0V7es7p3OhvADGW3/lmo95oxmaZyRsDkpsvuY7KbkhktdvsCR7zfi1bn9MPGhWteKc
         GLh9i8j3RNo8Z/aDhN9V/ubGfj/6yZIg6K+u5pL1+oq41eLwXCgIpICqo4qWtB/OIBwH
         XZ3f12XnNtBeTAVP9KYYSq3MkNzazHZBQ1S9ZRsNxO4TAEd59D6wVblipz9ZPJLZaBE7
         fWd5e5iWfuBRZKHh8Q3Dsxan6HzUdX+w21nyD6qz8xqhrUxGG4g4WIKcuZ7K47RAKbe3
         U8gw==
X-Gm-Message-State: APjAAAXm/JWhC94NXyexFKviH94OSIM1OcC4UAyKJOo5JUfgHLL44VU4
        Tg6y9D2LR5ONdxULN78bZFw=
X-Google-Smtp-Source: APXvYqynQHZ+LtAagji3jSZGDp8/ZQFb5ShdqPhqc44KILqSgW95hb4i1P2+5ZSSRM1qcaY9R8SN0A==
X-Received: by 2002:a63:d055:: with SMTP id s21mr9061931pgi.219.1569586556011;
        Fri, 27 Sep 2019 05:15:56 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id d76sm6204634pga.80.2019.09.27.05.15.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 05:15:55 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH] m68k: q40: Fix info-leak in rtc_ioctl
Date:   Fri, 27 Sep 2019 20:15:44 +0800
Message-Id: <20190927121544.7650-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the option is RTC_PLL_GET, pll will be copied to userland
via copy_to_user. pll is initialized using mach_get_rtc_pll indirect
call and mach_get_rtc_pll is only assigned with function
q40_get_rtc_pll in arch/m68k/q40/config.c.
In function q40_get_rtc_pll, the field pll_ctrl is not initialized.
This will leak uninitialized stack content to userland.
Fix this by zeroing the uninitialized field.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 arch/m68k/q40/config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/m68k/q40/config.c b/arch/m68k/q40/config.c
index e63eb5f06999..f31890078197 100644
--- a/arch/m68k/q40/config.c
+++ b/arch/m68k/q40/config.c
@@ -264,6 +264,7 @@ static int q40_get_rtc_pll(struct rtc_pll_info *pll)
 {
 	int tmp = Q40_RTC_CTRL;
 
+	pll->pll_ctrl = 0;
 	pll->pll_value = tmp & Q40_RTC_PLL_MASK;
 	if (tmp & Q40_RTC_PLL_SIGN)
 		pll->pll_value = -pll->pll_value;
-- 
2.11.0

