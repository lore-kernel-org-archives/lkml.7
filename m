Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F5DC2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 14:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33461206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 14:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnTbozAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfLXOt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 09:49:58 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38673 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfLXOt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 09:49:58 -0500
Received: by mail-pl1-f196.google.com with SMTP id f20so8552578plj.5;
        Tue, 24 Dec 2019 06:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9qJ4QX/O9pedWC4ReUIXSopENMJeF9k7yOnEg+shTPI=;
        b=VnTbozAKz9ZlZBmyU0uHx+ynZVdyU9j9ngEcgnL7gZI+fAuAqNQ9eQoQsIThbSHN//
         rkMdot+Njbcfqihx5iIiV2Enbgzt9FYxl1hGG0qJ+tx9XfQPThetZkmjYwMEXVhZoVxx
         3438FYt0+yiQGZ65v+kVzBwLc0g3fnGxcw9mWIzVpLhnC462kfnzXM79uqnnaRxiTvoD
         NynOyCwKp2Iamv+qGGQICg2f21yM+6p8/aYLwTne/7VMMyX3A3tCvJO+tA9KKG7N8iOf
         bN2IL/INffw4WM1mXxRb19Zoq1PNy+XerEVmGr/7eXXhpEPwif8R6usTobK0emG6yp7L
         BygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9qJ4QX/O9pedWC4ReUIXSopENMJeF9k7yOnEg+shTPI=;
        b=Xwi+ckFBReMhUKcp9YsP8cPN35GRfHh+9miJ9aoQ+p8rwKHy8UnYQgdddWX0bgwxn2
         283oz4K7zA+erBuC43paDhO5Go3f/MX9HQcDwVfywaPGAOCTZ9SffpMrc5fIlo2yCS9N
         /f8JSsib0iUStQHdt/3ea/+KGea3S/IfuzobwMPgEOkdJRgNeUo6pc72Mke7St64Re7a
         vh6rNpm+seJ6rTpLruoDQVJI6Sx3F7j7n9pp6fyXXtovz23y8GY+CCRzycpiKFmZt8nr
         uG4H57kWWkRJcpoCp4VL/ftjgyoDIWV8hWasbSVZwUSJV/ownflvCiPpkYb2nms2Z5jT
         350Q==
X-Gm-Message-State: APjAAAWeBmIq3V2tCY9crQ0SkGrw25jP+NNtFhIBRVPs/kJbSHTG2xcy
        DpUePb0uBNvHT4srUHKfkgg=
X-Google-Smtp-Source: APXvYqxhTEg2NXHaE+Zd7wNoia2SxPlCI7V18qlyqQOOfP3FcLQripV1VQyu/HVcttF/iQLQIO1fdA==
X-Received: by 2002:a17:90a:a386:: with SMTP id x6mr6578091pjp.116.1577198997673;
        Tue, 24 Dec 2019 06:49:57 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id s18sm24669905pfh.179.2019.12.24.06.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Dec 2019 06:49:56 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, kgene@kernel.org, krzk@kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] PM / devfreq: exynos-bus: Add error log when fail to get devfreq-event
Date:   Tue, 24 Dec 2019 14:49:54 +0000
Message-Id: <20191224144954.26152-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding an error log makes it easier to trace the function's error path.
Because the error code may be rewritten on return, print error code here.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
v2:
-update subject and fix over 80 char
---
 drivers/devfreq/exynos-bus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 948e9340f91c..a4c6187b1eac 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -126,6 +126,9 @@ static int exynos_bus_get_dev_status(struct device *dev,
 
 	ret = exynos_bus_get_event(bus, &edata);
 	if (ret < 0) {
+		dev_err(dev,
+			"failed to get event from devfreq-event devices %d\n",
+			ret);
 		stat->total_time = stat->busy_time = 0;
 		goto err;
 	}
-- 
2.17.1

