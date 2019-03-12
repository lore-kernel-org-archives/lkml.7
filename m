Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85466C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47ABF2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjfxXweM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfCLPNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:13:41 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33105 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLPNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:13:40 -0400
Received: by mail-io1-f67.google.com with SMTP id b6so2432409iog.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 08:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7238B1e14/wSi7s99N+t1vvNQgdGXGJvWs0Av3wbQNk=;
        b=FjfxXweMEjaxBX0hFF6EO83ucRddZv16c9n2zsZrT+VWJ7AvdG04nxj7tpLa7BLR7s
         YowdxeQeR4lDOLLmFmLmURnIgpKooXnu64AS8NuPT4dytAaVMVmO4tJxDlK+ylWw3rsL
         M9BlcXIPrKd4/55PMdLPqY/lw0VuKBJ6UlkQxmiCnDIM18hPw4BzeWyr0iZhrCLVS/5A
         5YU8rvWAhV30rUz2PNU03yFo9pa7AEITv8QGht3oVSEXDj6wgrArmM48LlPoujUH09/z
         OxSXzxq7fYgAVvZHuAxslZMQoIPaLHheCtCd+D2v6uX4APnLhI7WTLwECxNorB2HjvBB
         3jrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7238B1e14/wSi7s99N+t1vvNQgdGXGJvWs0Av3wbQNk=;
        b=GhAV0eUhlZ84RAaFHg04VfdqO+SP6PNaVWM4q1h9/sw6huLoEJLCYSvdDUJb6Zbb4y
         v8FPZf11eB1XoRLNr+7eMauYiCZFpKcU07gEEHYzG7iFBnnHRO6o5IbQObRwZzkSmjwn
         c8Jl3FMXVl50x5/ZWvBw8huMqgbpHC31tSfVzhQxDJC0Tf1rm7qPay6pdBQwS4da3oBu
         Fb+uvGoIi+OHw77pRrCYFvn+5eb3XwEbWL+ldxOjXaXk595ol/6xvS7wI4Fu3EpninNw
         xYwQUzCvm9ahsv294eLnBfXIS/ox0Olpg2cH+r2/fzUN4H0QZlfOaX33VyMYHMVv7Y8q
         f5/Q==
X-Gm-Message-State: APjAAAX7uwcUZaJquAUDa3SCPBfhC2M59yQfMbWW4wU56zxlVn8JsZn/
        Y09c1IjVRYreinXEekrH7miHsqV5eL2iqqkth7TWQmwE
X-Google-Smtp-Source: APXvYqxgiYWwepVmuiotfWdiCASAlpHqPFPxzSsgD780PXUNKqpdiot+mkkyFLHDXE1MMlM9Nz6pDh2fKgK9EqbB4vg=
X-Received: by 2002:a6b:c80e:: with SMTP id y14mr9933957iof.214.1552403619718;
 Tue, 12 Mar 2019 08:13:39 -0700 (PDT)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 12 Mar 2019 10:13:28 -0500
Message-ID: <CABb+yY0bhhq1H5ogHOWxX1csSzmTd2jziryZCNtugUye9-LWTQ@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v5.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 3717f613f48df0222311f974cf8a06c8a6c97bae:

  Merge branch 'core-rcu-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2019-03-05
14:49:11 -0800)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v5.1

for you to fetch changes up to 17b860bbfc844a3d8e38135ef430d4af8e436b9e:

  mailbox: imx: keep MU irq working during suspend/resume (2019-03-11
02:51:43 -0500)

----------------------------------------------------------------
- mailbox-test: support multiple controller instances
- misc cleanup: IMX, STM32 and Tegra
- new driver: ZynqMP IPI

----------------------------------------------------------------
Anson Huang (1):
      mailbox: imx: keep MU irq working during suspend/resume

Arnd Bergmann (1):
      mailbox: tegra-hsp: mark suspend function as __maybe_unused

Fabien Dessenne (4):
      mailbox: mailbox-test: fix debugfs in multi-instances
      mailbox: mailbox-test: fix null pointer if no mmio
      mailbox: stm32-ipcc: do not enable wakeup source by default
      mailbox: stm32-ipcc: remove useless device_init_wakeup call

Wendy Liang (2):
      mailbox: ZynqMP IPI mailbox controller
      dt-bindings: mailbox: Add Xilinx IPI Mailbox

 .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt   | 127 ++++
 drivers/mailbox/Kconfig                            |  11 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/imx-mailbox.c                      |   4 +-
 drivers/mailbox/mailbox-test.c                     |  26 +-
 drivers/mailbox/stm32-ipcc.c                       |   4 +-
 drivers/mailbox/tegra-hsp.c                        |   2 +-
 drivers/mailbox/zynqmp-ipi-mailbox.c               | 725 +++++++++++++++++++++
 include/linux/mailbox/zynqmp-ipi-message.h         |  20 +
 9 files changed, 903 insertions(+), 18 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
 create mode 100644 drivers/mailbox/zynqmp-ipi-mailbox.c
 create mode 100644 include/linux/mailbox/zynqmp-ipi-message.h
