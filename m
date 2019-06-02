Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0085C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 15:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9495E27947
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 15:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYScFeS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfFBPiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 11:38:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35776 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfFBPiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 11:38:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so9656201wrv.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 08:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=I9nkTY8ZwvQsju+VswiZjejJvAc6AHITH0UJBlOQVHU=;
        b=NYScFeS9P2ci8LkMSPgmiHrRwMcFt5pIXcxWu5zdRdk62mSuqq+cDEms82TDVufyVo
         C3jJ6NgSsBgxXXeJLzE3No+0tetLTfadj6Ei9sA0Qvs1eoE8rBNIR8ONH/+/dN36uKIF
         RucAyQjqtCTQwrgWjWEemfoo3ioWem69l+xf6cjvK9Knx9AsnlP659w2GLmx73bMS5Aa
         nTiZcGK0R1IZHq3HuQigEII5bOdGI+93WVlZFOfK6DlK0XsebSwDXjQ5HSom6Q6y0kK1
         7q3dxi4lgH0DyOUGUkiU1jPLWh58Eh7DKkjW1L/cbT91OOyjIW1QY7Qvx8A2wXCkWXhV
         PzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=I9nkTY8ZwvQsju+VswiZjejJvAc6AHITH0UJBlOQVHU=;
        b=UpvSI1PmwN1MN/MUpQ3gbLN1gfoPGLgAHwphk2K+Oj+yLsuBL0hi4YSVqrp/lh4/kN
         ox9HFfkKlj2RYLUI3pKJyQByviszBWNJtnGY0Wl7YMORW2vNJU5Yb8+Ma0489uArkVin
         Hxmq5Luf/vXgMhRxDczn5TGFxcgufrxer7k5foKdyVi52ZWphw1+cc8cwS5JQH+UDhZg
         /zYkWyEEa7dL0A29aUI5EShQ9DNKUM6J0C4m2PsukzEe9ass3Jl5Npg0bUnmcrYgKV3w
         IWDCY0g5Oqirv7k6P9xrL4SoOttC4uiGbP8OsMfIH0aPGrzQKNNza2+JoF0MQ31BdVth
         KOWg==
X-Gm-Message-State: APjAAAV0u6kDQkbXEhOVD0KgsOb7El+QRtYaKasJ25w+g8rq4fuoEj1q
        6AxjC3B1LXNrAyLyUCO4HkFFUIhf9Zl0bQ==
X-Google-Smtp-Source: APXvYqyrO/P9EBEymUe9w8/oKweFzKM2YLW+VmbWmAUnM2S0SvDcv/qT3aIaKXgnQ8JBpgEH627ORw==
X-Received: by 2002:a05:6000:1143:: with SMTP id d3mr3727524wrx.139.1559489901829;
        Sun, 02 Jun 2019 08:38:21 -0700 (PDT)
Received: from p200300EEEE2F.fritz.box (p200300C98712670014A3D3D52C57F0B4.dip0.t-ipconnect.de. [2003:c9:8712:6700:14a3:d3d5:2c57:f0b4])
        by smtp.gmail.com with ESMTPSA id c15sm2346652wrx.23.2019.06.02.08.38.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 08:38:21 -0700 (PDT)
From:   Emanuel Bennici <benniciemanuel78@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Joe Perches <joe@perches.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 2/2] pci: cpqphp: Correct usage of 'return'
Date:   Sun,  2 Jun 2019 17:38:02 +0200
Message-Id: <20190602153804.15063-2-benniciemanuel78@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190602153804.15063-1-benniciemanuel78@gmail.com>
References: <20190602153804.15063-1-benniciemanuel78@gmail.com>
Reply-To: benniciemanuel78@gmail.com
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'return' is not correctly used here.
This Patch replaces 'return(n)' with 'return n'.

Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
---
 drivers/pci/hotplug/cpqphp_nvram.c | 48 +++++++++++++++---------------
 drivers/pci/hotplug/cpqphp_pci.c   | 24 +++++++--------
 drivers/pci/hotplug/shpchp_ctrl.c  |  2 +-
 3 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_nvram.c b/drivers/pci/hotplug/cpqphp_nvram.c
index 00cd2b43364f..2a2ffc9650d7 100644
--- a/drivers/pci/hotplug/cpqphp_nvram.c
+++ b/drivers/pci/hotplug/cpqphp_nvram.c
@@ -98,25 +98,25 @@ static u32 add_byte(u32 **p_buffer, u8 value, u32 *used, u32 *avail)
 	u8 **tByte;

 	if ((*used + 1) > *avail)
-		return(1);
+		return 1;

 	*((u8 *)*p_buffer) = value;
 	tByte = (u8 **)p_buffer;
 	(*tByte)++;
 	*used += 1;
-	return(0);
+	return 0;
 }


 static u32 add_dword(u32 **p_buffer, u32 value, u32 *used, u32 *avail)
 {
 	if ((*used + 4) > *avail)
-		return(1);
+		return 1;

 	**p_buffer = value;
 	(*p_buffer)++;
 	*used += 4;
-	return(0);
+	return 0;
 }


@@ -174,7 +174,7 @@ static u32 access_EV(u16 operation, u8 *ev_name, u8 *buffer, u32 *buf_size)
 		: "%ebx", "%edx");
 	spin_unlock_irqrestore(&int15_lock, flags);

-	return((ret_val & 0xFF00) >> 8);
+	return ((ret_val & 0xFF00) >> 8);
 }


@@ -236,12 +236,12 @@ static u32 store_HRT(void __iomem *rom_start)
 	available = 1024;

 	if (!check_for_compaq_ROM(rom_start))
-		return(1);
+		return 1;

 	buffer = (u32 *) evbuffer;

 	if (!buffer)
-		return(1);
+		return 1;

 	pFill = buffer;
 	usedbytes = 0;
@@ -253,12 +253,12 @@ static u32 store_HRT(void __iomem *rom_start)
 	/* The revision of this structure */
 	rc = add_byte(&pFill, 1 + ctrl->push_flag, &usedbytes, &available);
 	if (rc)
-		return(rc);
+		return rc;

 	/* The number of controllers */
 	rc = add_byte(&pFill, 1, &usedbytes, &available);
 	if (rc)
-		return(rc);
+		return rc;

 	while (ctrl) {
 		p_ev_ctrl = (struct ev_hrt_ctrl *) pFill;
@@ -268,22 +268,22 @@ static u32 store_HRT(void __iomem *rom_start)
 		/* The bus number */
 		rc = add_byte(&pFill, ctrl->bus, &usedbytes, &available);
 		if (rc)
-			return(rc);
+			return rc;

 		/* The device Number */
 		rc = add_byte(&pFill, PCI_SLOT(ctrl->pci_dev->devfn), &usedbytes, &available);
 		if (rc)
-			return(rc);
+			return rc;

 		/* The function Number */
 		rc = add_byte(&pFill, PCI_FUNC(ctrl->pci_dev->devfn), &usedbytes, &available);
 		if (rc)
-			return(rc);
+			return rc;

 		/* Skip the number of available entries */
 		rc = add_dword(&pFill, 0, &usedbytes, &available);
 		if (rc)
-			return(rc);
+			return rc;

 		/* Figure out memory Available */

@@ -297,12 +297,12 @@ static u32 store_HRT(void __iomem *rom_start)
 			/* base */
 			rc = add_dword(&pFill, resNode->base, &usedbytes, &available);
 			if (rc)
-				return(rc);
+				return rc;

 			/* length */
 			rc = add_dword(&pFill, resNode->length, &usedbytes, &available);
 			if (rc)
-				return(rc);
+				return rc;

 			resNode = resNode->next;
 		}
@@ -322,12 +322,12 @@ static u32 store_HRT(void __iomem *rom_start)
 			/* base */
 			rc = add_dword(&pFill, resNode->base, &usedbytes, &available);
 			if (rc)
-				return(rc);
+				return rc;

 			/* length */
 			rc = add_dword(&pFill, resNode->length, &usedbytes, &available);
 			if (rc)
-				return(rc);
+				return rc;

 			resNode = resNode->next;
 		}
@@ -347,12 +347,12 @@ static u32 store_HRT(void __iomem *rom_start)
 			/* base */
 			rc = add_dword(&pFill, resNode->base, &usedbytes, &available);
 			if (rc)
-				return(rc);
+				return rc;

 			/* length */
 			rc = add_dword(&pFill, resNode->length, &usedbytes, &available);
 			if (rc)
-				return(rc);
+				return rc;

 			resNode = resNode->next;
 		}
@@ -372,12 +372,12 @@ static u32 store_HRT(void __iomem *rom_start)
 			/* base */
 			rc = add_dword(&pFill, resNode->base, &usedbytes, &available);
 			if (rc)
-				return(rc);
+				return rc;

 			/* length */
 			rc = add_dword(&pFill, resNode->length, &usedbytes, &available);
 			if (rc)
-				return(rc);
+				return rc;

 			resNode = resNode->next;
 		}
@@ -402,10 +402,10 @@ static u32 store_HRT(void __iomem *rom_start)

 	if (rc) {
 		err(msg_unable_to_save);
-		return(1);
+		return 1;
 	}

-	return(0);
+	return 0;
 }


@@ -626,7 +626,7 @@ int compaq_nvram_load(void __iomem *rom_start, struct controller *ctrl)
 		rc &= cpqhp_resource_sort_and_combine(&(ctrl->bus_head));

 		if (rc)
-			return(rc);
+			return rc;
 	} else {
 		if ((evbuffer[0] != 0) && (!ctrl->push_flag))
 			return 1;
diff --git a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
index 1b2b3f3b648b..a8995c91cbbc 100644
--- a/drivers/pci/hotplug/cpqphp_pci.c
+++ b/drivers/pci/hotplug/cpqphp_pci.c
@@ -502,7 +502,7 @@ int cpqhp_save_slot_config(struct controller *ctrl, struct pci_func *new_slot)
 			 */
 			rc = cpqhp_save_config(ctrl, sub_bus, 0);
 			if (rc)
-				return(rc);
+				return rc;
 			ctrl->pci_bus->number = new_slot->bus;

 		}
@@ -669,7 +669,7 @@ int cpqhp_save_base_addr_length(struct controller *ctrl, struct pci_func *func)
 		func = cpqhp_slot_find(func->bus, func->device, index++);
 	}

-	return(0);
+	return 0;
 }


@@ -852,7 +852,7 @@ int cpqhp_save_used_resources(struct controller *ctrl, struct pci_func *func)
 						mem_node->next = func->mem_head;
 						func->mem_head = mem_node;
 					} else
-						return(1);
+						return 1;
 				}
 			}	/* End of base register loop */
 		/* Standard header */
@@ -923,7 +923,7 @@ int cpqhp_save_used_resources(struct controller *ctrl, struct pci_func *func)
 						mem_node->next = func->mem_head;
 						func->mem_head = mem_node;
 					} else
-						return(1);
+						return 1;
 				}
 			}	/* End of base register loop */
 		}
@@ -1038,7 +1038,7 @@ int cpqhp_valid_replace(struct controller *ctrl, struct pci_func *func)
 	unsigned int devfn;

 	if (!func->is_a_board)
-		return(ADD_NOT_SUPPORTED);
+		return ADD_NOT_SUPPORTED;

 	func = cpqhp_slot_find(func->bus, func->device, index++);

@@ -1050,17 +1050,17 @@ int cpqhp_valid_replace(struct controller *ctrl, struct pci_func *func)

 		/* No adapter present */
 		if (temp_register == 0xFFFFFFFF)
-			return(NO_ADAPTER_PRESENT);
+			return NO_ADAPTER_PRESENT;

 		if (temp_register != func->config_space[0])
-			return(ADAPTER_NOT_SAME);
+			return ADAPTER_NOT_SAME;

 		/* Check for same revision number and class code */
 		pci_bus_read_config_dword(pci_bus, devfn, PCI_CLASS_REVISION, &temp_register);

 		/* Adapter not the same */
 		if (temp_register != func->config_space[0x08 >> 2])
-			return(ADAPTER_NOT_SAME);
+			return ADAPTER_NOT_SAME;

 		/* Check for Bridge */
 		pci_bus_read_config_byte(pci_bus, devfn, PCI_HEADER_TYPE, &header_type);
@@ -1099,7 +1099,7 @@ int cpqhp_valid_replace(struct controller *ctrl, struct pci_func *func)
 				 */
 				if (!((func->config_space[0] == 0xAE100E11)
 				      && (temp_register == 0x00L)))
-					return(ADAPTER_NOT_SAME);
+					return ADAPTER_NOT_SAME;
 			}
 			/* Figure out IO and memory base lengths */
 			for (cloop = 0x10; cloop <= 0x24; cloop += 4) {
@@ -1132,10 +1132,10 @@ int cpqhp_valid_replace(struct controller *ctrl, struct pci_func *func)

 				/* Check information in slot structure */
 				if (func->base_length[(cloop - 0x10) >> 2] != base)
-					return(ADAPTER_NOT_SAME);
+					return ADAPTER_NOT_SAME;

 				if (func->base_type[(cloop - 0x10) >> 2] != type)
-					return(ADAPTER_NOT_SAME);
+					return ADAPTER_NOT_SAME;

 			}	/* End of base register loop */

@@ -1144,7 +1144,7 @@ int cpqhp_valid_replace(struct controller *ctrl, struct pci_func *func)
 			/* this is not a type 0 or 1 config space header so
 			 * we don't know how to do it
 			 */
-			return(DEVICE_TYPE_NOT_SUPPORTED);
+			return DEVICE_TYPE_NOT_SUPPORTED;
 		}

 		/* Get the next function */
diff --git a/drivers/pci/hotplug/shpchp_ctrl.c b/drivers/pci/hotplug/shpchp_ctrl.c
index a7b807b31726..ea58f9b1d43c 100644
--- a/drivers/pci/hotplug/shpchp_ctrl.c
+++ b/drivers/pci/hotplug/shpchp_ctrl.c
@@ -327,7 +327,7 @@ static int board_added(struct slot *p_slot)
 		return rc;
 	}

-	return(rc);
+	return rc;
 }


--
2.19.1

