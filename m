Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18813C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 11:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2F12184E
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 11:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565437985;
	bh=ET+i5nnSXbSIdaHFhUwXEe4VzaNWa6TPUsmIiO0OrCQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=W5OkMha0HvkUYAOYs6bHErVvBBtgb/Egj+3VkcjxKrQpkix0P/VgaOKOFKduTN9dQ
	 RD6/5AGPf782P4J/8aDLAQIBn/wuaI/ZB2FHy/i0wFtXbOgvs7Xl3BtdKa7vV7ABdH
	 EuZFpA9UlviHD0nd41kxiUUJeHCj1TvzUygph7AM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfHJLxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 07:53:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfHJLxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 07:53:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB4FE20880;
        Sat, 10 Aug 2019 11:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565437983;
        bh=ET+i5nnSXbSIdaHFhUwXEe4VzaNWa6TPUsmIiO0OrCQ=;
        h=Date:From:To:Cc:Subject:From;
        b=kowEqam0QaS77JKii1yVnV3g449T5oTxsWIPGEQYWmYfbQp6bIGJ8dipQE4IyjYIs
         28X8q7ErSlBPktEhbcSfS1/7czt0IfpNoAae9wfvccq04eGUlseiQhjxKPDdhpOjZX
         0RmsxSdso4y7eP/VTM9AQFAsIZh3T46ZKTyEh27c=
Date:   Sat, 10 Aug 2019 13:53:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] Driver core patches for 5.3-rc4
Message-ID: <20190810115301.GA6047@kroah.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.3-rc4

for you to fetch changes up to 8097c43bcbec56fbd0788d99e1e236c0e0d4013f:

  Revert "kernfs: fix memleak in kernel_ops_readdir()" (2019-08-08 08:39:35 +0200)

----------------------------------------------------------------
Driver core fixes for 5.3-rc4

Here are 2 small fixes for some driver core issues that have been
reported.  There is also a kernfs "fix" here, which was then reverted
because it was found to cause problems in linux-next.

The driver core fixes both resolve reported issues, one with gpioint
stuff that showed up in 5.3-rc1, and the other finally (and hopefully)
resolves a very long standing race when removing glue directories.  It's
nice to get that issue finally resolved and the developers involved
should be applauded for the persistence it took to get this patch
finally accepted.

All of these have been in linux-next for a while with no reported
issues.  Well, the one reported issue, hence the revert :)

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andrea Arcangeli (1):
      kernfs: fix memleak in kernel_ops_readdir()

Brian Norris (1):
      driver core: platform: return -ENXIO for missing GpioInt

Greg Kroah-Hartman (1):
      Revert "kernfs: fix memleak in kernel_ops_readdir()"

Muchun Song (1):
      driver core: Fix use-after-free and double free on glue directory

 drivers/base/core.c     | 53 ++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/base/platform.c |  9 +++++++--
 2 files changed, 59 insertions(+), 3 deletions(-)
