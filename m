Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C02C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F78207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfLJLwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 06:52:55 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:39106 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726957AbfLJLwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:52:53 -0500
Received: from faui04g.informatik.uni-erlangen.de (faui04g.informatik.uni-erlangen.de [131.188.30.137])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 494AA2417AD;
        Tue, 10 Dec 2019 12:52:50 +0100 (CET)
Received: by faui04g.informatik.uni-erlangen.de (Postfix, from userid 66991)
        id 49C86843FEC; Tue, 10 Dec 2019 12:44:22 +0100 (CET)
From:   Simon Geis <simon.geis@fau.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Simon Geis <simon.geis@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: [PATCH v2 09/10] PCMCIA/i82092: improve enter/leave macro
Date:   Tue, 10 Dec 2019 12:43:34 +0100
Message-Id: <20191210114333.12239-10-simon.geis@fau.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210114333.12239-1-simon.geis@fau.de>
References: <20191210114333.12239-1-simon.geis@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the log output by adding additional macros dev_enter/dev_leave
in i82092aa.h which print out device information. 

dev_leave takes a second parameter to print out further
information when needed. Use __func__ instead of function name
in the header file.

Co-developed-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Simon Geis <simon.geis@fau.de>

---
 drivers/pcmcia/i82092.c   | 59 ++++++++++++++++++++-------------------
 drivers/pcmcia/i82092aa.h | 16 ++++++++---
 2 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index f523a810ab66..668a2188ef66 100644
--- a/drivers/pcmcia/i82092.c
+++ b/drivers/pcmcia/i82092.c
@@ -76,7 +76,7 @@ static int i82092aa_pci_probe(struct pci_dev *dev,
 	unsigned char configbyte;
 	int i, ret;
 
-	enter("i82092aa_pci_probe");
+	dev_enter(&dev->dev);
 
 	ret = pci_enable_device(dev);
 	if (ret)
@@ -159,7 +159,7 @@ static int i82092aa_pci_probe(struct pci_dev *dev,
 			goto err_out_free_sockets;
 	}
 
-	leave("i82092aa_pci_probe");
+	dev_leave(&dev->dev, "");
 	return 0;
 
 err_out_free_sockets:
@@ -179,14 +179,14 @@ static void i82092aa_pci_remove(struct pci_dev *dev)
 {
 	int i;
 
-	enter("i82092aa_pci_remove");
+	dev_enter(&dev->dev);
 
 	free_irq(dev->irq, i82092aa_interrupt);
 
 	for (i = 0; i < socket_count; i++)
 		pcmcia_unregister_socket(&sockets[i].socket);
 
-	leave("i82092aa_pci_remove");
+	dev_leave(&dev->dev, "");
 }
 
 static DEFINE_SPINLOCK(port_lock);
@@ -323,7 +323,7 @@ static irqreturn_t i82092aa_interrupt(int irq, void *dev)
 
 	unsigned int events, active = 0;
 
-/*	enter("i82092aa_interrupt");*/
+	enter();
 
 	while (1) {
 		loopcount++;
@@ -378,7 +378,7 @@ static irqreturn_t i82092aa_interrupt(int irq, void *dev)
 			break;
 	}
 	return IRQ_RETVAL(handled);
-/*	leave("i82092aa_interrupt");*/
+	leave();
 }
 
 
@@ -389,7 +389,7 @@ static int card_present(int socketno)
 {
 	unsigned int val;
 
-	enter("card_present");
+	dev_enter(&sockets[socketno].dev->dev);
 
 	if ((socketno < 0) || (socketno >= MAX_SOCKETS))
 		return 0;
@@ -399,22 +399,22 @@ static int card_present(int socketno)
 
 	val = indirect_read(socketno, 1); /* Interface status register */
 	if ((val&12) == 12) {
-		leave("card_present 1");
+		dev_leave(&sockets[socketno].dev->dev, "1");
 		return 1;
 	}
 
-	leave("card_present 0");
+	dev_leave(&sockets[socketno].dev->dev, "0");
 	return 0;
 }
 
 static void set_bridge_state(int sock)
 {
-	enter("set_bridge_state");
+	dev_enter(&sockets[sock].dev->dev);
 	indirect_write(sock, I365_GBLCTL, 0x00);
 	indirect_write(sock, I365_GENCTL, 0x00);
 
 	indirect_setbit(sock, I365_INTCTL, 0x08);
-	leave("set_bridge_state");
+	dev_leave(&sockets[sock].dev->dev, "");
 }
 
 
@@ -425,7 +425,7 @@ static int i82092aa_init(struct pcmcia_socket *sock)
 	pccard_io_map io = { 0, 0, 0, 0, 1 };
 	pccard_mem_map mem = { .res = &res, };
 
-	enter("i82092aa_init");
+	dev_enter(&container_of(sock, struct socket_info, socket)->dev->dev);
 
 	for (i = 0; i < 2; i++) {
 		io.map = i;
@@ -436,7 +436,8 @@ static int i82092aa_init(struct pcmcia_socket *sock)
 		i82092aa_set_mem_map(sock, &mem);
 	}
 
-	leave("i82092aa_init");
+	dev_leave(&container_of(sock, struct socket_info, socket)->dev->dev,
+		  "");
 	return 0;
 }
 
@@ -448,7 +449,7 @@ static int i82092aa_get_status(struct pcmcia_socket *socket, u_int *value)
 	unsigned int sock = sock_info->number;
 	unsigned int status;
 
-	enter("i82092aa_get_status");
+	dev_enter(&sock_info->dev->dev);
 
 	/* Interface Status Register */
 	status = indirect_read(sock, I365_STATUS);
@@ -479,7 +480,7 @@ static int i82092aa_get_status(struct pcmcia_socket *socket, u_int *value)
 	if (status & I365_CS_POWERON)
 		(*value) |= SS_POWERON;  /* power is applied to the card */
 
-	leave("i82092aa_get_status");
+	dev_leave(&sock_info->dev->dev, "");
 	return 0;
 }
 
@@ -492,7 +493,7 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket,
 	unsigned int sock = sock_info->number;
 	unsigned char reg;
 
-	enter("i82092aa_set_socket");
+	dev_enter(&sock_info->dev->dev);
 
 	/* First, set the global controller options */
 
@@ -536,7 +537,7 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket,
 		dev_err(&sock_info->dev->dev,
 			"i82092aa: %s called with invalid VCC power value: %i",
 			__func__, state->Vcc);
-		leave("i82092aa_set_socket");
+		dev_leave(&sock_info->dev->dev, "");
 		return -EINVAL;
 	}
 
@@ -561,7 +562,7 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket,
 		dev_err(&sock_info->dev->dev,
 			"i82092aa: %s called with invalid VPP power value: %i",
 			__func__, state->Vcc);
-		leave("i82092aa_set_socket");
+		dev_leave(&sock_info->dev->dev, "");
 		return -EINVAL;
 	}
 
@@ -593,7 +594,7 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket,
 	indirect_write(sock, I365_CSCINT, reg);
 	(void)indirect_read(sock, I365_CSC);
 
-	leave("i82092aa_set_socket");
+	dev_leave(&sock_info->dev->dev, "");
 	return 0;
 }
 
@@ -605,18 +606,18 @@ static int i82092aa_set_io_map(struct pcmcia_socket *socket,
 	unsigned int sock = sock_info->number;
 	unsigned char map, ioctl;
 
-	enter("i82092aa_set_io_map");
+	dev_enter(&sock_info->dev->dev);
 
 	map = io->map;
 
 	/* Check error conditions */
 	if (map > 1) {
-		leave("i82092aa_set_io_map with invalid map");
+		dev_leave(&sock_info->dev->dev, "with invalid map");
 		return -EINVAL;
 	}
 	if ((io->start > 0xffff) || (io->stop > 0xffff)
 				 || (io->stop < io->start)) {
-		leave("i82092aa_set_io_map with invalid io");
+		dev_leave(&sock_info->dev->dev, "with invalid io");
 		return -EINVAL;
 	}
 
@@ -644,7 +645,7 @@ static int i82092aa_set_io_map(struct pcmcia_socket *socket,
 	if (io->flags & MAP_ACTIVE)
 		indirect_setbit(sock, I365_ADDRWIN, I365_ENA_IO(map));
 
-	leave("i82092aa_set_io_map");
+	dev_leave(&sock_info->dev->dev, "");
 	return 0;
 }
 
@@ -658,20 +659,20 @@ static int i82092aa_set_mem_map(struct pcmcia_socket *socket,
 	unsigned short base, i;
 	unsigned char map;
 
-	enter("i82092aa_set_mem_map");
+	dev_enter(&sock_info->dev->dev);
 
 	pcibios_resource_to_bus(sock_info->dev->bus, &region, mem->res);
 
 	map = mem->map;
 	if (map > 4) {
-		leave("i82092aa_set_mem_map: invalid map");
+		dev_leave(&sock_info->dev->dev, "with invalid map");
 		return -EINVAL;
 	}
 
 
 	if ((mem->card_start > 0x3ffffff) || (region.start > region.end) ||
 	     (mem->speed > 1000)) {
-		leave("i82092aa_set_mem_map: invalid address / speed");
+		dev_leave(&sock_info->dev->dev, "with invalid address / speed");
 		dev_err(&sock_info->dev->dev,
 			"invalid mem map for socket %i: %llx to %llx with a start of %x\n",
 			sock,
@@ -744,7 +745,7 @@ static int i82092aa_set_mem_map(struct pcmcia_socket *socket,
 	if (mem->flags & MAP_ACTIVE)
 		indirect_setbit(sock, I365_ADDRWIN, I365_ENA_MEM(map));
 
-	leave("i82092aa_set_mem_map");
+	dev_leave(&sock_info->dev->dev, "");
 	return 0;
 }
 
@@ -755,11 +756,11 @@ static int i82092aa_module_init(void)
 
 static void i82092aa_module_exit(void)
 {
-	enter("i82092aa_module_exit");
+	enter();
 	pci_unregister_driver(&i82092aa_pci_driver);
 	if (sockets[0].io_base > 0)
 		release_region(sockets[0].io_base, 2);
-	leave("i82092aa_module_exit");
+	leave();
 }
 
 module_init(i82092aa_module_init);
diff --git a/drivers/pcmcia/i82092aa.h b/drivers/pcmcia/i82092aa.h
index 4586c43c78e2..3f4b2652b2d0 100644
--- a/drivers/pcmcia/i82092aa.h
+++ b/drivers/pcmcia/i82092aa.h
@@ -6,11 +6,19 @@
 
 /* Debuging defines */
 #ifdef NOTRACE
-#define enter(x)   printk("Enter: %s, %s line %i\n",x,__FILE__,__LINE__)
-#define leave(x)   printk("Leave: %s, %s line %i\n",x,__FILE__,__LINE__)
+#define enter()   pr_debug("Enter: %s, %s line %i\n",\
+			    __func__, __FILE__, __LINE__)
+#define leave()   pr_debug("Leave: %s, %s line %i\n",\
+			   __func__, __FILE__, __LINE__)
+#define dev_enter(dev)      dev_dbg(dev, "Enter: %s, %s line %i\n",\
+				    __func__, __FILE__, __LINE__)
+#define dev_leave(dev, x)   dev_dbg(dev, "Leave: %s %s, %s line %i\n",\
+				    __func__, x, __FILE__, __LINE__)
 #else
-#define enter(x)   do {} while (0)
-#define leave(x)   do {} while (0)
+#define enter()   do {} while (0)
+#define leave()   do {} while (0)
+#define dev_enter(dev)      do {} while (0)
+#define dev_leave(dev, x)   do {} while (0)
 #endif
 
 
-- 
2.20.1

