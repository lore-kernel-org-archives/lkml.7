Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4E4C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4394B20863
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482434;
	bh=CnR8VqjPbUSexk0XC+b+VtAavmvPNRvwVEfAPui/OqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1tThe1T8Z+0DM4uPu5NWn/nR1XJX24Kl90pUd2HDl2W/uaqYnQjC5YTKtNH6yQIwc
	 G7g8KO2GK0VqE/GXHFUwiPasTfvc5FR9ycEl/DEP5PcQRCsQuJIK/30wkBCdjPA/VK
	 a4GLhE/gqWTb9V0k9eziR3gAMPppRiW+w2hflAjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfLDSAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:00:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:39110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729359AbfLDSA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:00:29 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 003A720863;
        Wed,  4 Dec 2019 18:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482428;
        bh=CnR8VqjPbUSexk0XC+b+VtAavmvPNRvwVEfAPui/OqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iuvxDbweGKZtZppFNYljV/VRKnLIk6M/bBoMcsLDm1KdB0DYsozQmRCgtslNsBpKF
         /5TaPizTeEIoTn+vBdMHXrgpWqmbT2XmDamE3EHHVb4ItHIOUq5qWMTw5gM/oVpIut
         jPPrOi5UTiCy8bfzcURBkCN6gkSM66DjWuoCMqpQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.4 82/92] pwm: Clear chip_data in pwm_put()
Date:   Wed,  4 Dec 2019 18:50:22 +0100
Message-Id: <20191204174335.134718709@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204174327.215426506@linuxfoundation.org>
References: <20191204174327.215426506@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

commit e926b12c611c2095c7976e2ed31753ad6eb5ff1a upstream.

After a PWM is disposed by its user the per chip data becomes invalid.
Clear the data in common code instead of the device drivers to get
consistent behaviour. Before this patch only three of nine drivers
cleaned up here.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pwm/core.c        |    1 +
 drivers/pwm/pwm-samsung.c |    1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -781,6 +781,7 @@ void pwm_put(struct pwm_device *pwm)
 	if (pwm->chip->ops->free)
 		pwm->chip->ops->free(pwm->chip, pwm);
 
+	pwm_set_chip_data(pwm, NULL);
 	pwm->label = NULL;
 
 	module_put(pwm->chip->ops->owner);
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -226,7 +226,6 @@ static int pwm_samsung_request(struct pw
 static void pwm_samsung_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	devm_kfree(chip->dev, pwm_get_chip_data(pwm));
-	pwm_set_chip_data(pwm, NULL);
 }
 
 static int pwm_samsung_enable(struct pwm_chip *chip, struct pwm_device *pwm)


