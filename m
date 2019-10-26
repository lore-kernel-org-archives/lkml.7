Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A80CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 18:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF90F21655
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 18:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572113860;
	bh=vrJm8LCpCiue1d27U5SoPMv1qRoh3r9h5zdT1buLFJE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=DzMoPrk5iYzfmIX3rx9iLxFv3yHvEo55m6qn+SA9KFFXyY6+vKxmyYHoPc/xMNcBG
	 WIjpQBSqUDXlTUa69StUmyAxi98fXQGY3qfO2msk8qP+kY/Hgmi/fRSJq9ilZ69VH4
	 qmqi+CS2mYDlgWUA5OXolZOFnfDT3OoJD5iE0BZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfJZSRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 14:17:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfJZSRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 14:17:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C21120867;
        Sat, 26 Oct 2019 18:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572113858;
        bh=vrJm8LCpCiue1d27U5SoPMv1qRoh3r9h5zdT1buLFJE=;
        h=Date:From:To:Cc:Subject:From;
        b=IMTQj6GwVeFtWDehsd6QgztpaT7aNU0kabQVk9DlYVUXSWwSwedSfJwR5Sc+fh2kz
         CteNmq3HGaoScnrUW0hsg9V0JfiQBFBnB1hmxYci8juw/3yQ+bUIUhtLCQUXvffZCY
         ymtBofIfd7i7LbONBYGSku6roiVlr3dWjspZFjYg=
Date:   Sat, 26 Oct 2019 20:17:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.4-rc5
Message-ID: <20191026181736.GA648771@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675:

  Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.4-rc5

for you to fetch changes up to 9794476942d8704cfbdef8d5f13427673ab70dcd:

  usb: cdns3: Error out if USB_DR_MODE_UNKNOWN in cdns3_core_init_role() (2019-10-18 12:00:15 -0700)

----------------------------------------------------------------
USB fixes for 5.4-rc5

Here are a number of small USB driver fixes for 5.4-rc5.

More "fun" with some of the misc USB drivers as found by syzbot, and
there are a number of other small bugfixes in here for reported issues.

All have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dan Carpenter (1):
      USB: legousbtower: fix a signedness bug in tower_probe()

Greg Kroah-Hartman (1):
      Merge tag 'usb-serial-5.4-rc4' of https://git.kernel.org/.../johan/usb-serial into usb-linus

Gustavo A. R. Silva (1):
      usb: udc: lpc32xx: fix bad bit shift operation

Johan Hovold (6):
      USB: ldusb: fix memleak on disconnect
      USB: legousbtower: fix memleak on disconnect
      USB: usblp: fix use-after-free on disconnect
      USB: serial: ti_usb_3410_5052: fix port-close races
      USB: serial: ti_usb_3410_5052: clean up serial data access
      USB: ldusb: fix read info leaks

Pawel Laszczak (1):
      usb: cdns3: Fix dequeue implementation.

Roger Quadros (1):
      usb: cdns3: Error out if USB_DR_MODE_UNKNOWN in cdns3_core_init_role()

 drivers/usb/cdns3/core.c              |  4 +++-
 drivers/usb/cdns3/gadget.c            | 35 ++++++++++++++++++++---------------
 drivers/usb/class/usblp.c             |  4 +++-
 drivers/usb/gadget/udc/lpc32xx_udc.c  |  6 +++---
 drivers/usb/misc/ldusb.c              | 23 ++++++++++++-----------
 drivers/usb/misc/legousbtower.c       |  7 ++-----
 drivers/usb/serial/ti_usb_3410_5052.c | 12 ++++--------
 7 files changed, 47 insertions(+), 44 deletions(-)
