Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B234DC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1532133D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbobLsOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfFGEq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 00:46:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34991 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfFGEqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 00:46:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id s27so488819pgl.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 21:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WJVHjkMmFxtpqrvFxD6VDdMJmS3mdvCf/T8uC/iQfpE=;
        b=UbobLsOMfL1T8Y0PMIQvPCXr7tTrhm91DzadWXd2tdTSVeCebke0OvMzDGsCLXNl/L
         zAC6aypF3axI2ZYyrDr5ekxwe6yoJK4CHetlk21tKv0O++yJrc6dnkmbQ2lBXduSh5hK
         kSihjYI194TaXo6ZdWUbg/Mj8q9Guxahr0C4cHXjC62tQ+f/E3D+13Bcg5iAc6DUyh+C
         LprWGC900VUMW82wXpkiyhoD+hx19F7MsNZUE42iiDxE+RnhFIz3u+B/Zk+IUlhMp+E9
         dlbQKj4AJx6n5V0nyoEo9ewd8uOYYUKEbg9W75fP7/V79/+BHwtXFPjZHbCpnPXfE0jo
         BQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WJVHjkMmFxtpqrvFxD6VDdMJmS3mdvCf/T8uC/iQfpE=;
        b=P9nt14vV+OrvQKMY0w3sZAPy1gc0Acvj7UsOuN83Q6Ykk6JeztXyt6KRpcPGRnGCsM
         BqvNNexnwtsnvw2iVaq1s6DVquIeLbxlDZxKkupoJtrn+kKNKpw49Z6hcH9pdWu338tX
         DBPEESbX2PyPBCLVdxkrygALXRTCLaik+e6ga3viwBHl8kLuda3YlMgGaik8vPz3QHGd
         MrQJSd3CvcOOGHutHgLo9fsC6Vhywa1oEvtiwOhPBjbnWulTm5bzt89nJM/jqXCZb6wa
         Bo1TQeHbFndNVCicS5I64m3kCSQJke0ZAt31hqOss/7Ewssaulbt/KUSKZi6BHUW1hg6
         eggw==
X-Gm-Message-State: APjAAAVLzQIRfKHsMCEUFm28TBAVpIzuFapLd1fbCZgy2eibk6uywaGk
        A9zYgL1ktAWXnTLiyhfPiB8=
X-Google-Smtp-Source: APXvYqzpGq5MoY1zujPlCb/7LP8knOsxcYR4CmRuTB/Esr7S6QMVgELMRyjDg+MeAh+WbRmfvPgwMQ==
X-Received: by 2002:a63:2160:: with SMTP id s32mr1099397pgm.431.1559882810101;
        Thu, 06 Jun 2019 21:46:50 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o13sm919516pfh.23.2019.06.06.21.46.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 21:46:49 -0700 (PDT)
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
Subject: [PATCH v4 15/15] drm/bridge: tc358767: Replace magic number in tc_main_link_enable()
Date:   Thu,  6 Jun 2019 21:45:50 -0700
Message-Id: <20190607044550.13361-16-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607044550.13361-1-andrew.smirnov@gmail.com>
References: <20190607044550.13361-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need 8 byte array, DP_LINK_STATUS_SIZE (6) should be
enough. This also gets rid of a magic number as a bonus.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
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
index 4a245144aa83..05c5fab011f8 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -874,7 +874,7 @@ static int tc_main_link_enable(struct tc_data *tc)
 	u32 dp_phy_ctrl;
 	u32 value;
 	int ret;
-	u8 tmp[8];
+	u8 tmp[DP_LINK_STATUS_SIZE];
 
 	dev_dbg(tc->dev, "link enable\n");
 
-- 
2.21.0

