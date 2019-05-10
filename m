Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62E8C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95ACC2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3CGRCfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfEJHaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 03:30:55 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55152 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfEJHaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 03:30:55 -0400
Received: by mail-it1-f194.google.com with SMTP id a190so7825882ite.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 00:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=tPx4WWgKD5fMIHB8bGFbha+k6EVA9D8G5KNNwnNFOts=;
        b=d3CGRCfUgt1wekx979HlBmcTfzlIkeNmVtfq21n2h+J2cWrI1iuyHGmJrFamFD3+I3
         B8jOOgdg5dZXkn4mIQXxube+OtP3mx0DoJskklbQOoQAPVK6Pte0G6EKcU7yl2k6EmCW
         Yt/4bqKw9GXsVNZl/vSNP05CskxpxTOLej4BGzaOBZArBZ0bM9BCh4m5TSpBDiU9CaZa
         BDhFYNWnU8IpHblMeZjqpQOrm7a56VVSE6hLKmhMBEoCJg2ZJ+p8CPJgVXX3g+Ei5GTO
         3LgRU/BWI68nsWD15k3EqVlmRxTg7a5PrCaexRcUuK0EIcQq2H18kFJQF7vdhcRTVWsz
         /jIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=tPx4WWgKD5fMIHB8bGFbha+k6EVA9D8G5KNNwnNFOts=;
        b=ac0ZuWF8I6LlihMZ1lb0q28pfDv6CmJ1ObbDL7wee+C0VkA3c3yYsqjVvPpG2E2pzQ
         rsfyBM53gkDjsPYhH9SE1nT5XbvSQi5qwND388SgIrQnHEM0Xvd7NdYPMjKyRi7dLOZZ
         qmbwakhiZdfQVmpZ7vXc7eIbox3BDA/8nezD67+LCdmkIO0iHbT1vHYU9fpTSFlqu5iN
         Hs4mUa6zMMEUP2bpKNceimGAEs+o2A1Y2sMQd/qPl7zpntPVHT/OevEW9Lx3oshhXCdB
         xQuqYUuhviKviSQbOkGk4Ufi00VbCX+MVEqkzUFX5M9AOJIehFucdpaCpNdlMlYT4hle
         J2rg==
X-Gm-Message-State: APjAAAUN6O5Ew1BeqLQXXne1qcCy3SfsRki7lLZ6En1DePiNJiaSA2LK
        K+u1ubwTzdlLj9F13a4vI6En0g0186NVxHhJ3NI=
X-Google-Smtp-Source: APXvYqwcGW2ugr017R+z4A1uYJBG9CeVuq1Hti0KvbMilmjAMjdatVVKN434nVhXD/nfUp3lEWKTh4l1d6sfmilxKJI=
X-Received: by 2002:a24:97d2:: with SMTP id k201mr1625763ite.151.1557473454035;
 Fri, 10 May 2019 00:30:54 -0700 (PDT)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 10 May 2019 02:30:42 -0500
Message-ID: <CABb+yY2cJiXMVaPX+r7TS_mFa=o-dj9HEOjZ2+8GEbs8kUX1Xw@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v5.2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 37624b58542fb9f2d9a70e6ea006ef8a5f66c30b:

  Linux 5.1-rc7 (2019-04-28 17:04:13 -0700)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v5.2

for you to fetch changes up to 8fbbfd966efa67ef9aec37cb4ff412f9f26e1e84:

  mailbox: Add support for Armada 37xx rWTM mailbox (2019-05-09 00:41:00 -0500)

----------------------------------------------------------------
- New driver: Armada 37xx mailbox controller
- Misc: Use devm_ api for imx and platform_get_irq for stm32

----------------------------------------------------------------
Anson Huang (1):
      mailbox: imx: use devm_platform_ioremap_resource() to simplify code

Fabien Dessenne (1):
      mailbox: stm32-ipcc: check invalid irq

Marek Behun (2):
      dt-bindings: mailbox: Document armada-3700-rwtm-mailbox binding
      mailbox: Add support for Armada 37xx rWTM mailbox

 .../mailbox/marvell,armada-3700-rwtm-mailbox.txt   |  16 ++
 drivers/mailbox/Kconfig                            |  10 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/armada-37xx-rwtm-mailbox.c         | 225 +++++++++++++++++++++
 drivers/mailbox/imx-mailbox.c                      |   4 +-
 drivers/mailbox/stm32-ipcc.c                       |  13 +-
 include/linux/armada-37xx-rwtm-mailbox.h           |  23 +++
 7 files changed, 285 insertions(+), 8 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/mailbox/marvell,armada-3700-rwtm-mailbox.txt
 create mode 100644 drivers/mailbox/armada-37xx-rwtm-mailbox.c
 create mode 100644 include/linux/armada-37xx-rwtm-mailbox.h
