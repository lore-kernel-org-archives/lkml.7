Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB0FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79197218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="EJvR+z+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfCOGU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 02:20:58 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:44584 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbfCOGU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 02:20:57 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 154ABD4C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 06:20:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hjSeTNwG6iDQ for <linux-kernel@vger.kernel.org>;
        Fri, 15 Mar 2019 01:20:55 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id DB325D16
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 01:20:55 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id a184so6507719itc.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 23:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Br3/U0mf/R/jQwiIltWwAExumrY4nZjRkWM2M0apZa8=;
        b=EJvR+z+HXKYN9bnEr7CKAv9UkVhR3jM67CJYW7G/gklZEDYExMUrvVSqw4kxOaOiGb
         PyvPuMQWbfTsqn9iDAYgckLtuX2Q2lpcsxTsX7gaXd/CvB7N8DGeQIobAhqd5v6NaZ2e
         FYYQkvkl8/d+U6D+8wySPfKk6No0gH7ThZT+cHy2topxZkKkTwQpliir9kJmfT8IFjhN
         DoW3+daElxaJtCbGsX3B6k1inJRZ8eTHM/UP9PtG4Lzxsl2TCTxlLh/Se9k/0F24PeLX
         fzXvMP0rDgADOqt6ynI8zxq9CbS5k/BnpSn0ENTcC7b5mm762lCWe0pkLZmSQ7/0khfj
         PnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Br3/U0mf/R/jQwiIltWwAExumrY4nZjRkWM2M0apZa8=;
        b=W6DCGndBcl8ui9PKSyCH/S956vbstPR+J+dlhIjoQZWFqjTZOudXy4ZPuEIQwrDhFd
         IELmJ9DjMFKOclPiuxhN7t7mdP86wKwbnu5BAiFsc3WCtOptFF3GLhfYO8uPvc+QKeEN
         g4Xx+n5ZoTLFb5kMq3sQGZsljeFbpPkM0wjHxRsKlvUtLMStVuC715275gwVWkoCE8bv
         UuX6c1UaMWbXByMwIt5Qjile6MwtqUsnaGfrAUQl3u/6ZitE0b9jF1ghzsyoajn+rTrk
         HYofcy4KS9WfPH2+5Wi4VOdUbyq5DzHclENxHvnOZcU9WYup1MMIGWnn9gtbmAAGO2yY
         0dZQ==
X-Gm-Message-State: APjAAAV02RLYz5OyPJTD/9frbFNvEMrdVKMa7tNHMS91UM7apyJIHudB
        JmUj+Lg3b/48R2InFhRhpG4wAN1npFbRVJSHitMyGbS+W1r7esF937GHDepeRr4xOZ03ddXNFGt
        oseRPK8d3rfTMHYhCUh2YD+x4yPGq
X-Received: by 2002:a02:8a4a:: with SMTP id e10mr1457812jal.120.1552630854721;
        Thu, 14 Mar 2019 23:20:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy5AbrXvR3MYaIsOrtbaEE3epm5jjU38uitbYmdpb9Bs0Ds2f/TKZMmNYU1UQbz2VJyPns+Tg==
X-Received: by 2002:a02:8a4a:: with SMTP id e10mr1457803jal.120.1552630854477;
        Thu, 14 Mar 2019 23:20:54 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id u13sm495570iog.80.2019.03.14.23.20.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 23:20:53 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] slimbus: fix a NULL pointer dereference in of_qcom_slim_ngd_register
Date:   Fri, 15 Mar 2019 01:20:48 -0500
Message-Id: <20190315062048.16642-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case platform_device_alloc fails, the fix returns an error
code to avoid the NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 71f094c9ec68..f3585777324c 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1342,6 +1342,10 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 			return -ENOMEM;
 
 		ngd->pdev = platform_device_alloc(QCOM_SLIM_NGD_DRV_NAME, id);
+		if (!ngd->pdev) {
+			kfree(ngd);
+			return -ENOMEM;
+		}
 		ngd->id = id;
 		ngd->pdev->dev.parent = parent;
 		ngd->pdev->driver_override = QCOM_SLIM_NGD_DRV_NAME;
-- 
2.17.1

