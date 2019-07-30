Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3448DC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C53420C01
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e+WyNRNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbfG3SUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:20:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35395 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387906AbfG3SQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id s1so24174751pgr.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VrkRbDzr3PjCa/bkRL7w2lB6fdcpmQGt7tWtDP9dwcc=;
        b=e+WyNRNolRLQziccTpNHSyiKpyyOeUMfcGl6wn61KqLcd1VX2GVhoen80F0RJRAzk9
         NP6LMtp6ZhdmWXmYwqsWPM9LHwk7sLvWLOrtAnjvvNMRVic6I6U6aZho/X52ypCRNup0
         9UPtzjMP+tAz/2ZNbfjssbrCKjy6dAzpHPong=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VrkRbDzr3PjCa/bkRL7w2lB6fdcpmQGt7tWtDP9dwcc=;
        b=HWq61XIdUzG1OUp6JWNLi6Adj9eyUg+07PzbkcoVvDtTFBAH2nObJ5S0ib0oU+ZCWp
         /vHBZJjOLggQxAuZbbGEWXFlJIg8LzFO4GaTOcyfKbHJXFnzdhhDIHQJr2CCWZNaSx5g
         ywzrJyMmRunQsgNPA25mrM0TnEwCwOgyvzAD8/jF9jsYKlugNzfMBWcNVTwzL+sVU33B
         gI2K8r4qRaDi655KC7aZW1TnDMHSCPw03bZKCoNRbAisDDxosiKlN9uMpSm7UkzU3nPQ
         lVThnoIM/vs3/rI8u9yMgyHgq0LElK+fQo6XGEwVoIkGnhDIEUevwlMB+RyNnhqrOSjN
         wRZw==
X-Gm-Message-State: APjAAAXdv4WIy09I8MUacln2BsOYMwA9jLTmzkpy6ncX1ZNSnH1KYU/W
        ze4+OVBQQwclIUi3B4xy2xqwXRovOxE=
X-Google-Smtp-Source: APXvYqxJWxieoGzyPZ24ebf1AxpIyPNcsS5Oh6md2BEapPyVdOsYCpjQyJR8ZnzfKSIADSSU+GyQyQ==
X-Received: by 2002:a17:90a:2486:: with SMTP id i6mr117014119pje.125.1564510576096;
        Tue, 30 Jul 2019 11:16:16 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:15 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 20/57] infiniband: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:20 -0700
Message-Id: <20190730181557.90391-21-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 81e6dedb1e02..7541177eb648 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -4637,10 +4637,8 @@ static int hns_roce_get_cfg(struct hns_roce_dev *hr_dev)
 	/* fetch the interrupt numbers */
 	for (i = 0; i < HNS_ROCE_V1_MAX_IRQ_NUM; i++) {
 		hr_dev->irq[i] = platform_get_irq(hr_dev->pdev, i);
-		if (hr_dev->irq[i] <= 0) {
-			dev_err(dev, "platform get of irq[=%d] failed!\n", i);
+		if (hr_dev->irq[i] <= 0)
 			return -EINVAL;
-		}
 	}
 
 	return 0;
-- 
Sent by a computer through tubes

