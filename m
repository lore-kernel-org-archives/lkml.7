Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA94CC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D54F2089C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561053947;
	bh=0r8EB9A95Hx3AvgT5QDsc/80bosvyDPT1B1h6AUuCrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l/hj2pIZwCsmHxpcAV2Hkh3xByvQR2jqbySzBrQEvlmSTuYA2+0nSYW2X8VplSKod
	 MAVSLUvTCoAJyKFAvhNbp4ur5jEWTeO9/j+9wZPBmf6CBEqPRfeiYgxS2TsgbeELFS
	 Rl29h2O3kTq/kbuqh/eaUMRYyZiWAZcUmnJvH4gY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfFTSFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:05:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbfFTSFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:05:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CAD4204FD;
        Thu, 20 Jun 2019 18:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053940;
        bh=0r8EB9A95Hx3AvgT5QDsc/80bosvyDPT1B1h6AUuCrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rdQrKs28LEIbGxkCtGcGm4t0WCjETfEgq4g8t4MWDgKjNQZ0KMU6MkjMK4tx73azx
         JINjBdNJRlf4k8JeY1LORGZg3GvXIiuLqL6jY/6XjZJlz8Trgf5PlYIpBhlfrS+Z/S
         +XR8+F7NtDMHn+2Q1PfmpflwOiPORisFabWsCnOs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christoph=20Vogtl=C3=A4nder?= 
        <c.vogtlaender@sigma-surface-science.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 051/117] pwm: tiehrpwm: Update shadow register for disabling PWMs
Date:   Thu, 20 Jun 2019 19:56:25 +0200
Message-Id: <20190620174355.377244550@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174351.964339809@linuxfoundation.org>
References: <20190620174351.964339809@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b00ef53053191d3025c15e8041699f8c9d132daf ]

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
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-tiehrpwm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index c0e06f0c19d1..9a232ebbbf96 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -383,6 +383,8 @@ static void ehrpwm_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	}
 
 	/* Update shadow register first before modifying active register */
+	ehrpwm_modify(pc->mmio_base, AQSFRC, AQSFRC_RLDCSF_MASK,
+		      AQSFRC_RLDCSF_ZRO);
 	ehrpwm_modify(pc->mmio_base, AQCSFRC, aqcsfrc_mask, aqcsfrc_val);
 	/*
 	 * Changes to immediate action on Action Qualifier. This puts
-- 
2.20.1



