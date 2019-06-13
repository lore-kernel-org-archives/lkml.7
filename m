Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DFCC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E0520644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392280AbfFMQ0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:26:02 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:34420 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730967AbfFMQ0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:26:00 -0400
Received: from heffalump.sk2.org (unknown [88.186.243.14])
        by smtp5-g21.free.fr (Postfix) with ESMTPS id E012F5FFD3;
        Thu, 13 Jun 2019 18:25:57 +0200 (CEST)
Received: from steve by heffalump.sk2.org with local (Exim 4.89)
        (envelope-from <steve@sk2.org>)
        id 1hbSY0-0005A0-Vs; Thu, 13 Jun 2019 18:25:57 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     corbet@lwn.net, federico.vaga@vaga.pv.it, linux-doc@vger.kernel.org
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH] docs: stop suggesting strlcpy
Date:   Thu, 13 Jun 2019 18:25:48 +0200
Message-Id: <20190613162548.19792-1-steve@sk2.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since strlcpy is deprecated, the documentation shouldn't suggest using
it. This patch fixes the examples to use strscpy instead. It also uses
sizeof instead of underlying constants as far as possible, to simplify
future changes to the corresponding data structures.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/hid/hid-transport.txt                         | 6 +++---
 Documentation/i2c/instantiating-devices                     | 2 +-
 Documentation/i2c/upgrading-clients                         | 4 ++--
 Documentation/kernel-hacking/locking.rst                    | 6 +++---
 Documentation/translations/it_IT/kernel-hacking/locking.rst | 6 +++---
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/hid/hid-transport.txt b/Documentation/hid/hid-transport.txt
index 3dcba9fd4a3a..4f41d67f1b4b 100644
--- a/Documentation/hid/hid-transport.txt
+++ b/Documentation/hid/hid-transport.txt
@@ -194,9 +194,9 @@ with HID core:
 		goto err_<...>;
 	}
 
-	strlcpy(hid->name, <device-name-src>, 127);
-	strlcpy(hid->phys, <device-phys-src>, 63);
-	strlcpy(hid->uniq, <device-uniq-src>, 63);
+	strscpy(hid->name, <device-name-src>, sizeof(hid->name));
+	strscpy(hid->phys, <device-phys-src>, sizeof(hid->phys));
+	strscpy(hid->uniq, <device-uniq-src>, sizeof(hid->uniq));
 
 	hid->ll_driver = &custom_ll_driver;
 	hid->bus = <device-bus>;
diff --git a/Documentation/i2c/instantiating-devices b/Documentation/i2c/instantiating-devices
index 0d85ac1935b7..8bc7d99133e3 100644
--- a/Documentation/i2c/instantiating-devices
+++ b/Documentation/i2c/instantiating-devices
@@ -137,7 +137,7 @@ static int usb_hcd_nxp_probe(struct platform_device *pdev)
 	(...)
 	i2c_adap = i2c_get_adapter(2);
 	memset(&i2c_info, 0, sizeof(struct i2c_board_info));
-	strlcpy(i2c_info.type, "isp1301_nxp", I2C_NAME_SIZE);
+	strscpy(i2c_info.type, "isp1301_nxp", sizeof(i2c_info.type));
 	isp1301_i2c_client = i2c_new_probed_device(i2c_adap, &i2c_info,
 						   normal_i2c, NULL);
 	i2c_put_adapter(i2c_adap);
diff --git a/Documentation/i2c/upgrading-clients b/Documentation/i2c/upgrading-clients
index ccba3ffd6e80..96392cc5b5c7 100644
--- a/Documentation/i2c/upgrading-clients
+++ b/Documentation/i2c/upgrading-clients
@@ -43,7 +43,7 @@ static int example_attach(struct i2c_adapter *adap, int addr, int kind)
 	example->client.adapter = adap;
 
 	i2c_set_clientdata(&state->i2c_client, state);
-	strlcpy(client->i2c_client.name, "example", I2C_NAME_SIZE);
+	strscpy(client->i2c_client.name, "example", sizeof(client->i2c_client.name));
 
 	ret = i2c_attach_client(&state->i2c_client);
 	if (ret < 0) {
@@ -138,7 +138,7 @@ can be removed:
 -	example->client.flags   = 0;
 -	example->client.adapter = adap;
 -
--	strlcpy(client->i2c_client.name, "example", I2C_NAME_SIZE);
+-	strscpy(client->i2c_client.name, "example", sizeof(client->i2c_client.name));
 
 The i2c_set_clientdata is now:
 
diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-hacking/locking.rst
index 519673df0e82..dc698ea456e0 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -451,7 +451,7 @@ to protect the cache and all the objects within it. Here's the code::
             if ((obj = kmalloc(sizeof(*obj), GFP_KERNEL)) == NULL)
                     return -ENOMEM;
 
-            strlcpy(obj->name, name, sizeof(obj->name));
+            strscpy(obj->name, name, sizeof(obj->name));
             obj->id = id;
             obj->popularity = 0;
 
@@ -660,7 +660,7 @@ Here is the code::
      }
 
     @@ -63,6 +94,7 @@
-             strlcpy(obj->name, name, sizeof(obj->name));
+             strscpy(obj->name, name, sizeof(obj->name));
              obj->id = id;
              obj->popularity = 0;
     +        obj->refcnt = 1; /* The cache holds a reference */
@@ -774,7 +774,7 @@ the lock is no longer used to protect the reference count itself.
      }
 
     @@ -94,7 +76,7 @@
-             strlcpy(obj->name, name, sizeof(obj->name));
+             strscpy(obj->name, name, sizeof(obj->name));
              obj->id = id;
              obj->popularity = 0;
     -        obj->refcnt = 1; /* The cache holds a reference */
diff --git a/Documentation/translations/it_IT/kernel-hacking/locking.rst b/Documentation/translations/it_IT/kernel-hacking/locking.rst
index 0ef31666663b..5fd8a1abd2be 100644
--- a/Documentation/translations/it_IT/kernel-hacking/locking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/locking.rst
@@ -468,7 +468,7 @@ e tutti gli oggetti che contiene. Ecco il codice::
             if ((obj = kmalloc(sizeof(*obj), GFP_KERNEL)) == NULL)
                     return -ENOMEM;
 
-            strlcpy(obj->name, name, sizeof(obj->name));
+            strscpy(obj->name, name, sizeof(obj->name));
             obj->id = id;
             obj->popularity = 0;
 
@@ -678,7 +678,7 @@ Ecco il codice::
      }
 
     @@ -63,6 +94,7 @@
-             strlcpy(obj->name, name, sizeof(obj->name));
+             strscpy(obj->name, name, sizeof(obj->name));
              obj->id = id;
              obj->popularity = 0;
     +        obj->refcnt = 1; /* The cache holds a reference */
@@ -792,7 +792,7 @@ contatore stesso.
      }
 
     @@ -94,7 +76,7 @@
-             strlcpy(obj->name, name, sizeof(obj->name));
+             strscpy(obj->name, name, sizeof(obj->name));
              obj->id = id;
              obj->popularity = 0;
     -        obj->refcnt = 1; /* The cache holds a reference */
-- 
2.11.0

