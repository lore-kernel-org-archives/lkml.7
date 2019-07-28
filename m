Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECE1C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 12:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697C12087C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 12:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564315299;
	bh=e6GwQsZtQTpUEgtJtC9R1YMCXph0gvZPN9nb92cRPa4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=sG8jqOI4NtPOzlB99kZpM59LY4KGgsHHavi6nKMdQbEPyEfmh401UbqViaQZJvvi1
	 RWtoEv/1hpiybN4PTaxY9DiSPDdKT7zngqplBPQJR93J2Dtg21wCMYsPrhQxItSrw4
	 Q2CaKVEOedFTihauRdPLTuasZnmPQkDAWw6uDlQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfG1MBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 08:01:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfG1MBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 08:01:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DD582075E;
        Sun, 28 Jul 2019 12:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564315296;
        bh=e6GwQsZtQTpUEgtJtC9R1YMCXph0gvZPN9nb92cRPa4=;
        h=Date:From:To:Cc:Subject:From;
        b=qMkcvtGwjnuS872+9u8LkzuSswbnVZK73QfBi6gkqCcenwk5EIWK27XBsCefKl4ql
         3JiTded9t259FxXcd9ko6vRsJihfXTq2QKiA4CuBqxzyTLR6riXqtFHIqipK79CHoB
         d8ZqSQeNwtzQkDKf3yMPHADJy2C/xD3FLEtR9QsM=
Date:   Sun, 28 Jul 2019 14:01:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial fixes for 5.3-rc2
Message-ID: <20190728120133.GA16163@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.3-rc2

for you to fetch changes up to 61d51456f35760a09e8aa1e6ddd247f1547015d3:

  vt: Grab console_lock around con_is_bound in show_bind (2019-07-25 13:47:35 +0200)

----------------------------------------------------------------
TTY fixes for 5.3-rc2

Here are 2 tty/vt patches for 5.3-rc2
  - delete the netx-serial driver as the arch has been removed, no need
    to keep the serial driver for it around either.
  - vt console_lock fix to resolve a reported noisy warning at runtime

Both of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Daniel Vetter (1):
      vt: Grab console_lock around con_is_bound in show_bind

Linus Walleij (1):
      tty: serial: netx: Delete driver

 drivers/tty/serial/Kconfig       |  19 -
 drivers/tty/serial/Makefile      |   1 -
 drivers/tty/serial/netx-serial.c | 733 ---------------------------------------
 drivers/tty/vt/vt.c              |   6 +-
 include/uapi/linux/serial_core.h |   3 -
 5 files changed, 5 insertions(+), 757 deletions(-)
 delete mode 100644 drivers/tty/serial/netx-serial.c
