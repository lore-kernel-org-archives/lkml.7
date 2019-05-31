Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862F8C28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E3F26264
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559267225;
	bh=OecpYtWJnFERvx0LdGFbAcYZk21QqOLhh8bV8JHhD/4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=T1hC9cRX68zJN9P5twH/33zCod2DkvschGm7DzXc963+5vUZ04j937RpCH0Q8TEyF
	 c+KRRZbJ47M2fggqSECIhvL126nVCDGpZ0AiQhT9u46znyocvcADU7hsl772FSKOgg
	 WTfcFmWj4pFwhngcx4WUgAfxPyb+4fQQsSgfL3iM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfEaBrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 21:47:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfEaBrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 21:47:03 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FBA02626B;
        Fri, 31 May 2019 01:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559267223;
        bh=OecpYtWJnFERvx0LdGFbAcYZk21QqOLhh8bV8JHhD/4=;
        h=Date:From:To:Cc:Subject:From;
        b=KbyMfS4DMpDbYh9RO4X/dFNooozYWz70zWAEAuOZ1Y1OzZPRyZbcjVR0vWEpwieI7
         Tgsatk8hS0o11M2o52Mc69wueIHlHMOLZYClrl7syVKEu16IBGpKZrK/fFhl8XZHVj
         9Kek0Q83/P/sbTis6J9jpnO/SwJA0wjdDcwqIyIU=
Date:   Thu, 30 May 2019 18:47:02 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial fixes for 5.2-rc3
Message-ID: <20190531014702.GA30713@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.2-rc3

for you to fetch changes up to a1ad1cc9704f64c169261a76e1aee1cf1ae51832:

  vt/fbcon: deinitialize resources in visual_init() after failed memory allocation (2019-05-24 17:08:18 +0200)

----------------------------------------------------------------
TTY/Serial driver fixes for 5.2-rc3

Here are some small serial and TTY driver fixes for 5.2-rc3.

Nothing major, just a number of fixes for reported issues.  The fbcon
core fix also resolves an issue, and was acked by the relevant
maintainer to go through this tree.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
George G. Davis (1):
      serial: sh-sci: disable DMA for uart_console

Grzegorz Halat (1):
      vt/fbcon: deinitialize resources in visual_init() after failed memory allocation

Joe Burmeister (1):
      tty: max310x: Fix external crystal register setup

Jorge Ramirez-Ortiz (1):
      tty: serial: msm_serial: Fix XON/XOFF

Sascha Hauer (1):
      serial: imx: remove log spamming error message

 drivers/tty/serial/imx.c         |  1 -
 drivers/tty/serial/max310x.c     |  2 +-
 drivers/tty/serial/msm_serial.c  |  5 ++++-
 drivers/tty/serial/sh-sci.c      |  7 +++++++
 drivers/tty/vt/vt.c              | 11 +++++++++--
 drivers/video/fbdev/core/fbcon.c |  2 +-
 6 files changed, 22 insertions(+), 6 deletions(-)
