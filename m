Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6E4C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 15:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE9624656
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 15:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576337299;
	bh=+Xz+uCe76wc0uyA264puP0KEktwfV+4eFIf5Z8fsDrc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=UEZwkKTxZSuSebkZY+3FIxYzXJZ5wOl0gH4R0mKKz4xuc+F7SntMK4Z/WxVdIDsSo
	 6PJQzseaPK5s/oHJA7UDP4AlEGaEdA/ieG6PSapfdUbw5ZTWrC+UWrXmizojkGQly0
	 YQ8vzm/4Jr8eaNSolg62BoiN1sN46b+G6HBxln1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfLNP2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 10:28:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:34822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbfLNP2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 10:28:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F294214AF;
        Sat, 14 Dec 2019 15:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576337297;
        bh=+Xz+uCe76wc0uyA264puP0KEktwfV+4eFIf5Z8fsDrc=;
        h=Date:From:To:Cc:Subject:From;
        b=GK3a7/xeSuhmO2Xn0OUpwJlI4PjQWg27dxuZYm6J4SV+9URDasirsy03a91wwF+l8
         exNwBWOa5Q08AOOpbOATMGf+KPNQ09JBv5WyDccTAwd9U3K2en6rVHCL2uoNDowcuW
         KUkXbxiZev0d4NUfDauB0c7/+Jo1vdiRSaWQGsvE=
Date:   Sat, 14 Dec 2019 16:28:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] Driver core fixes for 5.5-rc2
Message-ID: <20191214152815.GA3460263@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.5-rc2

for you to fetch changes up to eecd37e105f0137af0d1b726bf61ff35d1d7d2eb:

  drivers: Fix boot problem on SuperH (2019-12-10 15:51:20 +0100)

----------------------------------------------------------------
Driver core fixes for 5.5-rc2

Here are two small driver core fixes to resolve some reported issues

The first is to handle the much-reported (by the build systems) problem
that superH does not boot anymore.

The second handles an issue in the new platform logic that a number of
people ran into with the automated tests in kbuild

Both of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Guenter Roeck (1):
      drivers: Fix boot problem on SuperH

Saravana Kannan (1):
      of/platform: Unconditionally pause/resume sync state during kernel init

 arch/sh/drivers/platform_early.c | 11 ++---------
 drivers/base/platform.c          |  4 ++++
 drivers/of/platform.c            |  6 +++---
 3 files changed, 9 insertions(+), 12 deletions(-)
