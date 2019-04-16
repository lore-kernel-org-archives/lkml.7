Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04237C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D85204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5clGGbC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfDPP4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:56:25 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42119 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDPP4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:56:24 -0400
Received: by mail-io1-f68.google.com with SMTP id c4so18050304ioh.9;
        Tue, 16 Apr 2019 08:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IWFR1yluC2DK/tFyFORPQt7UgjY7H4FX9kP8ZkUmQs4=;
        b=s5clGGbCX5pFdh1/mo13FlDrcKFjPP8kqMS8bQV5EAw+rsRn2VPQAAuvhsY9SsEYFD
         ltV+aDGhSmnqgmJI1zanQPJjex1SA6IIX/jIApoo9DUd0ceC3sHtbpMWp7jRqFnYw33z
         YAccw2x+JQejd1Q3QyWMILnb13wvf9Cnf0fHd7Q2KXbT8WXkCWSd30FiwFsXQbzLjgDC
         bel1nNqU5cxAtT/xk5o+OIZJ6EHSVIhaHidktpmRJMW4CDN25tC+ItsYf1KtNowkc6vC
         eOgfN2qAA5ogIPIwTG3Qo9/OPsFD+x0pOZx6QV0yeR8snaIvbx5dc4PwZwVDpQ3I20K3
         tXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IWFR1yluC2DK/tFyFORPQt7UgjY7H4FX9kP8ZkUmQs4=;
        b=WELOLLRUZhonEFKGXRFqAaKTfcBFAzzs8PawZyVUfMkK64Rw6hHPcNo3VanDXZg7nP
         nf17H+0/noh/YDPKOjn8bBLEkXmUg4I1k4B5L/N0eqWTSMyHJrbUjaiCvf6/JQWd/9Vf
         V06jYx4V8HbzNpapfrSc8ivRU4ap3UUoJfP9zZepw/Ked1qJvf2yRe6zeLo75xshkjxt
         tH534T+05wIx12MQcTyXw9FgPNG0opJaFzKVrjBgH6r7n9O/Y13s/NQY65XjRmJtvkJm
         K9ekBy7pq5tCL4AFXau48Ty3bfBEYXVIeFsHFsaHzxSEMdIePmaDDf0kYJfPtlpN1usm
         qM0Q==
X-Gm-Message-State: APjAAAVDmdOF7T5t8NtbUamFGEm6iEQ2FDhDyMtUqtVIX/5DCBE+1F2G
        TpSk4dbigUqKuBy84CaLkzQ=
X-Google-Smtp-Source: APXvYqxBftoeRn9D+5UWA+a6nfEYu9pjUIK5tT/vO063E/1IWSNQ7v9i7DcBDR+wbm1ppsvyxyfNig==
X-Received: by 2002:a5d:9252:: with SMTP id e18mr19167685iol.97.1555430183714;
        Tue, 16 Apr 2019 08:56:23 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id 64sm9766630ite.42.2019.04.16.08.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 08:56:22 -0700 (PDT)
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
Subject: [PATCH v11 0/7] Add Fieldbus subsystem + support HMS Profinet card
Date:   Tue, 16 Apr 2019 11:56:11 -0400
Message-Id: <20190416155618.1369-1-TheSven73@gmail.com>
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

v11:
	keep all staging code self-contained within the staging/ directory

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

 .../fieldbus/arcx,anybus-controller.txt       |   71 +
 .../devicetree/bindings/vendor-prefixes.txt   |    1 +
 drivers/staging/Kconfig                       |    2 +
 drivers/staging/Makefile                      |    1 +
 .../Documentation/ABI/fieldbus-dev-cdev       |   31 +
 .../ABI/sysfs-class-fieldbus-dev              |   62 +
 .../fieldbus/Documentation/fieldbus_dev.txt   |   66 +
 drivers/staging/fieldbus/Kconfig              |   18 +
 drivers/staging/fieldbus/Makefile             |    7 +
 drivers/staging/fieldbus/TODO                 |    5 +
 drivers/staging/fieldbus/anybuss/Kconfig      |   39 +
 drivers/staging/fieldbus/anybuss/Makefile     |   10 +
 .../staging/fieldbus/anybuss/anybuss-client.h |  102 ++
 .../fieldbus/anybuss/anybuss-controller.h     |   47 +
 .../staging/fieldbus/anybuss/arcx-anybus.c    |  399 +++++
 .../staging/fieldbus/anybuss/hms-profinet.c   |  228 +++
 drivers/staging/fieldbus/anybuss/host.c       | 1460 +++++++++++++++++
 drivers/staging/fieldbus/dev_core.c           |  351 ++++
 drivers/staging/fieldbus/fieldbus_dev.h       |  108 ++
 19 files changed, 3008 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fieldbus/arcx,anybus-controller.txt
 create mode 100644 drivers/staging/fieldbus/Documentation/ABI/fieldbus-dev-cdev
 create mode 100644 drivers/staging/fieldbus/Documentation/ABI/sysfs-class-fieldbus-dev
 create mode 100644 drivers/staging/fieldbus/Documentation/fieldbus_dev.txt
 create mode 100644 drivers/staging/fieldbus/Kconfig
 create mode 100644 drivers/staging/fieldbus/Makefile
 create mode 100644 drivers/staging/fieldbus/TODO
 create mode 100644 drivers/staging/fieldbus/anybuss/Kconfig
 create mode 100644 drivers/staging/fieldbus/anybuss/Makefile
 create mode 100644 drivers/staging/fieldbus/anybuss/anybuss-client.h
 create mode 100644 drivers/staging/fieldbus/anybuss/anybuss-controller.h
 create mode 100644 drivers/staging/fieldbus/anybuss/arcx-anybus.c
 create mode 100644 drivers/staging/fieldbus/anybuss/hms-profinet.c
 create mode 100644 drivers/staging/fieldbus/anybuss/host.c
 create mode 100644 drivers/staging/fieldbus/dev_core.c
 create mode 100644 drivers/staging/fieldbus/fieldbus_dev.h

-- 
2.17.1

