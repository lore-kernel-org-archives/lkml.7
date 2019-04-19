Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151C6C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C348C20693
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555701428;
	bh=bsRNP6NvDhIFN7DBpQOgDPLNIYrfNgtQ3V/EoaNP+Y4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=OEdDUhQpYpLpRmmc7WdpQSruCwHdT5WEs8RdzHd3MI09byYhtNoIbuZFFFEHExQ5T
	 0+Co5JYNWsimHSyjLjtkzMMtrLTlpRHe1DDUq8ksobNBApVGbwxIH4WhExWR9bzYNb
	 D6CX5dLJNNjVwD9LS5gi8XhKIqJJasyIu5/Sf1ic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfDSTRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:17:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbfDSTRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:17:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BBEA204FD;
        Fri, 19 Apr 2019 19:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555701426;
        bh=bsRNP6NvDhIFN7DBpQOgDPLNIYrfNgtQ3V/EoaNP+Y4=;
        h=Date:From:To:Cc:Subject:From;
        b=2B/S3vElBU/3u1rxWI+MR2XJBlCKBTovyngUb6penW0DqewG1QSO526Q1I3MOytHT
         fnEdTMZwR0kmZYuLvV9yv4p5+DIOz8N969IyacSDDvdaXZSUUur+gxKrg2+ONXdbh0
         wYEgfWkmkh9ppBzjVCHeVc8W+LGZjb7Lw8HLMHZk=
Date:   Fri, 19 Apr 2019 21:17:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial fixes for 5.1-rc6
Message-ID: <20190419191703.GA4077@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.1-rc6

for you to fetch changes up to c53051128bb0e8754e13345d782ca69e5e1ce36d:

  sc16is7xx: put err_spi and err_i2c into correct #ifdef (2019-04-19 14:09:23 +0200)

----------------------------------------------------------------
TTY/Serial fixes for 5.1-rc6

Here are 5 small fixes for some tty/serial/vt issues that have been
reported.

The vt one has been around for a while, it is good to finally get that
resolved.  The others fix a build warning that showed up in 5.1-rc1, and
resolve a problem in the sh-sci driver.

Note, the second patch for build warning fix for the sc16is7xx driver
was just applied to the tree, as it resolves a problem with the previous
patch to try to solve the issue.  It has not shown up in linux-next yet,
unlike all of the other patches, but it has passed 0-day testing and
everyone seems to agree that it is correct.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Geert Uytterhoeven (2):
      serial: sh-sci: Fix HSCIF RX sampling point calculation
      serial: sh-sci: Fix HSCIF RX sampling point adjustment

Guoqing Jiang (2):
      sc16is7xx: move label 'err_spi' to correct section
      sc16is7xx: put err_spi and err_i2c into correct #ifdef

Mikulas Patocka (1):
      vt: fix cursor when clearing the screen

 drivers/tty/serial/sc16is7xx.c | 4 +++-
 drivers/tty/serial/sh-sci.c    | 6 ++++--
 drivers/tty/vt/vt.c            | 3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)
