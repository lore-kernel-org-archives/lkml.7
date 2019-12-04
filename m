Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAE7C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFA6206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483333;
	bh=RyH6x5tps500GEhi3m6/ykodFWf390gC8VJsTd+Pcwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yYOmZ7+S2BZgv8o0G7ymmEgE5tpJrL9AbynhYys9Zpof/8BdoIKCAE+4gJObsYcM/
	 OLAzUn+gyfKCZ+PpbDHGPfAJuKhIyQG1R2EAngPcK27A09ssXC5kapD/+Wyv1IdF1e
	 hyx0wcnJ207R8RhWjlgI/m7yKFuL2iboA7J0o4QQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbfLDSOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:14:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:43476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731436AbfLDSOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:14:09 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 507172084B;
        Wed,  4 Dec 2019 18:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575483248;
        bh=RyH6x5tps500GEhi3m6/ykodFWf390gC8VJsTd+Pcwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JwC01kGnsjtJJp82iUN5+pqxj36vcSwUuZSUbbVYuLY+skbH5v9Cj/OtqgG1pCT0B
         VWNkjcLhgdVts2MiUTN074+CCbipa21mFKhIUpxeiyRO5u3lXzmUbg3Hc8OlaR/Hm8
         9kzgZ8qN9Wx7xqBiz/gBxqUbu/Kb0Ms4TsOidHqE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.9 112/125] pwm: Clear chip_data in pwm_put()
Date:   Wed,  4 Dec 2019 18:56:57 +0100
Message-Id: <20191204175325.926764879@linuxfoundation.org>
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
 drivers/pwm/pwm-berlin.c  |    1 -
 drivers/pwm/pwm-samsung.c |    1 -
 3 files changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -858,6 +858,7 @@ void pwm_put(struct pwm_device *pwm)
 	if (pwm->chip->ops->free)
 		pwm->chip->ops->free(pwm->chip, pwm);
 
+	pwm_set_chip_data(pwm, NULL);
 	pwm->label = NULL;
 
 	module_put(pwm->chip->ops->owner);
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -78,7 +78,6 @@ static void berlin_pwm_free(struct pwm_c
 {
 	struct berlin_pwm_channel *channel = pwm_get_chip_data(pwm);
 
-	pwm_set_chip_data(pwm, NULL);
 	kfree(channel);
 }
 
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -235,7 +235,6 @@ static int pwm_samsung_request(struct pw
 static void pwm_samsung_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	devm_kfree(chip->dev, pwm_get_chip_data(pwm));
-	pwm_set_chip_data(pwm, NULL);
 }
 
 static int pwm_samsung_enable(struct pwm_chip *chip, struct pwm_device *pwm)


