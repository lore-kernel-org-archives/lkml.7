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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB4CC282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 15:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1B62796C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 15:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeoIg8Xw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfFBP4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 11:56:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44715 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfFBP4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 11:56:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id w13so9623682wru.11
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 08:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=nhWOILuDvP2H60A9rApnGdMVLdYuriaJlseg1jGSqdQ=;
        b=DeoIg8Xw5PtlIzybCBSjdIPhrA3kAG6nZ/TE5TVmgL9bCJAunkXWYflmFZQufVMueO
         k/QnCn3h6D4TQ3C+bSh07/lPKKwQsSqkQjy0nHm8YG8L1f60q8gAic+NWLqD97R05ccY
         NtKIv8iXkUJajf9M7eT2ckKUjvxwE6BxxuWPwVQvJPoV+klCP/nf3RAhCJ6FIffOldib
         OFqVCq8mqcqyKz984Gkm6Gjv0O+cXSGiN9MoN2vpbf1ERxjD6L838INS0Hj5HfUluTZz
         k0nTRrPQaPOZLqS2gAUWf0EYYjY5ZKwwmYjiruhkT8UkMAXMwyA2MdhZKiufc1AHrrys
         xXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=nhWOILuDvP2H60A9rApnGdMVLdYuriaJlseg1jGSqdQ=;
        b=HA5RQLvy7zLtPYhzf1zdUE4Py5idWU69EwPBG8zDNPodtlyHI9VkAYAyo4HwFRV0Dn
         i9dlT+9Eps8m1jJ8/DQN6NR2iEUwPN3LVyD+f06oGJ/Ec18Civp8Dd6eKsOpaNcixWPz
         gSmU1Ma3ziNO5XDoNV042uRmngtgr4Y9lpQrz2rqKLP9RwxjbLCZuaKho4gFgcfEt/5u
         POsSLTJkWT+92LWO56e9hpVQEgQFrQkf+V5wVOAKt9j2s2BLVkc1NCIyVdfbh2zWZ20/
         DxzIlf4OuVLKLPAdld8F+HDMkzbGCLo+3vnTd4IFExKj1I8vlAq0JcSwq60RAFqIe/Yb
         1MKQ==
X-Gm-Message-State: APjAAAVpYMs7ZxLVoH5+BlOSnxlRdMKbbGhyzlt2fIpQqWLU+sO4QWB8
        7Fp2yNnacGP51ABH6P2dgWg3cQEwrZpsrQ==
X-Google-Smtp-Source: APXvYqzOc2qNR8FJOAepVVu+GdCgf8Q5tVZ+bCz4X5QpW4HPq7O2mDwP5fwHeZZ0YhVBc/OuiUnbfg==
X-Received: by 2002:adf:df87:: with SMTP id z7mr13760130wrl.8.1559490980759;
        Sun, 02 Jun 2019 08:56:20 -0700 (PDT)
Received: from p200300EEEE2F.fritz.box (p200300C98712670014A3D3D52C57F0B4.dip0.t-ipconnect.de. [2003:c9:8712:6700:14a3:d3d5:2c57:f0b4])
        by smtp.gmail.com with ESMTPSA id p13sm9508823wmb.23.2019.06.02.08.56.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 08:56:20 -0700 (PDT)
From:   Emanuel Bennici <benniciemanuel78@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Joe Perches <joe@perches.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] pci: ibmphp: Replace functionname with __func__ in Messages
Date:   Sun,  2 Jun 2019 17:56:17 +0200
Message-Id: <20190602155619.21992-1-benniciemanuel78@gmail.com>
X-Mailer: git-send-email 2.19.1
Reply-To: benniciemanuel78@gmail.com
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the hardcoded Function-Names in error and debug Messages with
the __func__ Macro.
If the Function-Name changes we haven't to check all the error/ debug
messages.

Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
---
 drivers/pci/hotplug/ibmphp_core.c | 34 +++++++++++++++----------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
index 17124254d897..59840a094973 100644
--- a/drivers/pci/hotplug/ibmphp_core.c
+++ b/drivers/pci/hotplug/ibmphp_core.c
@@ -194,7 +194,7 @@ static inline int power_on(struct slot *slot_cur)
 		return retval;
 	}
 	if (CTLR_RESULT(slot_cur->ctrl->status)) {
-		err("command not completed successfully in power_on\n");
+		err("command not completed successfully in %s\n", __func__);
 		return -EIO;
 	}
 	msleep(3000);	/* For ServeRAID cards, and some 66 PCI */
@@ -212,7 +212,7 @@ static inline int power_off(struct slot *slot_cur)
 		return retval;
 	}
 	if (CTLR_RESULT(slot_cur->ctrl->status)) {
-		err("command not completed successfully in power_off\n");
+		err("command not completed successfully in %s\n", __func__);
 		retval = -EIO;
 	}
 	return retval;
@@ -224,8 +224,8 @@ static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 value)
 	struct slot *pslot;
 	u8 cmd = 0x00;     /* avoid compiler warning */

-	debug("set_attention_status - Entry hotplug_slot[%lx] value[%x]\n",
-			(ulong) hotplug_slot, value);
+	debug("%s - Entry hotplug_slot[%lx] value[%x]\n",
+			__func__, (ulong) hotplug_slot, value);
 	ibmphp_lock_operations();


@@ -242,7 +242,7 @@ static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 value)
 			break;
 		default:
 			rc = -ENODEV;
-			err("set_attention_status - Error : invalid input [%x]\n",
+			err("%s - Error : invalid input [%x]\n", __func__,
 					value);
 			break;
 		}
@@ -255,7 +255,7 @@ static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 value)

 	ibmphp_unlock_operations();

-	debug("set_attention_status - Exit rc[%d]\n", rc);
+	debug("%s - Exit rc[%d]\n", __func__, rc);
 	return rc;
 }

@@ -265,7 +265,7 @@ static int get_attention_status(struct hotplug_slot *hotplug_slot, u8 *value)
 	struct slot *pslot;
 	struct slot myslot;

-	debug("get_attention_status - Entry hotplug_slot[%lx] pvalue[%lx]\n",
+	debug("%s - Entry hotplug_slot[%lx] pvalue[%lx]\n", __func__,
 					(ulong) hotplug_slot, (ulong) value);

 	ibmphp_lock_operations();
@@ -282,7 +282,7 @@ static int get_attention_status(struct hotplug_slot *hotplug_slot, u8 *value)
 	}

 	ibmphp_unlock_operations();
-	debug("get_attention_status - Exit rc[%d] value[%x]\n", rc, *value);
+	debug("%s - Exit rc[%d] value[%x]\n", __func__, rc, *value);
 	return rc;
 }

@@ -292,7 +292,7 @@ static int get_latch_status(struct hotplug_slot *hotplug_slot, u8 *value)
 	struct slot *pslot;
 	struct slot myslot;

-	debug("get_latch_status - Entry hotplug_slot[%lx] pvalue[%lx]\n",
+	debug("%s - Entry hotplug_slot[%lx] pvalue[%lx]\n", __func__,
 					(ulong) hotplug_slot, (ulong) value);
 	ibmphp_lock_operations();
 	if (hotplug_slot) {
@@ -305,8 +305,7 @@ static int get_latch_status(struct hotplug_slot *hotplug_slot, u8 *value)
 	}

 	ibmphp_unlock_operations();
-	debug("get_latch_status - Exit rc[%d] rc[%x] value[%x]\n",
-			rc, rc, *value);
+	debug("%s - Exit rc[%d] rc[%x] value[%x]\n", __func__, rc, rc, *value);
 	return rc;
 }

@@ -317,7 +316,7 @@ static int get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
 	struct slot *pslot;
 	struct slot myslot;

-	debug("get_power_status - Entry hotplug_slot[%lx] pvalue[%lx]\n",
+	debug("%s - Entry hotplug_slot[%lx] pvalue[%lx]\n", __func__,
 					(ulong) hotplug_slot, (ulong) value);
 	ibmphp_lock_operations();
 	if (hotplug_slot) {
@@ -330,8 +329,7 @@ static int get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
 	}

 	ibmphp_unlock_operations();
-	debug("get_power_status - Exit rc[%d] rc[%x] value[%x]\n",
-			rc, rc, *value);
+	debug("%s - Exit rc[%d] rc[%x] value[%x]\n", __func__, rc, rc, *value);
 	return rc;
 }

@@ -360,7 +358,7 @@ static int get_adapter_present(struct hotplug_slot *hotplug_slot, u8 *value)
 	}

 	ibmphp_unlock_operations();
-	debug("get_adapter_present - Exit rc[%d] value[%x]\n", rc, *value);
+	debug("%s - Exit rc[%d] value[%x]\n", __func__, rc, *value);
 	return rc;
 }

@@ -711,8 +709,7 @@ static u8 bus_structure_fixup(u8 busno)
 	for (dev->devfn = 0; dev->devfn < 256; dev->devfn += 8) {
 		if (!pci_read_config_word(dev, PCI_VENDOR_ID, &l) &&
 					(l != 0x0000) && (l != 0xffff)) {
-			debug("%s - Inside bus_structure_fixup()\n",
-							__func__);
+			debug("%s - Inside %s\n", __func__, __func__);
 			b = pci_scan_bus(busno, ibmphp_pci_bus->ops, NULL);
 			if (!b)
 				continue;
@@ -885,7 +882,8 @@ static int set_bus(struct slot *slot_cur)
 			return retval;
 		}
 		if (CTLR_RESULT(slot_cur->ctrl->status)) {
-			err("command not completed successfully in set_bus\n");
+			err("command not completed successfully in %s\n",
+				__func__);
 			return -EIO;
 		}
 	}
--
2.19.1

