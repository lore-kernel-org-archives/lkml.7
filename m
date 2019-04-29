Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B28AC004C9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9FB20449
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tn+XgiyH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfD2IlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 04:41:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46424 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbfD2IlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 04:41:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id t17so14670171wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 01:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RkuphNEeqnp3OCEr+63Sfar4bxKyDZqKVHUmZHrORFY=;
        b=Tn+XgiyHsSFyzqj6mkPF6TWU/4PyPnJREoDA1sBsDlBHvI31Bsltv/9TaD6qLH7plq
         UuYqnjCfnvsMNujerwut2P8bQ0faee6kXncevbLSpxt2Y7+SqclZDwbLlW4XCaFRU9JA
         ta0D4RAK1aeP7xBQozPEesR1FkG56N/bKj/mRORuDY0wtn/X1lmAr8IOp7Rqmdumd6Jq
         daC8WXTQVn+up+RJlTXIwgex0wrJ1CicFQjVc9c4eR2pcDHQHeu5PuwG4BulNhUPZoux
         GdcLvhmA+scPpv81SXivS7zAvWTgqQnTguQE3i9kmf/Hm9htglHwaZF/QC60k89XyVwk
         kEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RkuphNEeqnp3OCEr+63Sfar4bxKyDZqKVHUmZHrORFY=;
        b=LQ0A5wPXoKX+qQi9McEbCHWzY/IrCmsmNOlIZr8Ffo5PYnkXdANIydcfIbOMBMh6hu
         wI3wEs+g/B7f2zb9H7GwN/unRXrjKQBJaxEf54/GhdEXqU5w9munWmeFxriWmeguVCq+
         mJw2Zk/1J2+iSAPWaosYr7pI3mhV8x1BjNpt52UPPkxzyTrgsu1we7s+GhnV4r9jwqW8
         I/rs5wIOGUh1g5Avlfag7+zDLvpfTo2XR31KuIuGyi7noEaAyB8eLWL1+Atu0a+B9bFN
         BWlnp0eu++h54uNFIyGSCgxdxCTLR7pdSpyGJdtfe+Jt01CnKouO/nhcFtsynR6dKrou
         LB3Q==
X-Gm-Message-State: APjAAAX1RqB1X/j07aItcg+Cs7ll86V6TeUmHrEkB6BIcR3rInikZFs0
        y3dfE2WY3/MM6FRM0mQNbm4OAA==
X-Google-Smtp-Source: APXvYqxGzGkretE4afo2nM4aoNaWHr/uFvy91W/ZDPl9IB3/bIPrF2LMkCXOtnEDQghdyePdoVt7pA==
X-Received: by 2002:adf:fc49:: with SMTP id e9mr17637388wrs.269.1556527258884;
        Mon, 29 Apr 2019 01:40:58 -0700 (PDT)
Received: from clegane.local (129.201.95.92.rev.sfr.net. [92.95.201.129])
        by smtp.gmail.com with ESMTPSA id n6sm39795964wmn.48.2019.04.29.01.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 01:40:58 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>
Subject: [PATCH - resend] thermal/drivers/cpu_cooling: Fixup the header and copyright
Date:   Mon, 29 Apr 2019 10:40:12 +0200
Message-Id: <20190429084012.23244-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190429054350.kaup4w2b5yx3mdqb@vireshk-i7>
References: <20190429054350.kaup4w2b5yx3mdqb@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The copyright format does not conform to the format requested by
Linaro: https://wiki.linaro.org/Copyright

Fix it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index ee8419a6390c..42aeb9087cab 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -2,9 +2,11 @@
  *  linux/drivers/thermal/cpu_cooling.c
  *
  *  Copyright (C) 2012	Samsung Electronics Co., Ltd(http://www.samsung.com)
- *  Copyright (C) 2012  Amit Daniel <amit.kachhap@linaro.org>
  *
- *  Copyright (C) 2014  Viresh Kumar <viresh.kumar@linaro.org>
+ *  Copyright (C) 2012-2018 Linaro Limited.
+ *
+ *  Authors:	Amit Daniel <amit.kachhap@linaro.org>
+ *		Viresh Kumar <viresh.kumar@linaro.org>
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *  This program is free software; you can redistribute it and/or modify
-- 
2.17.1

