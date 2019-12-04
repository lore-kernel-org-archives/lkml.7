Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FA5C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8425320674
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483159;
	bh=wLBO30qA8tZlK3OT5pGv0t3ty/ImslmbiEW2j4YjAG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sAmhRnt9jtsa/7miEXQN+nm8WM+7F3JBjNhZeS04NdQzWKIHk+06utbSINA172RRs
	 MDAaRLAi0zvib20dAIr2GwcktAUWY75z5Oj14YAn7HipGNTykHMT6WQ/IQ1NblNJa4
	 9gmxYxwiDyZ3rb2PNAo/3615OqsjHOeVYhmIR8Aw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbfLDSMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:12:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731614AbfLDSMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:12:35 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3599220863;
        Wed,  4 Dec 2019 18:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575483154;
        bh=wLBO30qA8tZlK3OT5pGv0t3ty/ImslmbiEW2j4YjAG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F1HvRGwzkKWRq0d5ns+cTCDtY6Y8G/mX4l06CnvbrMHTeKxjt1hjNbXzWtRRCSBQe
         tsH1fZkWnidw431fmSI6jhaDg/cNUqB+4PcalsbIG5HM/tnBXN/YPbDWnY8zvJdT+T
         DDvzoNqySIqx1jIKyjnshQVME+lGXYKPJXrDo8QY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 073/125] pwm: clps711x: Fix period calculation
Date:   Wed,  4 Dec 2019 18:56:18 +0100
Message-Id: <20191204175323.471018208@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175308.377746305@linuxfoundation.org>
References: <20191204175308.377746305@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shiyan <shc_work@mail.ru>

[ Upstream commit b0f17570b8203c22f139459c86cfbaa0311313ed ]

Commit e39c0df1be5a ("pwm: Introduce the pwm_args concept") has
changed the variable for the period for clps711x-pwm driver, so now
pwm_get/set_period() works with pwm->state.period variable instead
of pwm->args.period.
This patch changes the period variable in other places where it is used.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-clps711x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index 26ec24e457b12..7e16b7def0dcb 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -48,7 +48,7 @@ static void clps711x_pwm_update_val(struct clps711x_chip *priv, u32 n, u32 v)
 static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned int v)
 {
 	/* Duty cycle 0..15 max */
-	return DIV_ROUND_CLOSEST(v * 0xf, pwm_get_period(pwm));
+	return DIV_ROUND_CLOSEST(v * 0xf, pwm->args.period);
 }
 
 static int clps711x_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -71,7 +71,7 @@ static int clps711x_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct clps711x_chip *priv = to_clps711x_chip(chip);
 	unsigned int duty;
 
-	if (period_ns != pwm_get_period(pwm))
+	if (period_ns != pwm->args.period)
 		return -EINVAL;
 
 	duty = clps711x_get_duty(pwm, duty_ns);
-- 
2.20.1



