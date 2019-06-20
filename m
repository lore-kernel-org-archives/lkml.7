Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D768C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C582089C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561053592;
	bh=uWqTkvhAbeBAIbcFMNUDEK4AMMCS5aJxq5r700jjb70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0UiPKiiMJQq8eBUOlERJ3JP3OddXM0EYTvhCEVmu3AzV4hkogNmiiEolH63Tsjo0B
	 p1GUjtU+JfVvVexLDHx0ntcQmon1spu24WbLcD97vmKkTSf88D3Clkzo8Ubhgw/RwX
	 vWl/YrrHw3KDBiDOORRpKdRFVKfkh/YM8FJtr5vk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfFTR7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:59:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbfFTR7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:59:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76B4721537;
        Thu, 20 Jun 2019 17:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053589;
        bh=uWqTkvhAbeBAIbcFMNUDEK4AMMCS5aJxq5r700jjb70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mbl0TR7lXuAbKtaAwkvyfHpuGH2udR3IIW3U7al79KLRKc6ueZNtH9TmPVi94JArN
         MQpMw+dqf+9Z0Ju4NQzkz/BbC9tE5GGnq1rgZZreDANa7GR+kpmXf9PCQc+NcepQ+J
         Ldgz/M1vsuAPTFDXXeoV4oibyemi99Y9OJcQPVLA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christoph=20Vogtl=C3=A4nder?= 
        <c.vogtlaender@sigma-surface-science.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 34/84] pwm: tiehrpwm: Update shadow register for disabling PWMs
Date:   Thu, 20 Jun 2019 19:56:31 +0200
Message-Id: <20190620174343.157192128@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174337.538228162@linuxfoundation.org>
References: <20190620174337.538228162@linuxfoundation.org>
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
index 062dff1c902d..ede17f89d57f 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -385,6 +385,8 @@ static void ehrpwm_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	}
 
 	/* Update shadow register first before modifying active register */
+	ehrpwm_modify(pc->mmio_base, AQSFRC, AQSFRC_RLDCSF_MASK,
+		      AQSFRC_RLDCSF_ZRO);
 	ehrpwm_modify(pc->mmio_base, AQCSFRC, aqcsfrc_mask, aqcsfrc_val);
 	/*
 	 * Changes to immediate action on Action Qualifier. This puts
-- 
2.20.1



