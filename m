Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A458C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7DC2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkTyLU90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfDIOm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:42:56 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39729 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfDIOm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:42:56 -0400
Received: by mail-io1-f66.google.com with SMTP id e13so14478341ioq.6;
        Tue, 09 Apr 2019 07:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VPp1xqaw10PXjcUG+W/1s2F3M7J5tRUfOf0rlEaQQUo=;
        b=BkTyLU90CrzLPeyJ4799F2QGe0mdu8hqyYW2MwcvpSBQIm+g3S4r6QFRDe0hAMMt/9
         K4vZqVJ4w9kH1cIBibDMNcTMjj3fT6M8cnlAIya2qoOwmbNMu7tdDg2cO5IGURw+L4kt
         TK/7xcE6Dfbby8pDlqGENprCDmjIXuBX0UrRtPvUWTYjZElIUsViadvKfSd4GN8edthH
         VQcp1mZluWsdsyP7assy1l/djM3kuSEu5CMrGcF0MG6/TqU4D3sX4+cumdhPym7+cSbs
         XUINNpCwgJgslMS8BcdSG/tWHtHX5HZqsHcBEA7qR8HC4SQKMk7ayMUYldqSXxuLOLLC
         j6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VPp1xqaw10PXjcUG+W/1s2F3M7J5tRUfOf0rlEaQQUo=;
        b=LwXzlGSvwdZfrymp01TqjZV32Fi9lVG7NeGA01fyJHYbs2K+cF/VgPPWvlBL80aX3Y
         v8/CT4BLvmkqjc6pJfcxNKZuOIjRpcEUbBhH5lkFzQQ/6I8SAaMKqUvjQKZrQEVBY8wJ
         rUOKqMeOMVULiga6jpZe5lQmEpLdrUqps8NOGU0DJM7L92OmZUqg2hLFdnbL7uAzqyrb
         S79uhyaNaFVmG8LesKtIK57fvLbQdQ+uNlcsFloXU0idtDLY+rXs8g5bwZ2g5ygZazYb
         W9Fzzjrz1Oy1ldDyDEet7EXQ3o/gGtBtnFAcSOb5wlOprF5wByDF58wsA10n3QPs0gwB
         xOPg==
X-Gm-Message-State: APjAAAVvnJAd5L4BcDVfjGxdqg4MtCZg52QN/kXvKgiV7FA9R02r0JPm
        Iw52gfiKyxjy5L5EktgDSiA=
X-Google-Smtp-Source: APXvYqy7tID+DSRf4L6WV+mIGh7InK7+wlwu7jd/BuIf0+vtxgiAcpkMYKz4ZsP9uq/gxgZrPqD2fQ==
X-Received: by 2002:a5e:d616:: with SMTP id w22mr24227173iom.118.1554820975033;
        Tue, 09 Apr 2019 07:42:55 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id j10sm6562000itj.32.2019.04.09.07.42.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 07:42:54 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     robh+dt@kernel.org, linus.walleij@linaro.org
Cc:     lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, jan.kiszka@siemens.com,
        maxime.ripard@bootlin.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v10 0/7] Add Fieldbus subsystem + support HMS Profinet card
Date:   Tue,  9 Apr 2019 10:42:43 -0400
Message-Id: <20190409144250.7237-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch:
  1. adds a Fieldbus subsystem
  2. adds support for the HMS Industrial Networks AB Profinet card.

1. Fieldbus subsystem
---------------------

Fieldbus device (client) adapters allow data exchange with a PLC aka.
"Fieldbus Controller" over a fieldbus (Profinet, FLNet, etc.)
They are typically used when a Linux device wants to expose itself
as an actuator, motor, console light, switch, etc. over the fieldbus.
The framework is designed to provide a generic interface to Fieldbus
Devices from both the Linux Kernel and the userspace.

2. Add support for HMS Profinet Card
------------------------------------

Profinet is an industry technical standard for data communication over
Industrial Ethernet, designed for collecting data from, and controlling,
equipment in industrial systems, with a particular strength in delivering data
under tight time constraints (on the order of 1ms or less).

The profinet card itself is connected to the system via an industrial bus
called 'anybus'.

I have followed the bus driver/client driver pattern, and created an anybus
bus driver, plus a client driver for the profinet card.

In case this patch set gets (eventually) accepted, drivers for other anybus
client cards may follow: flnet, cc-link, ...

The anybus slot on the host is located on an 'anybus controller', which is
custom h/w designed by arcx. It exposes a dual anybus host implementation,
plus a power readout unrelated to the anybus.

v10:
	add a TODO file on how to take this patch set out of staging
	fix linker errors on defconfigs without HAS_IOMEM or REGULATOR

v9:
	Moved everything to staging/ so new userspace ABI can still be tweaked
	Suggested cross-posting to linux-netdev to widen audience
	Greg KH: call ida_destroy() on module exits
	replace arcx anybus controller's reset spinlock with mutex
		(no need for spinlock as never run in atomic context)
		udelay() can now be replaced with usleep_range()
	harmonized email addresses across patchset
	various whitespace changes to silence checkpatch.pl --strict

v8:
	allow fieldbus core to be built as a module (define as tristate).
	use IS_ENABLED() in fieldbus_dev.h to conditionally compile dummy functions.
	anybuss_core.ko uses symbols from fieldbus_dev.ko. Use "top level kbuild
		file" method to make this work.
		See Documentation/kbuild/modules.txt, section 6.3
	Confirm licence choice: GPL-v2 only. no changes.

v7:
	use %zu printf formatter to display size_t

v6:
	Randy Dunlap:
	correctly/consistently indent Kconfig
	spelling/punctuation improvements

	Greg KH:
	suggestion: simplify /sys/class/fieldbus_dev/fieldbus_devX/ -> /sys/class/fieldbus_dev/X/
		can't simplify: create_device() also determines the name of the
		associated char device. simplification would result in a char device
		named /dev/X ?
	applied above suggestion to arcx-controller driver, this works ok as it does not
		have associated char device
	class name left as-is (fieldbus_dev) to differentiate between
		"fieldbus controller" and "fieldbus device" in the future
	makefile clean-up
	sysfs attributes: snprintf -> sprintf
		except card_name, as it's externally provided and could potentially
		be > PAGE_SIZE
	enabled/online sysfs attributes converted to "0/1" values
		using kstrtobool()

v5:
	Greg KH:
		fix licence nit
		consistent use of e-mail address
		replaced raw sysfs attribute with kobject_uevent() call
		keep __ATTRIBUTE_GROUPS because we need is_visible field
	Rob Herring:
		controller devicetree entry now requires multiple address
			regions and interrupts
		controller child node(s) now mapped to child devices by
			slot/host position (using devicetree reg = <>)
		architectural overhaul to align closely to existing pci arch:

				pci			anybus			
--------------------------------------------------------------------------------
Common bus code (spec),		pci/pci_driver.c	anybus/dev_core.c
  calls bus_register()		no of compatible	no of compatible
--------------------------------------------------------------------------------
Device on bus, calls
  XXX_client_driver_register()	hwmon/k8temp.c		fieldbus/hms-profinet.c
--------------------------------------------------------------------------------
Controller, silicon driver	pci/pcie-tango.c	anybus/arcx-anybus.c
				platform_driver calls	platform_driver calls
				pci_host_probe()	anybus_host_common_probe()

v4:
	general
		create fieldbus_dev subsystem, with standardized 'simple'
			userspace interface (sysfs + cdev)
		remove redundant __packed keywords
		use __be16/32 types wherever values are explicitly big-endian
	hms-profinet:
		remove configuration code, and uapi headers: not supported (yet)
			when registering as a fieldbus_dev.
	anybuss-host:
		use struct kref to reference-count tasks
		replace busy loops with usleep_range() loop after 10 tries
		use threaded irq so time_before_eq(jiffies, timeout) will
			continue to work
		allow client devices to be assigned a devicetree node,
			in the same way as pci/mmc/...

v3:
	devicetree-bindings
		adding the vendor prefix is now a separate commit
	anybus-bridge:
		moved misc driver to drivers/bus/
		converted of_gpio_* to gpiod_* abstractions
		can power readout is now a fixed-voltage regulator
	anybuss-host:
		converted refcounts from atomic_t to refcount_t
		fixed potential use-after-free
	hms-profinet:
		applied minor kernel build robot suggestion

v2:
	added architecture overview comments to host driver
	completely reworked anybus-bridge driver, it becomes a reset controller
	anybuss-host driver now needs devicetree entry, link to reset controller
	I will hold off on kernel-doc until the overall architecture gets
		more validation / approval
	fixed Kconfig, comment-style, document ioctl magic numbers
	removed redundant pwm dependency
	renamed enable-gpios to reset-gpios
	stop driving reset-gpio after unloading driver
	use interrupt-parent / interrupts method to describe interrupts
		in the devicetree
	convert references 'i.MX WEIM parallel bus' to 'parallel bus'
	replace devicetree functions with more generic platform_get_resource()
							platform_get_irq()
	added device unique data to add_device_randomness()

v1:
	first shot

Sven Van Asbroeck (7):
  fieldbus_dev: add Fieldbus Device subsystem.
  anybus-s: support HMS Anybus-S bus
  anybus-s: support the Arcx anybus controller
  dt-bindings: anybus-controller: document devicetree binding
  dt-bindings: Add vendor prefix for arcx / Archronix
  fieldbus_dev: support HMS Profinet IRT industrial controller
  staging: fieldbus_dev: add TODO

 Documentation/ABI/testing/fieldbus-dev-cdev   |   31 +
 .../ABI/testing/sysfs-class-fieldbus-dev      |   62 +
 .../fieldbus/arcx,anybus-controller.txt       |   71 +
 .../devicetree/bindings/vendor-prefixes.txt   |    1 +
 Documentation/fieldbus_dev/fieldbus_dev.txt   |   66 +
 drivers/staging/Kconfig                       |    2 +
 drivers/staging/Makefile                      |    1 +
 drivers/staging/fieldbus/Kconfig              |   18 +
 drivers/staging/fieldbus/Makefile             |    7 +
 drivers/staging/fieldbus/TODO                 |    5 +
 drivers/staging/fieldbus/anybuss/Kconfig      |   39 +
 drivers/staging/fieldbus/anybuss/Makefile     |   10 +
 .../staging/fieldbus/anybuss/arcx-anybus.c    |  398 +++++
 .../staging/fieldbus/anybuss/hms-profinet.c   |  224 +++
 drivers/staging/fieldbus/anybuss/host.c       | 1459 +++++++++++++++++
 drivers/staging/fieldbus/dev_core.c           |  349 ++++
 include/linux/anybuss-client.h                |  102 ++
 include/linux/anybuss-controller.h            |   47 +
 include/linux/fieldbus_dev.h                  |  106 ++
 19 files changed, 2998 insertions(+)
 create mode 100644 Documentation/ABI/testing/fieldbus-dev-cdev
 create mode 100644 Documentation/ABI/testing/sysfs-class-fieldbus-dev
 create mode 100644 Documentation/devicetree/bindings/fieldbus/arcx,anybus-controller.txt
 create mode 100644 Documentation/fieldbus_dev/fieldbus_dev.txt
 create mode 100644 drivers/staging/fieldbus/Kconfig
 create mode 100644 drivers/staging/fieldbus/Makefile
 create mode 100644 drivers/staging/fieldbus/TODO
 create mode 100644 drivers/staging/fieldbus/anybuss/Kconfig
 create mode 100644 drivers/staging/fieldbus/anybuss/Makefile
 create mode 100644 drivers/staging/fieldbus/anybuss/arcx-anybus.c
 create mode 100644 drivers/staging/fieldbus/anybuss/hms-profinet.c
 create mode 100644 drivers/staging/fieldbus/anybuss/host.c
 create mode 100644 drivers/staging/fieldbus/dev_core.c
 create mode 100644 include/linux/anybuss-client.h
 create mode 100644 include/linux/anybuss-controller.h
 create mode 100644 include/linux/fieldbus_dev.h

-- 
2.17.1

