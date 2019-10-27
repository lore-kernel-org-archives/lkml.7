Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C47CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1DD20B7C
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210897;
	bh=lhAvbhfQlTnRyecNnxC92jiplQHtUjhVHPGI6Ea5VTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0wRAg3qvG+Xr/e3DTND/eGGHNOamvrZzVKQp4aCgCzEJWGKzjC7vt4/Kn8mIwp4vd
	 YShwP6sMUdAk5PgTNhaCgrryfgoPH3o2Ugu1rRTQuAQoMru0uyX1xeCamqmLtKupw7
	 YoJO03i5YrmaGwRjfgR2krrTq2t77cIUMXhgfPzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbfJ0VO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:14:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730533AbfJ0VOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:14:53 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07EBF214AF;
        Sun, 27 Oct 2019 21:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210892;
        bh=lhAvbhfQlTnRyecNnxC92jiplQHtUjhVHPGI6Ea5VTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Su3VFObjISlx3r7hcb4AMANNvXK9eCOwXlyLy7uJnh8Yq/8Y1u/HowBywyLvueMbx
         kH/icvMqb9SyrYul7XYIJ/8AFjkA2kUo4M3rtDfdoDRc5Kw8t0p3o7VKZgVEyvMkb7
         XmNY2lA+twIhr3uzHOx4D8rWYZKUrLc9OJBQ0sFc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.19 53/93] Input: da9063 - fix capability and drop KEY_SLEEP
Date:   Sun, 27 Oct 2019 22:01:05 +0100
Message-Id: <20191027203301.409557915@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203251.029297948@linuxfoundation.org>
References: <20191027203251.029297948@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Felsch <m.felsch@pengutronix.de>

commit afce285b859cea91c182015fc9858ea58c26cd0e upstream.

Since commit f889beaaab1c ("Input: da9063 - report KEY_POWER instead of
KEY_SLEEP during power key-press") KEY_SLEEP isn't supported anymore. This
caused input device to not generate any events if "dlg,disable-key-power"
is set.

Fix this by unconditionally setting KEY_POWER capability, and not
declaring KEY_SLEEP.

Fixes: f889beaaab1c ("Input: da9063 - report KEY_POWER instead of KEY_SLEEP during power key-press")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/misc/da9063_onkey.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/input/misc/da9063_onkey.c
+++ b/drivers/input/misc/da9063_onkey.c
@@ -248,10 +248,7 @@ static int da9063_onkey_probe(struct pla
 	onkey->input->phys = onkey->phys;
 	onkey->input->dev.parent = &pdev->dev;
 
-	if (onkey->key_power)
-		input_set_capability(onkey->input, EV_KEY, KEY_POWER);
-
-	input_set_capability(onkey->input, EV_KEY, KEY_SLEEP);
+	input_set_capability(onkey->input, EV_KEY, KEY_POWER);
 
 	INIT_DELAYED_WORK(&onkey->work, da9063_poll_on);
 


