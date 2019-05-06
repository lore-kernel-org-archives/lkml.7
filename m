Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3C6C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF1920830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557151430;
	bh=FXubAvo9V0PK7Rwm8hcSkfbB7jk3cSjEyLlzaus3lg8=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=jDSmAOt+cFa85EdJrTs5+fNKCeI3HpDiJs1v53rHCQeMFRO+IFlg5dvaga73Z7tZM
	 2gNKQfzPF/rBZuulghS6bStsqrpZS3RWgprRtnMpoplhRBLq81BbNYeAN/zoCeWJyp
	 1xei1BJByrV1BpvfxwmZ5o+3t1iHNoh9Fct17Fw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfEFODs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:03:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfEFODs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:03:48 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6B352054F;
        Mon,  6 May 2019 14:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557151426;
        bh=FXubAvo9V0PK7Rwm8hcSkfbB7jk3cSjEyLlzaus3lg8=;
        h=Date:From:To:cc:Subject:From;
        b=D8lNuE6G6UIJ0xW4VFtk97EDJ2SO6GYYrHPNwqV/2TibXRTdwIBjKRqwSReKQaMxR
         LiqQQI4P+yA56sVaotgOKQFcc+NQWuHbRPbPx59+BWj2z9hk7+M7AJ4cMqgWmp3d0Z
         pRLjVD1Kp/BQxrUWCqt2M4e8JqqhQxQVfaphx8Zk=
Date:   Mon, 6 May 2019 16:03:43 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID for 5.2
Message-ID: <nycvar.YFH.7.76.1905061547380.17054@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive 5.2 merge window updates for HID subsystem. Highlights:

=====
- support for U2F Zero device, from Andrej Shadura
- logitech-dj has historically been treating devices behind
  non-unifying receivers as generic devices, using the HID emulation
  in the receiver. That had several shortcomings (special keys handling,
  battery level monitoring, etc). The driver has been reworked to
  enumarate (and directly communicate with) the devices behind the
  receiver, to avoid the (too) generic HID implementation in the
  receiver itself. All the work done by Benjamin Tissoires and Hans de 
  Goede.
- restructuring of intel-ish driver in order to allow for multiple
  clients of the ISH implementation, from Srinivas Pandruvada
- several other smaller fixes and assorted device ID additions
=====

Thanks.

----------------------------------------------------------------
Alex Henrie (1):
      HID: macally: Add support for Macally ikey keyboard

Andrej Shadura (1):
      HID: add driver for U2F Zero built-in LED and RNG

Andy Shevchenko (1):
      HID: picolcd: Convert to use sysfs_streq()

Benjamin Tissoires (14):
      HID: quirks: do not blacklist Logitech devices
      HID: logitech: Stop setting drvdata to NULL on probe failure and remove
      HID: logitech-dj: reshuffle logi_dj_recv_forward_*
      HID: logitech-dj: fix variable naming in logi_dj_hidpp_event
      HID: logitech-dj: use BIT() macro for RF Report types
      HID: logitech-dj: declare and use a few HID++ 1.0 constants
      HID: logitech-dj: remove USB dependency
      HID: logitech-dj: do not schedule the dj report itself
      HID: logitech-dj: add support for the gaming unifying receiver
      HID: logitech-hidpp: allow non HID++ devices to be handled by this module
      HID: logitech-hidpp: make .probe usbhid capable
      HID: logitech-dj: add usbhid dependency in Kconfig
      HID: input: make sure the wheel high resolution multiplier is set
      HID: input: fix assignment of .value

Colin Ian King (2):
      HID: intel-ish-hid: fix spelling mistake "multipe" -> "multiple"
      HID: logitech-dj: fix spelling in printk

Hans de Goede (31):
      HID: logitech-hidpp: simplify printing of HID++ version
      HID: logitech-hidpp: remove hidpp_is_connected()
      HID: logitech-hidpp: change low battery level threshold from 31 to 30 percent
      HID: core: Call request_module before doing device_add
      HID: core: Do not call request_module() in async context
      HID: logitech-dj: remove unused querying_devices variable
      HID: logitech-dj: protect the paired_dj_devices access in add_djhid_dev with the lock
      HID: logitech-dj: rename dj_receiver_dev.hdev to dj_receiver_dev.hidpp
      HID: logitech-dj: support sharing struct dj_receiver_dev between USB-interfaces
      HID: logitech-dj: add logi_dj_recv_queue_unknown_work helper
      HID: logitech-dj: add support for non unifying receivers
      HID: logitech-dj: add support for 27 MHz receivers
      HID: logitech-dj: add support for 27 MHz mouse-only receivers
      HID: logitech-dj: replace dev_err calls with hid_err calls
      HID: logitech-dj: deal with some KVMs adding an extra interface to the usbdev
      HID: logitech-dj: pick a better name for non-unifying receivers
      HID: logitech-dj: remove false-positive error on double queueing of delayed-work
      HID: logitech-dj: make appending of the HID++ descriptors conditional
      HID: logitech-dj: add support for Logitech Bluetooth Mini-Receiver
      HID: logitech-hidpp: ignore very-short or empty names
      HID: logitech-hidpp: do not make failure to get the name fatal
      HID: logitech-hidpp: remove double assignment from __hidpp_send_report
      HID: logitech-hidpp: remove unused origin_is_hid_core function parameter
      HID: logitech-hidpp: use RAP instead of FAP to get the protocol version
      HID: logitech-hidpp: handle devices attached to 27MHz wireless receivers
      HID: logitech-hidpp: do not hardcode very long report length
      HID: logitech-hidpp: add input_device ptr to struct hidpp_device
      HID: logitech-hidpp: make hidpp10_set_register_bit a bit more generic
      HID: logitech-hidpp: add support for HID++ 1.0 wheel reports
      HID: logitech-hidpp: add support for HID++ 1.0 extra mouse buttons reports
      HID: logitech-hidpp: add support for HID++ 1.0 consumer keys reports

Hong Liu (1):
      HID: intel-ish-hid: Add match callback to ishtp bus type

Hui Wang (1):
      Revert "HID: i2c-hid: Disable runtime PM on Synaptics touchpad"

Hyungwoo Yang (1):
      HID: intel-ish: enable raw interface to HID devices on ISH

Jiri Kosina (1):
      HID: u2fzero: fail probe if not using USB transport

Mao Wenan (1):
      HID: u2fzero: fix compiling error in u2fzero_probe()

Nicolas Saenz Julienne (1):
      HID: core: move Usage Page concatenation to Main item

Rushikesh S Kadam (1):
      HID: intel-ish-hid: ISH firmware loader client driver

Srinivas Pandruvada (10):
      HID: intel-ish-hid: Hide members of struct ishtp_cl_device
      HID: intel-ish-hid: Simplify ishtp_cl_link()
      HID: intel-ish-hid: Move driver registry functions
      HID: intel-ish-hid: Store ishtp_cl_device instance in device
      HID: intel-ish-hid: Move the common functions from client.h
      HID: intel-ish-hid: Add interface functions for struct ishtp_cl
      HID: intel-ish-hid: Move functions related to bus and device
      HID: intel-ish-hid: Use the new interface functions in HID ish client
      HID: intel-ish-hid: Add interface function for PCI device pointer
      HID: intel-ish-hid: Add Comet Lake PCI device ID

Wolfram Sang (1):
      HID: hid-sensor-custom: simplify getting .driver_data

 drivers/hid/Kconfig                          |   27 +
 drivers/hid/Makefile                         |    3 +
 drivers/hid/hid-core.c                       |   53 +-
 drivers/hid/hid-ids.h                        |    7 +-
 drivers/hid/hid-input.c                      |   81 +-
 drivers/hid/hid-lg.c                         |    2 -
 drivers/hid/hid-logitech-dj.c                | 1142 +++++++++++++++++++++-----
 drivers/hid/hid-logitech-hidpp.c             |  736 ++++++++++++-----
 drivers/hid/hid-macally.c                    |   45 +
 drivers/hid/hid-picolcd_core.c               |   18 +-
 drivers/hid/hid-quirks.c                     |    6 -
 drivers/hid/hid-sensor-custom.c              |   12 +-
 drivers/hid/hid-u2fzero.c                    |  374 +++++++++
 drivers/hid/i2c-hid/i2c-hid-core.c           |    2 -
 drivers/hid/intel-ish-hid/Kconfig            |   15 +
 drivers/hid/intel-ish-hid/Makefile           |    3 +
 drivers/hid/intel-ish-hid/ipc/hw-ish.h       |    1 +
 drivers/hid/intel-ish-hid/ipc/pci-ish.c      |    1 +
 drivers/hid/intel-ish-hid/ishtp-fw-loader.c  | 1085 ++++++++++++++++++++++++
 drivers/hid/intel-ish-hid/ishtp-hid-client.c |  168 ++--
 drivers/hid/intel-ish-hid/ishtp-hid.c        |   49 +-
 drivers/hid/intel-ish-hid/ishtp-hid.h        |   14 +-
 drivers/hid/intel-ish-hid/ishtp/bus.c        |   96 ++-
 drivers/hid/intel-ish-hid/ishtp/bus.h        |   37 +-
 drivers/hid/intel-ish-hid/ishtp/client.c     |   60 +-
 drivers/hid/intel-ish-hid/ishtp/client.h     |   24 -
 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h  |   31 -
 include/linux/hid.h                          |    4 +-
 include/linux/intel-ish-client-if.h          |  112 +++
 29 files changed, 3518 insertions(+), 690 deletions(-)
 create mode 100644 drivers/hid/hid-macally.c
 create mode 100644 drivers/hid/hid-u2fzero.c
 create mode 100644 drivers/hid/intel-ish-hid/ishtp-fw-loader.c
 create mode 100644 include/linux/intel-ish-client-if.h

-- 
Jiri Kosina
SUSE Labs

