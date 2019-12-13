Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7856AC50711
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA932470C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfLMNz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:55:26 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:43672 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727489AbfLMNzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 08:55:25 -0500
Received: from faui04f.informatik.uni-erlangen.de (faui04f.informatik.uni-erlangen.de [IPv6:2001:638:a000:4130:131:188:30:136])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 478AF2417CD;
        Fri, 13 Dec 2019 14:55:21 +0100 (CET)
Received: by faui04f.informatik.uni-erlangen.de (Postfix, from userid 66991)
        id 3B2E8C20BC7; Fri, 13 Dec 2019 14:55:21 +0100 (CET)
From:   Simon Geis <simon.geis@fau.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Simon Geis <simon.geis@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: [PATCH v3 02/10] PCMCIA/i82092: add/remove spaces to improve readability
Date:   Fri, 13 Dec 2019 14:53:06 +0100
Message-Id: <20191213135311.9111-3-simon.geis@fau.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213135311.9111-1-simon.geis@fau.de>
References: <20191213135311.9111-1-simon.geis@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the readability by adding whitespaces after commas 
and around comparative operations. Also change indentation of 
one comment block.
While at it, remove trailing whitespaces and spaces before tabs.

Co-developed-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Simon Geis <simon.geis@fau.de>

---
 drivers/pcmcia/i82092.c | 380 ++++++++++++++++++++--------------------
 1 file changed, 188 insertions(+), 192 deletions(-)

diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index 0afcdc69c103..87680a748cbd 100644
--- a/drivers/pcmcia/i82092.c
+++ b/drivers/pcmcia/i82092.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* 
+/*
  * Driver for Intel I82092AA PCI-PCMCIA bridge.
  *
  * (C) 2001 Red Hat, Inc.
@@ -42,7 +42,7 @@ static struct pci_driver i82092aa_pci_driver = {
 
 /* the pccard structure and its functions */
 static struct pccard_operations i82092aa_operations = {
-	.init 		 	= i82092aa_init,
+	.init			= i82092aa_init,
 	.get_status		= i82092aa_get_status,
 	.set_socket		= i82092aa_set_socket,
 	.set_io_map		= i82092aa_set_io_map,
@@ -53,33 +53,35 @@ static struct pccard_operations i82092aa_operations = {
 
 struct socket_info {
 	int	number;
-	int	card_state; 	/*  0 = no socket,
-				    1 = empty socket, 
-				    2 = card but not initialized,
-				    3 = operational card */
-	unsigned int io_base; 	/* base io address of the socket */
-	
+	int	card_state;
+		/* 0 = no socket,
+		 * 1 = empty socket,
+		 * 2 = card but not initialized,
+		 * 3 = operational card
+		 */
+	unsigned int io_base;	/* base io address of the socket */
+
 	struct pcmcia_socket socket;
 	struct pci_dev *dev;	/* The PCI device for the socket */
 };
 
 #define MAX_SOCKETS 4
 static struct socket_info sockets[MAX_SOCKETS];
-static int socket_count;  /* shortcut */                                  	                                	
+static int socket_count;	/* shortcut */
 
 
 static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	unsigned char configbyte;
 	int i, ret;
-	
+
 	enter("i82092aa_pci_probe");
-	
+
 	if ((ret = pci_enable_device(dev)))
 		return ret;
-		
+
 	pci_read_config_byte(dev, 0x40, &configbyte);  /* PCI Configuration Control */
-	switch(configbyte&6) {
+	switch (configbyte&6) {
 		case 0:
 			socket_count = 2;
 			break;
@@ -90,7 +92,7 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 		case 6:
 			socket_count = 4;
 			break;
-			
+
 		default:
 			dev_err(&dev->dev,
 				"Oops, you did something we didn't think of.\n");
@@ -104,8 +106,8 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 		ret = -EBUSY;
 		goto err_out_disable;
 	}
-	
-	for (i = 0;i<socket_count;i++) {
+
+	for (i = 0; i < socket_count; i++) {
 		sockets[i].card_state = 1; /* 1 = present but empty */
 		sockets[i].io_base = pci_resource_start(dev, 0);
 		sockets[i].socket.features |= SS_CAP_PCCARD;
@@ -116,7 +118,7 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 		sockets[i].socket.owner = THIS_MODULE;
 
 		sockets[i].number = i;
-		
+
 		if (card_present(i)) {
 			sockets[i].card_state = 3;
 			dev_dbg(&dev->dev, "slot %i is occupied\n", i);
@@ -124,7 +126,7 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 			dev_dbg(&dev->dev, "slot %i is vacant\n", i);
 		}
 	}
-		
+
 	/* Now, specifiy that all interrupts are to be done as PCI interrupts */
 	configbyte = 0xFF; /* bitmask, one bit per event, 1 = PCI interrupt, 0 = ISA interrupt */
 	pci_write_config_byte(dev, 0x50, configbyte); /* PCI Interrupt Routing Register */
@@ -137,7 +139,7 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 		goto err_out_free_res;
 	}
 
-	for (i = 0; i<socket_count; i++) {
+	for (i = 0; i < socket_count; i++) {
 		sockets[i].socket.dev.parent = &dev->dev;
 		sockets[i].socket.ops = &i82092aa_operations;
 		sockets[i].socket.resource_ops = &pccard_nonstatic_ops;
@@ -152,7 +154,7 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 
 err_out_free_sockets:
 	if (i) {
-		for (i--;i>=0;i--) {
+		for (i--; i >= 0; i--) {
 			pcmcia_unregister_socket(&sockets[i].socket);
 		}
 	}
@@ -161,7 +163,7 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 	release_region(pci_resource_start(dev, 0), 2);
 err_out_disable:
 	pci_disable_device(dev);
-	return ret;			
+	return ret;
 }
 
 static void i82092aa_pci_remove(struct pci_dev *dev)
@@ -169,7 +171,7 @@ static void i82092aa_pci_remove(struct pci_dev *dev)
 	int i;
 
 	enter("i82092aa_pci_remove");
-	
+
 	free_irq(dev->irq, i82092aa_interrupt);
 
 	for (i = 0; i < socket_count; i++)
@@ -187,12 +189,12 @@ static unsigned char indirect_read(int socket, unsigned short reg)
 	unsigned short int port;
 	unsigned char val;
 	unsigned long flags;
-	spin_lock_irqsave(&port_lock,flags);
+	spin_lock_irqsave(&port_lock, flags);
 	reg += socket * 0x40;
 	port = sockets[socket].io_base;
-	outb(reg,port);
+	outb(reg, port);
 	val = inb(port+1);
-	spin_unlock_irqrestore(&port_lock,flags);
+	spin_unlock_irqrestore(&port_lock, flags);
 	return val;
 }
 
@@ -202,15 +204,15 @@ static unsigned short indirect_read16(int socket, unsigned short reg)
 	unsigned short int port;
 	unsigned short tmp;
 	unsigned long flags;
-	spin_lock_irqsave(&port_lock,flags);
+	spin_lock_irqsave(&port_lock, flags);
 	reg  = reg + socket * 0x40;
 	port = sockets[socket].io_base;
-	outb(reg,port);
+	outb(reg, port);
 	tmp = inb(port+1);
 	reg++;
-	outb(reg,port);
+	outb(reg, port);
 	tmp = tmp | (inb(port+1)<<8);
-	spin_unlock_irqrestore(&port_lock,flags);
+	spin_unlock_irqrestore(&port_lock, flags);
 	return tmp;
 }
 #endif
@@ -219,12 +221,12 @@ static void indirect_write(int socket, unsigned short reg, unsigned char value)
 {
 	unsigned short int port;
 	unsigned long flags;
-	spin_lock_irqsave(&port_lock,flags);
+	spin_lock_irqsave(&port_lock, flags);
 	reg = reg + socket * 0x40;
-	port = sockets[socket].io_base; 
-	outb(reg,port);
-	outb(value,port+1);
-	spin_unlock_irqrestore(&port_lock,flags);
+	port = sockets[socket].io_base;
+	outb(reg, port);
+	outb(value, port+1);
+	spin_unlock_irqrestore(&port_lock, flags);
 }
 
 static void indirect_setbit(int socket, unsigned short reg, unsigned char mask)
@@ -232,15 +234,15 @@ static void indirect_setbit(int socket, unsigned short reg, unsigned char mask)
 	unsigned short int port;
 	unsigned char val;
 	unsigned long flags;
-	spin_lock_irqsave(&port_lock,flags);
+	spin_lock_irqsave(&port_lock, flags);
 	reg = reg + socket * 0x40;
-	port = sockets[socket].io_base; 
-	outb(reg,port);
+	port = sockets[socket].io_base;
+	outb(reg, port);
 	val = inb(port+1);
 	val |= mask;
-	outb(reg,port);
-	outb(val,port+1);
-	spin_unlock_irqrestore(&port_lock,flags);
+	outb(reg, port);
+	outb(val, port+1);
+	spin_unlock_irqrestore(&port_lock, flags);
 }
 
 
@@ -249,15 +251,15 @@ static void indirect_resetbit(int socket, unsigned short reg, unsigned char mask
 	unsigned short int port;
 	unsigned char val;
 	unsigned long flags;
-	spin_lock_irqsave(&port_lock,flags);
+	spin_lock_irqsave(&port_lock, flags);
 	reg = reg + socket * 0x40;
-	port = sockets[socket].io_base; 
-	outb(reg,port);
+	port = sockets[socket].io_base;
+	outb(reg, port);
 	val = inb(port+1);
 	val &= ~mask;
-	outb(reg,port);
-	outb(val,port+1);
-	spin_unlock_irqrestore(&port_lock,flags);
+	outb(reg, port);
+	outb(val, port+1);
+	spin_unlock_irqrestore(&port_lock, flags);
 }
 
 static void indirect_write16(int socket, unsigned short reg, unsigned short value)
@@ -265,20 +267,20 @@ static void indirect_write16(int socket, unsigned short reg, unsigned short valu
 	unsigned short int port;
 	unsigned char val;
 	unsigned long flags;
-	spin_lock_irqsave(&port_lock,flags);
+	spin_lock_irqsave(&port_lock, flags);
 	reg = reg + socket * 0x40;
-	port = sockets[socket].io_base; 
-	
-	outb(reg,port);
+	port = sockets[socket].io_base;
+
+	outb(reg, port);
 	val = value & 255;
-	outb(val,port+1);
-	
+	outb(val, port+1);
+
 	reg++;
-	
-	outb(reg,port);
+
+	outb(reg, port);
 	val = value>>8;
-	outb(val,port+1);
-	spin_unlock_irqrestore(&port_lock,flags);
+	outb(val, port+1);
+	spin_unlock_irqrestore(&port_lock, flags);
 }
 
 /* simple helper functions */
@@ -287,12 +289,12 @@ static int cycle_time = 120;
 
 static int to_cycles(int ns)
 {
-	if (cycle_time!=0)
+	if (cycle_time != 0)
 		return ns/cycle_time;
 	else
 		return 0;
 }
-    
+
 
 /* Interrupt handler functionality */
 
@@ -302,56 +304,55 @@ static irqreturn_t i82092aa_interrupt(int irq, void *dev)
 	int loopcount = 0;
 	int handled = 0;
 
-	unsigned int events, active=0;
-	
+	unsigned int events, active = 0;
+
 /*	enter("i82092aa_interrupt");*/
-	
+
 	while (1) {
 		loopcount++;
-		if (loopcount>20) {
+		if (loopcount > 20) {
 			pr_err("i82092aa: infinite eventloop in interrupt\n");
 			break;
 		}
-		
+
 		active = 0;
-		
-		for (i=0;i<socket_count;i++) {
+
+		for (i = 0; i < socket_count; i++) {
 			int csc;
-			if (sockets[i].card_state==0) /* Inactive socket, should not happen */
+			if (sockets[i].card_state == 0) /* Inactive socket, should not happen */
+				continue;
+
+			csc = indirect_read(i, I365_CSC); /* card status change register */
+
+			if (csc == 0)  /* no events on this socket */
 				continue;
-			
-			csc = indirect_read(i,I365_CSC); /* card status change register */
-			
-			if (csc==0)  /* no events on this socket */
-			   	continue;
 			handled = 1;
 			events = 0;
-			 
+
 			if (csc & I365_CSC_DETECT) {
 				events |= SS_DETECT;
 				dev_info(&sockets[i].dev->dev,
 					 "Card detected in socket %i!\n", i);
-			 }
-			
-			if (indirect_read(i,I365_INTCTL) & I365_PC_IOCARD) { 
+			}
+
+			if (indirect_read(i, I365_INTCTL) & I365_PC_IOCARD) {
 				/* For IO/CARDS, bit 0 means "read the card" */
-				events |= (csc & I365_CSC_STSCHG) ? SS_STSCHG : 0; 
+				events |= (csc & I365_CSC_STSCHG) ? SS_STSCHG : 0;
 			} else {
 				/* Check for battery/ready events */
 				events |= (csc & I365_CSC_BVD1) ? SS_BATDEAD : 0;
 				events |= (csc & I365_CSC_BVD2) ? SS_BATWARN : 0;
 				events |= (csc & I365_CSC_READY) ? SS_READY : 0;
 			}
-			
+
 			if (events) {
 				pcmcia_parse_events(&sockets[i].socket, events);
 			}
 			active |= events;
 		}
-				
-		if (active==0) /* no more events to handle */
-			break;				
-		
+
+		if (active == 0) /* no more events to handle */
+			break;
 	}
 	return IRQ_RETVAL(handled);
 /*	leave("i82092aa_interrupt");*/
@@ -362,22 +363,22 @@ static irqreturn_t i82092aa_interrupt(int irq, void *dev)
 /* socket functions */
 
 static int card_present(int socketno)
-{	
+{
 	unsigned int val;
 	enter("card_present");
-	
-	if ((socketno<0) || (socketno >= MAX_SOCKETS))
+
+	if ((socketno < 0) || (socketno >= MAX_SOCKETS))
 		return 0;
 	if (sockets[socketno].io_base == 0)
 		return 0;
 
-		
+
 	val = indirect_read(socketno, 1); /* Interface status register */
-	if ((val&12)==12) {
+	if ((val&12) == 12) {
 		leave("card_present 1");
 		return 1;
 	}
-		
+
 	leave("card_present 0");
 	return 0;
 }
@@ -385,56 +386,53 @@ static int card_present(int socketno)
 static void set_bridge_state(int sock)
 {
 	enter("set_bridge_state");
-	indirect_write(sock, I365_GBLCTL,0x00);
-	indirect_write(sock, I365_GENCTL,0x00);
-	
-	indirect_setbit(sock, I365_INTCTL,0x08);
+	indirect_write(sock, I365_GBLCTL, 0x00);
+	indirect_write(sock, I365_GENCTL, 0x00);
+
+	indirect_setbit(sock, I365_INTCTL, 0x08);
 	leave("set_bridge_state");
 }
 
 
-
-
-
-      
 static int i82092aa_init(struct pcmcia_socket *sock)
 {
 	int i;
 	struct resource res = { .start = 0, .end = 0x0fff };
-        pccard_io_map io = { 0, 0, 0, 0, 1 };
+	pccard_io_map io = { 0, 0, 0, 0, 1 };
 	pccard_mem_map mem = { .res = &res, };
-        
-        enter("i82092aa_init");
-                        
-        for (i = 0; i < 2; i++) {
-        	io.map = i;
-                i82092aa_set_io_map(sock, &io);
+
+	enter("i82092aa_init");
+
+	for (i = 0; i < 2; i++) {
+		io.map = i;
+		i82092aa_set_io_map(sock, &io);
 	}
-        for (i = 0; i < 5; i++) {
-        	mem.map = i;
-                i82092aa_set_mem_map(sock, &mem);
+	for (i = 0; i < 5; i++) {
+		mem.map = i;
+		i82092aa_set_mem_map(sock, &mem);
 	}
-	
+
 	leave("i82092aa_init");
 	return 0;
 }
-                                                                                                                                                                                                                                              
+
+
 static int i82092aa_get_status(struct pcmcia_socket *socket, u_int *value)
 {
 	struct socket_info *sock_info = container_of(socket, struct socket_info,
 						     socket);
 	unsigned int sock = sock_info->number;
 	unsigned int status;
-	
+
 	enter("i82092aa_get_status");
-	
-	status = indirect_read(sock,I365_STATUS); /* Interface Status Register */
+
+	status = indirect_read(sock, I365_STATUS); /* Interface Status Register */
 	*value = 0;
-	
+
 	if ((status & I365_CS_DETECT) == I365_CS_DETECT) {
 		*value |= SS_DETECT;
 	}
-		
+
 	/* IO cards have a different meaning of bits 0,1 */
 	/* Also notice the inverse-logic on the bits */
 	if (indirect_read(sock, I365_INTCTL) & I365_PC_IOCARD)	{
@@ -447,13 +445,13 @@ static int i82092aa_get_status(struct pcmcia_socket *socket, u_int *value)
 		if (!(status & I365_CS_BVD2))
 			*value |= SS_BATWARN;
 	}
-	 
+
 	if (status & I365_CS_WRPROT)
 		(*value) |= SS_WRPROT;	/* card is write protected */
-	 
+
 	if (status & I365_CS_READY)
 		(*value) |= SS_READY;    /* card is not busy */
-	 	
+
 	if (status & I365_CS_POWERON)
 		(*value) |= SS_POWERON;  /* power is applied to the card */
 
@@ -462,33 +460,33 @@ static int i82092aa_get_status(struct pcmcia_socket *socket, u_int *value)
 }
 
 
-static int i82092aa_set_socket(struct pcmcia_socket *socket, socket_state_t *state) 
+static int i82092aa_set_socket(struct pcmcia_socket *socket, socket_state_t *state)
 {
 	struct socket_info *sock_info = container_of(socket, struct socket_info,
 						     socket);
 	unsigned int sock = sock_info->number;
 	unsigned char reg;
-	
+
 	enter("i82092aa_set_socket");
-	
+
 	/* First, set the global controller options */
-	
+
 	set_bridge_state(sock);
-	
+
 	/* Values for the IGENC register */
-	
+
 	reg = 0;
-	if (!(state->flags & SS_RESET)) 	/* The reset bit has "inverse" logic */
-		reg = reg | I365_PC_RESET;  
-	if (state->flags & SS_IOCARD) 
+	if (!(state->flags & SS_RESET))	/* The reset bit has "inverse" logic */
+		reg = reg | I365_PC_RESET;
+	if (state->flags & SS_IOCARD)
 		reg = reg | I365_PC_IOCARD;
-		
-	indirect_write(sock,I365_INTCTL,reg); /* IGENC, Interrupt and General Control Register */
-	
+
+	indirect_write(sock, I365_INTCTL, reg); /* IGENC, Interrupt and General Control Register */
+
 	/* Power registers */
-	
+
 	reg = I365_PWR_NORESET; /* default: disable resetdrv on resume */
-	
+
 	if (state->flags & SS_PWR_AUTO) {
 		dev_info(&sock_info->dev->dev, "Auto power\n");
 		reg |= I365_PWR_AUTO;	/* automatic power mngmnt */
@@ -497,11 +495,11 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket, socket_state_t *sta
 		dev_info(&sock_info->dev->dev, "Power Enabled\n");
 		reg |= I365_PWR_OUT;	/* enable power */
 	}
-	
+
 	switch (state->Vcc) {
-		case 0:	
+		case 0:
 			break;
-		case 50: 
+		case 50:
 			dev_info(&sock_info->dev->dev,
 				 "setting voltage to Vcc to 5V on socket %i\n",
 				 sock);
@@ -514,19 +512,18 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket, socket_state_t *sta
 			leave("i82092aa_set_socket");
 			return -EINVAL;
 	}
-	
-	
+
 	switch (state->Vpp) {
-		case 0:	
+		case 0:
 			dev_info(&sock_info->dev->dev,
 				 "not setting Vpp on socket %i\n", sock);
 			break;
-		case 50: 
+		case 50:
 			dev_info(&sock_info->dev->dev,
 				 "setting Vpp to 5.0 for socket %i\n", sock);
 			reg |= I365_VPP1_5V | I365_VPP2_5V;
 			break;
-		case 120: 
+		case 120:
 			dev_info(&sock_info->dev->dev, "setting Vpp to 12.0\n");
 			reg |= I365_VPP1_12V | I365_VPP2_12V;
 			break;
@@ -537,12 +534,12 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket, socket_state_t *sta
 			leave("i82092aa_set_socket");
 			return -EINVAL;
 	}
-	
-	if (reg != indirect_read(sock,I365_POWER)) /* only write if changed */
-		indirect_write(sock,I365_POWER,reg);
-		
+
+	if (reg != indirect_read(sock, I365_POWER)) /* only write if changed */
+		indirect_write(sock, I365_POWER, reg);
+
 	/* Enable specific interrupt events */
-	
+
 	reg = 0x00;
 	if (state->csc_mask & SS_DETECT) {
 		reg |= I365_CSC_DETECT;
@@ -551,19 +548,19 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket, socket_state_t *sta
 		if (state->csc_mask & SS_STSCHG)
 			reg |= I365_CSC_STSCHG;
 	} else {
-		if (state->csc_mask & SS_BATDEAD) 
+		if (state->csc_mask & SS_BATDEAD)
 			reg |= I365_CSC_BVD1;
-		if (state->csc_mask & SS_BATWARN) 
+		if (state->csc_mask & SS_BATWARN)
 			reg |= I365_CSC_BVD2;
-		if (state->csc_mask & SS_READY) 
-			reg |= I365_CSC_READY; 
-		                        
+		if (state->csc_mask & SS_READY)
+			reg |= I365_CSC_READY;
+
 	}
-	
+
 	/* now write the value and clear the (probably bogus) pending stuff by doing a dummy read*/
-	
-	indirect_write(sock,I365_CSCINT,reg);
-	(void)indirect_read(sock,I365_CSC);
+
+	indirect_write(sock, I365_CSCINT, reg);
+	(void)indirect_read(sock, I365_CSC);
 
 	leave("i82092aa_set_socket");
 	return 0;
@@ -575,41 +572,41 @@ static int i82092aa_set_io_map(struct pcmcia_socket *socket, struct pccard_io_ma
 						     socket);
 	unsigned int sock = sock_info->number;
 	unsigned char map, ioctl;
-	
+
 	enter("i82092aa_set_io_map");
-	
+
 	map = io->map;
-	
-	/* Check error conditions */	
+
+	/* Check error conditions */
 	if (map > 1) {
 		leave("i82092aa_set_io_map with invalid map");
 		return -EINVAL;
 	}
-	if ((io->start > 0xffff) || (io->stop > 0xffff) || (io->stop < io->start)){
+	if ((io->start > 0xffff) || (io->stop > 0xffff) || (io->stop < io->start)) {
 		leave("i82092aa_set_io_map with invalid io");
 		return -EINVAL;
 	}
 
-	/* Turn off the window before changing anything */ 
+	/* Turn off the window before changing anything */
 	if (indirect_read(sock, I365_ADDRWIN) & I365_ENA_IO(map))
 		indirect_resetbit(sock, I365_ADDRWIN, I365_ENA_IO(map));
 
 	/* write the new values */
-	indirect_write16(sock,I365_IO(map)+I365_W_START,io->start);            	
-	indirect_write16(sock,I365_IO(map)+I365_W_STOP,io->stop);            	
-	            	
-	ioctl = indirect_read(sock,I365_IOCTL) & ~I365_IOCTL_MASK(map);
-	
+	indirect_write16(sock, I365_IO(map)+I365_W_START, io->start);
+	indirect_write16(sock, I365_IO(map)+I365_W_STOP, io->stop);
+
+	ioctl = indirect_read(sock, I365_IOCTL) & ~I365_IOCTL_MASK(map);
+
 	if (io->flags & (MAP_16BIT|MAP_AUTOSZ))
 		ioctl |= I365_IOCTL_16BIT(map);
-		
-	indirect_write(sock,I365_IOCTL,ioctl);
-	
+
+	indirect_write(sock, I365_IOCTL, ioctl);
+
 	/* Turn the window back on if needed */
 	if (io->flags & MAP_ACTIVE)
-		indirect_setbit(sock,I365_ADDRWIN,I365_ENA_IO(map));
-			
-	leave("i82092aa_set_io_map");	
+		indirect_setbit(sock, I365_ADDRWIN, I365_ENA_IO(map));
+
+	leave("i82092aa_set_io_map");
 	return 0;
 }
 
@@ -620,20 +617,20 @@ static int i82092aa_set_mem_map(struct pcmcia_socket *socket, struct pccard_mem_
 	struct pci_bus_region region;
 	unsigned short base, i;
 	unsigned char map;
-	
+
 	enter("i82092aa_set_mem_map");
 
 	pcibios_resource_to_bus(sock_info->dev->bus, &region, mem->res);
-	
+
 	map = mem->map;
 	if (map > 4) {
 		leave("i82092aa_set_mem_map: invalid map");
 		return -EINVAL;
 	}
-	
-	
-	if ( (mem->card_start > 0x3ffffff) || (region.start > region.end) ||
-	     (mem->speed > 1000) ) {
+
+
+	if ((mem->card_start > 0x3ffffff) || (region.start > region.end) ||
+	     (mem->speed > 1000)) {
 		leave("i82092aa_set_mem_map: invalid address / speed");
 		dev_err(&sock_info->dev->dev,
 			"invalid mem map for socket %i: %llx to %llx with a "
@@ -644,24 +641,23 @@ static int i82092aa_set_mem_map(struct pcmcia_socket *socket, struct pccard_mem_
 			mem->card_start);
 		return -EINVAL;
 	}
-	
+
 	/* Turn off the window before changing anything */
 	if (indirect_read(sock, I365_ADDRWIN) & I365_ENA_MEM(map))
-	              indirect_resetbit(sock, I365_ADDRWIN, I365_ENA_MEM(map));
-	                 
-	                 
+		indirect_resetbit(sock, I365_ADDRWIN, I365_ENA_MEM(map));
+
 	/* write the start address */
 	base = I365_MEM(map);
 	i = (region.start >> 12) & 0x0fff;
-	if (mem->flags & MAP_16BIT) 
+	if (mem->flags & MAP_16BIT)
 		i |= I365_MEM_16BIT;
 	if (mem->flags & MAP_0WS)
-		i |= I365_MEM_0WS;	
-	indirect_write16(sock,base+I365_W_START,i);
-		               
+		i |= I365_MEM_0WS;
+	indirect_write16(sock, base+I365_W_START, i);
+
 	/* write the stop address */
-	
-	i= (region.end >> 12) & 0x0fff;
+
+	i = (region.end >> 12) & 0x0fff;
 	switch (to_cycles(mem->speed)) {
 		case 0:
 			break;
@@ -675,22 +671,22 @@ static int i82092aa_set_mem_map(struct pcmcia_socket *socket, struct pccard_mem_
 			i |= I365_MEM_WS1 | I365_MEM_WS0;
 			break;
 	}
-	
-	indirect_write16(sock,base+I365_W_STOP,i);
-	
+
+	indirect_write16(sock, base+I365_W_STOP, i);
+
 	/* card start */
-	
+
 	i = ((mem->card_start - region.start) >> 12) & 0x3fff;
 	if (mem->flags & MAP_WRPROT)
 		i |= I365_MEM_WRPROT;
 	if (mem->flags & MAP_ATTRIB)
 		i |= I365_MEM_REG;
-	indirect_write16(sock,base+I365_W_OFF,i);
-	
+	indirect_write16(sock, base+I365_W_OFF, i);
+
 	/* Enable the window if necessary */
 	if (mem->flags & MAP_ACTIVE)
 		indirect_setbit(sock, I365_ADDRWIN, I365_ENA_MEM(map));
-	            
+
 	leave("i82092aa_set_mem_map");
 	return 0;
 }
@@ -704,7 +700,7 @@ static void i82092aa_module_exit(void)
 {
 	enter("i82092aa_module_exit");
 	pci_unregister_driver(&i82092aa_pci_driver);
-	if (sockets[0].io_base>0)
+	if (sockets[0].io_base > 0)
 			 release_region(sockets[0].io_base, 2);
 	leave("i82092aa_module_exit");
 }
-- 
2.20.1

