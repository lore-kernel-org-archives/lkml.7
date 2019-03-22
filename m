Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7508C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820F921902
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcGhzxz/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfCVD3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 23:29:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39895 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbfCVD3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 23:29:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id h8so498766pgp.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 20:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PepZC5bd26Tk1NrlpBtC7ziOr6hFFYvCPCCSR9RW8p8=;
        b=GcGhzxz/AqGXTIZUruK+8pD+RAae9UmrqbG+NH/dlNyJaGp1za2hmYp8tROr8YwWLp
         KaySBEb3aNWDPCrASWYuufGX+EfC5/m1PA6ilt5dmR79vTT4Ib0U3h+n8r+TaR91h9Tw
         fTqHEgqWWx5VNvMHH9GBmjMtIPqZ9OA/Svi/+FRl952NtpyELz/hVhc7weGiE0yfkAej
         K4hogLsLYNLpWYpvrkS0tjaaGe+Qi8ozXcOBWYcocL5b+jTJv8SxO0K+tKno59wcJe1m
         BHDhFp9Vzld10PyjJic5HBIqCiqbD3xRU3yc2NX7H5EKy1/5dfI4XmlZY2NtoLsMn7KK
         5/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PepZC5bd26Tk1NrlpBtC7ziOr6hFFYvCPCCSR9RW8p8=;
        b=dN+SxqURkZQrDD/wggI1vasKLpX34bJ3TCkYqGJpSZXhEencQ8Z+DPE2SI6mRWpjyB
         /+XNu3PC1uMRyMzn/8A5xnugHWm3JvTZENVxgxuMNBz6z439aNlfFKS3QurgoDKgBqLt
         pBFrFfP3Y2B6lO9mQhgT/Ua0LDT5pgA9stY2klwEnCqKmnhGe//Yuo6rbZ9OA36fNDCu
         jpI0/fd7ULOI4GySZ89e8VSqqAI/Q2o2+14ywDo9gtNftamHUT9cVSFe24nDbLnOOckA
         +MsBhOgq5xa69P/kpZgzdI+sjihl2gGuDOk6E/yrDMbezUFXw8VfiZkbr+OcDk0i7O0X
         2nGw==
X-Gm-Message-State: APjAAAV9l2pi/Zv623G5Ju1NeLHx3WdygrYyqvk4Om/0g6NkoKEPi9v3
        8mQJVo+C+WkAPTtU0F91YGo=
X-Google-Smtp-Source: APXvYqwDi75kz2Yd3ts8ScTa/tkWSX25p2PCmMifGrkFNYv3j4/1E268ERhP493EotouN5jbgVmCow==
X-Received: by 2002:a65:43c7:: with SMTP id n7mr6797157pgp.173.1553225375647;
        Thu, 21 Mar 2019 20:29:35 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o76sm16154476pfa.156.2019.03.21.20.29.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 20:29:35 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/15] drm/bridge: tc358767: Replace magic number in tc_main_link_enable()
Date:   Thu, 21 Mar 2019 20:29:01 -0700
Message-Id: <20190322032901.12045-16-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322032901.12045-1-andrew.smirnov@gmail.com>
References: <20190322032901.12045-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need 8 byte array, DP_LINK_STATUS_SIZE (6) should be
enough. This also gets rid of a magic number as a bonus.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Archit Taneja <architt@codeaurora.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index b106e6181a5f..68af144b8768 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -823,7 +823,7 @@ static int tc_main_link_enable(struct tc_data *tc)
 	u32 dp_phy_ctrl;
 	u32 value;
 	int ret;
-	u8 tmp[8];
+	u8 tmp[DP_LINK_STATUS_SIZE];
 	u32 error;
 
 	dev_dbg(tc->dev, "link enable\n");
-- 
2.20.1

