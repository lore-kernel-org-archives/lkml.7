Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F09FC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48832173B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565089186;
	bh=mrWV7hZuOr2uGBDZZAgb7e6U9GthHIrRUWGwibapWc8=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=qKKOM3kya3LCsvZAqck7YrvsMA3kGfTb9OwxBmMxU04PpenUnrLN9tPa3+VRLySug
	 67BgWUteY4Hpeucuq5MfAtesmv+tAM9v91dHG+oru0ChB5b3B9dTqA7jrhpNiaWt9o
	 3AVwzqYT0IdRdLvlQfPQtp7iV3xDGXN+M3hp4Bhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbfHFK7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 06:59:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730877AbfHFK7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:59:44 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F83D216B7;
        Tue,  6 Aug 2019 10:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565089183;
        bh=mrWV7hZuOr2uGBDZZAgb7e6U9GthHIrRUWGwibapWc8=;
        h=Date:From:To:cc:Subject:From;
        b=Y+Qma2aZjeGimRX2mjXEjnhS/DzbVBio5wkATg+naai9YbyBL2TjcMV5pP4HwAimR
         2jyj8JLLs7gEBwXQHQQuMG3IuR6ljMobrBtE8iCQ1E3ukkQhv/YV0pFZDOq54gTPxp
         t/Sbtgwkx3evKGMHkQMlOOkEKcB9m7j9eAs7V9io=
Date:   Tue, 6 Aug 2019 12:59:39 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.1908061254440.27147@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive HID subsystem fixes:

=====
- functional regression fix for some of the Logitech unifying devices, 
  from Hans de Goede
- race condition fix in hid-sony for bug severely affecting Valve/Android 
  deployments, from Roderick Colenbrander
- several fixes for issues found by syzbot/kasan, from Oliver Neukum and 
  Hillf Danton
- functional regression fix for Wacom Cintiq device, from Aaron Armstrong 
  Skomra
- a few other assorted device-specific quirks
=====

Thanks.

----------------------------------------------------------------
Aaron Armstrong Skomra (1):
      HID: wacom: fix bit shift for Cintiq Companion 2

Filipe Laíns (3):
      HID: logitech-dj: rename "gaming" receiver to "lightspeed"
      HID: logitech-hidpp: add USB PID for a few more supported mice
      HID: logitech-dj: add the Powerplay receiver

Hans de Goede (1):
      HID: logitech-dj: Really fix return value of logi_dj_recv_query_hidpp_devices

Hillf Danton (2):
      HID: hiddev: avoid opening a disconnected device
      HID: hiddev: do cleanup in failure of opening a device

Ilya Trukhanov (1):
      HID: Add 044f:b320 ThrustMaster, Inc. 2 in 1 DT

István Váradi (1):
      HID: quirks: Set the INCREMENT_USAGE_ON_DUPLICATE quirk on Saitek X52

Nicolas Saenz Julienne (1):
      HID: input: fix a4tech horizontal wheel custom usage

Oliver Neukum (1):
      HID: holtek: test for sanity of intfdata

Roderick Colenbrander (1):
      HID: sony: Fix race condition between rumble and device remove.

Sebastian Parschauer (1):
      HID: Add quirk for HP X1200 PIXART OEM mouse

 drivers/hid/hid-a4tech.c         | 30 +++++++++++++++++++++++++++---
 drivers/hid/hid-holtek-kbd.c     |  9 +++++++--
 drivers/hid/hid-ids.h            |  5 ++++-
 drivers/hid/hid-logitech-dj.c    | 10 +++++++---
 drivers/hid/hid-logitech-hidpp.c | 32 +++++++++++++++++++++++++++++++-
 drivers/hid/hid-quirks.c         |  2 ++
 drivers/hid/hid-sony.c           | 15 ++++++++++++---
 drivers/hid/hid-tmff.c           | 12 ++++++++++++
 drivers/hid/usbhid/hiddev.c      | 12 ++++++++++++
 drivers/hid/wacom_wac.c          | 12 ++++++------
 10 files changed, 120 insertions(+), 19 deletions(-)

-- 
Jiri Kosina
SUSE Labs

