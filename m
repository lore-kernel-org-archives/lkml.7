Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D82C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC539207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fD4dVOhv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731838AbfIRQAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 12:00:41 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41679 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfIRQAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 12:00:40 -0400
Received: by mail-io1-f66.google.com with SMTP id r26so373790ioh.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 09:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ywo1LWQXhtnnsGBUwqYVAp61PxHZGvXmpc5vAeqGshs=;
        b=fD4dVOhvCor/5Hphh2dpZdcTGN3t4ew61AWnXg30rOVONDgrS2kl17CRRvhTnlMAC2
         Okp97wGoZehoOmQGr3oztl8ywFGX5oQWiE0V3JOE2PIemrCt5tiYhOhVYNhMB7tcRW0y
         Mj7kTRT7/ROIP+mBtRoQAQcICTVTKcAEbBqPhv18ohZGBlIcf+J7uzqlrFmnTnO1tESu
         j0Q8Wu2rTwr2gca/9P1nAsoxSBNt9MzMTsauf/hqmajEq9f27klYeyiN8NUa9cKLe7nn
         Uz2UiQiG+NVcA3EkvKBqcmQ22I9FLgOM03PL2Xmt5W4UfyOWCm7RGpDStVdz4gD/ycNL
         GKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ywo1LWQXhtnnsGBUwqYVAp61PxHZGvXmpc5vAeqGshs=;
        b=EjLamfqstofyaYiGv07X/F9i5Lv6ttaeng5QHAWeTJSJTDBV7UOcEKteJbBBRc5bU3
         v25J4V04jV35gN4mvViALFJRO8/xYy/k0JbhsW3pzhlST/vXe69haMlYcJ7t8tG+AIFW
         sD8n+2+tjUBY7jCL855QTcHH0iOn3FMty/F3SViT4CuvW7T9Hib0Z0iLQYIWXmhOhvm0
         UkDwItPP6pMR3xoGsy/Lwx405lM1hpeZG68DUerUC3TMHwcQDuP1qISW3BKUQrObLJEL
         BxGmY3SP7TNVEmF/LLPmzdYJ2s+iIQFxjT3q/topIsFA6mAarhWbgyEwYl9H+CXW4ctu
         iAxw==
X-Gm-Message-State: APjAAAWwt4+iEvMUruC9ALapIjfqHwo+S3Lh2hUsQhwJtfyfjQqHhRkB
        CO7Yh0mlcUNfn3TWlwhcHGWHihr+6H6COHWFPrE=
X-Google-Smtp-Source: APXvYqwlDA2TnLSXNW06tUwHy0B3dJRlCrapRf8xAZ/mN9UXvrnbyEmFKppxSgak/3C49MDvyOqdxnVT5skiCpRUZbc=
X-Received: by 2002:a6b:f319:: with SMTP id m25mr5535247ioh.33.1568822438949;
 Wed, 18 Sep 2019 09:00:38 -0700 (PDT)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 18 Sep 2019 11:00:28 -0500
Message-ID: <CABb+yY2AFK4G8i765--h0D7h1xcsrhSP2fKzWmcza9OcrdT22g@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v5.4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
The following changes since commit f74c2bb98776e2de508f4d607cd519873065118e:

  Linux 5.3-rc8 (2019-09-08 13:33:15 -0700)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v5.4

for you to fetch changes up to 556a0964e28c4441dcdd50fb07596fd042246bd5:

  mailbox: qcom-apcs: fix max_register value (2019-09-17 00:54:29 -0500)

----------------------------------------------------------------
- qcom : enable support for ipq8074, sm1850 and sm7180.
         add child device node for qcs404.
         misc fixes.

- mediatek : enable support for mt8183.
          misc rejig of cmdq driver.
          new client-reg dt property.

- armada: use device-managed registration api

----------------------------------------------------------------
Bibby Hsieh (6):
      dt-binding: gce: remove thread-num property
      dt-binding: gce: add gce header file for mt8183
      dt-binding: gce: add binding for gce client reg property
      mailbox: mediatek: cmdq: move the CMDQ_IRQ_MASK into cmdq driver data
      mailbox: mediatek: cmdq: support mt8183 gce function
      mailbox: mediatek: cmdq: clear the event in cmdq initial flow

Chuhong Yuan (1):
      mailbox: armada-37xx-rwtm: Use device-managed registration API

Gokul Sriram Palanisamy (2):
      dt-bindings: mailbox: qom: Add ipq8074 APPS compatible
      mailbox: qcom: Add support for IPQ8074 APCS

Jorge Ramirez-Ortiz (3):
      mbox: qcom: add APCS child device for QCS404
      mbox: qcom: replace integer with valid macro
      mailbox: qcom-apcs: fix max_register value

Sibi Sankar (2):
      dt-bindings: mailbox: Add APSS shared for SM8150 and SC7180 SoCs
      mailbox: qcom: Add support for Qualcomm SM8150 and SC7180 SoCs

 .../devicetree/bindings/mailbox/mtk-gce.txt        |  23 ++-
 .../bindings/mailbox/qcom,apcs-kpss-global.txt     |   3 +
 drivers/mailbox/armada-37xx-rwtm-mailbox.c         |  14 +-
 drivers/mailbox/mtk-cmdq-mailbox.c                 |  18 ++-
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            |  16 +-
 include/dt-bindings/gce/mt8183-gce.h               | 175 +++++++++++++++++++++
 include/linux/mailbox/mtk-cmdq-mailbox.h           |   3 +
 include/linux/soc/mediatek/mtk-cmdq.h              |   3 -
 8 files changed, 222 insertions(+), 33 deletions(-)
 create mode 100644 include/dt-bindings/gce/mt8183-gce.h
