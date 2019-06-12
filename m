Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5D9C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3851F2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="teC0eGfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408681AbfFLIdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:33:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33054 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408666AbfFLId3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:33:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id x15so9251980pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=igoVoB0OnXmy6EuJPmaIUyWNG2dIdSj4pnrf3gfv3+o=;
        b=teC0eGfzqUO3ALXtEZBFv+MKaGc6LEKWBQiJAEeODv6JYqxVtDS3W+4mJ3f/IM7Rrl
         /nBZFQW/Aq56XVyB0zHcWM5QjtZinq/CVvkfKJiR4fPOcL9mdpbCMRr+AlGWS8MgK5Lu
         0R8Wa2PgAroQB8xFNAqU4qYPFARBqwrwwAj7T4g2Pnmv4iQ4cRCCPdCUm55RjsHLDic4
         anxaURAwP4BsQnqPOrkO550RdpAva/9SivhuijKsP392SD0X3CbVvQuFiumZ4oXYX3mQ
         O6vdTFP7ugHku9MNcQ/gtReA2mwI9lY+z2AAJs/owk5UH8eCpE0BzTML6d4DIM9yaX+N
         L+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=igoVoB0OnXmy6EuJPmaIUyWNG2dIdSj4pnrf3gfv3+o=;
        b=tPGh1UdP5t/OJ7wRru27Z2W/N0vVlCpi65U2jpe5REHihngMkW09X8OCmglV8LZpjj
         vv1Z2/C+QmWRj9UMJqVlTohDipDDyhVnHfNPTa9b8hNL8ysMe1TQCcn1ftwGVJ3bWcx/
         8LjPS6UmPBYKSLXWSSuUR4ezWEEJEE4F36UhqUCrFtKJyS6J2DiJsfHDiZXPms/o18WN
         62oPnBeAwgWToFjJmGE80PtgxJXNVKCCpZYFlmRIssy+6EZMtOku1O2YEBLUtLNKpdKB
         ZkJX4DDKDTaKXshJcOQvn2llsFq4zQXK06LSITTfngYgKBIf4SFUIQAP6ydy9OziaGub
         GCLg==
X-Gm-Message-State: APjAAAWWaTpopYDkL5LYsJrLwhR+21xAtQtTFLbz0NCNA84GGrNcnoGl
        cSWzxprC+jcJnKdltPavn48=
X-Google-Smtp-Source: APXvYqw/eK2VeKXRRyWQlJOOIhkx61Jz2WsrzwZ54xiu4xqwThRJaSbrxMJ9eo5gT6QDFRMc9Cy51A==
X-Received: by 2002:a17:90a:a790:: with SMTP id f16mr31979845pjq.27.1560328408785;
        Wed, 12 Jun 2019 01:33:28 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d21sm18845991pfr.162.2019.06.12.01.33.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 01:33:28 -0700 (PDT)
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
Subject: [PATCH v5 15/15] drm/bridge: tc358767: Replace magic number in tc_main_link_enable()
Date:   Wed, 12 Jun 2019 01:32:52 -0700
Message-Id: <20190612083252.15321-16-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190612083252.15321-1-andrew.smirnov@gmail.com>
References: <20190612083252.15321-1-andrew.smirnov@gmail.com>
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
index 81ed359487c7..b403c7bad156 100644
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

