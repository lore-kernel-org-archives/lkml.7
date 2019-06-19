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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280EBC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFB421655
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S51k0hH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbfFSF2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 01:28:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33943 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731011AbfFSF1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 01:27:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id p10so8989845pgn.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 22:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZCDVBhBSdQwjhUcz4qxkFwsgejbQrMll+z7BIFVYRDY=;
        b=S51k0hH7G/P3knDJiHETJE01QvNgGL4FJAvVIGm7IdT9TsBVy07Z1fRsXO0dQ3Fj+y
         yLM2/ieJvkGHUR7st1ZF/bxCaQ298ICHe1vqRdQo/4v10S7cX7Wkp2Rzj+NZ9sy/0BeZ
         zoD9CuTzDa1gfIiyqv3XOQ999loYFYjnB7joFJgKaCGLspk8e1H83a56sLFqdjcwcSPb
         AufVXzZfmes8LHv/qHxpzdODLAnAOMFH++cD5sGsoBjm7RUwJJZ16ZZDY+ImwJbSOLuy
         9qy2dOgt/M5I1N1tg3E9XsASOC3BeEteYdAFZxarPtdGSvlBdx6MjStziL47qlBaGokF
         tUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZCDVBhBSdQwjhUcz4qxkFwsgejbQrMll+z7BIFVYRDY=;
        b=URwQijGIIaHjISzeyF8Uajrsv+OH3YkGawaEn0BMDSi5DVUVO/xko3xEfkVGfDxdw1
         uvIRRRtFiiScdNvuj1VrPBCzxUWeVDNqJuaqS6rzrREwntW8bZ6kXJ5qrhVq1VXUKgHD
         TvjX+Am9Ht/UnjFjghd3xuB/FMttzMNpIHnYdHw+54OXgfxIlu9AtJlXJ4A0upH7R9h/
         KYJW0cie9mAV7uIZHRs5fMe5AErE7HKViIIhBnNL4EP5LCCpatX7u8q0kCrjvIesYGr3
         9905vjtMQ5MSB4CURsME8763Lrl3exPI+QHP/Oa7YLfbSPGEez5Em4K7cJOJRU11gBTS
         UCDA==
X-Gm-Message-State: APjAAAWjZmHz95E5X1XnMdFyEUgq15VUj1BgZa3/RFCjaSGD5ENEgrHY
        cZJzFRAsSxKwzXsLN5iPEMg=
X-Google-Smtp-Source: APXvYqxqix4U9U5bTiku1r37m+qTXtbfiKflyJpw4QKp2H3PoKmJStqAmpMW/smESx6oF15+HTWaRg==
X-Received: by 2002:a63:511b:: with SMTP id f27mr6001887pgb.135.1560922073067;
        Tue, 18 Jun 2019 22:27:53 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id l44sm534742pje.29.2019.06.18.22.27.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 22:27:52 -0700 (PDT)
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
Subject: [PATCH v6 14/15] drm/bridge: tc358767: Replace magic number in tc_main_link_enable()
Date:   Tue, 18 Jun 2019 22:27:15 -0700
Message-Id: <20190619052716.16831-15-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619052716.16831-1-andrew.smirnov@gmail.com>
References: <20190619052716.16831-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need 8 byte array, DP_LINK_STATUS_SIZE (6) should be
enough. This also gets rid of a magic number as a bonus.

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
 drivers/gpu/drm/bridge/tc358767.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index f0baf6d7ca80..3f8a15390813 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -858,7 +858,7 @@ static int tc_main_link_enable(struct tc_data *tc)
 	u32 dp_phy_ctrl;
 	u32 value;
 	int ret;
-	u8 tmp[8];
+	u8 tmp[DP_LINK_STATUS_SIZE];
 
 	dev_dbg(tc->dev, "link enable\n");
 
-- 
2.21.0

