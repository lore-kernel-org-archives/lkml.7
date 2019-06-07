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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE72C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6255E21019
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoVJ+oYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfFGEqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 00:46:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36675 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfFGEqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 00:46:39 -0400
Received: by mail-pf1-f195.google.com with SMTP id u22so467859pfm.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 21:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NNIcg/6FzHv0SaLr8o+2YXmb6sNSUGijrDWegBfUk58=;
        b=HoVJ+oYD8J4ULPS9O8lxZd8yvoPINb8pNDoitMPebyRoxetwy3X8gqUHTiCymIAA4x
         9FRpH6by3GCn4DvwoGa2vJ2dw1wxmwjj1PgmZkEILGuBiq5EKm+8RVetgs8ulQEqON/a
         1KNu4Zi3RLzCUhRuw6PbUvaRrlux/CKHaDsEpc3CYpTM+z7vpn4VcY+wotHFSrWQzcIB
         76nTrVbiWF31h288acQJXHUuKaNGEkHmG1P/xrQQvhTLUlK2KTsWacQMlvlBK4pZ8vjn
         o3rPtrbxfGy6n3Z2b1A/SBC6GLc/A+62Any+6k00II8vxT4ypfUa1x+8LK53rwmswWqE
         DXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NNIcg/6FzHv0SaLr8o+2YXmb6sNSUGijrDWegBfUk58=;
        b=e8XD/VTxbi8J8SUMX+UuEtD5afHFz6fi2kE4FpmVwiggK0kh5BWqmNVO5FkADqygxg
         BG4O3mQK4Gr50W8cc5yUstkfW3DkcbZMPyyxW8CO/BasEz5rsq6DWcHAvNbfekNHMQYR
         X9KwduPxK59kg7fNFYmsgEswfeifcm0TBGFAIKX7FWLe2QpIotTqdyezeSJYYFH3MQE1
         ZkhHfKlEqXSCZEAZtl7vEll3q0DKJibOlGV6wAVhtFyHfwcnyuXN2tvr/C6pKrSibcxj
         qEtRKtvbJLQbEMV1XYT5oDA1ODuRm0DHvqs/9207LUMjD/IGglO90LAYtoe9eGrouFHQ
         QZjw==
X-Gm-Message-State: APjAAAW5pc2S5L5bs8Y8crQiWOQik9/ErWNi5XwxMtBbvFDrfFpu1WcT
        9joNZEBQ7UY4PkdD7wgFQgQ=
X-Google-Smtp-Source: APXvYqxhtmD8MwY1SN9meHAooF12SA/dpknHU/fATHAHPHjtZqm+E1Y1cCzspQ8puHBgKMzprCdtOw==
X-Received: by 2002:a17:90a:a397:: with SMTP id x23mr3542121pjp.118.1559882798281;
        Thu, 06 Jun 2019 21:46:38 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o13sm919516pfh.23.2019.06.06.21.46.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 21:46:37 -0700 (PDT)
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
Subject: [PATCH v4 08/15] drm/bridge: tc358767: Increase AUX transfer length limit
Date:   Thu,  6 Jun 2019 21:45:43 -0700
Message-Id: <20190607044550.13361-9-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607044550.13361-1-andrew.smirnov@gmail.com>
References: <20190607044550.13361-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheet tc358767 can transfer up to 16 bytes via
its AUX channel, so the artificial limit of 8 appears to be too
low. However only up to 15-bytes seem to be actually supported and
trying to use 16-byte transfers results in transfers failing
sporadically (with bogus status in case of I2C transfers), so limit it
to 15.

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
index e60692b8cd69..8b53dc8908d3 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -354,7 +354,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 			       struct drm_dp_aux_msg *msg)
 {
 	struct tc_data *tc = aux_to_tc(aux);
-	size_t size = min_t(size_t, 8, msg->size);
+	size_t size = min_t(size_t, DP_AUX_MAX_PAYLOAD_BYTES - 1, msg->size);
 	u8 request = msg->request & ~DP_AUX_I2C_MOT;
 	int ret;
 
-- 
2.21.0

