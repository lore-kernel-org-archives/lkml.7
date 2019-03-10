Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D189BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 21:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA87206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 21:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sp4m.net header.i=@sp4m.net header.b="E34EJvBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfCJVoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 17:44:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32891 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfCJVoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 17:44:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id i8so2992971wrm.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 14:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sp4m.net; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OP10GNGnw2nygoIrXbrWR9tx09fCNlSVkxHXTH7kbAc=;
        b=E34EJvBjN3zdy6s8qSsl0/FqfWsqRXJbqi/+oYkng+oFR0bgcsPhFzmxCrNzx0ahzX
         rWOxpLEhuT5GqmQHYT5YXdZQH7uXTmiHU2izqVn7mR/Lonpgpfzlw2InIiri1az4UQnk
         /eomVFpCp+EGc8e3dkhCxZawILSPFcfyyN01c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OP10GNGnw2nygoIrXbrWR9tx09fCNlSVkxHXTH7kbAc=;
        b=mxTbeqYbPQ58zr0Ku6Te3XcdQp7IYu7MqP3ahW9aQd3KlqntHe9ag75YC0RNanFVNh
         0pv6+HfOw09ILY1jqqC53/dI2phawBe+N9UlMiJWzUtyQVngiOJA8T+BdfUZAFx6yX4T
         fdIPJMEwTMMBhz/H/58LM6f3ukVInW04sCN5ttCFfbDSQd1VsOVGh65rq4mE8NmJaFT7
         uQY4RLpFBs3RKj0Nm5vdI7oyY6mEtY9+ExRL/7etQ1oLlCtJmtLK4AE4PMs4hxlh7Lhu
         uPE+lD0jsubDHrzKkK5XN26V3noDwDltFKiMr8Rx9bEN3+dX57CVPLZLoEMC6JZHbWMg
         aMTQ==
X-Gm-Message-State: APjAAAUZsFZhXdY4SOYHBrN0ybXTnoz8A4dUbVCyWt72y28GcIxAKhB4
        8mqQEArcgJjRKFp/e/oe6jHcr9q1061oWT3Q
X-Google-Smtp-Source: APXvYqyfsSys9jZwCdnB+zkd79jOqZJogc+85bg8CA80xA/jMdYgcJVapzoo5NyJ1i3rNTANMnwvPQ==
X-Received: by 2002:adf:9d13:: with SMTP id k19mr18813420wre.82.1552254248959;
        Sun, 10 Mar 2019 14:44:08 -0700 (PDT)
Received: from zort.sp4m.net (zort.sp4m.net. [212.105.165.186])
        by smtp.gmail.com with ESMTPSA id h10sm6741659wrs.12.2019.03.10.14.44.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 14:44:08 -0700 (PDT)
Received: by zort.sp4m.net (sSMTP sendmail emulation); Sun, 10 Mar 2019 21:44:06 +0000
From:   "David Emett" <dave@sp4m.net>
Cc:     David Emett <dave@sp4m.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: fix read of tty->pgrp outside of ctrl_lock
Date:   Sun, 10 Mar 2019 21:43:47 +0000
Message-Id: <20190310214347.12015-1-dave@sp4m.net>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intention was clearly to use the tty_pgrp local variable rather than
re-read tty->pgrp outside of ctrl_lock, so do that.

This bug was introduced by commit 2812d9e9fd94 ("tty: Combine
SIGTTOU/SIGTTIN handling").

Signed-off-by: David Emett <dave@sp4m.net>
---
 drivers/tty/tty_jobctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index c4ecd66fafef..eac05227588d 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -44,7 +44,7 @@ int __tty_check_change(struct tty_struct *tty, int sig)
 	tty_pgrp = tty->pgrp;
 	spin_unlock_irqrestore(&tty->ctrl_lock, flags);
 
-	if (tty_pgrp && pgrp != tty->pgrp) {
+	if (tty_pgrp && pgrp != tty_pgrp) {
 		if (is_ignored(sig)) {
 			if (sig == SIGTTIN)
 				ret = -EIO;
-- 
2.17.1

