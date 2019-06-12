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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113AEC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A692086A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOvvwzHP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407827AbfFLIdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:33:21 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45180 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407739AbfFLIdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:33:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id bi6so5935155plb.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NNIcg/6FzHv0SaLr8o+2YXmb6sNSUGijrDWegBfUk58=;
        b=mOvvwzHPXtbeJQJgKDqkLn87pkjQYbEZSLBgDdPr55YYhw+JQsnz0osXnx9SgcHM5D
         gSzYvEVPSL8B+n/X+xXWESg15Z+8sGqkJxi79mI3UsMehPqzERZvOp/WNs6E/j9Xlsyq
         Rp/vsYZ4C62qzKb5k6grCJPVN9VToVF+hpYC28tEPuMZQ3m0ZXeWmXqxT5OIOTY8RcTM
         zzhd6hX9TnBrH1POf6+nxLfSXP2oRx7wcA3cPU0QhtPQ5TB4iflsgGyDcj0C/nMEHKhA
         FqCw4FjJwh91q/jqWkWUE2bA50rFcvRtZ5cn58PHtFeo+2L3qqSaWS4m77U6XRxTIkQ0
         pBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NNIcg/6FzHv0SaLr8o+2YXmb6sNSUGijrDWegBfUk58=;
        b=dmPg6+dQVxMRUgXhOEjrjqTfl1mSISZzOONhuYxOlMak0wQsWE3riJ8Vkw9W+pjwH3
         Jc+WdxudaNuAPB+nMUuNekQMcbqg92gV+nHLc6ba05Xr91f7Qc5fKPM9k7QkXz0VIDvt
         gbbfev4hM5WKNl77gOdGNur+aO9F8okw12XIT4Ap9jpOk4Olznlv2uT35SS+eoxoNdQp
         uFrauuHRyjXBxDPSiDykwPRukw2v6UWZ134OyLngrOineJXTh4i+dgyljVCzKaTCyoUQ
         fJRrtuJLayD/7ZwGAJUnmuvqQPU+ts2ekh5R7cqU8uUnvMdM3ldw1oc8YguBFg3QwzkC
         kioQ==
X-Gm-Message-State: APjAAAXQOjDHxsDFMKY231h7Lu7y5+bPGaJkbojgJ/344lbwasvySRAo
        n2TyAxJqH2IFde+7hWlYCXQ=
X-Google-Smtp-Source: APXvYqwx+IeAH5nURjmn+nAtr3THKqSpmGJOJTcW7P1j0EIpbWFp1Xgjqw3+CYbo4iwQey8e9QkC5g==
X-Received: by 2002:a17:902:20e9:: with SMTP id v38mr39306822plg.62.1560328398066;
        Wed, 12 Jun 2019 01:33:18 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d21sm18845991pfr.162.2019.06.12.01.33.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 01:33:16 -0700 (PDT)
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
Subject: [PATCH v5 08/15] drm/bridge: tc358767: Increase AUX transfer length limit
Date:   Wed, 12 Jun 2019 01:32:45 -0700
Message-Id: <20190612083252.15321-9-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190612083252.15321-1-andrew.smirnov@gmail.com>
References: <20190612083252.15321-1-andrew.smirnov@gmail.com>
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

