Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F691C46477
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19054207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560438073;
	bh=gVhsA2V4Up0x7d4yh2MEfkVq4qTx2nGcU8j8Txc5KoQ=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=vSu1Iu5FrJvxFDeVDlU5DGqU0tHDqI9PavHPLNa0LlaZCzHbkfDDpm7oRvkAYTYt4
	 O+Hra9Oxl6U0olcPGLK9dGNlYvQfBqIAYw9SRbvTmwpM6Mg7aHuThEGUYtbW2cCCyr
	 SpavUw3vnT7Xk/BhbgqwxvEPJMnPouC5jxJCiYI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733005AbfFMPBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:01:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732562AbfFMOhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:37:23 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BAFF20679;
        Thu, 13 Jun 2019 14:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560436643;
        bh=gVhsA2V4Up0x7d4yh2MEfkVq4qTx2nGcU8j8Txc5KoQ=;
        h=Date:From:To:cc:Subject:From;
        b=d+dOAvT/t+u/ZGFW+ta3v9me+sCiznvzQ8oEVTWBJYvr7k674sLVSHKTmzkIKSZ43
         r+SLgmvUEblp3vmSiLZl1J2TiuudDHUTAY7H5p9C0tgogc/oaB/BMRit3ZHtwwU698
         z36dWjNIPVQZBbVtrFdbuLYbE5mtMP2/cohx+uwE=
Date:   Thu, 13 Jun 2019 16:37:20 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fixes for 5.2-rc
Message-ID: <nycvar.YFH.7.76.1906131632070.27227@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive fixes for HID subsystem; highlights:

=====
- regression fixes (reverts) for module loading changes that turned out to
  be incompatible with some userspace, from Benjamin Tissoires
- regression fix for special Logitech unifiying receiver 0xc52f, from Hans 
  de Goede
- a few device ID additions to logitech driver, from Hans de Goede
- fix for Bluetooth support on 2nd-gen Wacom Intuos Pro, from Jason 
  Gerecke
=====

Thanks.

----------------------------------------------------------------
Benjamin Tissoires (4):
      HID: multitouch: handle faulty Elo touch device
      Revert "HID: Increase maximum report size allowed by hid_field_extract()"
      Revert "HID: core: Do not call request_module() in async context"
      Revert "HID: core: Call request_module before doing device_add"

B³a¿ej Szczygie³ (1):
      HID: a4tech: fix horizontal scrolling

Hans de Goede (4):
      HID: logitech-dj: add support for the Logitech MX5500's Bluetooth Mini-Receiver
      HID: logitech-hidpp: add support for the MX5500 keyboard
      HID: logitech-hidpp: Add support for the S510 remote control
      HID: logitech-dj: Fix 064d:c52f receiver support

Jason Gerecke (5):
      HID: wacom: Don't set tool type until we're in range
      HID: wacom: Don't report anything prior to the tool entering range
      HID: wacom: Send BTN_TOUCH in response to INTUOSP2_BT eraser contact
      HID: wacom: Correct button numbering 2nd-gen Intuos Pro over Bluetooth
      HID: wacom: Sync INTUOSP2_BT touch state after each frame if necessary

Joseph Salisbury (1):
      HID: hyperv: Add a module description line

Kai-Heng Feng (1):
      HID: i2c-hid: add iBall Aer3 to descriptor override

Tobias Auerochs (1):
      HID: rmi: Use SET_REPORT request on control endpoint for Acer Switch 3 and 5

 drivers/hid/hid-a4tech.c                 | 11 +++--
 drivers/hid/hid-core.c                   | 16 ++-----
 drivers/hid/hid-hyperv.c                 |  2 +
 drivers/hid/hid-ids.h                    |  1 +
 drivers/hid/hid-logitech-dj.c            | 50 +++++++++++++++-------
 drivers/hid/hid-logitech-hidpp.c         |  9 ++++
 drivers/hid/hid-multitouch.c             |  7 ++++
 drivers/hid/hid-rmi.c                    | 15 ++++++-
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c |  8 ++++
 drivers/hid/wacom_wac.c                  | 71 ++++++++++++++++++++++----------
 10 files changed, 136 insertions(+), 54 deletions(-)

-- 
Jiri Kosina
SUSE Labs

