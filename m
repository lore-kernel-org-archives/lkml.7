Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D39EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35882082C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="l223+tlm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfCXWCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 18:02:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35004 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbfCXWCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 18:02:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so7053116wmd.0;
        Sun, 24 Mar 2019 15:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v+fyB4tI3gKbJMEPPqCvbrfsNxpucCIHFMC9GxrzHgg=;
        b=l223+tlmj3z0NLeJvTxzZWimnTsh1nV0CycvWZG1TaxDt/+H7uAb/H2jY+oar8yEHg
         DQwnqTePU+RWCD3KRQgpqeyl+GOU409bk8NP77wt9rInmAeg1PWNyBxmjWEtdA5a4pBi
         9vvrjHkJeERhiN5txXHgVd08HH8fTIbbYcIi+0zaAnyZk2x3YwwdAJi8KjPOxaug1pwv
         ELc1JCIFCGRWYxaBdvDIHl7EMoTBIxz7x7aNtE7jmrhg7+JjFMQCUEtNVy320ZRPW9V9
         W1HWokG+Keb7510GRtYArjGdSGjRPtQaHJASMq+EF++D0YbBvVWQNCBjBbUautCKpDp9
         nfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v+fyB4tI3gKbJMEPPqCvbrfsNxpucCIHFMC9GxrzHgg=;
        b=DAWk/dqgDT+NFwJsIkujYNbq/pN8vR66ZcL8RDIOk2qSVK3uEV8J8Wq+9Mldtnk7Su
         D2VpgRxowLttygA+6i6lTeptyy2TwrWsctktBheJFC9tiYkj0uptQg8IrDr8Ddqio6aR
         VKOm4QHHsTrkS1V3EKphB3oWgPTYu0aqKyi5kTU9AB0EfSetJlmT79+FVlXEa8qhmXZn
         TBk26wDp/U2NucTBsdOfvD5q2eO/GwhIzzJCW3Se8p5v05E/CRLijvxskpWUTDxLbpVa
         Y1vIT9cwP1J7K2Z9mh5/KVg/xR2NUqrVq7AHomH6p1m1cRMekjTdqKLZMvf8lSc2RB1D
         8rIg==
X-Gm-Message-State: APjAAAXWjZ2PyNjghDPMCJ2BR1murt0GBSz7+9q3ZDO/ogeU9xRh2o3O
        74JmI1im2CUQIAaCfMfGris=
X-Google-Smtp-Source: APXvYqwtHPXmQGHQZmmujSavXIzMLmkHXwZYnhyA/LalXDpzzopkoylRvJOHBeHWi1NSKBFL1oDI5Q==
X-Received: by 2002:a7b:cb58:: with SMTP id v24mr560348wmj.121.1553464954737;
        Sun, 24 Mar 2019 15:02:34 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD7399900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d739:9900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id o13sm12743485wmc.20.2019.03.24.15.02.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 15:02:33 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     thierry.reding@gmail.com, narmstrong@baylibre.com,
        jbrunet@baylibre.com, linux-pwm@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/1] pwm: meson: fix scheduling while atomic issue
Date:   Sun, 24 Mar 2019 23:02:16 +0100
Message-Id: <20190324220217.15813-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Back in January a "BUG: scheduling while atomic" error showed up during
boot on my Meson8b Odroid-C1 (which uses a PWM regulator as CPU supply).
The call trace comes down to:
  __mutex_lock
  clk_prepare_lock
  clk_core_get_rate
  meson_pwm_apply
  ..
  dev_pm_opp_set_rate
  ..

Jerome has also seen the same problem but from pwm-leds (instead of a
pwm-regulator). He posted a patch which replaces the spinlock with a
mutex. That works. I believe we can optimize this by reducing the time
where the lock is held - that also allows to keep the spin-lock.

Analyzing this issue helped me understand the pwm-meson driver better.
My plan is to send some cleanups (with the goal of re-using more of the
goodies from the PWM core in the pwm-meson driver) after this single fix
is merged (they can be found here: [1]).

Dependencies: none

Target version: please queue this for -fixes so it makes it's way into
v5.1-rc (so we can get it backported from there, because this issue has
existed since the pwm-meson driver was introduced).


[0] http://lists.infradead.org/pipermail/linux-amlogic/2019-January/009690.html
[1] https://github.com/xdarklight/linux/commits/meson-pwm-for-5.2-v0


Martin Blumenstingl (1):
  pwm: meson: use the spin-lock only to protect register modifications

 drivers/pwm/pwm-meson.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

-- 
2.21.0

