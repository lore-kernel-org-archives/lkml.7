Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF2FC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A026120673
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MF2FHnqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfKGUCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 15:02:04 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46745 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfKGUCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 15:02:04 -0500
Received: by mail-lj1-f193.google.com with SMTP id e9so3627851ljp.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 12:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sWK1iMgmuXL7Tb2eplZGx/oC/uSa+BZBKZskoo3wBq0=;
        b=MF2FHnqwNpUU1MM46hHcSNiI6UcalrGXvlUZZJVBIEDtW3mJ/3BnVsPCaQRozU6h/D
         SzbLKGbfe3Y9im4AX468u9BQakpwU1En4z3SEZJPh3JGItTTaScDLLub68CTsu0a40L1
         mnbkcSOyESoO9UabUIb3+z6zWPWxkUNy1KTMZ4ru3NIAx0qjddLKybg4qVb8OAqjVPnw
         sSMdWzo+eTj8Fjt8DyimLKrsLowsAI+GWR0nAyxjdH1sUTYW6NlimklxiBM1+a4S6qbN
         ++HoFBULs4/iDx8ql7MrWNeTdRLTDkg21S9uMLSgQzu1GYNqxp0wI1YD3FqYjZpld6z4
         mYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sWK1iMgmuXL7Tb2eplZGx/oC/uSa+BZBKZskoo3wBq0=;
        b=fyOKwhqeHVmP4RtgwxKB40wgAHR8gJnuUUAnf8dQfPhPVkwbpOQpBtYHE35uBLQVCh
         VHDipMCGW78MFPR9OWmenPU4SNetlwBRPPURAeHtnxfUUZtrDC4Pcv1K43y9vauzVu86
         LPh+H5ATqMdeDtdbZnPmoLyk7o1spHtP3O2BhS2bkUjWdXwsmz/tfCL6YMfCgJrXbLvP
         k5q5cN6AR5u4UrBStMngWI3hLVQygo13M8CkXqsu2PTVj2uva435S4cDS7CAgauoNleT
         CbJegBbM6v4tq8h2BA1qI9X6Uhx/ub0L0cea/KBnEQwZAHUizBEGeYKyHtBHdekpLw5C
         XlIw==
X-Gm-Message-State: APjAAAXVAxX34aIt1CTWFM0uS0ilEqFBsGNGV2B+4wHpG2Oj/6abSWU8
        FxP1TsK+WNmZIEd/5+mIfh9vDA==
X-Google-Smtp-Source: APXvYqwJ/Pg+KQ4mZ6nX3AZSLmAL8hvpA11PJ6SvYUc0Eu5WEKaB8sAbOB3LnatyRaGfe++ocp5aqg==
X-Received: by 2002:a05:651c:326:: with SMTP id b6mr3807356ljp.119.1573156922048;
        Thu, 07 Nov 2019 12:02:02 -0800 (PST)
Received: from localhost.localdomain (57-201-94-178.pool.ukrtel.net. [178.94.201.57])
        by smtp.gmail.com with ESMTPSA id q24sm1259746ljm.76.2019.11.07.12.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 12:02:01 -0800 (PST)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     davem@davemloft.net, grygorii.strashko@ti.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next] ethernet: ti: cpts: use ktime_get_real_ns helper
Date:   Thu,  7 Nov 2019 22:01:58 +0200
Message-Id: <20191107200158.25978-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update on more short variant for getting real clock in ns.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
index 61136428e2c0..729ce09dded9 100644
--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -459,7 +459,7 @@ int cpts_register(struct cpts *cpts)
 	cpts_write32(cpts, CPTS_EN, control);
 	cpts_write32(cpts, TS_PEND_EN, int_enable);
 
-	timecounter_init(&cpts->tc, &cpts->cc, ktime_to_ns(ktime_get_real()));
+	timecounter_init(&cpts->tc, &cpts->cc, ktime_get_real_ns());
 
 	cpts->clock = ptp_clock_register(&cpts->info, cpts->dev);
 	if (IS_ERR(cpts->clock)) {
-- 
2.20.1

