Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F44C432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 05:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA7D20867
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 05:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrYvcqjK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfLAFjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 00:39:12 -0500
Received: from mail-il1-f176.google.com ([209.85.166.176]:44622 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfLAFjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 00:39:11 -0500
Received: by mail-il1-f176.google.com with SMTP id z12so20899220iln.11
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 21:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9lRRM9nAxR2+9byCRc11pTa2dZse+bTnvaqd/WNewI8=;
        b=BrYvcqjKbd+CsXqPy6yteeqqoA3/udny2z7bdvUHTjHo3jeuZHIpqeEAxbTjr0Pgsd
         PaV4CTX/yAbiDsZNeVinCH/LUJ3d8326mzdB4XhhBQ+QUCkOI1jD9JXrSZitgs2anfjn
         RasEE7UC4aPNrDqagQ6vpbvvPNbOtoY332hRimYBcQItrf6X0t6bk7BStYIYk7MEXbi/
         4mRmUKMbK2TMyHztTuzEBaSFoq2yvD0AJDR39eJRJcj/OxgZOqRef6uhf3tdoCRTWeo7
         GOQq/H4ngsKoE4fpEXuoZpYv7Yy0SezlGQ0GOuCNKeswKO4yEgMBT7GBIUb1EX02BQkc
         0d+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9lRRM9nAxR2+9byCRc11pTa2dZse+bTnvaqd/WNewI8=;
        b=Utp99110SXVQrzDSQaTGBJu5//C+wtTREq7nZIL2H0eypBlX7k/1riTMtOubgjlgtM
         B0No7ZK5TXARxbu8rSAscnb6/ZOfFa6195Q9RJZkWhQq0iKaHuXZoLS2Y54fFYKInnx8
         9Tfyx8Vznm9YhP4C2aBDobsuRUSXmoJzSp5ojBaPBGGnnVlW5J7Sv8yfEmTRwXH23USc
         bhhgQCNLmaE9I/1gAl51GTysO0ZENaHDu5O/F5V3ppg6lo9ce6ZJhusD2w6eSQJTMu01
         9lNQ6pGJ/3KjqU0E9V/UpjALgGKTHdb2MBhuSxy9pU/FODQKTdE+GQ5GkkuXmZpANTiH
         eygg==
X-Gm-Message-State: APjAAAWou+aZ3vn/C26/ocxPXq9Hu8wip/n6HLydwsBdt0Str4zW8oK/
        hcHLYgcOSRcGVneJ5q5AkKhdsirTIEuMspDlh9U5Vtmj
X-Google-Smtp-Source: APXvYqxnrl5/T2N7UjNb9sbOKSpxWp46NRwYJ4HaeQiDtwmWH5XJoGtF4nsaARBxMCxUO4KHPlaTxnJwUI02h36pwL4=
X-Received: by 2002:a92:84d1:: with SMTP id y78mr179801ilk.69.1575178749332;
 Sat, 30 Nov 2019 21:39:09 -0800 (PST)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Sat, 30 Nov 2019 23:38:58 -0600
Message-ID: <CABb+yY1dtWjRW4Wi3jX178Zyd+yNW_bGCwVm3DD4mNYz4ozd-A@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v5.5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
The following changes since commit af42d3466bdc8f39806b26f593604fdc54140bcb:

  Linux 5.4-rc8 (2019-11-17 14:47:30 -0800)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v5.5

for you to fetch changes up to c6c6bc6ea9fce31baaca053befc31215cfcb3dd9:

  mailbox: imx: add support for imx v1 mu (2019-11-30 23:09:14 -0600)

----------------------------------------------------------------
mailbox changes for v5.5

- omap : misc - catch error returned from pm_runtime_put_sync
- hisi : misc - drop .owner from platform_driver
- stm : change how wakeup is handled
- imx : fix - bailout on error and nuke correct irq
- imx : add support for imx7ulp platform

----------------------------------------------------------------
Brandon Maier (1):
      mailbox/omap: Handle if CONFIG_PM is disabled

Daniel Baluta (2):
      mailbox: imx: Fix Tx doorbell shutdown path
      mailbox: imx: Clear the right interrupts at shutdown

Fabien Dessenne (1):
      mailbox: stm32-ipcc: Update wakeup management

Richard Zhu (2):
      dt-bindings: mailbox: imx-mu: add imx7ulp MU support
      mailbox: imx: add support for imx v1 mu

Tian Tao (1):
      mailbox: no need to set .owner platform_driver_register

 .../devicetree/bindings/mailbox/fsl,mu.txt         |  2 +
 drivers/mailbox/hi6220-mailbox.c                   |  1 -
 drivers/mailbox/imx-mailbox.c                      | 74 ++++++++++++++++------
 drivers/mailbox/omap-mailbox.c                     |  2 +-
 drivers/mailbox/stm32-ipcc.c                       | 36 ++---------
 5 files changed, 64 insertions(+), 51 deletions(-)
