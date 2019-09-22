Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB53C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 20:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55BE720830
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 20:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569185423;
	bh=joWVA76OepDavLT0wjk1xjupXCX5NEg9RdVMiof339U=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=rq5lS3vMz+Mbvn35VVxC2TfUCQfEMTiKYoBCpdmgnpuhbHlKKbf+uXJG3+ind4QUq
	 7zwbkW9/mUVVDfyf/gb54zZJAoD0xkKQeef2Fa2h5CQQK7OT8PXJUixURZPige+8Bw
	 IC6G2HiBDbH1cNgXYYjFEKyBF4bjPPBFFNalcb5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391761AbfIVUuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 16:50:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391477AbfIVUuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 16:50:21 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80CC220830;
        Sun, 22 Sep 2019 20:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569185420;
        bh=joWVA76OepDavLT0wjk1xjupXCX5NEg9RdVMiof339U=;
        h=Date:From:To:cc:Subject:From;
        b=SWQU8XAEP7eLpBo8PCWBlf9OgTAiPCJ9KPUtcV157yUdHBdSk6uRwMb785pp79bEV
         vm16QGoWehU4c3Bs8jVw3yWEoqAAu+nTy+Q7+IbIXvnKYWqFdyyv8OJRGBZPg07Ajr
         ZalzapuP8u4RFYwsjxObJCgOGyvC1YTIuzn+yEK0=
Date:   Sun, 22 Sep 2019 22:49:57 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID for 5.4
Message-ID: <nycvar.YFH.7.76.1909222244300.1459@cbobk.fhfr.pm>
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

to receive merge window updates for HID subsystem:

=====
- syzbot memory corruption fixes for hidraw, Prodikeys, Logitech and Sony 
  drivers from Alan Stern and Roderick Colenbrander
- stuck 'fn' key fix for hid-apple from Joao Moreno
- proper propagation of EPOLLOUT from hiddev and hidraw, from
  Fabian Henneke
- fixes for handling power management for intel-ish devices with NO_D3 
  flag set, from Zhang Lixu
- extension of supported usage range for customer page, as some Logitech 
  devices are actually making use of it. From Olivier Gay.
- hid-multitouch is no longer filtering mice node creation, from Benjamin 
  Tissoires
- MobileStudio Pro 13 support, from Ping Cheng
- a few other device ID additions and assorted smaller fixes
=====

Thanks.

----------------------------------------------------------------
Aaron Armstrong Skomra (1):
      HID: wacom: support named keys on older devices

Alan Stern (3):
      HID: hidraw: Fix invalid read in hidraw_ioctl
      HID: logitech: Fix general protection fault caused by Logitech driver
      HID: prodikeys: Fix general protection fault during probe

Bastien Nocera (1):
      HID: sb0540: add support for Creative SB0540 IR receivers

Benjamin Tissoires (5):
      HID: wacom: do not call hid_set_drvdata(hdev, NULL)
      HID: do not call hid_set_drvdata(hdev, NULL) in drivers
      HID: multitouch: do not filter mice nodes
      HID: multitouch: add support for the Smart Tech panel
      HID: logitech-dj: add support of the G700(s) receiver

Fabian Henneke (2):
      hidraw: Return EPOLLOUT from hidraw_poll
      hiddev: Return EPOLLOUT from hiddev_poll

Filipe Laíns (1):
      hid-logitech-dj: add the new Lightspeed receiver

Hans de Goede (1):
      HID: logitech-dj: Fix crash when initial logi_dj_recv_query_paired_devices fails

HungNien Chen (1):
      HID: i2c-hid: modify quirks for weida's devices

Jason Gerecke (1):
      HID: wacom: Fix several minor compiler warnings

Joao Moreno (1):
      HID: apple: Fix stuck function keys when using FN

Joshua Clayton (3):
      HID: core: reformat and reduce hid_printk macros
      HID: core: Add printk_once variants to hid_warn() etc
      HID: core: fix dmesg flooding if report field larger than 32bit

Olivier Gay (1):
      HID: logitech-dj: extend consumer usages range

Ping Cheng (1):
      HID: wacom: add new MobileStudio Pro 13 support

Roderick Colenbrander (1):
      HID: sony: Fix memory corruption issue on cleanup.

Sebastian Parschauer (1):
      HID: Add quirk for HP X500 PIXART OEM mouse

Zhang Lixu (3):
      HID: intel-ish-hid: ipc: set NO_D3 flag only when needed
      HID: intel-ish-hid: ipc: make ish suspend paths clear
      HID: intel-ish-hid: ipc: check the NO_D3 flag to distinguish resume paths

 MAINTAINERS                             |   6 +
 drivers/hid/Kconfig                     |   9 ++
 drivers/hid/Makefile                    |   1 +
 drivers/hid/hid-apple.c                 |  49 +++---
 drivers/hid/hid-core.c                  |   4 +-
 drivers/hid/hid-cougar.c                |   6 +-
 drivers/hid/hid-creative-sb0540.c       | 268 ++++++++++++++++++++++++++++++++
 drivers/hid/hid-gfrm.c                  |   7 -
 drivers/hid/hid-ids.h                   |   5 +-
 drivers/hid/hid-lenovo.c                |   2 -
 drivers/hid/hid-lg.c                    |  10 +-
 drivers/hid/hid-lg4ff.c                 |   1 -
 drivers/hid/hid-logitech-dj.c           |  32 ++--
 drivers/hid/hid-multitouch.c            |  37 ++++-
 drivers/hid/hid-picolcd_core.c          |   7 +-
 drivers/hid/hid-prodikeys.c             |  12 +-
 drivers/hid/hid-quirks.c                |   1 +
 drivers/hid/hid-sensor-hub.c            |   1 -
 drivers/hid/hid-sony.c                  |   2 +-
 drivers/hid/hidraw.c                    |   4 +-
 drivers/hid/i2c-hid/i2c-hid-core.c      |   4 +-
 drivers/hid/intel-ish-hid/ipc/hw-ish.h  |   1 +
 drivers/hid/intel-ish-hid/ipc/ipc.c     |   2 +-
 drivers/hid/intel-ish-hid/ipc/pci-ish.c |  95 ++++++-----
 drivers/hid/usbhid/hiddev.c             |   2 +-
 drivers/hid/wacom_sys.c                 |  25 ++-
 drivers/hid/wacom_wac.c                 |  76 ++++++++-
 include/linux/hid.h                     |  43 ++---
 28 files changed, 561 insertions(+), 151 deletions(-)
 create mode 100644 drivers/hid/hid-creative-sb0540.c

-- 
Jiri Kosina
SUSE Labs

