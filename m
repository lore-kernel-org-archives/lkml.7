Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2150C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 16:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991FB2087E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 16:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570897117;
	bh=jWiKjnx7PWQqEmrk3KPVS7AVXK4uTwoEwikRODdNAr0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=eyG75/FC5HwqqeZTNQUHzeRYYDxeWmaW2A8El2fRMzSTTdpGNLeGoAfY9E0t09ZlL
	 +pu2FmVXCr2As+JoUpZSFoMuvLRUYo6pHpMzeyZIn28W4D9zXLhJRtTsQCGe65Hs9A
	 MZTOwVM1LDtKFaWedjpxBxGhA/tgrshavrlmU4IA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbfJLQSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 12:18:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729387AbfJLQQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 12:16:19 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7155F21850;
        Sat, 12 Oct 2019 16:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570896978;
        bh=jWiKjnx7PWQqEmrk3KPVS7AVXK4uTwoEwikRODdNAr0=;
        h=Date:From:To:Cc:Subject:From;
        b=UntGHDNXn6E6/pt2hq1Z0zNWnLW6W0oKiJKUZwUH8H3ndoQeZjmxqQUCLCsFI58GK
         ho/t+eodrNccRKeAJ0hZMn4Cuv+WQxpcieidhmY6NUvMaWobZv3WXh8o4/IewY0io5
         XXP2B8Q13kZMbwVK2WFsBLoS6DJjvQCqeGnMxMh4=
Date:   Sat, 12 Oct 2019 18:16:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial fixes for 5.4-rc3
Message-ID: <20191012161614.GA2191633@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.4-rc3

for you to fetch changes up to 10deeac921647c929c67752d377f22e632d55d1c:

  MAINTAINERS: kgdb: Add myself as a reviewer for kgdb/kdb (2019-10-11 08:40:29 +0200)

----------------------------------------------------------------
TTY/Serial driver fixes for 5.4-rc3

Here are some small tty and serial driver fixes for 5.4-rc3 that resolve
a number of reported issues and regressions.

None of these are huge, full details are in the shortlog.  THere's also
a MAINTAINERS update that I think you might have already taken in your
tree already, but git should handle that merge easily.

All have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Adam Ford (2):
      serial: mctrl_gpio: Check for NULL pointer
      serial: 8250_omap: Fix gpio check for auto RTS/CTS

Andrey Smirnov (1):
      tty: serial: fsl_lpuart: Fix lpuart_flush_buffer()

Anson Huang (1):
      tty: serial: imx: Use platform_get_irq_optional() for optional IRQs

Biju Das (1):
      dt-bindings: serial: sh-sci: Document r8a774b1 bindings

Christoph Hellwig (1):
      serial/sifive: select SERIAL_EARLYCON

Christophe JAILLET (2):
      tty: serial: owl: Fix the link time qualifier of 'owl_uart_exit()'
      tty: serial: rda: Fix the link time qualifier of 'rda_uart_exit()'

Douglas Anderson (1):
      MAINTAINERS: kgdb: Add myself as a reviewer for kgdb/kdb

Geert Uytterhoeven (1):
      serial: sh-sci: Use platform_get_irq_optional() for optional interrupts

Michal Simek (1):
      serial: uartps: Fix uartps_major handling

Randy Dunlap (3):
      serial: uartlite: fix exit path null pointer
      tty: n_hdlc: fix build on SPARC
      serial: fix kernel-doc warning in comments

Stefan-gabriel Mirea (2):
      tty: serial: linflexuart: Fix magic SysRq handling
      tty: serial: Fix PORT_LINFLEXUART definition

 .../bindings/serial/renesas,sci-serial.txt          |  2 ++
 MAINTAINERS                                         |  1 +
 drivers/tty/n_hdlc.c                                |  5 +++++
 drivers/tty/serial/8250/8250_omap.c                 |  5 +++--
 drivers/tty/serial/Kconfig                          |  1 +
 drivers/tty/serial/fsl_linflexuart.c                | 21 ++++++++++++++-------
 drivers/tty/serial/fsl_lpuart.c                     |  2 +-
 drivers/tty/serial/imx.c                            |  4 ++--
 drivers/tty/serial/owl-uart.c                       |  2 +-
 drivers/tty/serial/rda-uart.c                       |  2 +-
 drivers/tty/serial/serial_core.c                    |  2 ++
 drivers/tty/serial/serial_mctrl_gpio.c              |  3 +++
 drivers/tty/serial/sh-sci.c                         |  8 ++++++--
 drivers/tty/serial/uartlite.c                       |  3 ++-
 drivers/tty/serial/xilinx_uartps.c                  |  8 +++++++-
 include/uapi/linux/serial_core.h                    |  2 +-
 16 files changed, 52 insertions(+), 19 deletions(-)
