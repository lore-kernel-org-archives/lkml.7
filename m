Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51650C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 18:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9DA222ED
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 18:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X2Qv3IxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfKRSwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 13:52:14 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38997 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfKRSwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 13:52:12 -0500
Received: by mail-pl1-f196.google.com with SMTP id o9so10276074plk.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 10:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uSTPqpXCkdIz0Ys9ZLE2MJ6RpXCWxgbm8ltsUhdFuaA=;
        b=X2Qv3IxFUWevF27cjY8aXXrQI2siYVe73dYgkiMeUtD/JEU7etfRh0B7TwpGyJ4dG6
         jy0fqJ/P9lbHqOib0wPfWSFcfjZVDpP7MWNTjayCixoBsM55AtghsA8jB2GsDcvQOZi0
         Us6IssUiDvQAGIkruSf/mIDKvpH+JaKyL13YjPV2CI6+Sb+IFf22B9AbrdOhh+f2VfQU
         x5Ky+GqrN4UPOKZu7xBcsGsGNtsH0j1aHNS9G6wpjVzMc9usP1PIdfmNuFn8nYUz6pDL
         m19ojjf5y5iB2iDEXA61IiX8bUDRh0lvu1letC5Lej5L0ZaDvofGQDca93txuvzzp+1K
         zp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uSTPqpXCkdIz0Ys9ZLE2MJ6RpXCWxgbm8ltsUhdFuaA=;
        b=FddRXBbYUUAMssq30+i3704H95kXKYHdVxD9HKVel/paxW6TWU5+0I7v8ejMS64FCE
         F3QoyC4o1doZQERWZhMnUT/PVPJvWvV42GT0nP9agZBd0f76dfys1T/8GyUSeLd2kguj
         94Og3u9nTa8/VV7y9ZDknKnFeosyKG8C36hiW2/xYtkNu28QfgNG2HvNW2VtS2ZkS/JM
         Iumi8x6YOVIfh6jk4iO9+RBasjcQOiA3otDUNHujQg1ISN25TfwcQ7/FwwYz88/wgKZi
         Ldr5IdcKM64S5hvpvHhjTNYA7k6LQbp6TctHH7gaFPZG2DolywdNK0k/A5Hsrs4G4XCV
         s7FA==
X-Gm-Message-State: APjAAAW/8y9ZuAinJ5xNerWvTbS7ycAjybnFbOXgtB2zVc/8CmwM/DyT
        Ve6poN7OKLolsbiTdey/AQiY/G9W9oo=
X-Google-Smtp-Source: APXvYqzzItYreBeWBbFqrWCtFJCzpea9kEtD7ao2jmO1F22pYdxUyW2dEdPzqkra62qpmsk0ZQLzEg==
X-Received: by 2002:a17:902:9a04:: with SMTP id v4mr4924119plp.192.1574103131601;
        Mon, 18 Nov 2019 10:52:11 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id r10sm19878910pgn.68.2019.11.18.10.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 10:52:10 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] coresight: replicator: Fix missing spin_lock_init()
Date:   Mon, 18 Nov 2019 11:52:07 -0700
Message-Id: <20191118185207.30441-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191118185207.30441-1-mathieu.poirier@linaro.org>
References: <20191118185207.30441-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

The driver allocates the spinlock but not initialize it.
Use spin_lock_init() on it to initialize it correctly.

This is detected by Coccinelle semantic patch.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Tested-by: Yabin Cui <yabinc@google.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-replicator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 43304196a1a6..e7dc1c31d20d 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -248,6 +248,7 @@ static int replicator_probe(struct device *dev, struct resource *res)
 	}
 	dev->platform_data = pdata;
 
+	spin_lock_init(&drvdata->spinlock);
 	desc.type = CORESIGHT_DEV_TYPE_LINK;
 	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_SPLIT;
 	desc.ops = &replicator_cs_ops;
-- 
2.17.1

