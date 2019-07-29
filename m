Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2860EC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF221216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RAfvxQcl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388344AbfG2WLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 18:11:32 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:37146 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387769AbfG2WL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 18:11:29 -0400
Received: by mail-qt1-f202.google.com with SMTP id 41so50626753qtm.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 15:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q/JO0jIzFDUcBLNa0OLAVEbtuFfd8ssnFHaHdmtCpxU=;
        b=RAfvxQcl4h2BOyaK31H1/xWYCyBx/eMduTNV0vQvG5cGkn5cGK3RzQnHoHIatewHnm
         Fg1LrxZP4gf7iMy/GnI+7ngsBGnaRAZjvWfL4bpRWJKpKv0/5v8jJJ54kIYZll1fkhrs
         CXXej9PXznYSVaqvLO4jibT0OH+iqf5eceI834QosZHeYCIlkQTBEqAYfwFwSt4dLmuw
         p49wppWLaI3vC7K4KJRvbYvAbQ8Uu8YGMIn/Ymu/YE8ZZOEgVLlGivl3A6edYaBM1xtW
         +v4tiDen5L66O2NJg/9wyISohBTn/MqJv8xjwO5aYduPo5+sY0d122+2EzQXQz0RNUx5
         j4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q/JO0jIzFDUcBLNa0OLAVEbtuFfd8ssnFHaHdmtCpxU=;
        b=CyPpxDwtlcIJg89DP6xyW/6+UU8XHZDurqvNtuM5w/SqMqyGu2RP7nsgJqDqe9v4Js
         F0hyvIa1cCRX3Me0Y1Md3LTmfk1/y6+3mTsDbrAnxEKNYvfdURwVQhWNNaCPSQ/Kxhoi
         1Z6K+BsQj/2KC9XzrKX1YSJhbsLty0eXLep1gvmrTEGoImeKQtbA62PJieGyiqs9f0nr
         fr8hDp28rP74phgrSXT2iPBaOasnhnkpNhBN+OVJedCfEWFJ48AwLyI1b0w207LvDBM2
         G7tzmZPm+JpQuebZNVe12ojsFOpOw8wauTQmopHYABG+3yVXJTbZgJi09e0cH4DCibha
         U32g==
X-Gm-Message-State: APjAAAXHuQfx57JhEJhuS6pBJWZVbzjtk7zCL5bOLrQ2zDhdqN+Q307l
        vC9yaFCvE1zsnGrNZJ5k9l5bxTX/CRRb8J4=
X-Google-Smtp-Source: APXvYqydELxRbsHighcxSWgGx87UveXV5heA+fTgZ2mjwG8HEYlndd5i5Hfoa3E9mNglZFW6alDPgxqaqeQ/Og8=
X-Received: by 2002:a05:620a:1228:: with SMTP id v8mr29782991qkj.357.1564438288576;
 Mon, 29 Jul 2019 15:11:28 -0700 (PDT)
Date:   Mon, 29 Jul 2019 15:11:01 -0700
In-Reply-To: <20190729221101.228240-1-saravanak@google.com>
Message-Id: <20190729221101.228240-8-saravanak@google.com>
Mime-Version: 1.0
References: <20190729221101.228240-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v8 7/7] of/platform: Don't create device links for default busses
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Default busses also have devices created for them. But there's no point
in creating device links for them. It's especially wasteful as it'll
cause the traversal of the entire device tree and also spend a lot of
time checking and figuring out that creating those links isn't allowed.
So check for default busses and skip trying to create device links for
them.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 41499ddc8d95..676b2f730d1b 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -682,6 +682,8 @@ static int of_link_to_suppliers(struct device *dev)
 		return 0;
 	if (unlikely(!dev->of_node))
 		return 0;
+	if (of_match_node(of_default_bus_match_table, dev->of_node))
+		return 0;
 
 	return __of_link_to_suppliers(dev, dev->of_node);
 }
-- 
2.22.0.709.g102302147b-goog

