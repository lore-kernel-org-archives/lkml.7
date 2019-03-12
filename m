Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E07EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498A0214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JGvwP/aM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfCLJIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:08:15 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35638 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfCLJIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:08:15 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2C97oma084659;
        Tue, 12 Mar 2019 04:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552381670;
        bh=6wFsx3arYhDWGq7pYD0Rk6+oN8YiwFPms/p2/bt/LD4=;
        h=From:To:CC:Subject:Date;
        b=JGvwP/aMO1FF7D4I1GtH95qCjf6rqCioreKFyaWTqknVvO//8J0VzI+Y1FflyYYEw
         pYdwLIA1tcMVrZ6UUJiCvVWsrCCaTuKvTAhAEnRVh7glNJFzDatfCUaUkGh9vmvlfq
         Iln6naZBYWEYvYWG+XsSAGRJqGELxWM8Fq0stj/c=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2C97oeq048475
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Mar 2019 04:07:50 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Mar 2019 04:07:50 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Mar 2019 04:07:50 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2C97lFf007393;
        Tue, 12 Mar 2019 04:07:48 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?q?Christoph=20Vogtl=C3=A4nder?= 
        <c.vogtlaender@sigma-surface-science.com>
Subject: [PATCH] pwm: tiehrpwm: Update shadow register for disabling PWMs
Date:   Tue, 12 Mar 2019 14:38:46 +0530
Message-ID: <20190312090846.29519-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Vogtländer <c.vogtlaender@sigma-surface-science.com>

It must be made sure that immediate mode is not already set, when
modifying shadow register value in ehrpwm_pwm_disable(). Otherwise
modifications to the action-qualifier continuous S/W force
register(AQSFRC) will be done in the active register.
This may happen when both channels are being disabled. In this case,
only the first channel state will be recorded as disabled in the shadow
register. Later, when enabling the first channel again, the second
channel would be enabled as well. Setting RLDCSF to zero, first, ensures
that the shadow register is updated as desired.

Fixes: 38dabd91ff0b ("pwm: tiehrpwm: Fix disabling of output of PWMs")
Signed-off-by: Christoph Vogtländer <c.vogtlaender@sigma-surface-science.com>
[vigneshr@ti.com: Improve commit message]
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index f7b8a86fa5c5..ad4a40c0f27c 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -382,6 +382,8 @@ static void ehrpwm_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	}
 
 	/* Update shadow register first before modifying active register */
+	ehrpwm_modify(pc->mmio_base, AQSFRC, AQSFRC_RLDCSF_MASK,
+		      AQSFRC_RLDCSF_ZRO);
 	ehrpwm_modify(pc->mmio_base, AQCSFRC, aqcsfrc_mask, aqcsfrc_val);
 	/*
 	 * Changes to immediate action on Action Qualifier. This puts
-- 
2.21.0

