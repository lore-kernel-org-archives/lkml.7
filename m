Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CACFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE2021848
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404476AbfJPKCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:02:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:43714 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727167AbfJPKCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:02:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C9B13B024;
        Wed, 16 Oct 2019 10:02:00 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Michael Moese <mmoese@suse.de>, Jessica Yu <jeyu@kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] drivers: mcb: use symbol namespaces
Date:   Wed, 16 Oct 2019 12:01:58 +0200
Message-Id: <20191016100158.1400-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have symbol namespaces, use them in MCB to not pollute the
default namespace with MCB internals.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/gpio/gpio-menz127.c            |  1 +
 drivers/iio/adc/men_z188_adc.c         |  1 +
 drivers/mcb/mcb-core.c                 | 28 ++++++++++++++--------------
 drivers/mcb/mcb-lpc.c                  |  1 +
 drivers/mcb/mcb-parse.c                |  2 +-
 drivers/mcb/mcb-pci.c                  |  1 +
 drivers/tty/serial/8250/8250_men_mcb.c |  1 +
 drivers/tty/serial/men_z135_uart.c     |  1 +
 drivers/watchdog/menz69_wdt.c          |  1 +
 9 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpio-menz127.c b/drivers/gpio/gpio-menz127.c
index 70fdb42a8e88..1e21c661d79d 100644
--- a/drivers/gpio/gpio-menz127.c
+++ b/drivers/gpio/gpio-menz127.c
@@ -211,3 +211,4 @@ MODULE_AUTHOR("Andreas Werner <andreas.werner@men.de>");
 MODULE_DESCRIPTION("MEN 16z127 GPIO Controller");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("mcb:16z127");
+MODULE_IMPORT_NS(MCB);
diff --git a/drivers/iio/adc/men_z188_adc.c b/drivers/iio/adc/men_z188_adc.c
index 3b2fbb7ce431..196c8226381e 100644
--- a/drivers/iio/adc/men_z188_adc.c
+++ b/drivers/iio/adc/men_z188_adc.c
@@ -167,3 +167,4 @@ MODULE_AUTHOR("Johannes Thumshirn <johannes.thumshirn@men.de>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("IIO ADC driver for MEN 16z188 ADC Core");
 MODULE_ALIAS("mcb:16z188");
+MODULE_IMPORT_NS(MCB);
diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
index b72e82efaee5..38fbb3b59873 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -191,7 +191,7 @@ int __mcb_register_driver(struct mcb_driver *drv, struct module *owner,
 
 	return driver_register(&drv->driver);
 }
-EXPORT_SYMBOL_GPL(__mcb_register_driver);
+EXPORT_SYMBOL_NS_GPL(__mcb_register_driver, MCB);
 
 /**
  * mcb_unregister_driver() - Unregister a @mcb_driver from the system
@@ -203,7 +203,7 @@ void mcb_unregister_driver(struct mcb_driver *drv)
 {
 	driver_unregister(&drv->driver);
 }
-EXPORT_SYMBOL_GPL(mcb_unregister_driver);
+EXPORT_SYMBOL_NS_GPL(mcb_unregister_driver, MCB);
 
 static void mcb_release_dev(struct device *dev)
 {
@@ -249,7 +249,7 @@ int mcb_device_register(struct mcb_bus *bus, struct mcb_device *dev)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(mcb_device_register);
+EXPORT_SYMBOL_NS_GPL(mcb_device_register, MCB);
 
 static void mcb_free_bus(struct device *dev)
 {
@@ -301,7 +301,7 @@ struct mcb_bus *mcb_alloc_bus(struct device *carrier)
 	kfree(bus);
 	return ERR_PTR(rc);
 }
-EXPORT_SYMBOL_GPL(mcb_alloc_bus);
+EXPORT_SYMBOL_NS_GPL(mcb_alloc_bus, MCB);
 
 static int __mcb_devices_unregister(struct device *dev, void *data)
 {
@@ -323,7 +323,7 @@ void mcb_release_bus(struct mcb_bus *bus)
 {
 	mcb_devices_unregister(bus);
 }
-EXPORT_SYMBOL_GPL(mcb_release_bus);
+EXPORT_SYMBOL_NS_GPL(mcb_release_bus, MCB);
 
 /**
  * mcb_bus_put() - Increment refcnt
@@ -338,7 +338,7 @@ struct mcb_bus *mcb_bus_get(struct mcb_bus *bus)
 
 	return bus;
 }
-EXPORT_SYMBOL_GPL(mcb_bus_get);
+EXPORT_SYMBOL_NS_GPL(mcb_bus_get, MCB);
 
 /**
  * mcb_bus_put() - Decrement refcnt
@@ -351,7 +351,7 @@ void mcb_bus_put(struct mcb_bus *bus)
 	if (bus)
 		put_device(&bus->dev);
 }
-EXPORT_SYMBOL_GPL(mcb_bus_put);
+EXPORT_SYMBOL_NS_GPL(mcb_bus_put, MCB);
 
 /**
  * mcb_alloc_dev() - Allocate a device
@@ -371,7 +371,7 @@ struct mcb_device *mcb_alloc_dev(struct mcb_bus *bus)
 
 	return dev;
 }
-EXPORT_SYMBOL_GPL(mcb_alloc_dev);
+EXPORT_SYMBOL_NS_GPL(mcb_alloc_dev, MCB);
 
 /**
  * mcb_free_dev() - Free @mcb_device
@@ -383,7 +383,7 @@ void mcb_free_dev(struct mcb_device *dev)
 {
 	kfree(dev);
 }
-EXPORT_SYMBOL_GPL(mcb_free_dev);
+EXPORT_SYMBOL_NS_GPL(mcb_free_dev, MCB);
 
 static int __mcb_bus_add_devices(struct device *dev, void *data)
 {
@@ -412,7 +412,7 @@ void mcb_bus_add_devices(const struct mcb_bus *bus)
 {
 	bus_for_each_dev(&mcb_bus_type, NULL, NULL, __mcb_bus_add_devices);
 }
-EXPORT_SYMBOL_GPL(mcb_bus_add_devices);
+EXPORT_SYMBOL_NS_GPL(mcb_bus_add_devices, MCB);
 
 /**
  * mcb_get_resource() - get a resource for a mcb device
@@ -428,7 +428,7 @@ struct resource *mcb_get_resource(struct mcb_device *dev, unsigned int type)
 	else
 		return NULL;
 }
-EXPORT_SYMBOL_GPL(mcb_get_resource);
+EXPORT_SYMBOL_NS_GPL(mcb_get_resource, MCB);
 
 /**
  * mcb_request_mem() - Request memory
@@ -454,7 +454,7 @@ struct resource *mcb_request_mem(struct mcb_device *dev, const char *name)
 
 	return mem;
 }
-EXPORT_SYMBOL_GPL(mcb_request_mem);
+EXPORT_SYMBOL_NS_GPL(mcb_request_mem, MCB);
 
 /**
  * mcb_release_mem() - Release memory requested by device
@@ -469,7 +469,7 @@ void mcb_release_mem(struct resource *mem)
 	size = resource_size(mem);
 	release_mem_region(mem->start, size);
 }
-EXPORT_SYMBOL_GPL(mcb_release_mem);
+EXPORT_SYMBOL_NS_GPL(mcb_release_mem, MCB);
 
 static int __mcb_get_irq(struct mcb_device *dev)
 {
@@ -495,7 +495,7 @@ int mcb_get_irq(struct mcb_device *dev)
 
 	return __mcb_get_irq(dev);
 }
-EXPORT_SYMBOL_GPL(mcb_get_irq);
+EXPORT_SYMBOL_NS_GPL(mcb_get_irq, MCB);
 
 static int mcb_init(void)
 {
diff --git a/drivers/mcb/mcb-lpc.c b/drivers/mcb/mcb-lpc.c
index 8f1bde437a7e..506676754538 100644
--- a/drivers/mcb/mcb-lpc.c
+++ b/drivers/mcb/mcb-lpc.c
@@ -168,3 +168,4 @@ module_exit(mcb_lpc_exit);
 MODULE_AUTHOR("Andreas Werner <andreas.werner@men.de>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("MCB over LPC support");
+MODULE_IMPORT_NS(MCB);
diff --git a/drivers/mcb/mcb-parse.c b/drivers/mcb/mcb-parse.c
index 3b69e6aa3d88..0266bfddfbe2 100644
--- a/drivers/mcb/mcb-parse.c
+++ b/drivers/mcb/mcb-parse.c
@@ -253,4 +253,4 @@ int chameleon_parse_cells(struct mcb_bus *bus, phys_addr_t mapbase,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(chameleon_parse_cells);
+EXPORT_SYMBOL_NS_GPL(chameleon_parse_cells, MCB);
diff --git a/drivers/mcb/mcb-pci.c b/drivers/mcb/mcb-pci.c
index 14866aa22f75..dc88232d9af8 100644
--- a/drivers/mcb/mcb-pci.c
+++ b/drivers/mcb/mcb-pci.c
@@ -131,3 +131,4 @@ module_pci_driver(mcb_pci_driver);
 MODULE_AUTHOR("Johannes Thumshirn <johannes.thumshirn@men.de>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("MCB over PCI support");
+MODULE_IMPORT_NS(MCB);
diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/8250/8250_men_mcb.c
index 02c5aff58a74..80a5c063ed70 100644
--- a/drivers/tty/serial/8250/8250_men_mcb.c
+++ b/drivers/tty/serial/8250/8250_men_mcb.c
@@ -174,3 +174,4 @@ MODULE_AUTHOR("Michael Moese <michael.moese@men.de");
 MODULE_ALIAS("mcb:16z125");
 MODULE_ALIAS("mcb:16z025");
 MODULE_ALIAS("mcb:16z057");
+MODULE_IMPORT_NS(MCB);
diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial/men_z135_uart.c
index e5d3ebab6dae..4f53a4caabf6 100644
--- a/drivers/tty/serial/men_z135_uart.c
+++ b/drivers/tty/serial/men_z135_uart.c
@@ -930,3 +930,4 @@ MODULE_AUTHOR("Johannes Thumshirn <johannes.thumshirn@men.de>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("MEN 16z135 High Speed UART");
 MODULE_ALIAS("mcb:16z135");
+MODULE_IMPORT_NS(MCB);
diff --git a/drivers/watchdog/menz69_wdt.c b/drivers/watchdog/menz69_wdt.c
index ed18238c5407..8973f98bc6a5 100644
--- a/drivers/watchdog/menz69_wdt.c
+++ b/drivers/watchdog/menz69_wdt.c
@@ -168,3 +168,4 @@ module_mcb_driver(men_z069_driver);
 MODULE_AUTHOR("Johannes Thumshirn <jth@kernel.org>");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("mcb:16z069");
+MODULE_IMPORT_NS(MCB);
-- 
2.16.4

