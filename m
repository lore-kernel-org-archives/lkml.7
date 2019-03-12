Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB98C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56DAD2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfCLO6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:58:51 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:47949 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfCLO6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:58:47 -0400
Received: from orion.localdomain ([77.4.190.91]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N5FQJ-1gtNfB1RMj-011B2z; Tue, 12 Mar 2019 15:58:00 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] drivers: tty: serial: introduce struct resource
Date:   Tue, 12 Mar 2019 15:57:37 +0100
Message-Id: <1552402660-31730-6-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552402660-31730-1-git-send-email-info@metux.net>
References: <1552402660-31730-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:Z3CS6QZlcka6ABXb/1Z3QPD+/Xh3CYH1vw4l+AaNcNhlFyBrOvH
 pazdteWCQBnmq78rrQGum9ZPAt3rFQngbaDzjZUSAm6Jr0PWJuSsk1/HxvsOxNWEciaod05
 UkLxu4mWw374yFo2wZBb0TD70PFr7p4B7S7/PFtUKm/1sVz6v0Sp+N6o7RD+9AZuO/+7Uxa
 WO2wz2TvAyrznDEhh908A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lHEssxpnTgs=:B/rGFU0nPalUlyZZLA9ZaD
 tkH46nhvLwE8xcSyWUnnBW92hxbrEotiNh7+5NdT9IEggFoIMjVRdTiB5myRsRSnJGYsrTRpb
 tAU/IlU/R9V5QLsFZsAbhYAta/1fnbEJXnz4Iqg/v4OTKosMqFPMaCctn813rGgY1jHgE7NXp
 vXb4PgUcx+HlZTmbRKk8qQggNMJe9dJ23Xwda16jQ4yAP/dUjEoeO5EN9XMf09IFeU/sXwL2m
 eV4ZPRHlcUkRhl2AUxqDdsk0QP/IWSwPE+euloRFEl8vsVcmVds3SFjTNHY51uGW9qV6nhHbK
 WSpzX5yUYYKHnozi+P3maJdnqzIh/jEbPKSMQfZjHlQkwhMLl/SJv58E3RR3CNwGaMMAuCuc3
 qIRSncQGzhJ0NxAjq1x6Ft0ijTlixMwGtIP4Kx+pt3sXMhHHpXTEAUiJElzsBfRcng3syBgRF
 mTSE8nXKAO2TvNvN8cKTs3MxkFADCXngkIRX3aD4URquxWTYCIqeHiMHQa9cvJxlC/x9m8tUY
 8NYXerZfRWzYlHCcidOvHfSO1sNr3GO7/PkaR01t0dnhbCq1YyT5WHs5gXxTfAptoN2kxqpUL
 B+1EIFHfNxpaGdrwpJScwrsrU/W6A7I9REBPFKLyLGKniIK0mx591QRV6ea877AOunqbsT6rQ
 Xy6x6Dgtf2X4jWGYcNC7p7KBZB9fa4Bjztvm29VzSiAXbJIZeGHgGfVGz/vtUBVheO+7p85dT
 xUwkV7xV/CxMjrLJcYwnCFhqQ0La7kfWhzbV3A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The standard data structure for holding io resources in the
kernel is struct resource. Serial drivers yet don't really
use it (except when retrieving from oftree).

This patch introduces a new field in struct uart_port for that,
plus several helpers. Yet it's up to the individual drivers for
using it - serial_core doesn't care yet. Therefore, the old fields
mapbase and mapsize need to be filled properly by the drivers.
---
 include/linux/serial_core.h | 49 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 5fe2b03..9b07a40 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -24,6 +24,7 @@
 #include <linux/compiler.h>
 #include <linux/console.h>
 #include <linux/interrupt.h>
+#include <linux/ioport.h>
 #include <linux/circ_buf.h>
 #include <linux/spinlock.h>
 #include <linux/sched.h>
@@ -256,6 +257,7 @@ struct uart_port {
 	unsigned int		minor;
 	resource_size_t		mapbase;		/* for ioremap */
 	resource_size_t		mapsize;
+	struct resource		memres;
 	struct device		*dev;			/* parent device */
 	unsigned char		hub6;			/* this should be in the 8250 driver */
 	unsigned char		suspended;
@@ -427,6 +429,53 @@ void uart_console_write(struct uart_port *port, const char *s,
 int uart_match_port(struct uart_port *port1, struct uart_port *port2);
 
 /*
+ * Port resource management
+ */
+static inline void uart_memres_set(struct uart_port *port,
+				     struct resource res)
+{
+	port->memres = res;
+	port->mapbase = res.start;
+}
+
+static inline void uart_memres_clear(struct uart_port *port)
+{
+	port->memres = DEFINE_RES_MEM(0, 0);
+}
+
+static inline int uart_memres_valid(struct uart_port *port)
+{
+	return (port->memres.start != 0);
+}
+
+static inline struct resource *uart_memres_request(struct uart_port *port,
+				     const char *name)
+{
+	return request_mem_region(
+		port->memres.start,
+		resource_size(&port->memres),
+		name);
+}
+
+static inline void uart_memres_release(struct uart_port *port)
+{
+	return release_mem_region(port->memres.start,
+				  resource_size(&port->memres));
+}
+
+static inline void __iomem *uart_memres_ioremap_nocache(struct uart_port *port)
+{
+	return ioremap_nocache(port->memres.start,
+			       resource_size(&port->memres.start));
+}
+
+static inline void __iomem *uart_memres_ioremap(struct uart_port *port)
+{
+	return ioremap(port->memres.start,
+		       resource_size(&port->memres.start));
+}
+
+/*
  * Power Management
  */
 int uart_suspend_port(struct uart_driver *reg, struct uart_port *port);
-- 
1.9.1

