Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C954C2D0BF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 16:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6315B20700
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 16:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfLHQPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 11:15:42 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:49512 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726453AbfLHQPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 11:15:40 -0500
Received: from faui04f.informatik.uni-erlangen.de (faui04f.informatik.uni-erlangen.de [IPv6:2001:638:a000:4130:131:188:30:136])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 57348241723;
        Sun,  8 Dec 2019 17:10:05 +0100 (CET)
Received: by faui04f.informatik.uni-erlangen.de (Postfix, from userid 66991)
        id 456DDC20BC6; Sun,  8 Dec 2019 17:10:05 +0100 (CET)
From:   Simon Geis <simon.geis@fau.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Simon Geis <simon.geis@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: [PATCH 01/12] PCMCIA: use dev_err/dev_info instead of printk
Date:   Sun,  8 Dec 2019 17:09:36 +0100
Message-Id: <20191208160947.20694-2-simon.geis@fau.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the checkpatch warning:
	WARNING: Prefer netdev_err(netdev, ... then dev_err(dev, ...
		then pr_err(...  to printk(KERN_ERR ...
and
	WARNING: printk() should include KERN_<LEVEL> facility level
		by using dev_err()/dev_info() according to the message.

Split the assignment of variable 'sock' in in order to get access to
struct_info with the 'container_of' function call.

pr_err is used where no struct pci_dev is available.

Co-developed-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Simon Geis <simon.geis@fau.de>

---
 drivers/pcmcia/i82092.c | 79 ++++++++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 21 deletions(-)

diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index aad8a46605be..ba33293b1a34 100644
--- a/drivers/pcmcia/i82092.c
+++ b/drivers/pcmcia/i82092.c
@@ -92,11 +92,13 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 			break;
 			
 		default:
-			printk(KERN_ERR "i82092aa: Oops, you did something we didn't think of.\n");
+			dev_err(&dev->dev,
+				"i82092aa: Oops, you did something we didn't think of.\n");
 			ret = -EIO;
 			goto err_out_disable;
 	}
-	printk(KERN_INFO "i82092aa: configured as a %d socket device.\n", socket_count);
+	dev_info(&dev->dev, "i82092aa: configured as a %d socket device.\n",
+		 socket_count);
 
 	if (!request_region(pci_resource_start(dev, 0), 2, "i82092aa")) {
 		ret = -EBUSY;
@@ -130,7 +132,9 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 	/* Register the interrupt handler */
 	dev_dbg(&dev->dev, "Requesting interrupt %i\n", dev->irq);
 	if ((ret = request_irq(dev->irq, i82092aa_interrupt, IRQF_SHARED, "i82092aa", i82092aa_interrupt))) {
-		printk(KERN_ERR "i82092aa: Failed to register IRQ %d, aborting\n", dev->irq);
+		dev_err(&dev->dev,
+			"i82092aa: Failed to register IRQ %d, aborting\n",
+			dev->irq);
 		goto err_out_free_res;
 	}
 
@@ -306,7 +310,7 @@ static irqreturn_t i82092aa_interrupt(int irq, void *dev)
 	while (1) {
 		loopcount++;
 		if (loopcount>20) {
-			printk(KERN_ERR "i82092aa: infinite eventloop in interrupt \n");
+			pr_err("i82092aa: infinite eventloop in interrupt\n");
 			break;
 		}
 		
@@ -326,7 +330,8 @@ static irqreturn_t i82092aa_interrupt(int irq, void *dev)
 			 
 			if (csc & I365_CSC_DETECT) {
 				events |= SS_DETECT;
-				printk("Card detected in socket %i!\n",i);
+				dev_info(&sockets[i].dev->dev,
+					 "Card detected in socket %i!\n", i);
 			 }
 			
 			if (indirect_read(i,I365_INTCTL) & I365_PC_IOCARD) { 
@@ -417,7 +422,9 @@ static int i82092aa_init(struct pcmcia_socket *sock)
                                                                                                                                                                                                                                               
 static int i82092aa_get_status(struct pcmcia_socket *socket, u_int *value)
 {
-	unsigned int sock = container_of(socket, struct socket_info, socket)->number;
+	struct socket_info *sock_info = container_of(socket, struct socket_info,
+						     socket);
+	unsigned int sock = sock_info->number;
 	unsigned int status;
 	
 	enter("i82092aa_get_status");
@@ -458,7 +465,9 @@ static int i82092aa_get_status(struct pcmcia_socket *socket, u_int *value)
 
 static int i82092aa_set_socket(struct pcmcia_socket *socket, socket_state_t *state) 
 {
-	unsigned int sock = container_of(socket, struct socket_info, socket)->number;
+	struct socket_info *sock_info = container_of(socket, struct socket_info,
+						     socket);
+	unsigned int sock = sock_info->number;
 	unsigned char reg;
 	
 	enter("i82092aa_set_socket");
@@ -482,11 +491,11 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket, socket_state_t *sta
 	reg = I365_PWR_NORESET; /* default: disable resetdrv on resume */
 	
 	if (state->flags & SS_PWR_AUTO) {
-		printk("Auto power\n");
+		dev_info(&sock_info->dev->dev, "Auto power\n");
 		reg |= I365_PWR_AUTO;	/* automatic power mngmnt */
 	}
 	if (state->flags & SS_OUTPUT_ENA) {
-		printk("Power Enabled \n");
+		dev_info(&sock_info->dev->dev, "Power Enabled\n");
 		reg |= I365_PWR_OUT;	/* enable power */
 	}
 	
@@ -494,11 +503,15 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket, socket_state_t *sta
 		case 0:	
 			break;
 		case 50: 
-			printk("setting voltage to Vcc to 5V on socket %i\n",sock);
+			dev_info(&sock_info->dev->dev,
+				 "setting voltage to Vcc to 5V on socket %i\n",
+				 sock);
 			reg |= I365_VCC_5V;
 			break;
 		default:
-			printk("i82092aa: i82092aa_set_socket called with invalid VCC power value: %i ", state->Vcc);
+			dev_err(&sock_info->dev->dev,
+				"i82092aa: %s called with invalid VCC power value: %i",
+				__func__, state->Vcc);
 			leave("i82092aa_set_socket");
 			return -EINVAL;
 	}
@@ -506,18 +519,25 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket, socket_state_t *sta
 	
 	switch (state->Vpp) {
 		case 0:	
-			printk("not setting Vpp on socket %i\n",sock);
+			dev_info(&sock_info->dev->dev,
+				 "not setting Vpp on socket %i\n",
+				 sock);
 			break;
 		case 50: 
-			printk("setting Vpp to 5.0 for socket %i\n",sock);
+			dev_info(&sock_info->dev->dev,
+				 "setting Vpp to 5.0 for socket %i\n",
+				 sock);
 			reg |= I365_VPP1_5V | I365_VPP2_5V;
 			break;
 		case 120: 
-			printk("setting Vpp to 12.0\n");
+			dev_info(&sock_info->dev->dev,
+				 "setting Vpp to 12.0\n");
 			reg |= I365_VPP1_12V | I365_VPP2_12V;
 			break;
 		default:
-			printk("i82092aa: i82092aa_set_socket called with invalid VPP power value: %i ", state->Vcc);
+			dev_err(&sock_info->dev->dev,
+				"i82092aa: %s called with invalid VPP power value: %i",
+				__func__, state->Vcc);
 			leave("i82092aa_set_socket");
 			return -EINVAL;
 	}
@@ -555,7 +575,9 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket, socket_state_t *sta
 
 static int i82092aa_set_io_map(struct pcmcia_socket *socket, struct pccard_io_map *io)
 {
-	unsigned int sock = container_of(socket, struct socket_info, socket)->number;
+	struct socket_info *sock_info = container_of(socket, struct socket_info,
+						     socket);
+	unsigned int sock = sock_info->number;
 	unsigned char map, ioctl;
 	
 	enter("i82092aa_set_io_map");
@@ -576,7 +598,10 @@ static int i82092aa_set_io_map(struct pcmcia_socket *socket, struct pccard_io_ma
 	if (indirect_read(sock, I365_ADDRWIN) & I365_ENA_IO(map))
 		indirect_resetbit(sock, I365_ADDRWIN, I365_ENA_IO(map));
 
-/*	printk("set_io_map: Setting range to %x - %x \n",io->start,io->stop);  */
+/*	dev_info(&sock_info->dev->dev,
+ *		 "set_io_map: Setting range to %x - %x\n",
+ *		 io->start, io->stop);
+ */
 	
 	/* write the new values */
 	indirect_write16(sock,I365_IO(map)+I365_W_START,io->start);            	
@@ -619,7 +644,8 @@ static int i82092aa_set_mem_map(struct pcmcia_socket *socket, struct pccard_mem_
 	if ( (mem->card_start > 0x3ffffff) || (region.start > region.end) ||
 	     (mem->speed > 1000) ) {
 		leave("i82092aa_set_mem_map: invalid address / speed");
-		printk("invalid mem map for socket %i: %llx to %llx with a "
+		dev_err(&sock_info->dev->dev,
+			"invalid mem map for socket %i: %llx to %llx with a "
 			"start of %x\n",
 			sock,
 			(unsigned long long)region.start,
@@ -633,7 +659,12 @@ static int i82092aa_set_mem_map(struct pcmcia_socket *socket, struct pccard_mem_
 	              indirect_resetbit(sock, I365_ADDRWIN, I365_ENA_MEM(map));
 	                 
 	                 
-/* 	printk("set_mem_map: Setting map %i range to %x - %x on socket %i, speed is %i, active = %i \n",map, region.start,region.end,sock,mem->speed,mem->flags & MAP_ACTIVE);  */
+/*	dev_info(&sock_info->dev->dev,
+ *		 "set_mem_map: Setting map %i range to %x - %x on socket %i, "
+ *		 "speed is %i, active = %i\n", map,
+ *		 region.start, region.end, sock,mem->speed,
+ *		 mem->flags & MAP_ACTIVE);
+ */
 
 	/* write the start address */
 	base = I365_MEM(map);
@@ -669,10 +700,16 @@ static int i82092aa_set_mem_map(struct pcmcia_socket *socket, struct pccard_mem_
 	if (mem->flags & MAP_WRPROT)
 		i |= I365_MEM_WRPROT;
 	if (mem->flags & MAP_ATTRIB) {
-/*		printk("requesting attribute memory for socket %i\n",sock);*/
+/*		dev_info(&sock_info->dev->dev,
+ *			 "requesting attribute memory for socket %i\n",
+ *			 sock);
+ */
 		i |= I365_MEM_REG;
 	} else {
-/*		printk("requesting normal memory for socket %i\n",sock);*/
+/*		dev_info(&sock_info->dev->dev,
+ *			 "requesting normal memory for socket %i\n",
+ *			 sock);
+ */
 	}
 	indirect_write16(sock,base+I365_W_OFF,i);
 	
-- 
2.20.1

