Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B0FC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF5121D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XhtkzLSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfLRT1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:27:04 -0500
Received: from mail-qv1-f73.google.com ([209.85.219.73]:53802 "EHLO
        mail-qv1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfLRT1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:27:03 -0500
Received: by mail-qv1-f73.google.com with SMTP id g15so1994339qvq.20
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 11:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=TVGdYk+xoUeaPiO0H9f6MWnkivghvA1sBOueLHicqQ4=;
        b=XhtkzLSf9aomRjhnviFpUv3OXk7Hjoow5GlAYB1/OUFQvyDXgEb3ltN/xHWwIqfyv4
         JfkncybKTW0KTqzLnFts5ZraA0+Ld83WOcKkpeNeqzrXjJAxi+NcR70I/PRqw8ahJShA
         BcLqNW1AeQSUPVuonylwW6FMsOlU8lewzwvWdHzFQv1V131Ag7eguCWjNybCoP3UPkgC
         22I2DP/lV1BhadPlfZZRycpSO8+SgPfxr7wDFwtKzZOchogUZjyuC0Sknoj7l6DHlDxk
         5iw9LgYnOplLJ56So06hig0/yFMq5TUfhbfYTaTOfORNaKvtIMnjNJOanAD2YjQEF5KV
         ja2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=TVGdYk+xoUeaPiO0H9f6MWnkivghvA1sBOueLHicqQ4=;
        b=tgMHRRelom19QW27HtNR/vDpc/BAYKBWPfnCRF7dtnBYC9vPmUlee9oi4z5KoMlz0S
         PwhVy2g2TkPzmTDMlNH7uf7BR/WPIg0kUbPw9V4c5fU2/ty1ktEeyrXCb0I0RP8yS0Ow
         IOkncd9OOxfFW+/ySN/H1nygNKYiEELX6ro5LJg3Te7Uc6NXB+HDV3H24RrsKUohb1R8
         rSkA9+Tjg0b6ug79EM+La3AB9kmFgKOaT2PajJlmFol/c8R0kcxB3h94Nfp825WqXVWi
         48PHpxa0mbVAEm6Un+K1qHNEtpRf9GgFfZImT+roL0WWyW+Scf4f0VI/C8HSQpiNbHGj
         30dw==
X-Gm-Message-State: APjAAAXYgNJ2ZliC51IxUod5exxRAkxxTPkZhMcut9Lzvu0wbtSMlhhK
        re2JmhzIkdthyD7EDOBIhyGBtSOnS7jNXBBx
X-Google-Smtp-Source: APXvYqzrIDbluclhkbrlfM/Big9TGT60Egl7TBvwLUB7Cnm5H3NtJY7Lk/gKvdgTDBfTp5yv5ZG6ZNsZxg7onu3e
X-Received: by 2002:ad4:4810:: with SMTP id g16mr3853583qvy.22.1576697222665;
 Wed, 18 Dec 2019 11:27:02 -0800 (PST)
Date:   Wed, 18 Dec 2019 20:26:56 +0100
Message-Id: <cover.1576697098.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v4 0/1] usb: gadget: add raw-gadget interface
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Jonathan Corbet <corbet@lwn.net>, Felipe Balbi <balbi@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset (currently a single patch) adds a new userspace interface
for the USB Gadget subsystem called USB Raw Gadget (I don't mind changing
the name to something else if there are better ideas). This is what
currently being used to enable coverage-buided USB fuzzing with syzkaller:

https://github.com/google/syzkaller/blob/master/docs/linux/external_fuzzing_usb.md

Initially I was using GadgetFS (together with the Dummy HCD/UDC module)
to perform emulation of USB devices for fuzzing, but later switched to a
custom written interface. The incentive to implement a different interface
was to provide a somewhat raw and direct access to the USB Gadget layer
for the userspace, where every USB request is passed to the userspace to
get a response. See documentation for the list of differences between
Raw Gadget and GadgetFS.

This patchset has been pushed to the public Linux kernel Gerrit instance:

https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/2144

Changes v3 -> v4:
- Print debug message when maxpacket check fails.
- Use module_misc_device() instead of module_init/exit().
- Reuse DRIVER_NAME macro in raw_device struct definition.
- Don't print WARNING in raw_release().
- Add comment that explains locking into raw_event_queue_fetch().
- Print a WARNING when event queue size is exceeded.
- Rename raw.c to raw_gadget.c.
- Mention module name in Kconfig.
- Reworked logging to use dev_err/dbg() instead of pr_err/debug().

Changes v2 -> v3:
- Updated device path in documentation.
- Changed usb_raw_init struct layout to make it the same for 32 bit compat
  mode.
- Added compat_ioctl to raw_fops.
- Changed raw_ioctl_init() to return EINVAL for invalid USB speeds, except
  for USB_SPEED_UNKNOWN, which defaults to USB_SPEED_HIGH.
- Reject endpoints with maxpacket = 0 in raw_ioctl_ep_enable().

Changes v1 -> v2:
- Moved raw.c to legacy/.
- Changed uapi header to use __u* types.
- Switched from debugfs entry to a misc device.
- Changed raw_dev from refcount to kref.
- Moved UDC_NAME_LENGTH_MAX to uapi headers.
- Used usb_endpoint_type() and usb_endpoint_dir_in/out() functions instead
  of open coding them.
- Added "WITH Linux-syscall-note" to SPDX id in the uapi header.
- Removed pr_err() if case dev_new() fails.
- Reduced the number of debugging messages.

Andrey Konovalov (1):
  usb: gadget: add raw-gadget interface

 Documentation/usb/index.rst            |    1 +
 Documentation/usb/raw-gadget.rst       |   59 ++
 drivers/usb/gadget/legacy/Kconfig      |   11 +
 drivers/usb/gadget/legacy/Makefile     |    1 +
 drivers/usb/gadget/legacy/raw_gadget.c | 1071 ++++++++++++++++++++++++
 include/uapi/linux/usb/raw_gadget.h    |  167 ++++
 6 files changed, 1310 insertions(+)
 create mode 100644 Documentation/usb/raw-gadget.rst
 create mode 100644 drivers/usb/gadget/legacy/raw_gadget.c
 create mode 100644 include/uapi/linux/usb/raw_gadget.h

-- 
2.24.1.735.g03f4e72817-goog

