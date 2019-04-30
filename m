Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F978C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09D82147A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556635036;
	bh=jskeg3SR1dgm17UY2N0VqSC0ev0vGZ156lqX+0VWeR8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=dhR9Y51ENlgEMpLgxZI+sDmpN3HGRU6hSb6SlaJDm2dQLM0QiMJ/d/XC10OCHmSMG
	 zyZ3QtP5EQC7a1DGm1L3RymqUTOslNfZMAj8mhDDt5T1CpPowVL/zOGSCiqNUK6djc
	 zPFuDUzmrMuzcR9W8sEFJZGoJ7IvBMHRT+iuWTJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfD3OhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 10:37:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbfD3OhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 10:37:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B90E120835;
        Tue, 30 Apr 2019 14:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556635034;
        bh=jskeg3SR1dgm17UY2N0VqSC0ev0vGZ156lqX+0VWeR8=;
        h=Date:From:To:Cc:Subject:From;
        b=vkg8t/v/Towx7Q0H6mlUsT7npsrE79pCepPbclSLHC2JCqkbbAfjEYrKM4IVXKmwi
         f7IxfWM3XH8a66t3D8ldusu44erx6Jc9qdLGLMZAytQPheuwIVpL6fTXmwhFZYJkYu
         Ifmshnrde1dWV8yrArigFkSM++rGRo6rtH8RAceU=
Date:   Tue, 30 Apr 2019 16:37:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.1-rc8
Message-ID: <20190430143711.GA24385@kroah.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.1-rc8

for you to fetch changes up to c114944d7d67f24e71562fcfc18d550ab787e4d4:

  USB: w1 ds2490: Fix bug caused by improper use of altsetting array (2019-04-25 11:11:41 +0200)

----------------------------------------------------------------
USB fixes for 5.1-rc8/final

Here are some small USB fixes for a bunch of warnings/errors that the
syzbot has been finding with it's new-found ability to stress-test the
USB layer.

All of these are tiny, but fix real issues, and are marked for stable as
well.  All of these have had lots of testing in linux-next as well.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (5):
      USB: core: Fix unterminated string returned by usb_string()
      USB: dummy-hcd: Fix failure to give back unlinked URBs
      USB: core: Fix bug caused by duplicate interface PM usage counter
      USB: yurex: Fix protection fault after device removal
      USB: w1 ds2490: Fix bug caused by improper use of altsetting array

Malte Leip (1):
      usb: usbip: fix isoc packet num validation in get_pipe

 Documentation/driver-api/usb/power-management.rst | 14 +++++++++-----
 drivers/usb/core/driver.c                         | 13 -------------
 drivers/usb/core/message.c                        |  4 +++-
 drivers/usb/gadget/udc/dummy_hcd.c                | 19 +++++++++++++++----
 drivers/usb/misc/yurex.c                          |  1 +
 drivers/usb/storage/realtek_cr.c                  | 13 +++++--------
 drivers/usb/usbip/stub_rx.c                       | 12 +++---------
 drivers/usb/usbip/usbip_common.h                  |  7 +++++++
 drivers/w1/masters/ds2490.c                       |  6 +++---
 include/linux/usb.h                               |  2 --
 10 files changed, 46 insertions(+), 45 deletions(-)
