Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4737BC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206C3218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vL5qa2Ax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfGCMbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 08:31:05 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34108 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfGCMbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 08:31:05 -0400
Received: by mail-lj1-f194.google.com with SMTP id p17so2244027ljg.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 05:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=OKyfJtOIrTtrcXiKdrFl82qYRA8oFsDa8OFy//DbwT0=;
        b=vL5qa2AxRk4yNCXYnY2hu3ejEhwEeBXf5U+CTeE+UjFgLrNxFHJ/Z1X6Sj3e7rNnoI
         qb8N7frPLoHAeTW8dgTnS53LdHmHGE9TXRvsGTL0BA/iVqOfIBDwBr2c1owuul1YVOM/
         QKxADvn+5/zOW3olQFu3ygQHl+ekZ8eoqxCRDVGh7Pf1YCSb626YKl4tvtv/oP7howJa
         k2ZkIbcOz4cnBmIfC66vVZkCIzHMSXDQiaWJuIXhkBKg448jomsePGpfR9MDEYH15gp1
         bPfOAi+z2klXIfjzPK2CPYwvcd4nTsG9Sb8JAKejYqijK7wrp9dDSkNDY1hNcevvEKMA
         0TSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=OKyfJtOIrTtrcXiKdrFl82qYRA8oFsDa8OFy//DbwT0=;
        b=eKsnIYGCXCL3wPkyQLpi8JDmLwwWiU94n95tsov6hSnINA2EcXbz7aiPaLSWGvmH9L
         7BbGwSisP6amhDgGZfQisaziAc2/aZ9t/RyV00lm0fHuKMrXKcv19RQFLHUb4b6jYTjC
         BZyd++CctKF/tBZAE2KANDllcjwV6a51PBrX7NMfghOdEiuDWl3edPw6KGhBS4hLim+V
         XTHidzYQrMeP2Wx11+4UDiXW/9Nn4PW0SFiPxTVKznYApvGK4NEHSg9hKTtGRmmDHf8e
         AzUA6xu7trvJbQXzf8/oCw4G+5pt1lk8ccTCxdwvnix8lGaN19hY23dZZENySOy9GGjm
         3JsQ==
X-Gm-Message-State: APjAAAUw6fA7wW753qcXZzMCCn2HeyIbT05AFnArLiTUyyQhDhL5WT4w
        jMm5nHaySEPVid/2clzbHe/oYLxmMnS7dztHFez41Q==
X-Google-Smtp-Source: APXvYqz16tXQY7gwwzYAJQ0Io8yONIUhwBcxtZ1TJNjprFJvqYdxFLlUGbX00ke1r99DpVN20uQQMLx0vwcqJuRhSmI=
X-Received: by 2002:a2e:650a:: with SMTP id z10mr21044108ljb.28.1562157062976;
 Wed, 03 Jul 2019 05:31:02 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Jul 2019 14:30:51 +0200
Message-ID: <CACRpkdZBhUF7C_+vPc6tkasBk5DAGh01g3eu8OYQ16QBehUZWw@mail.gmail.com>
Subject: [GIT PULL] GPIO fix for v5.2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

last minute regressions galore. Here is a fixup for an
issue I found monday when testing unrelated patches.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 4b972a01a7da614b4796475f933094751a295a2f:

  Linux 5.2-rc6 (2019-06-22 16:01:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v5.2-4

for you to fetch changes up to fbbf145a0e0a0177e089c52275fbfa55763e7d1d:

  gpio/spi: Fix spi-gpio regression on active high CS (2019-07-02
22:31:37 +0200)

----------------------------------------------------------------
A single fixup for the SPI CS gpios that regressed
in the current kernel cycle.

----------------------------------------------------------------
Linus Walleij (1):
      gpio/spi: Fix spi-gpio regression on active high CS

 drivers/gpio/gpiolib-of.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)
