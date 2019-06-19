Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7203C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0D821479
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+85u3eD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbfFSF23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 01:28:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42451 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730785AbfFSF1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 01:27:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id l19so8952352pgh.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 22:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G/oBLQcGnx/gnzbBsvs2luhfWdsPZ44ykpse07/04ZU=;
        b=T+85u3eDWlE84s/NikVtVZ07INyUOjHurTvZKCngf8SQNC+k7kSRNe3RMyHuACMyW0
         Ye5rm36YZ69RFtdGRolDtGvr85jKQdoFYHw1nKcS2eaPiktqLcr3A0Jw+cj72IU85s8s
         43+slUjdX34FMIsgI2zY9EqseYRetvIYz3JV9nIFxLLy59UlfwgvcengPXr6VgN0ZpCu
         EiYzn4QWWZfmols4NOSEXEmzKuLvMGqx7gUmkuh8QXq2zI6TvJECznG0mURQ37sQfWQ0
         lBkPnxzCGM925GxDuiXv/zcTdUuYHIPEEqYK3jYRKD78UJcofNLAeZxAmpJy0U/ma6N4
         HBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G/oBLQcGnx/gnzbBsvs2luhfWdsPZ44ykpse07/04ZU=;
        b=OXBdBO6tli6laRY952CYZLGwDE/lxGdH3KR2tn7lUboM2mChQAc5a9vviENUjE6F5Y
         QSzI//VSAxW/U+MOWMGCbNCc0OVKUE1i5UeCvwV38T2nX5kUNUJct1w9Voc4nUqltCYc
         dd/WvYzkkPtLJ4pbjCwzcQCx9ge8SFuDk/R94uBZ11gVFcQVrMeQvXaKWMmGfgts1eDq
         cIXGuwO6P4IrING9YXA8eg+sJXwIYzcAVvYVMh0aslXK0dSB7+EOWs+TsvEMgEILLZ5e
         7MaZRvK6b8p74NesN0+p0fa4Nei4RWiIi3SC/vRzKMg71+pDv2AX7RdIKzes+Mb+b5XB
         AnSQ==
X-Gm-Message-State: APjAAAXeBA9GQ8vVtX70BfMx2KGZ/6naWHQbXOG5B48weYtwbVhSDpg5
        fLLRhhH4Cuho8cQOM77tc5o=
X-Google-Smtp-Source: APXvYqxub1BG9Akb060K5f4TgwG8lFmIUJcYVAdYfPH1LO8j1fycgh35NS0Osy/SJQdrdXt7Cd1gXg==
X-Received: by 2002:a17:90a:a601:: with SMTP id c1mr8874185pjq.24.1560922061561;
        Tue, 18 Jun 2019 22:27:41 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id l44sm534742pje.29.2019.06.18.22.27.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 22:27:40 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 06/15] drm/bridge: tc358767: Simplify AUX data read
Date:   Tue, 18 Jun 2019 22:27:07 -0700
Message-Id: <20190619052716.16831-7-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619052716.16831-1-andrew.smirnov@gmail.com>
References: <20190619052716.16831-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify AUX data read by removing index arithmetic and shifting with
a helper function that does two things:

    1. Fetch data from up to 4 32-bit registers from the chip
    2. Copy read data into user provided array.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 6a3e7c7e1189..02f6d907f5c4 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -321,6 +321,20 @@ static int tc_aux_get_status(struct tc_data *tc, u8 *reply)
 	return 0;
 }
 
+static int tc_aux_read_data(struct tc_data *tc, void *data, size_t size)
+{
+	u32 auxrdata[DP_AUX_MAX_PAYLOAD_BYTES / sizeof(u32)];
+	int ret, count = ALIGN(size, sizeof(u32));
+
+	ret = regmap_raw_read(tc->regmap, DP0_AUXRDATA(0), auxrdata, count);
+	if (ret)
+		return ret;
+
+	memcpy(data, auxrdata, size);
+
+	return size;
+}
+
 static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 			       struct drm_dp_aux_msg *msg)
 {
@@ -379,19 +393,10 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	if (ret)
 		return ret;
 
-	if (request == DP_AUX_I2C_READ || request == DP_AUX_NATIVE_READ) {
-		/* Read data */
-		while (i < size) {
-			if ((i % 4) == 0) {
-				ret = regmap_read(tc->regmap,
-						  DP0_AUXRDATA(i >> 2), &tmp);
-				if (ret)
-					return ret;
-			}
-			buf[i] = tmp & 0xff;
-			tmp = tmp >> 8;
-			i++;
-		}
+	switch (request) {
+	case DP_AUX_NATIVE_READ:
+	case DP_AUX_I2C_READ:
+		return tc_aux_read_data(tc, msg->buffer, size);
 	}
 
 	return size;
-- 
2.21.0

