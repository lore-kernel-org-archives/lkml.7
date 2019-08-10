Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC67C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 11:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B33021743
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 11:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565437922;
	bh=4YROqdvrywxnjFklnTwQaN4gMQkKYxLAhH+wie1vDwA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=BwjatO//c2pH+e1XijRkgAyW9ityXhRAfGO5KtW7yPl9QMrBGOWzkc5vF5T7/gXnE
	 tqibpgHqo+YPxiHhqr3kPNCtvfkRqcZqbI5bAktrtiMLodqghd7klz5DHTOCaP0dhS
	 Dh/JoshIAp/XJePfffUDSqqn5eA2epqp9PsTeEvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfHJLv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 07:51:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfHJLv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 07:51:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55BB421743;
        Sat, 10 Aug 2019 11:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565437917;
        bh=4YROqdvrywxnjFklnTwQaN4gMQkKYxLAhH+wie1vDwA=;
        h=Date:From:To:Cc:Subject:From;
        b=PlyOqBUoFfq+rb1fi+XKKQNEbJUxrjMBdon65nf5pQ5c1wcmpPQxJwhe0VQ4A7ps0
         1NEOsa6mdSjLIS1eKhZM7JDSmAFUDx2q3c48Wn3AFLYDFjr0S3XvAqpy6Wrojh5vFp
         0x9S7mYB0ajpL0Z0NJ39GC769FjPxMV0WSYoTWHY=
Date:   Sat, 10 Aug 2019 13:51:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.3-rc4
Message-ID: <20190810115155.GA5792@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.3-rc4

for you to fetch changes up to 27709ae4e2fe6cf7da2ae45e718e190c5433342b:

  usb: setup authorized_default attributes using usb_bus_notify (2019-08-08 16:07:34 +0200)

----------------------------------------------------------------
USB fixes for 5.3-rc4

Here are some small USB fixes for 5.3-rc4.

The "biggest" one here is moving code from one file to another in order
to fix a long-standing race condition with the creation of sysfs files
for USB devices.  Turns out that there are now userspace tools out there
that are hitting this long-known bug, so it's time to fix them.
Thankfully the tool-maker in this case fixed the issue :)

The other patches in here are all fixes for reported issues.  Now that
syzbot knows how to fuzz USB drivers better, and is starting to now fuzz
the userspace facing side of them at the same time, there will be more
and more small fixes like these coming, which is a good thing.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Gavin Li (1):
      usb: usbfs: fix double-free of usb memory upon submiturb error

Guenter Roeck (2):
      usb: typec: tcpm: Add NULL check before dereferencing config
      usb: typec: tcpm: Ignore unsupported/unknown alternate mode requests

Heikki Krogerus (1):
      usb: typec: ucsi: ccg: Fix uninitilized symbol error

Li Jun (2):
      usb: typec: tcpm: free log buf memory when remove debug file
      usb: typec: tcpm: remove tcpm dir if no children

Mathias Nyman (1):
      xhci: Fix NULL pointer dereference at endpoint zero reset.

Oliver Neukum (2):
      Revert "USB: rio500: simplify locking"
      usb: iowarrior: fix deadlock on disconnect

Suzuki K Poulose (1):
      usb: yurex: Fix use-after-free in yurex_delete

Thiébaud Weksteen (1):
      usb: setup authorized_default attributes using usb_bus_notify

Yoshihiro Shimoda (1):
      usb: host: xhci-rcar: Fix timeout in xhci_suspend()

 drivers/usb/core/devio.c          |   2 -
 drivers/usb/core/hcd.c            | 123 --------------------------------------
 drivers/usb/core/sysfs.c          | 121 +++++++++++++++++++++++++++++++++++++
 drivers/usb/core/usb.h            |   5 ++
 drivers/usb/host/xhci-rcar.c      |   9 ++-
 drivers/usb/host/xhci.c           |  10 ++++
 drivers/usb/misc/iowarrior.c      |   7 ++-
 drivers/usb/misc/rio500.c         |  43 ++++++++-----
 drivers/usb/misc/yurex.c          |   2 +-
 drivers/usb/typec/tcpm/tcpm.c     |  58 ++++++++++++------
 drivers/usb/typec/ucsi/ucsi_ccg.c |   2 +-
 11 files changed, 217 insertions(+), 165 deletions(-)
