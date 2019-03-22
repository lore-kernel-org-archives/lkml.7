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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07013C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E1621904
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beI7DWud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfCVD33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 23:29:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33093 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbfCVD30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 23:29:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id i19so551096pfd.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 20:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7PFJY4F1JUiusPvb41BXA5uI1ZQU6Bw5nPmkYpdoAqw=;
        b=beI7DWud71DA6lHK2sfCfBxEzaQkDTb+DKgOvFNOmDRvcg04uCeIC1LSzmImP9qmV1
         FTax5uV2vwgp2AKc7mr/rRTyeoHkIOwYgQGHiApXRX4mXsnP33v/Us6vjWoz0Wa4OMrG
         gZMm5T5S6qSKI+zwnCVxRSN3sLl39UG9IVLl26WJK2/pbUFOsFPsBsWNmRYYDxPU0GKi
         creyIAyL7BTtTwhdL5JIsugVIQMoqT8tnlUmfaPTkK21GYtkG/8ixM+s135nGG7JvVRi
         oQHSh5ILR0MSlU5SMXID/TcrKFuPeevyh17bggKAZlaFE8HA7fYmXt4caiCQvfqhkEzH
         3NyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7PFJY4F1JUiusPvb41BXA5uI1ZQU6Bw5nPmkYpdoAqw=;
        b=YtDEU6z8cvUUK7eCndpjLab1vnNteA6uaPEBrB8dlXfepfWBxaSOykauBf2gzjuzA+
         8FODbk1GXiXCw2+Q4ba3QmljXGPavMlLfZjKjpRj4pePzxLd/EfdPi97gR5eS5d8XgNe
         wjD4rqoOgIbIsY2Yvhr2LQRts7SAaJwhM/kX5MJhJN672i7niHLPhBmRAUyNvk+OIuTK
         LjSSUY96y8U/X8eeC2PNMXW2bylWbWLsOVQaiPrl9BL3WHSDhSjccPoziSQbceEPxXI3
         tyq2X8iXzFhohM8XuRoAfkngXzzaj/BFWKLHTL10FPtw8SgH0jJRUhLm5Uz4KZuqqIP2
         FOPg==
X-Gm-Message-State: APjAAAUO4cEQrUOV27UgtILdPEF1klzXov+OeJuAOdhBsZ1W+CsboJP3
        EwrGX2vHrxh9AWhB9JRfgpPFjshOimc=
X-Google-Smtp-Source: APXvYqxlHPyXfysWcrUMfV8wleo8TFiORUjolB067nDVU57TUXU6gmvyBnZN+WcQ9tUEj+8wiGVrGw==
X-Received: by 2002:a63:f556:: with SMTP id e22mr6766222pgk.321.1553225365202;
        Thu, 21 Mar 2019 20:29:25 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o76sm16154476pfa.156.2019.03.21.20.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 20:29:24 -0700 (PDT)
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
Subject: [PATCH v2 08/15] drm/bridge: tc358767: Increase AUX transfer length limit
Date:   Thu, 21 Mar 2019 20:28:54 -0700
Message-Id: <20190322032901.12045-9-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322032901.12045-1-andrew.smirnov@gmail.com>
References: <20190322032901.12045-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheet tc358767 can transfer up to 16 bytes via
its AUX channel, so the artificial limit of 8 apperas to be too
low. However only up to 15-bytes seem to be actually supported and
trying to use 16-byte transfers results in transfers failing
sporadically (with bogus status in case of I2C transfers), so limit it
to 15.

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
index 21374565585d..8adaac5ca271 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -358,7 +358,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 			       struct drm_dp_aux_msg *msg)
 {
 	struct tc_data *tc = aux_to_tc(aux);
-	size_t size = min_t(size_t, 8, msg->size);
+	size_t size = min_t(size_t, DP_AUX_MAX_PAYLOAD_BYTES - 1, msg->size);
 	u8 request = msg->request & ~DP_AUX_I2C_MOT;
 	int ret;
 
-- 
2.20.1

