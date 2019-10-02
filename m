Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262E5C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB803222C0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="a2Gbtd+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfJBRDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 13:03:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38338 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfJBRC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 13:02:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id w12so20531163wro.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 10:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j6mEZW97cwRM3vW7U2lOpw/fWWoNmGcPeVDFJW5o5aI=;
        b=a2Gbtd+4W12wuYhZwNclrG1CiaE+Ig5ZKGP7L2XIgw2aMZEt5v/lArhsfbIH0rlNyg
         8VNYvFqtCW5eDYw37XpGCiasH2cgZpTSFxRG6OjqQBzQHGpS+IP3piTuKe+HBdIGG7pR
         Gy18ypVO/6vOJxxoJF1y3/sxycQ6cKb0rN0qUjq4rBIDNWSN4kWBiY5T7fmu0vw1IUIQ
         Mdw1BETnD9crNfwgo+dt0G5BcEGpwohvE793VDVImLQTNlXj5Nu2941+maXLXQQilTZh
         wbeHu96UYwNJ0ux/6BtvU4YU+6uIbZHy1wmfj7Xb72Wk9VKSR1T3Uthmq5wkHSGKdV2b
         m6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j6mEZW97cwRM3vW7U2lOpw/fWWoNmGcPeVDFJW5o5aI=;
        b=cTu5hSTeLWejMbr0ZmdS48ptASTZQ5KeJWZjzpI7Bjr0QuXpBB/BWj5ccKtilYNIu0
         jemHTuMBY/5NpD5m+RsA62CdZWfmV5MkGEBDRt/bzSRXoIOCQJ6Lhl6Iivp27EcuYxXg
         P59PhwB9FMfObOkjPuVEqVqtFET7NYkh5gB5/m59wbOhx2z9h3VJJMQk+bjxMje8XpmJ
         zOBxZH5JmE3U4hpTogJJ6pwQ5Ss7mHmqnoeCYbxL4WdnoMIB98F0QCB+Cv6Opo7ux0Sd
         IzrD1/1kGLU/BAJzg/K+yYQ8RxK+xDFrUodPd4odkfYxmAEVh28atcyRFU8G9EgI1HDi
         C/Ew==
X-Gm-Message-State: APjAAAXJRW/+2ViUEHbJAiD3oTCx4qOWQu4LFxt3Gc/byfObcd5jW6nP
        dla/PJeLHxJxbnBl/AwmZw1bsANkUnE=
X-Google-Smtp-Source: APXvYqyfHPaXuTDHKR0G+6d4PXNieCa79JUKUPWeNcTxzobXu39t6AQ29qJUgKxoLoO72YNBEn6chw==
X-Received: by 2002:adf:e988:: with SMTP id h8mr3531294wrm.354.1570035776511;
        Wed, 02 Oct 2019 10:02:56 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id b62sm11188575wmc.13.2019.10.02.10.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 10:02:55 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alban Bedel <albeu@free.fr>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/6] gpio: replace nocache ioremap functions with devm_platform_ioremap_resource()
Date:   Wed,  2 Oct 2019 19:02:43 +0200
Message-Id: <20191002170249.17366-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

According to Arnd Bergmann:

"The only architecture that actually has a difference between
ioremap() and ioremap_nocache() seems to be ia64. I would
generally assume that any driver using ioremap_nocache()
that is not ia64 specific should just use ioremap()."

This series converts all users of nocache ioremap variants that aren't
ia64-specific to using devm_platform_ioremap_resource().

Most of these don't call request_mem_region() currently, which
devm_platform_ioremap_resource() does implicitly, so testing would
be appreciated.

Included are two minor fixes for xgene and htc-egpio.

Bartosz Golaszewski (6):
  gpio: xgene: remove redundant error message
  gpio: xgene: use devm_platform_ioremap_resource()
  gpio: em: use devm_platform_ioremap_resource()
  gpio: ath79: use devm_platform_ioremap_resource()
  gpio: htc-egpio: use devm_platform_ioremap_resource()
  gpio: htc-egpio: remove redundant error message

 drivers/gpio/gpio-ath79.c     | 10 +++-------
 drivers/gpio/gpio-em.c        | 20 ++++++++-----------
 drivers/gpio/gpio-htc-egpio.c | 37 ++++++++++++-----------------------
 drivers/gpio/gpio-xgene.c     | 27 ++++++-------------------
 4 files changed, 30 insertions(+), 64 deletions(-)

-- 
2.23.0

