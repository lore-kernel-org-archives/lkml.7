Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C0BC33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBFC21775
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2j7noEH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgAFHWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 02:22:15 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39216 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFHWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 02:22:14 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so18573979plp.6;
        Sun, 05 Jan 2020 23:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VeggttJg0Pje/R+c9YmMm34vxKsAvn9MPA4ZMGlgdew=;
        b=Q2j7noEHBiBWbtSbMQmaKwBI8ydmkNAfCsg/z/5pf2OTGUDdQ80j9x4GDM6AE1smsp
         nsp/OeET/00sp+AWDMODr9+g/o4y4g9gjqU9pDcyZBHU69fltJ63fgbyGY0mpTYiHAc3
         fFlvbxfwwtvEqG6KaPiX7yH+CrvQIBvYLyv999pjIAhWS+VFVPHLzR4dFhAAUMWWPIa4
         QF6t1SmZTaTRz4EL3cGJijDCI9ON1TL/J6JiSN0HKsdqq32O9pIj5cvRS+fq9eQqSTcp
         YIjBz4PQyyzD/8yhTlET6x7jcTlJvO9d9Qkkusqfkx6AD0Vlq6frcoJRXqp44ZZjY+8h
         Aalw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VeggttJg0Pje/R+c9YmMm34vxKsAvn9MPA4ZMGlgdew=;
        b=MOCRKCfKwYYuL2F8A4jkio43ws66tJZd1xpwixW7HnNeAvh78/r/CLNgTwgI0ZaDlh
         x+E7ekufSMOfdg1pbMv+nlrq5OCDVFOLTpVKAt5HrBGphD28RUGO3m52WRN2KTChHi4+
         MitQba7SGn3f1PJk5sqqj9wQq3RH4FkAlqHPWXfoVqYvC3+cGvfSEngtfqQ3mwX9jx4A
         NM94eSL7P94Yq1BBE+O/eZB+gDIjNHSRGkUCsxfWcqDB73yF1T1Mhvz7IlawxzINqufQ
         03ZenKZFhH+ZDc9591tUuucZPxhj0pcmW5BQEFRPWqyj5rlCx9X7N9HXBx7qLjugtMb7
         LZYg==
X-Gm-Message-State: APjAAAUNx2p1HJXK5H8gTmw7bKHaUeq09rICC5i4GL/QWN1wN5aX+1jM
        SNMRdpvvnf5o0tKytLrnZM4=
X-Google-Smtp-Source: APXvYqzkNBCwTuZO8lb4mGtMa4XFdozVm3QWiTpXSECu2DZ945Vka8GQcDuSrF8qv0vA7BkG4ewUaw==
X-Received: by 2002:a17:902:74c5:: with SMTP id f5mr99802403plt.229.1578295333957;
        Sun, 05 Jan 2020 23:22:13 -0800 (PST)
Received: from localhost.localdomain ([49.207.56.131])
        by smtp.gmail.com with ESMTPSA id q8sm72968137pgg.92.2020.01.05.23.22.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Jan 2020 23:22:13 -0800 (PST)
From:   Rishi Gupta <gupt21@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH v1 0/3] Add virtual serial null modem emulation driver
Date:   Mon,  6 Jan 2020 12:51:52 +0530
Message-Id: <cover.1578235515.git.gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver named ttyvs creates virtual tty/serial device which emulates
behaviour of a real serial port device. Serial port events like parity,
frame, overflow errors, ring indications, break assertions, flow controls
are also emulated.

It supports both device-tree and non device-tree platforms. And works in
both built-in and loadable driver methods.

Use cases
~~~~~~~~~~~~~~~~~
This driver saves time to market and have following use cases including
but not limited to; automated testing, GPS and other data simulation, data
injection for corner case testing, scaleability testing, data sniffing,
robotics emulator/simulator, application development when hardware,
firmware and driver is still not available, identifying hardware issues
from software bugs quickly during development, development cost reduction
across team, product demo where data from hardware needs to be sent to the
GUI application, data forwarding, serial port redirection etc.

Basic idea
~~~~~~~~~~~~~~~~~

This driver implements a virtual multi-port serial card in such a
way that the virtual card can have 0 to N number of virtual serial
ports (tty devices). The devices created in this card are used in
exactly the same way as the real tty devices using standard termios
and Linux/Posix APIs.
 
     /dev/ttyvs_card
   +~~~~~~~~~~~~~~~~~~~~~+
   |   +-------------+   |
   |   | /dev/ttyvs0 |   |
   |   +-------------+   |
   |   .                 |
   |   .                 |
   |   +-------------+   |
   |   | /dev/ttyvsN |   |
   |   +-------------+   |
   +~~~~~~~~~~~~~~~~~~~~~+

Creating devices
~~~~~~~~~~~~~~~~~

Devices can be created/deleted by writing to /dev/ttyvs_card node.

# Create a loop back device using given number (for ex; ttyvs8):
echo "genlb#00008#xxxxx#7-8,x,x,x#4-1,6,x,x#x-x,x,x,x#x-x,x,x,x#y#x" > /dev/ttyvs_card

# Create a null modem pair using given numbers (for ex; ttyvs5/6):
echo "gennm#xxxxx#xxxxx#7-8,x,x,x#4-1,6,x,x#7-8,x,x,x#4-1,6,x,x#y#y" > /dev/ttyvs_card

# Create null modem pair using next free number (index)
echo "gennm#xxxxx#xxxxx#7-8,x,x,x#4-1,6,x,x#7-8,x,x,x#4-1,6,x,x#y#y" > /dev/ttyvs_card

# Create loopback devices using next free number (index)
echo "genlb#xxxxx#xxxxx#7-8,x,x,x#4-1,6,x,x#x-x,x,x,x#x-x,x,x,x#y#x" > /dev/ttyvs_card

Devices can also be created through DT. This patch describes this in detail:
[PATCH 1/3] dt-bindings: ttyvs: document serial null modem driver dt bindings

Deleting devices
~~~~~~~~~~~~~~~~~

Devices can be deleted by writing pre-formatted string only. Driver
returns negative error code if invalid, out of range values or
syntactically invalid values are supplied.

# To delete all devices in one shot write 'xxxxx' as shown below:
echo "del#xxxxx#xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" > /dev/ttyvs_card

# To delete a device by number specify its number for ex; to delete 5th device:
echo "del#00005#xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" > /dev/ttyvs_card

Device tree bindings
~~~~~~~~~~~~~~~~~~~~

Devices can also be created and configured through DT. Following patch
describes how to do it in detail.
[PATCH 1/3] dt-bindings: ttyvs: document serial null modem driver dt bindings

Module parameters
~~~~~~~~~~~~~~~~~

The ttyvs driver can be passd 3 optional parameters.

max_num_vs_devs: specifies how may virtyal tty devices this driver should
support. By default driver supports upto 64 devices. This can also be
specified through DT property.

init_num_nm_pairs: specifies how many standard type null modem pairs should
be created when driver is loaded. If this parameter is used and devices are
also created through DT, then all of these devices will be deleted. DT is
given more preference in all cases.

init_num_lb_devs: specifies how many standard type loop-back devices should
be created when driver is loaded. If this parameter is used and devices are
also created through DT, then all of these devices will be deleted. DT is
given more preference in all cases.

Udev rules example
~~~~~~~~~~~~~~~~~~

# Set permissions on card node to manage devices
ACTION=="add", SUBSYSTEM=="misc", KERNEL=="ttyvs_card", MODE="0666"

# Set permissions of sysfs files for event emulation
ACTION=="add", SUBSYSTEM=="tty", KERNEL=="ttyvs[0-9]*", MODE="0666",\
RUN+="/bin/chmod 0666 %S%p/event %S%p/faultycable"

Emulating events
~~~~~~~~~~~~~~~~~

Event emulation is through per-device sysfs file.

1. Emulate framing error (insert TTY_FRAME in data buffer):
$ echo "1" > /sys/devices/virtual/tty/ttyvsN/event

2. Emulate parity error (insert TTY_PARITY in data buffer):
$ echo "2" > /sys/devices/virtual/tty/ttyvsN/event

3. Emulate overrun error (insert TTY_OVERRUN in data buffer):
$ echo "3" > /sys/devices/virtual/tty/ttyvsN/event

4. Emulate ring indicator (set RI signal):
$ echo "4" > /sys/devices/virtual/tty/ttyvsN/event

5. Emulate ring indicator (unset RI signal):
$ echo "5" > /sys/devices/virtual/tty/ttyvsN/event

6. Emulate break received (insert TTY_BREAK in data buffer):
$ echo "6" > /sys/devices/virtual/tty/ttyvsN/event

7. Emulate cable is faulty (data sent is not received):
$ echo "1" > /sys/devices/virtual/tty/ttyvsN/faultycable

8. Emulate cable is not faulty (default):
$ echo "0" > /sys/devices/virtual/tty/ttyvsN/faultycable


There are 3 patches in this submission:
[PATCH 1/3] dt-bindings: ttyvs: document serial null modem driver dt bindings
[PATCH 2/3] tty/serial: ttvys: add null modem driver emulating serial port
[PATCH 3/3] tty: documentation: abi: add ttyvs null modem driver sysfs nodes

Rishi Gupta (3):
  dt-bindings: ttyvs: document serial null modem driver dt bindings
  tty/serial: ttvys: add null modem driver emulating serial port
  tty: documentation: abi: add ttyvs null modem driver sysfs nodes

 .../ABI/testing/sysfs-devices-virtual-tty_ttyvs    |   18 +
 .../devicetree/bindings/serial/ttyvs.yaml          |  175 ++
 MAINTAINERS                                        |    8 +
 drivers/tty/Kconfig                                |   16 +
 drivers/tty/Makefile                               |    1 +
 drivers/tty/ttyvs.c                                | 2429 ++++++++++++++++++++
 6 files changed, 2647 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-virtual-tty_ttyvs
 create mode 100644 Documentation/devicetree/bindings/serial/ttyvs.yaml
 create mode 100644 drivers/tty/ttyvs.c

-- 
2.7.4

