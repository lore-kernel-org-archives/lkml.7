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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A648C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0967B21902
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExBJCigH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfCVD3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 23:29:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41032 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbfCVD3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 23:29:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id k11so490366pgb.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 20:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1SpLWn2GNZxw8TpsUtWTa95KkSKBcIOU+P/XIiFsSiI=;
        b=ExBJCigHEwuSNm8pFYe5VfRDt3bPfhu1chj0ZBLPO7EvUOwWM0hKSzvPggK8vO7irL
         vKLPf4b/aFg346Os1URvrw556chW+wPGtsrG/U2ELc8Z0fKA5sopu4uwMRqdH+pSOgP0
         ZIbyRzMtSv18l4cHrbMfTu42mYN65RB20wMSSLht38RbRcaTLW/DQlXOT6jtyUVOlpit
         w0WDnrKfEwEn/n7KBCrhEA2/qS9RlfAawXsVgFaluIa1mYYWuduq++3qu665+LkH+44v
         k1ltbSzxg9id4vrhzvXZ3oolD52ZPIGIf4OiYmTx43R5QJUCuFLB0ncTOYjwf4aWHD9B
         JfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1SpLWn2GNZxw8TpsUtWTa95KkSKBcIOU+P/XIiFsSiI=;
        b=WyfcYLdW8fBcduWMLDYh/vicpCtM4w8GqHYG9Yrlc4YbOLJ5SVSlx5/frzczexZCj7
         PLLv9QHwbNTZgxMPQ76J1J9lIVNLRqXjIfkU2RAUH+9Q6gjgGKNLEyHFYEqtdzjHYvPr
         Sr2blMI+e3sfkpymX/RRaeVuthlex/UDztjCXyvzLK1z2xBtX3JdY/ZNYQIt5Tq2Q4il
         R68QzuLdiaE5GBAIe8nHY2pCjHnXwTxPoIK4nuLjyuM1HRcIcx9L5PNLrLC2BGvz5Ae2
         FTl0Dy5pHe5PG2JsJAojSlBiLoEAoDHikAJYUzGO769K1sF/A1Ddr4BZgRQ3eCGeVLMd
         ejAQ==
X-Gm-Message-State: APjAAAU8UTbuVBMUSaXieM9ICkxdtV/PhVBli/YGFph6LCKyBl4Nv7RO
        S/hYcxzu8NeDD/DoWzdgFs0=
X-Google-Smtp-Source: APXvYqwDNKLTMzuI6cUfCSzer7pg5nvTND+OyJIR6wrp6alk+O0roVaCrjZib/qKZ5KWhlhfVnhE9w==
X-Received: by 2002:a63:d5f:: with SMTP id 31mr6692027pgn.274.1553225372709;
        Thu, 21 Mar 2019 20:29:32 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o76sm16154476pfa.156.2019.03.21.20.29.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 20:29:32 -0700 (PDT)
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
Subject: [PATCH v2 13/15] drm/bridge: tc358767: Simplify tc_aux_wait_busy()
Date:   Thu, 21 Mar 2019 20:28:59 -0700
Message-Id: <20190322032901.12045-14-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322032901.12045-1-andrew.smirnov@gmail.com>
References: <20190322032901.12045-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We never pass anything but 100 as timeout_ms to tc_aux_wait_busy(), so
we may as well hardcode that value and simplify function's signature.

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
 drivers/gpu/drm/bridge/tc358767.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index f66a1c4a2047..07d568761463 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -280,10 +280,9 @@ static inline int tc_poll_timeout(struct tc_data *tc, unsigned int addr,
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
@@ -354,7 +353,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	u32 auxstatus;
 	int ret;
 
-	ret = tc_aux_wait_busy(tc, 100);
+	ret = tc_aux_wait_busy(tc);
 	if (ret)
 		return ret;
 
@@ -381,7 +380,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	if (ret)
 		return ret;
 
-	ret = tc_aux_wait_busy(tc, 100);
+	ret = tc_aux_wait_busy(tc);
 	if (ret)
 		return ret;
 
-- 
2.20.1

