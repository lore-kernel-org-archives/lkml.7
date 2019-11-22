Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B64C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6C4208A1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420729;
	bh=Hk1LfhPBk8mf4j0A6gLA3Gxbg20jEn3kThQ4rBD+a2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1gDcjhAdfyrpWtJ0tAEABv+rLOxM2U/4cD1FYqkLM9JuHbKclO9qD88riOAlf1NIz
	 QNgBe1VfLLQc4o7jZJbVyz+MiG+kH2VgTB67w3YeU+FDhK3uRRmR8Sd2nlyjWxvr+G
	 1vFEun/yGmR2gvINA6PotDJonTlYiJzwB84R/eMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731718AbfKVLF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:05:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:32896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730755AbfKVLFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:05:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4B9B207FC;
        Fri, 22 Nov 2019 11:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420723;
        bh=Hk1LfhPBk8mf4j0A6gLA3Gxbg20jEn3kThQ4rBD+a2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ClfBvbA8kVKFmmyT/SoDPFwBcWmYXIHp/zKuXz/k/TwqSy0eKaIS14hjeDus5A26z
         /5Hn0pYckzPsLWZXX2vBIIa2NAqkTbOLf4txIYFXubxEKnpwMxVPcIqyFb2OvxacRo
         BKShQiECGb9ZuHI1bylbvzfSgUeYCxnQoOBxbaPI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kun Yi <kunyi@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 203/220] hwmon: (npcm-750-pwm-fan) Change initial pwm target to 255
Date:   Fri, 22 Nov 2019 11:29:28 +0100
Message-Id: <20191122100928.459962906@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kun Yi <kunyi@google.com>

[ Upstream commit f21c8e753b1dcb8f9e5b096db1f7f4e6fdfa7258 ]

Change initial PWM target to 255 to prevent overheating, for example
when BMC hangs in userspace or when userspace fan control application is
not implemented yet.

Signed-off-by: Kun Yi <kunyi@google.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/npcm750-pwm-fan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-fan.c
index b998f9fbed41e..979b579bc118f 100644
--- a/drivers/hwmon/npcm750-pwm-fan.c
+++ b/drivers/hwmon/npcm750-pwm-fan.c
@@ -52,7 +52,7 @@
 
 /* Define the Counter Register, value = 100 for match 100% */
 #define NPCM7XX_PWM_COUNTER_DEFAULT_NUM		255
-#define NPCM7XX_PWM_CMR_DEFAULT_NUM		127
+#define NPCM7XX_PWM_CMR_DEFAULT_NUM		255
 #define NPCM7XX_PWM_CMR_MAX			255
 
 /* default all PWM channels PRESCALE2 = 1 */
-- 
2.20.1



