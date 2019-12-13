Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8093C50732
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3369E24718
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfLMOGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 09:06:23 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:43878 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726524AbfLMOGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 09:06:21 -0500
Received: from faui04f.informatik.uni-erlangen.de (faui04f.informatik.uni-erlangen.de [IPv6:2001:638:a000:4130:131:188:30:136])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 1C7742417DA;
        Fri, 13 Dec 2019 15:06:18 +0100 (CET)
Received: by faui04f.informatik.uni-erlangen.de (Postfix, from userid 66991)
        id 75777C20BCE; Fri, 13 Dec 2019 14:56:19 +0100 (CET)
From:   Simon Geis <simon.geis@fau.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Simon Geis <simon.geis@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: [PATCH v3 09/10] PCMCIA/i82092: delete enter/leave macro
Date:   Fri, 13 Dec 2019 14:53:13 +0100
Message-Id: <20191213135311.9111-10-simon.geis@fau.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213135311.9111-1-simon.geis@fau.de>
References: <20191213135311.9111-1-simon.geis@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the enter/leave macros and the corresponding calls.
These are obsolete since ftrace is available.

Co-developed-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Simon Geis <simon.geis@fau.de>

---
 drivers/pcmcia/i82092.c   | 53 ++++-----------------------------------
 drivers/pcmcia/i82092aa.h | 11 --------
 2 files changed, 5 insertions(+), 59 deletions(-)

diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index 5d7d04657b6d..9184fafcb8af 100644
--- a/drivers/pcmcia/i82092.c
+++ b/drivers/pcmcia/i82092.c
@@ -76,8 +76,6 @@ static int i82092aa_pci_probe(struct pci_dev *dev,
 	unsigned char configbyte;
 	int i, ret;
 
-	enter("i82092aa_pci_probe");
-
 	ret = pci_enable_device(dev);
 	if (ret)
 		return ret;
@@ -158,7 +156,6 @@ static int i82092aa_pci_probe(struct pci_dev *dev,
 			goto err_out_free_sockets;
 	}
 
-	leave("i82092aa_pci_probe");
 	return 0;
 
 err_out_free_sockets:
@@ -178,14 +175,10 @@ static void i82092aa_pci_remove(struct pci_dev *dev)
 {
 	int i;
 
-	enter("i82092aa_pci_remove");
-
 	free_irq(dev->irq, i82092aa_interrupt);
 
 	for (i = 0; i < socket_count; i++)
 		pcmcia_unregister_socket(&sockets[i].socket);
-
-	leave("i82092aa_pci_remove");
 }
 
 static DEFINE_SPINLOCK(port_lock);
@@ -322,8 +315,6 @@ static irqreturn_t i82092aa_interrupt(int irq, void *dev)
 
 	unsigned int events, active = 0;
 
-/*	enter("i82092aa_interrupt");*/
-
 	while (1) {
 		loopcount++;
 		if (loopcount > 20) {
@@ -377,7 +368,6 @@ static irqreturn_t i82092aa_interrupt(int irq, void *dev)
 			break;
 	}
 	return IRQ_RETVAL(handled);
-/*	leave("i82092aa_interrupt");*/
 }
 
 
@@ -388,8 +378,6 @@ static int card_present(int socketno)
 {
 	unsigned int val;
 
-	enter("card_present");
-
 	if ((socketno < 0) || (socketno >= MAX_SOCKETS))
 		return 0;
 	if (sockets[socketno].io_base == 0)
@@ -397,23 +385,18 @@ static int card_present(int socketno)
 
 
 	val = indirect_read(socketno, 1); /* Interface status register */
-	if ((val&12) == 12) {
-		leave("card_present 1");
+	if ((val&12) == 12)
 		return 1;
-	}
 
-	leave("card_present 0");
 	return 0;
 }
 
 static void set_bridge_state(int sock)
 {
-	enter("set_bridge_state");
 	indirect_write(sock, I365_GBLCTL, 0x00);
 	indirect_write(sock, I365_GENCTL, 0x00);
 
 	indirect_setbit(sock, I365_INTCTL, 0x08);
-	leave("set_bridge_state");
 }
 
 
@@ -424,8 +407,6 @@ static int i82092aa_init(struct pcmcia_socket *sock)
 	pccard_io_map io = { 0, 0, 0, 0, 1 };
 	pccard_mem_map mem = { .res = &res, };
 
-	enter("i82092aa_init");
-
 	for (i = 0; i < 2; i++) {
 		io.map = i;
 		i82092aa_set_io_map(sock, &io);
@@ -435,7 +416,6 @@ static int i82092aa_init(struct pcmcia_socket *sock)
 		i82092aa_set_mem_map(sock, &mem);
 	}
 
-	leave("i82092aa_init");
 	return 0;
 }
 
@@ -447,8 +427,6 @@ static int i82092aa_get_status(struct pcmcia_socket *socket, u_int *value)
 	unsigned int sock = sock_info->number;
 	unsigned int status;
 
-	enter("i82092aa_get_status");
-
 	/* Interface Status Register */
 	status = indirect_read(sock, I365_STATUS);
 	*value = 0;
@@ -478,7 +456,6 @@ static int i82092aa_get_status(struct pcmcia_socket *socket, u_int *value)
 	if (status & I365_CS_POWERON)
 		(*value) |= SS_POWERON;  /* power is applied to the card */
 
-	leave("i82092aa_get_status");
 	return 0;
 }
 
@@ -491,8 +468,6 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket,
 	unsigned int sock = sock_info->number;
 	unsigned char reg;
 
-	enter("i82092aa_set_socket");
-
 	/* First, set the global controller options */
 
 	set_bridge_state(sock);
@@ -536,7 +511,6 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket,
 		dev_err(&sock_info->dev->dev,
 			"%s called with invalid VCC power value: %i",
 			__func__, state->Vcc);
-		leave("i82092aa_set_socket");
 		return -EINVAL;
 	}
 
@@ -558,7 +532,6 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket,
 		dev_err(&sock_info->dev->dev,
 			"%s called with invalid VPP power value: %i",
 			__func__, state->Vcc);
-		leave("i82092aa_set_socket");
 		return -EINVAL;
 	}
 
@@ -590,7 +563,6 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket,
 	indirect_write(sock, I365_CSCINT, reg);
 	(void)indirect_read(sock, I365_CSC);
 
-	leave("i82092aa_set_socket");
 	return 0;
 }
 
@@ -602,20 +574,15 @@ static int i82092aa_set_io_map(struct pcmcia_socket *socket,
 	unsigned int sock = sock_info->number;
 	unsigned char map, ioctl;
 
-	enter("i82092aa_set_io_map");
-
 	map = io->map;
 
 	/* Check error conditions */
-	if (map > 1) {
-		leave("i82092aa_set_io_map with invalid map");
+	if (map > 1)
 		return -EINVAL;
-	}
+
 	if ((io->start > 0xffff) || (io->stop > 0xffff)
-				 || (io->stop < io->start)) {
-		leave("i82092aa_set_io_map with invalid io");
+				 || (io->stop < io->start))
 		return -EINVAL;
-	}
 
 	/* Turn off the window before changing anything */
 	if (indirect_read(sock, I365_ADDRWIN) & I365_ENA_IO(map))
@@ -636,7 +603,6 @@ static int i82092aa_set_io_map(struct pcmcia_socket *socket,
 	if (io->flags & MAP_ACTIVE)
 		indirect_setbit(sock, I365_ADDRWIN, I365_ENA_IO(map));
 
-	leave("i82092aa_set_io_map");
 	return 0;
 }
 
@@ -650,20 +616,14 @@ static int i82092aa_set_mem_map(struct pcmcia_socket *socket,
 	unsigned short base, i;
 	unsigned char map;
 
-	enter("i82092aa_set_mem_map");
-
 	pcibios_resource_to_bus(sock_info->dev->bus, &region, mem->res);
 
 	map = mem->map;
-	if (map > 4) {
-		leave("i82092aa_set_mem_map: invalid map");
+	if (map > 4)
 		return -EINVAL;
-	}
-
 
 	if ((mem->card_start > 0x3ffffff) || (region.start > region.end) ||
 	     (mem->speed > 1000)) {
-		leave("i82092aa_set_mem_map: invalid address / speed");
 		dev_err(&sock_info->dev->dev,
 			"invalid mem map for socket %i: %llx to %llx with a start of %x\n",
 			sock,
@@ -718,7 +678,6 @@ static int i82092aa_set_mem_map(struct pcmcia_socket *socket,
 	if (mem->flags & MAP_ACTIVE)
 		indirect_setbit(sock, I365_ADDRWIN, I365_ENA_MEM(map));
 
-	leave("i82092aa_set_mem_map");
 	return 0;
 }
 
@@ -729,11 +688,9 @@ static int i82092aa_module_init(void)
 
 static void i82092aa_module_exit(void)
 {
-	enter("i82092aa_module_exit");
 	pci_unregister_driver(&i82092aa_pci_driver);
 	if (sockets[0].io_base > 0)
 		release_region(sockets[0].io_base, 2);
-	leave("i82092aa_module_exit");
 }
 
 module_init(i82092aa_module_init);
diff --git a/drivers/pcmcia/i82092aa.h b/drivers/pcmcia/i82092aa.h
index 4586c43c78e2..0f851acab7e5 100644
--- a/drivers/pcmcia/i82092aa.h
+++ b/drivers/pcmcia/i82092aa.h
@@ -4,17 +4,6 @@
 
 #include <linux/interrupt.h>
 
-/* Debuging defines */
-#ifdef NOTRACE
-#define enter(x)   printk("Enter: %s, %s line %i\n",x,__FILE__,__LINE__)
-#define leave(x)   printk("Leave: %s, %s line %i\n",x,__FILE__,__LINE__)
-#else
-#define enter(x)   do {} while (0)
-#define leave(x)   do {} while (0)
-#endif
-
-
-
 /* prototypes */
 
 static int  i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *id);
-- 
2.20.1

