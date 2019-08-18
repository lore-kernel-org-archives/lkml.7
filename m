Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB45DC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 08:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DD82086C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 08:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566118590;
	bh=YPy61RhFWh/qNEnakfb0FEU4mMBXMcqoky7A4GSYIFw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=b3YxDomDnZI+UysXURpJnfY4nOnvHRKIrqlL42NboQbqFienGVKa2gPCm7IZwZ+Sf
	 SuDfX/cp8crPdbdUdL4DNSMcNSxUWj11f8xao342RfEsMJo/bmon8lpgM0JEizTPx2
	 B/Im1WEqzftpwwa1/FYqGJcIfHoaZzC/2uRsc4Wg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfHRI42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 04:56:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfHRI42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 04:56:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4001A2086C;
        Sun, 18 Aug 2019 08:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566118586;
        bh=YPy61RhFWh/qNEnakfb0FEU4mMBXMcqoky7A4GSYIFw=;
        h=Date:From:To:Cc:Subject:From;
        b=Frphb+0fLqoC89eQXQgMpzg0rGbByDkzvAhtt7LxVCj10yJn5SRD+1VvMOnoBtDDH
         b/kCu6BnZ+d8/B8EfNAIIvWimuyXvm+CkYGb0TFIN40A+3V1cEGobIvkBXsvGsIOGO
         UMaTdL/1LLiy8Lk6VwU2IWGuK8c0C8FnV6VDRTfU=
Date:   Sun, 18 Aug 2019 10:56:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 5.3-rc5
Message-ID: <20190818085624.GA28589@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d45331b00ddb179e291766617259261c112db872:

  Linux 5.3-rc4 (2019-08-11 13:26:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.3-rc5

for you to fetch changes up to 6a5f43d1d8bd3779e428178438caf33f60427124:

  Merge tag 'usb-serial-5.3-rc5' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus (2019-08-17 17:09:33 +0200)

----------------------------------------------------------------
USB fixes for 5.3-rc5

Here are number of small USB fixes for 5.3-rc5.

Syzbot has been on a tear recently now that it has some good USB
debugging hooks integrated, so there's a number of fixes in here found
by those tools for some _very_ old bugs.  Also a handful of gadget
driver fixes for reported issues, some hopefully-final dma fixes for
host controller drivers, and some new USB serial gadget driver ids.

All of these have been in linux-next this week with no reported issues
(the usb-serial ones were in linux-next in its own branch, but merged
into mine on Friday.)

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (1):
      USB: core: Fix races in character device registration and deregistraion

André Draszik (1):
      usb: chipidea: imx: fix EPROBE_DEFER support during driver probe

Benjamin Herrenschmidt (2):
      usb: gadget: composite: Clear "suspended" on reset/disconnect
      usb: gadget: mass_storage: Fix races between fsg_disable and fsg_set_alt

Bob Ham (1):
      USB: serial: option: add the BroadMobi BM818 card

Christoph Hellwig (2):
      usb: don't create dma pools for HCDs with a localmem_pool
      usb: add a hcd_uses_dma helper

Greg Kroah-Hartman (2):
      Merge tag 'fixes-for-v5.3-rc4' of git://git.kernel.org/.../balbi/usb into usb-linus
      Merge tag 'usb-serial-5.3-rc5' of https://git.kernel.org/.../johan/usb-serial into usb-linus

Hans Ulli Kroll (1):
      usb: host: fotg2: restart hcd after port reset

Oliver Neukum (2):
      usb: cdc-acm: make sure a refcount is taken early enough
      USB: CDC: fix sanity checks in CDC union parser

Rogan Dawes (1):
      USB: serial: option: add D-Link DWM-222 device ID

Tony Lindgren (1):
      USB: serial: option: Add Motorola modem UARTs

Yoshiaki Okamoto (1):
      USB: serial: option: Add support for ZTE MF871A

Yoshihiro Shimoda (1):
      usb: gadget: udc: renesas_usb3: Fix sysfs interface of "role"

 drivers/usb/chipidea/ci_hdrc_imx.c           | 19 ++++++++++++-------
 drivers/usb/class/cdc-acm.c                  | 12 +++++++-----
 drivers/usb/core/buffer.c                    | 10 +++-------
 drivers/usb/core/file.c                      | 10 +++++-----
 drivers/usb/core/hcd.c                       |  4 ++--
 drivers/usb/core/message.c                   |  4 ++--
 drivers/usb/dwc2/hcd.c                       |  2 +-
 drivers/usb/gadget/composite.c               |  1 +
 drivers/usb/gadget/function/f_mass_storage.c | 28 ++++++++++++++++++----------
 drivers/usb/gadget/udc/renesas_usb3.c        |  5 +++--
 drivers/usb/host/fotg210-hcd.c               |  4 ++++
 drivers/usb/serial/option.c                  | 10 ++++++++++
 include/linux/usb.h                          |  2 +-
 include/linux/usb/hcd.h                      |  3 +++
 14 files changed, 72 insertions(+), 42 deletions(-)
