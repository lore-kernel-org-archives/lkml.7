Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79D1C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB19E208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uIdECYbC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbfFGSZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:25:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36220 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731801AbfFGSZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:25:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id u22so1653174pfm.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 11:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RPfYQVtr7i2X0SwwuFnYuXXFGb6jZvwJFY0341/Mfgk=;
        b=uIdECYbC085+knZoFzAaRksKjg8/aXU9R+5ZqF4ECkhA6Q9dFnVMse1iwibe9u4Flz
         47MhQ6odYvPWziZiad/VICVbUFSfhmiuowaKA81WTe854581vkJA8r63dBiTO93P1301
         2nNs201EOCG06ShnM7MqW56bdpe+6lWbx7E/O9ng+7vz+J41ZSzUYqjNb3rQIhSntvZC
         F+WvO0wLWRUdjBmAmnmx3jDKjLgmM0zzM6+TF0SUZ613fgW5w606M0NNaNNUZPotIKyu
         PHFRFLxSsOJftWJOoa70q/sFJ/zgbr8aW9GGExZBfx9R/oelQrPwn3Nn7PWIl0cdgbH5
         gF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RPfYQVtr7i2X0SwwuFnYuXXFGb6jZvwJFY0341/Mfgk=;
        b=grenKoX0I6alGt4FKNjL4XLrUKifnEryYJ6k5yhBCUBt+HlslRvCmnL7j8udXBf7Fp
         gHlx6hOn3e/9MfOCU5np21K1Dbi9i1nVdNen+GPb0zG/GmvjgQg57/Ju6evSNEGCz9sS
         E3emoJFXg5wZrZkzY6jrFEaA4+YyXQ5HBOJ4s4mhFITPQc7MLBVDT9hEm7aWOmxCUriv
         TksUzPTE7PWriLIlVesw2LrSetTQy2tUf0HggTprasrJKIggzd/jvWuyVlulg2Rzq4Sg
         l/J6u4sqkw2AzezTtwaqBuNHgKAcUFhLxOGGcvOrTghCIhTS95zNRiqtqUob6/TMZwl7
         sj0A==
X-Gm-Message-State: APjAAAV8Wu25CVf7M7EifZv8jNxqkcj9PhZRbPPevNjAWJp3lDbiT9zG
        DyotkpaOFFyGlTWT4lt945I=
X-Google-Smtp-Source: APXvYqx+dB2/16VQNFt6PjLJf3Kzcelx1Vr5U9O9elnUhZJi+H6aAnvwvaQn46r2q1u/4F57bYm0VA==
X-Received: by 2002:a65:4b88:: with SMTP id t8mr4432594pgq.374.1559931931681;
        Fri, 07 Jun 2019 11:25:31 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id x129sm3117505pfb.29.2019.06.07.11.25.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 11:25:31 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     tytso@mit.edu, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 4/5] random: fix typo in add_timer_randomness()
Date:   Fri,  7 Jun 2019 14:25:16 -0400
Message-Id: <20190607182517.28266-4-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190607182517.28266-1-tiny.windzz@gmail.com>
References: <20190607182517.28266-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/entimate/estimate

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index f0c834af14a8..885707ac8e3b 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1247,7 +1247,7 @@ static void add_timer_randomness(struct timer_rand_state *state, unsigned num)
 	/*
 	 * delta is now minimum absolute delta.
 	 * Round down by 1 bit on general principles,
-	 * and limit entropy entimate to 12 bits.
+	 * and limit entropy estimate to 12 bits.
 	 */
 	credit_entropy_bits(r, min_t(int, fls(delta>>1), 11));
 }
-- 
2.17.0

