Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799FEC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4AB2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BySmcBdr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfFEHFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:05:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36887 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfFEHFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:05:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id 20so11881729pgr.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 00:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d2izPr39F3F0VHRMOQwIEoQfvTiBqRIbKynBXN0NUa0=;
        b=BySmcBdri3W99nnsQSAV43VhgYjxYbf/4s1H2Ffq8FJOzXMN069qRgTdjBnaBeXkKe
         hyOQGqkICDAwG9O/U+MqLX3sX8C5cWdggkkH5I5PUYi6ALpkAfYnyKBwfMuSGHE03tGV
         +4eS3liPY8ScJWNsOwZbtepvi9X8H/xWmeApo+/0QzjdkD2LicPI/WhnFLM5HcyS1Usd
         VEwauu6vJt8efqTX3u8HgwaXCBX2GCwjNmbwJK9jBF/7fbz6sMOz4uKZPDOAckDiw9Nc
         vCe3jvE+6mHuL+l/IW7M29zfaLOGvuWh2ajB2HcMfXGRFeXi5KKlPFWFfYAb2AZYQJdx
         8nQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d2izPr39F3F0VHRMOQwIEoQfvTiBqRIbKynBXN0NUa0=;
        b=p/Oz57xSMOfTn8wcCldx02ZlITMD0qQCwRh41cXndBmKCNEnhtMByl9BfP1XXNALVO
         HUkOlNhbahtgAW4xqPRnb4kwBYcpzJxe7uUVYOAZLH+1Z14fqpgTemxsgzoBJ0w6XJA6
         4TKZ0qNFLGwMfRTz0nAef8EeG2BVhiqdX5LR4lfy8zcXfZyjz+KRxutf1HQye2Er5K9I
         IN4nFXx2MyWlBNe0LITqQA8cmYgaDqm1Fh/4hxRSYC/wcaWfNC+uotqxcAtqDQFvArFI
         /RM24lXgpHm3iuPVgbAznsElIU4AppKr95TOeCOYTPYW8zIQDbztII2raSIRtSC7k8rl
         B2eg==
X-Gm-Message-State: APjAAAVZeSXJkESz0Z+9iIdr8idKuOEyHL59hHR96JuJ0oJ8MhXdHlXI
        CuXBa791nStiAsWSdXPHXoQ=
X-Google-Smtp-Source: APXvYqxifsh8LBT0sk9LAzZyDwQ07jHD8F1USZwx/MC+2mwHbldjh1VnrJKg1q3DGXF67e3q25xX8w==
X-Received: by 2002:a63:a449:: with SMTP id c9mr2466787pgp.149.1559718343138;
        Wed, 05 Jun 2019 00:05:43 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d132sm6527348pfd.61.2019.06.05.00.05.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 00:05:42 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/15] drm/bridge: tc358767: Simplify tc_aux_wait_busy()
Date:   Wed,  5 Jun 2019 00:05:05 -0700
Message-Id: <20190605070507.11417-14-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190605070507.11417-1-andrew.smirnov@gmail.com>
References: <20190605070507.11417-1-andrew.smirnov@gmail.com>
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
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index a04401cf2a92..4fe7641f84ee 100644
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
@@ -370,7 +369,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	u32 auxstatus;
 	int ret;
 
-	ret = tc_aux_wait_busy(tc, 100);
+	ret = tc_aux_wait_busy(tc);
 	if (ret)
 		return ret;
 
@@ -397,7 +396,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	if (ret)
 		return ret;
 
-	ret = tc_aux_wait_busy(tc, 100);
+	ret = tc_aux_wait_busy(tc);
 	if (ret)
 		return ret;
 
-- 
2.21.0

