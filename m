Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87973C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D220206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="AponybTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbfJHMFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:05:18 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46272 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730710AbfJHMFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:05:18 -0400
Received: by mail-lf1-f66.google.com with SMTP id t8so11691963lfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 05:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yIqqIP3EIw1WUky7Dl5KboQRqFaypkEePxm8k0rEc9o=;
        b=AponybTxAeH4Qwys7uf32YeqpoJ78jgDddTlKOmqmCAlexPcNn8x24ajVQ+O7+xRkR
         RuBT096o6RaBaaTnFRhKPGbBnK69SeSdi0jX5VxETzV8yWF+FlbeSjLE8LtoSz+LXe/9
         1SJ01i6mDKGlRWpaglFSkyprM69Ur66rByxaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yIqqIP3EIw1WUky7Dl5KboQRqFaypkEePxm8k0rEc9o=;
        b=UQMice3leCmg8FexiZ5RarV5egJ0qbP3Znaw90roUSuUsXPi4/oEFadUy/avtt5Yf1
         TfAEClJgGnOyKtSCBoEssQlgiWizF+uwc6DiaqsBXoNDTHeU1LTtUXmoz6MAMvfuU8GK
         RzAqYL2MzivMXrlj648ErNTfdDQqKJAB7Eoe2ai0hUZSq+MbNYslJGEIHp8yHBA8ZzDA
         B41Nj/vtHAsYG1Td6JPq+Dxi0UlrLfe6Tb66PEGN3g0IgEg7dnW2NME2f2zT61M6fuLn
         tVOS0Wa5s3nCPHSXvjipztmiip/em34xXuDOssJ91hDNdC3n6Cn3mG6p79McfwoI6wg5
         V7vw==
X-Gm-Message-State: APjAAAUG6U+kK84EtNJ+awKPjqKrUujcw2WZADUCH93DLvUWiJcxyZFA
        mmRteSicpb/gzdLZRU+PQKD5DQ==
X-Google-Smtp-Source: APXvYqykeLmJ/WUhlQxva8zZaqPikrZhQ2ld9WnisNftyHunM8rSa4gXa55Lqcwffs1sdJgebXd04g==
X-Received: by 2002:a19:ec16:: with SMTP id b22mr20438594lfa.189.1570536316077;
        Tue, 08 Oct 2019 05:05:16 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id z18sm3918033ljh.17.2019.10.08.05.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 05:05:15 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 0/4] backlight: pwm_bl: optimizations and small fix for cie1913
Date:   Tue,  8 Oct 2019 14:03:23 +0200
Message-Id: <20191008120327.24208-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches optimize the cie1913() implementation by using fewer 64
bit divisions and multiplications. It also contains a minor fix for
the linear constant used.

v2:
- Drop patch 5.
- Fix thinko in patch 4, otherwise no code change.
- Better changelog in patch 3.
- Add Daniel's Reviewed-By to the four patches.

Daniel, I took the liberty of adding your R-B to patch 4 despite
changing it a little to fix a thinko - I should add 1<<31 and not
1<<15. Please tell me if that was inappropriate.

Rasmus Villemoes (4):
  backlight: pwm_bl: fix cie1913 comments and constant
  backlight: pwm_bl: eliminate a 64/32 division
  backlight: pwm_bl: drop use of int_pow()
  backlight: pwm_bl: switch to power-of-2 base for fixed-point math

 drivers/video/backlight/pwm_bl.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

-- 
2.20.1

