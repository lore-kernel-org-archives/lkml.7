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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EB3C46460
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9F3208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 04:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qit71R6h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfFGEq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 00:46:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41865 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfFGEqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 00:46:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id q17so451973pfq.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 21:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ATu26WvvNPiJ9Ah/tmZWwxGXI/i8AcwKGoFEMQ2U0A4=;
        b=Qit71R6hsjTt2C4V/Wmws+Xb8tajqL1zmFx25XZOZkLaLnybvYDuq2g3DOfwRErqu4
         YUfs6BWhrZeulSYQPt0iTiYCnSiWyT0Q548h4FFds+OlzCOyu7ZaoK9GkfsLjKNomynO
         LIEGZ+rvvioEEtU2eqbUpTe8Ki6OMkD8VbIElvbUU6Lml4Xy9HW99/TL18ROZhaPf6Wm
         YownnNe5HLc+1BzuUy28y1uoOTzBUk+jxHZODcxx8fv/Iwv913Zp+PY9/v2QlHDHQoiE
         T5OwKc4trf32G6q3HsjgHFEeU6JEPWTLgVokIIm8xpEEbbacOTc3lEy+GhJ+6wEVLWr+
         ZcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ATu26WvvNPiJ9Ah/tmZWwxGXI/i8AcwKGoFEMQ2U0A4=;
        b=UYKSnR7bf21TIIZDnE8FoTIySUIN0FFd6eVumMAJGM7NkKTgAEEbc4xsCyLOQSL9Vr
         fRHfafwFgypXeLJDYEYBenqni5igxNTPZbYcYYbZbtqgnNrcf4O9MIJu0R1OWpSlaEL9
         OSC5hJb7oQzD2aXsBAUEAemgdForMOJFbh6aP3UDN07pvif2QJp3B/OmPIEUvxasuJAv
         WWkoqPTHNJ1hEVAkVwKndw7Ma1BZ4mIhsdUE6zS9wnwlGnjJMRdcOzoKibpdyk5pizsQ
         efzNTr+J6xH/HUgr3yfk0iR78Ji9qNLlLt873qT+7fAuPGmPm5vgaXu2WcQaQqUYf1qW
         Qurw==
X-Gm-Message-State: APjAAAW1fXt+dhSfPFl241QvLFmZbEUVOux4E/bHbKaFpMinrm1RVYPa
        gSfnJRWKuSChm3KgYAYKgX8=
X-Google-Smtp-Source: APXvYqya01PmMslldpFFJmX9gxMsFDFW7DAkTuaAUIFFvO4jrqj3mnDiJc+NAIWK6NlFp8zLLAPNlQ==
X-Received: by 2002:a17:90a:ba81:: with SMTP id t1mr3370811pjr.139.1559882806633;
        Thu, 06 Jun 2019 21:46:46 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o13sm919516pfh.23.2019.06.06.21.46.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 21:46:45 -0700 (PDT)
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
Subject: [PATCH v4 13/15] drm/bridge: tc358767: Simplify tc_aux_wait_busy()
Date:   Thu,  6 Jun 2019 21:45:48 -0700
Message-Id: <20190607044550.13361-14-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607044550.13361-1-andrew.smirnov@gmail.com>
References: <20190607044550.13361-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We never pass anything but 100 as timeout_ms to tc_aux_wait_busy(), so
we may as well hardcode that value and simplify function's signature.

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
 drivers/gpu/drm/bridge/tc358767.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index c994c72eb330..e747f10021e3 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -294,10 +294,9 @@ static inline int tc_poll_timeout(struct tc_data *tc, unsigned int addr,
 					sleep_us, timeout_us);
 }
 
-static int tc_aux_wait_busy(struct tc_data *tc, unsigned int timeout_ms)
+static int tc_aux_wait_busy(struct tc_data *tc)
 {
-	return tc_poll_timeout(tc, DP0_AUXSTATUS, AUX_BUSY, 0,
-			       1000, 1000 * timeout_ms);
+	return tc_poll_timeout(tc, DP0_AUXSTATUS, AUX_BUSY, 0, 1000, 100000);
 }
 
 static int tc_aux_write_data(struct tc_data *tc, const void *data,
@@ -350,7 +349,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	u32 auxstatus;
 	int ret;
 
-	ret = tc_aux_wait_busy(tc, 100);
+	ret = tc_aux_wait_busy(tc);
 	if (ret)
 		return ret;
 
@@ -377,7 +376,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	if (ret)
 		return ret;
 
-	ret = tc_aux_wait_busy(tc, 100);
+	ret = tc_aux_wait_busy(tc);
 	if (ret)
 		return ret;
 
-- 
2.21.0

