Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE715C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 16:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC6CC20692
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 16:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfLHQNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 11:13:14 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:49482 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726453AbfLHQNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 11:13:14 -0500
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Dec 2019 11:13:12 EST
Received: from faui04f.informatik.uni-erlangen.de (faui04f.informatik.uni-erlangen.de [IPv6:2001:638:a000:4130:131:188:30:136])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 1669C24164E;
        Sun,  8 Dec 2019 17:13:11 +0100 (CET)
Received: by faui04f.informatik.uni-erlangen.de (Postfix, from userid 66991)
        id F2BEDC20BCE; Sun,  8 Dec 2019 17:13:09 +0100 (CET)
From:   Simon Geis <simon.geis@fau.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Simon Geis <simon.geis@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: [PATCH 11/12] PCMCIA: use dev_dbg instead of enter/leave
Date:   Sun,  8 Dec 2019 17:09:46 +0100
Message-Id: <20191208160947.20694-12-simon.geis@fau.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191208160947.20694-2-simon.geis@fau.de>
References: <20191208160947.20694-2-simon.geis@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using dev_dbg() instead of the enter()/leave()
macro. This allows the usage of format strings.
Remove the now unused macro definition in i82092aa.h.

pr_debug is used where no struct pci_dev is available.

Co-developed-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Simon Geis <simon.geis@fau.de>

---
 drivers/pcmcia/i82092.c   | 91 ++++++++++++++++++++++++++-------------
 drivers/pcmcia/i82092aa.h | 11 -----
 2 files changed, 62 insertions(+), 40 deletions(-)

diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index fb2654a95f28..a2d1e457d931 100644
--- a/drivers/pcmcia/i82092.c
+++ b/drivers/pcmcia/i82092.c
@@ -76,7 +76,8 @@ static int i82092aa_pci_probe(struct pci_dev *dev,
 	unsigned char configbyte;
 	int i, ret;
 
-	enter("i82092aa_pci_probe");
+	dev_dbg(&dev->dev, "Enter: %s, %s line %i\n",
+			__func__, __FILE__, __LINE__);
 
 	ret = pci_enable_device(dev);
 	if (ret)
@@ -159,7 +160,9 @@ static int i82092aa_pci_probe(struct pci_dev *dev,
 			goto err_out_free_sockets;
 	}
 
-	leave("i82092aa_pci_probe");
+	dev_dbg(&dev->dev, "Leave: %s, %s line %i\n",
+			__func__, __FILE__, __LINE__);
+
 	return 0;
 
 err_out_free_sockets:
@@ -179,14 +182,16 @@ static void i82092aa_pci_remove(struct pci_dev *dev)
 {
 	int i;
 
-	enter("i82092aa_pci_remove");
+	dev_dbg(&dev->dev, "Enter: %s, %s line %i\n",
+			__func__, __FILE__, __LINE__);
 
 	free_irq(dev->irq, i82092aa_interrupt);
 
 	for (i = 0; i < socket_count; i++)
 		pcmcia_unregister_socket(&sockets[i].socket);
 
-	leave("i82092aa_pci_remove");
+	dev_dbg(&dev->dev, "Leave: %s, %s line %i\n",
+			__func__, __FILE__, __LINE__);
 }
 
 static DEFINE_SPINLOCK(port_lock);
@@ -323,7 +328,7 @@ static irqreturn_t i82092aa_interrupt(int irq, void *dev)
 
 	unsigned int events, active = 0;
 
-/*	enter("i82092aa_interrupt");*/
+	pr_debug("Enter: %s, %s line %i\n", __func__, __FILE__, __LINE__);
 
 	while (1) {
 		loopcount++;
@@ -378,8 +383,9 @@ static irqreturn_t i82092aa_interrupt(int irq, void *dev)
 		if (active == 0) /* no more events to handle */
 			break;
 	}
+
+	pr_debug("Leave: %s, %s line %i\n", __func__, __FILE__, __LINE__);
 	return IRQ_RETVAL(handled);
-/*	leave("i82092aa_interrupt");*/
 }
 
 
@@ -390,7 +396,8 @@ static int card_present(int socketno)
 {
 	unsigned int val;
 
-	enter("card_present");
+	dev_dbg(&sockets[socketno].dev->dev, "Enter: %s, %s line %i\n",
+		__func__, __FILE__, __LINE__);
 
 	if ((socketno < 0) || (socketno >= MAX_SOCKETS))
 		return 0;
@@ -400,22 +407,28 @@ static int card_present(int socketno)
 
 	val = indirect_read(socketno, 1); /* Interface status register */
 	if ((val&12) == 12) {
-		leave("card_present 1");
+		dev_dbg(&sockets[socketno].dev->dev, "Leave: %s 1, %s line %i\n",
+				__func__, __FILE__, __LINE__);
 		return 1;
 	}
 
-	leave("card_present 0");
+	dev_dbg(&sockets[socketno].dev->dev, "Leave: %s 0, %s line %i\n",
+		__func__, __FILE__, __LINE__);
 	return 0;
 }
 
 static void set_bridge_state(int sock)
 {
-	enter("set_bridge_state");
+	dev_dbg(&sockets[sock].dev->dev, "Enter: %s, %s line %i\n",
+		__func__, __FILE__, __LINE__);
+
 	indirect_write(sock, I365_GBLCTL, 0x00);
 	indirect_write(sock, I365_GENCTL, 0x00);
 
 	indirect_setbit(sock, I365_INTCTL, 0x08);
-	leave("set_bridge_state");
+
+	dev_dbg(&sockets[sock].dev->dev, "Leave: %s, %s line %i\n",
+		__func__, __FILE__, __LINE__);
 }
 
 
@@ -423,10 +436,13 @@ static int i82092aa_init(struct pcmcia_socket *sock)
 {
 	int i;
 	struct resource res = { .start = 0, .end = 0x0fff };
+	struct socket_info *sock_info = container_of(sock, struct socket_info,
+						     socket);
 	pccard_io_map io = { 0, 0, 0, 0, 1 };
 	pccard_mem_map mem = { .res = &res, };
 
-	enter("i82092aa_init");
+	dev_dbg(&sock_info->dev->dev, "Enter: %s, %s line %i\n",
+		__func__, __FILE__, __LINE__);
 
 	for (i = 0; i < 2; i++) {
 		io.map = i;
@@ -437,7 +453,8 @@ static int i82092aa_init(struct pcmcia_socket *sock)
 		i82092aa_set_mem_map(sock, &mem);
 	}
 
-	leave("i82092aa_init");
+	dev_dbg(&sock_info->dev->dev, "Leave: %s, %s line %i\n",
+		__func__, __FILE__, __LINE__);
 	return 0;
 }
 
@@ -449,7 +466,8 @@ static int i82092aa_get_status(struct pcmcia_socket *socket, u_int *value)
 	unsigned int sock = sock_info->number;
 	unsigned int status;
 
-	enter("i82092aa_get_status");
+	dev_dbg(&sock_info->dev->dev, "Enter: %s, %s line %i\n",
+		__func__, __FILE__, __LINE__);
 
 	/* Interface Status Register */
 	status = indirect_read(sock, I365_STATUS);
@@ -480,7 +498,8 @@ static int i82092aa_get_status(struct pcmcia_socket *socket, u_int *value)
 	if (status & I365_CS_POWERON)
 		(*value) |= SS_POWERON;  /* power is applied to the card */
 
-	leave("i82092aa_get_status");
+	dev_dbg(&sock_info->dev->dev, "Leave: %s, %s line %i\n",
+		__func__, __FILE__, __LINE__);
 	return 0;
 }
 
@@ -493,7 +512,8 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket,
 	unsigned int sock = sock_info->number;
 	unsigned char reg;
 
-	enter("i82092aa_set_socket");
+	dev_dbg(&sock_info->dev->dev, "Enter: %s, %s line %i\n",
+		__func__, __FILE__, __LINE__);
 
 	/* First, set the global controller options */
 
@@ -537,7 +557,8 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket,
 		dev_err(&sock_info->dev->dev,
 			"i82092aa: %s called with invalid VCC power value: %i",
 			__func__, state->Vcc);
-		leave("i82092aa_set_socket");
+		dev_dbg(&sock_info->dev->dev, "Leave: %s, %s line %i\n",
+			__func__, __FILE__, __LINE__);
 		return -EINVAL;
 	}
 
@@ -562,7 +583,8 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket,
 		dev_err(&sock_info->dev->dev,
 			"i82092aa: %s called with invalid VPP power value: %i",
 			__func__, state->Vcc);
-		leave("i82092aa_set_socket");
+		dev_dbg(&sock_info->dev->dev, "Leave: %s, %s line %i\n",
+			__func__, __FILE__, __LINE__);
 		return -EINVAL;
 	}
 
@@ -594,7 +616,8 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket,
 	indirect_write(sock, I365_CSCINT, reg);
 	(void)indirect_read(sock, I365_CSC);
 
-	leave("i82092aa_set_socket");
+	dev_dbg(&sock_info->dev->dev, "Leave: %s, %s line %i\n",
+		__func__, __FILE__, __LINE__);
 	return 0;
 }
 
@@ -606,18 +629,21 @@ static int i82092aa_set_io_map(struct pcmcia_socket *socket,
 	unsigned int sock = sock_info->number;
 	unsigned char map, ioctl;
 
-	enter("i82092aa_set_io_map");
+	dev_dbg(&sock_info->dev->dev, "Enter: %s, %s line %i\n",
+		__func__, __FILE__, __LINE__);
 
 	map = io->map;
 
 	/* Check error conditions */
 	if (map > 1) {
-		leave("i82092aa_set_io_map with invalid map");
+		dev_dbg(&sock_info->dev->dev, "Leave: %s with invalid map, %s line %i\n",
+			__func__, __FILE__, __LINE__);
 		return -EINVAL;
 	}
 	if ((io->start > 0xffff) || (io->stop > 0xffff)
 				 || (io->stop < io->start)) {
-		leave("i82092aa_set_io_map with invalid io");
+		dev_dbg(&sock_info->dev->dev, "Leave: %s with invalid io, %s line %i\n",
+			__func__, __FILE__, __LINE__);
 		return -EINVAL;
 	}
 
@@ -645,7 +671,8 @@ static int i82092aa_set_io_map(struct pcmcia_socket *socket,
 	if (io->flags & MAP_ACTIVE)
 		indirect_setbit(sock, I365_ADDRWIN, I365_ENA_IO(map));
 
-	leave("i82092aa_set_io_map");
+	dev_dbg(&sock_info->dev->dev, "Leave: %s, %s line %i\n",
+		__func__, __FILE__, __LINE__);
 	return 0;
 }
 
@@ -659,20 +686,23 @@ static int i82092aa_set_mem_map(struct pcmcia_socket *socket,
 	unsigned short base, i;
 	unsigned char map;
 
-	enter("i82092aa_set_mem_map");
+	dev_dbg(&sock_info->dev->dev, "Enter: %s, %s line %i\n",
+		__func__, __FILE__, __LINE__);
 
 	pcibios_resource_to_bus(sock_info->dev->bus, &region, mem->res);
 
 	map = mem->map;
 	if (map > 4) {
-		leave("i82092aa_set_mem_map: invalid map");
+		dev_dbg(&sock_info->dev->dev, "Leave: %s: invalid map, %s line %i\n",
+			__func__, __FILE__, __LINE__);
 		return -EINVAL;
 	}
 
 
 	if ((mem->card_start > 0x3ffffff) || (region.start > region.end) ||
 	     (mem->speed > 1000)) {
-		leave("i82092aa_set_mem_map: invalid address / speed");
+		dev_dbg(&sock_info->dev->dev, "Leave: %s: invalid address / speed, %s line %i\n",
+			__func__, __FILE__, __LINE__);
 		dev_err(&sock_info->dev->dev,
 			"invalid mem map for socket %i: %llx to %llx with a start of %x\n",
 			sock,
@@ -745,7 +775,8 @@ static int i82092aa_set_mem_map(struct pcmcia_socket *socket,
 	if (mem->flags & MAP_ACTIVE)
 		indirect_setbit(sock, I365_ADDRWIN, I365_ENA_MEM(map));
 
-	leave("i82092aa_set_mem_map");
+	dev_dbg(&sock_info->dev->dev, "Leave: %s, %s line %i\n",
+		__func__, __FILE__, __LINE__);
 	return 0;
 }
 
@@ -756,11 +787,13 @@ static int i82092aa_module_init(void)
 
 static void i82092aa_module_exit(void)
 {
-	enter("i82092aa_module_exit");
+	pr_debug("Enter: %s, %s line %i\n", __func__, __FILE__, __LINE__);
+
 	pci_unregister_driver(&i82092aa_pci_driver);
 	if (sockets[0].io_base > 0)
 		release_region(sockets[0].io_base, 2);
-	leave("i82092aa_module_exit");
+
+	pr_debug("Leave: %s, %s line %i\n", __func__, __FILE__, __LINE__);
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

