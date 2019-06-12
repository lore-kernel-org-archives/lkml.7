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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD463C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B2F2063F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nW+E4KDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbfFLIdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:33:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38377 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408650AbfFLId0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:33:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id a186so9220440pfa.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ww6brkr59ulFad1KL7LWJRPTHM4vzJU/q/AyY2cW8Es=;
        b=nW+E4KDzpmgWAUJ0Tpc6bOnHwrdWhmDOOQ0VZRQktRWGal0aB80LNVmsUJ8rixGYBf
         J42Qgvq1YrTh+vt47FXanyjj4cREHnqIgyCLpDUKRJ6NsReiH/Dwio1JGu0ErqIicQLm
         EaThXafTHKYS1bqZlSqJCJRRJ66+p3xB9Z1kHHsf5WhUhkzMhzxmCiFrM/CX5jZiTmZT
         dUFUmQEm2akdXAArBrV8XCemHKKV37Vg25pMl1aI9Dx2fpTjdFtD0lTieSLCvLUSGZ1J
         88EaQK0IKTCoOZ9dB+gsHEV8Nt38oBZRNek1VmLFL4KusxMcjUFGEPNdP+QFRd+F98cg
         Ledg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ww6brkr59ulFad1KL7LWJRPTHM4vzJU/q/AyY2cW8Es=;
        b=BOhXYjtDHEEhJnZUn4IUQVktEC8JwVfhu3ADlMWgO+PSk4d+o2d2plGI6QU6cMIIFj
         1MBYdEl78V/NyuRj9iOxvea2irk3qwQwoZmioETKmvh6D2g3eAv/RRTPADXLfocavr8+
         LXlazakREML+Eir/HGIur2aGW3IrbRXGFITqkUKTnY1C9BRzkisUeD+V+Apm46Hm6wbb
         9cM/0PuqYyhK8WQPBRgt152TQkLEHhI+f4tF2Rvx7/y9Z/lQuAf67tB+bEQ/eh4xvhMz
         AbxCrpHOWVD1SUJ9uQ69pwAiDRjZ6md8XwTwED5T2VI81jt3hYcIKHhqL3IX99oh7Axb
         b/4Q==
X-Gm-Message-State: APjAAAVUSIBAp1RsWtkrysb3Ivz0Kci9yjCxgSGcEajgK3kqEdtxf2IB
        /Orwuk+2H7aaO4GjQE2qLqE=
X-Google-Smtp-Source: APXvYqyxl34p06cYUEj4S/jd5SfPoeVgMlKjFMraSOKtxEop59Si1HJYqH2IDxpdPh58M5IZ3/z9iA==
X-Received: by 2002:a17:90a:8a10:: with SMTP id w16mr31528113pjn.133.1560328405864;
        Wed, 12 Jun 2019 01:33:25 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d21sm18845991pfr.162.2019.06.12.01.33.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 01:33:25 -0700 (PDT)
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
Subject: [PATCH v5 13/15] drm/bridge: tc358767: Simplify tc_aux_wait_busy()
Date:   Wed, 12 Jun 2019 01:32:50 -0700
Message-Id: <20190612083252.15321-14-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190612083252.15321-1-andrew.smirnov@gmail.com>
References: <20190612083252.15321-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We never pass anything but 100 as timeout_ms to tc_aux_wait_busy(), so
we may as well hardcode that value and simplify function's signature.

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
 drivers/gpu/drm/bridge/tc358767.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 28df53f7c349..01ca92a6d9c8 100644
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

