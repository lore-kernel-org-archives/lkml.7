Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416DDC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 22:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0767F20828
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 22:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="Y3crGWn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfIBW3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 18:29:16 -0400
Received: from mx6.ucr.edu ([138.23.62.71]:17437 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbfIBW3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 18:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1567463355; x=1598999355;
  h=from:to:cc:subject:date:message-id;
  bh=/rnNmkN0lJmNstKoEYq0s/CsngFGzgDjTMCLUiqUAgQ=;
  b=Y3crGWn7DosAPKQ2bHPpYb8vahqtsNiybvuEwImHkwpXpIjMF6MAQY0X
   ouhr6/kkgZO9j1gTOW0a+TpDfB/fjGynAI8w78D/5fypQEAy2WKUgtzEW
   Y/Nlr2x45/0prb2dLvz4vVyFNYcRtisyvmqD9yHCh37TtFKiY/18c4j18
   9cjV+SaLF4N1+KRdfB7ee/pFwarTTqH/iw1ylroezBF/yFCU+T3vx2B5n
   ZElQtoTJePX+kfBCLOFtCX+0JfzFrrr3GxnSrHdfwgj3nlV9OWjVqqTLX
   XUxtGDPtJ/XIif3MBl8nz5gVQy8qnEq4jT4jvonO314GZMwC4a2wp9oXI
   Q==;
IronPort-SDR: sWvjMYvvuimG30pUkOyYnNDMnK4bwgLqdBcwdnG4mAO7M02KxjQ8zcL/aYy6k9Yb6NBnr2iSgK
 VFMPbmBJR+o7g96T0lsNd2o/S1zj3DBgsST2r4Asj2V3mH37UDbds5N81wN/A+oeQj2NGaSsf1
 6dROgTw+HxVeZgDdnPbp4lGVjwiXmukmP85kqBwptIqFpr9tzkCYnfGR58HBh/AnK4aIaSihL+
 uxN4vpnV5RXCq+mEJTYGuXWbBdfIPqb/+VOyn1IdxaWJSnhgs5h0Oom9TB85VA+G6S8hvyXRE+
 ecs=
IronPort-PHdr: =?us-ascii?q?9a23=3AcNRpzRC6O+eimB6X6P7BUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPvyo8bcNUDSrc9gkEXOFd2Cra4d0ayP7PmrAT1IyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfK1+IA+roQjTq8UajpduJ6IswR?=
 =?us-ascii?q?bVv3VEfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmVLJUFDspPX?=
 =?us-ascii?q?w7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RD?=
 =?us-ascii?q?qv47t3RBLulSwKLCAy/n3JhcNsjaJbuBOhqAJ5w47Ie4GeKf5ycrrAcd8GWW?=
 =?us-ascii?q?ZNW8BcVylAAoOndIsPDuwBPelFpIfjvlUFsBW+BQiyC+Pr1zBDm3v60KMm3+?=
 =?us-ascii?q?gkFwzNwQ4uEM8UsHnMrNv7KrocX+62wqfP1jjPc+9a1C3h5IXSbhwtvfeBVq?=
 =?us-ascii?q?9wf8rLzkkvEhvIgVeRqY3kPzOVy+MNuHWc4utgVOOvi3QoqwBtrjSzyMohkZ?=
 =?us-ascii?q?TJiZ4Pylze6yp23Zs1KMS+RUVmYtCkCINduz+GO4ZyWM8vQGFltDwkxrEbtp?=
 =?us-ascii?q?O3ZjYGxIg7yxLHdvCKcoyF7gj9WOufITp0nmxpdbOlixuw/kWtzPD3WNOu31?=
 =?us-ascii?q?ZQtCVFl8HBtnUK1xPO9MeKUuB9/kK92TaX0ADT9/1ELVg0laXFL54hxaY9lp?=
 =?us-ascii?q?8JvkTCGi/6gV32jKuLekk99Oik9fjrbqn8qp+TMI90jQ7+MqAwlcClHes4NQ?=
 =?us-ascii?q?0OU3Ca+eS6yrLj4VX0TKtWgvAyiKXUs5DXKd4FqqKkDAJZyJgv5wqjAzu+1d?=
 =?us-ascii?q?QXh3gHLFZLeBKdiIjpPknDIfD5DPe/mVuskStny+zIM7D6H5XCMmLDnK3/cr?=
 =?us-ascii?q?lg9k5Q0BAzwsxH55JIFrEBJ+r+WkvwtNzeEx84PBW4w+X5B9Vn0IMRR2aPD7?=
 =?us-ascii?q?SHMKPdr1CI/PgjI+qSa48PvjbyNfwl6+TpjX8jll9ONYez2p5CWXGqHulhax?=
 =?us-ascii?q?GIc3rlg49ZSk8XtRB4QeD33g7RGQVPbmq/CvpvrgowD5irWMKcHo0=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HYAABEl21dgMjWVdFlHQEBBQEHBQG?=
 =?us-ascii?q?BVQYBCwGDV0wQjR2GEFABAQEGizhxhXqDCYUkgXsBCAEBAQwBAS0CAQGEP4J?=
 =?us-ascii?q?vIzYHDgIDCAEBBQEBAQEBBgQBAQIQAQEJDQkIJ4VDgjopgmALFmeBFQEFATU?=
 =?us-ascii?q?iOYJHAYF2FAWdb4EDPIxWiG4BCAyBSQkBCIEiAYcehFmBEIEHhGGEDYNWgkQ?=
 =?us-ascii?q?EgS4BAQGNRIcWlg0BBgKCDRSBc5JcJ4IzgX+JGzmKXwEtphICCgcGDyGBNgG?=
 =?us-ascii?q?CCU0lgWwKgUSCThcVji0gM4EIjCqCVAE?=
X-IPAS-Result: =?us-ascii?q?A2HYAABEl21dgMjWVdFlHQEBBQEHBQGBVQYBCwGDV0wQj?=
 =?us-ascii?q?R2GEFABAQEGizhxhXqDCYUkgXsBCAEBAQwBAS0CAQGEP4JvIzYHDgIDCAEBB?=
 =?us-ascii?q?QEBAQEBBgQBAQIQAQEJDQkIJ4VDgjopgmALFmeBFQEFATUiOYJHAYF2FAWdb?=
 =?us-ascii?q?4EDPIxWiG4BCAyBSQkBCIEiAYcehFmBEIEHhGGEDYNWgkQEgS4BAQGNRIcWl?=
 =?us-ascii?q?g0BBgKCDRSBc5JcJ4IzgX+JGzmKXwEtphICCgcGDyGBNgGCCU0lgWwKgUSCT?=
 =?us-ascii?q?hcVji0gM4EIjCqCVAE?=
X-IronPort-AV: E=Sophos;i="5.64,460,1559545200"; 
   d="scan'208";a="73905600"
Received: from mail-pl1-f200.google.com ([209.85.214.200])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 15:29:14 -0700
Received: by mail-pl1-f200.google.com with SMTP id bj9so1183215plb.22
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 15:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qIiiW+T1UhAkks5lNklqLuvddm5DVfrBC5xScbkb+w4=;
        b=WiVlShM8EZZXJbeu0micrlwrtw7hk1d+FKTb+3E+twG4Ae3clZt90aye3NyhHcyQHi
         ubTx/iQ0ncaRNJsPUmxRFS3ZH9HCpLzVGGaHCcu1LQGWPH5uC3X5rm8b2nGkXCuQ0mXd
         RAewbp4xOPKsGJ9rg76BJvwIPNryN4ToqT6MjUTN82nBd37G9YXZfokfi3mZwdS4FRU+
         phQHOS15jpcFIyxlME9YLdfcm1CCCj5bgRQv6eGbGaAyrg790osK71JUeEdV8TgLHUfO
         Zql71qov2WVekU7vEqBM/wdSwgmfQTUxxZjL6V7HX0lnEFRIu9hFv6UELXnzSKQl4qOF
         9VZw==
X-Gm-Message-State: APjAAAWmQwS3e5nBOsWsND88DUvvX8lLvGRC6rB5To9T7kXp9C2F6LLV
        f8miVtWwQOV5wYeITQYQvU6oFFKIzqkOftVCGMTmJjNYYptUQYAL/QEHZfp1oiz6bw9arcQzsVp
        cK2ZdZNjOQ1Bhw+SXxbWLhp8bAA==
X-Received: by 2002:a63:ee0c:: with SMTP id e12mr27852087pgi.184.1567463353517;
        Mon, 02 Sep 2019 15:29:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxwUg5ETbmFWe2jD2Z1F51cpIZCZAiQ7rBmqE0CCRmJNv6W5/YKEkY9iPwuX9+S2MB1lyVWcg==
X-Received: by 2002:a63:ee0c:: with SMTP id e12mr27852065pgi.184.1567463353277;
        Mon, 02 Sep 2019 15:29:13 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id z23sm5681733pgi.78.2019.09.02.15.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 15:29:12 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] clocksource: atmel-st: Variable sr in at91rm9200_timer_interrupt() could be uninitialized
Date:   Mon,  2 Sep 2019 15:29:46 -0700
Message-Id: <20190902222946.20548-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside function at91rm9200_timer_interrupt(), variable sr could
be uninitialized if regmap_read() fails. However, sr is used
to decide the control flow later in the if statement, which is
potentially unsafe. We could check the return value of
regmap_read() and print an error here.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/clocksource/timer-atmel-st.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksource/timer-atmel-st.c
index ab0aabfae5f0..061a3f27847e 100644
--- a/drivers/clocksource/timer-atmel-st.c
+++ b/drivers/clocksource/timer-atmel-st.c
@@ -48,8 +48,14 @@ static inline unsigned long read_CRTR(void)
 static irqreturn_t at91rm9200_timer_interrupt(int irq, void *dev_id)
 {
 	u32 sr;
+	int ret;
+
+	ret = regmap_read(regmap_st, AT91_ST_SR, &sr);
+	if (ret) {
+		pr_err("Fail to read AT91_ST_SR.\n");
+		return ret;
+	}
 
-	regmap_read(regmap_st, AT91_ST_SR, &sr);
 	sr &= irqmask;
 
 	/*
-- 
2.17.1

