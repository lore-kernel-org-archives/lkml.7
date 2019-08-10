Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4010C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 11:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16BD217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 11:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565437975;
	bh=wBa7C310UzA7unhnszru2NQ1hQsawyl8lXZo+ZBoTrg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=DyYll/PzmlDH+AtUghP3hOKC0E107XUuBt48Joaut9J3IfPpAwa09I32e+TcB54iU
	 Tzv+njrNyOhvGXFnHd0249LKgU1g2vUXqgPDKXC/DujW3eGy/WDgDvvTjV65FY5GK2
	 pzyOWFgSaUL8nNJptDF7A+MutuDLRt3msTMLkbXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfHJLwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 07:52:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfHJLwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 07:52:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBE8620880;
        Sat, 10 Aug 2019 11:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565437958;
        bh=wBa7C310UzA7unhnszru2NQ1hQsawyl8lXZo+ZBoTrg=;
        h=Date:From:To:Cc:Subject:From;
        b=MdPJJM+EUBPheSi9NQE6F0i82D28EsTJbmVDUYpDBlzABobBVBPb00yRuJwR7sRZR
         dmzliBmevq2yYzgiKnwL02oC6pnXEbyPXyTqjFUoBEJ5ZdRTmFJFPycj2QXnpH+cUU
         uCk9oY8+ZWe+ebYhqv8TA9ilNcAQe+Bxplz8F3bU=
Date:   Sat, 10 Aug 2019 13:52:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial fixes for 5.3-rc4
Message-ID: <20190810115235.GA5930@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.3-rc4

for you to fetch changes up to 81eaadcae81b4c1bf01649a3053d1f54e2d81cf1:

  kgdboc: disable the console lock when in kgdb (2019-07-30 17:39:39 +0200)

----------------------------------------------------------------
TTY fix for 5.3-rc4

Here is a single tty kgdb fix for 5.3-rc4.

It fixes an annoying log message that has caused kdb to become useless.
It's another fallout from ddde3c18b700 ("vt: More locking checks") which
tries to enforce locking checks more strictly in the tty layer,
unfortunatly when kdb is stopped, there's no need for locks :)

This patch has been linux-next for a while with no reported issues

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Douglas Anderson (1):
      kgdboc: disable the console lock when in kgdb

 drivers/tty/serial/kgdboc.c | 4 ++++
 1 file changed, 4 insertions(+)
