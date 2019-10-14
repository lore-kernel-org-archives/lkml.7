Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CE2ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCBF217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbIgsQ3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387839AbfJNPrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 11:47:04 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38392 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731070AbfJNPrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:47:03 -0400
Received: by mail-oi1-f196.google.com with SMTP id m16so14131547oic.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 08:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+d/ANv1Sk5IA8SJFgYWLVzJmUF0sZPRMkbEU6RlJbuU=;
        b=RbIgsQ3JeEoO2SUOr8czjyqwoTyu9r8YhfgWisemdpxK2TD1dtv+aT7vlxPqIla1pI
         HC10AunLc1raT9aMtGsv8cMVAagR08qwBHnCigIE1cpkkHwxDsfvxdLIp05rI+qIS1hU
         Y7ekzDFMeu+RxKMZwPncW2tvPmij9/iW1nQVTpJlhVclDUl/F99UBtfouYxkJiw7aE1E
         7c1p3klAtJjlAxLA7XT3gvqi34CrNTAKfxstdablRwFGe5qKrNAV5qNlctCGjafPirMM
         dCBbBrDTnm82fyaf3uoxEEJhlyuUK4d1y1NZ4JL5nFUkjYjw1lnxCpVqLo51fya8aPHW
         Py/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=+d/ANv1Sk5IA8SJFgYWLVzJmUF0sZPRMkbEU6RlJbuU=;
        b=EukRDUDWa/I/QzkTyWY1/UwvPWkHKwsqjZSW0ApBwF0Jr1uQTj7FG5tJl0zZuu1k/t
         ahvLNQnNdseTQm83zfZ1N+MfC8QOJK59qGHdw+g1E2b7AjKeL6zmrLSDG9zaerDLCB6X
         VV7ZIw88HKpO9+EqROerWJqn99EfgCZaJkiNcyug9nsJHPG0Za8644Xlnu+EexuVUcVA
         F4avS58hS/cfoxlqT8hHELXA6hBPzs8sbDKvRtteyQN9xy5F+CF8WXrUOhgnIZwlH7Zv
         zgWXz7nQMD2lP4nCeBriUzGdRNGZz7E63FLKF9U6f0BeYdDtbWLojTE0dt+7Ipv878Dt
         oIIg==
X-Gm-Message-State: APjAAAU9GvcRKNa7+aW2Jt9QdQ3f9xP3o67mT2CADQnfGU2/ExNHpAAI
        67KSiJI0o6gqo0VGaTIc/w==
X-Google-Smtp-Source: APXvYqwI0Z1cxSpz1w0mNked6Bo5WZ8GaCPKDgxLt7TEcEY/EZGe/CNHeNQtWH8abrD4+mF/fnVJCg==
X-Received: by 2002:aca:5ed7:: with SMTP id s206mr23826167oib.134.1571068022560;
        Mon, 14 Oct 2019 08:47:02 -0700 (PDT)
Received: from serve.minyard.net ([47.184.136.59])
        by smtp.gmail.com with ESMTPSA id o23sm5832035ote.67.2019.10.14.08.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 08:47:02 -0700 (PDT)
Received: from t560.minyard.net (unknown [192.168.27.180])
        by serve.minyard.net (Postfix) with ESMTPA id 7FEA1180044;
        Mon, 14 Oct 2019 15:47:01 +0000 (UTC)
From:   minyard@acm.org
To:     tony camuso <tcamuso@redhat.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        Corey Minyard <minyard@acm.org>, linux-kernel@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH] ipmi: Don't allow device module unload when in use
Date:   Mon, 14 Oct 2019 10:46:32 -0500
Message-Id: <20191014154632.11103-1-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191014134141.GA25427@t560>
References: <20191014134141.GA25427@t560>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

If something has the IPMI driver open, don't allow the device
module to be unloaded.  Before it would unload and the user would
get errors on use.

This change is made on user request, and it makes it consistent
with the I2C driver, which has the same behavior.

It does change things a little bit with respect to kernel users.
If the ACPI or IPMI watchdog (or any other kernel user) has
created a user, then the device module cannot be unloaded.  Before
it could be unloaded,

This does not affect hot-plug.  If the device goes away (it's on
something removable that is removed or is hot-removed via sysfs)
then it still behaves as it did before.

Reported-by: tony camuso <tcamuso@redhat.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
Tony, here is a suggested change for this.  Can you look it over and
see if it looks ok?

Thanks,

-corey

 drivers/char/ipmi/ipmi_msghandler.c | 23 ++++++++++++++++-------
 include/linux/ipmi_smi.h            | 12 ++++++++----
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 2aab80e19ae0..15680de18625 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -448,6 +448,8 @@ enum ipmi_stat_indexes {
 
 #define IPMI_IPMB_NUM_SEQ	64
 struct ipmi_smi {
+	struct module *owner;
+
 	/* What interface number are we? */
 	int intf_num;
 
@@ -1220,6 +1222,11 @@ int ipmi_create_user(unsigned int          if_num,
 	if (rv)
 		goto out_kfree;
 
+	if (!try_module_get(intf->owner)) {
+		rv = -ENODEV;
+		goto out_kfree;
+	}
+	
 	/* Note that each existing user holds a refcount to the interface. */
 	kref_get(&intf->refcount);
 
@@ -1349,6 +1356,7 @@ static void _ipmi_destroy_user(struct ipmi_user *user)
 	}
 
 	kref_put(&intf->refcount, intf_free);
+	module_put(intf->owner);
 }
 
 int ipmi_destroy_user(struct ipmi_user *user)
@@ -2459,7 +2467,7 @@ static int __get_device_id(struct ipmi_smi *intf, struct bmc_device *bmc)
  * been recently fetched, this will just use the cached data.  Otherwise
  * it will run a new fetch.
  *
- * Except for the first time this is called (in ipmi_register_smi()),
+ * Except for the first time this is called (in ipmi_add_smi()),
  * this will always return good data;
  */
 static int __bmc_get_device_id(struct ipmi_smi *intf, struct bmc_device *bmc,
@@ -3377,10 +3385,11 @@ static void redo_bmc_reg(struct work_struct *work)
 	kref_put(&intf->refcount, intf_free);
 }
 
-int ipmi_register_smi(const struct ipmi_smi_handlers *handlers,
-		      void		       *send_info,
-		      struct device            *si_dev,
-		      unsigned char            slave_addr)
+int ipmi_add_smi(struct module         *owner,
+		 const struct ipmi_smi_handlers *handlers,
+		 void		       *send_info,
+		 struct device         *si_dev,
+		 unsigned char         slave_addr)
 {
 	int              i, j;
 	int              rv;
@@ -3406,7 +3415,7 @@ int ipmi_register_smi(const struct ipmi_smi_handlers *handlers,
 		return rv;
 	}
 
-
+	intf->owner = owner;
 	intf->bmc = &intf->tmp_bmc;
 	INIT_LIST_HEAD(&intf->bmc->intfs);
 	mutex_init(&intf->bmc->dyn_mutex);
@@ -3514,7 +3523,7 @@ int ipmi_register_smi(const struct ipmi_smi_handlers *handlers,
 
 	return rv;
 }
-EXPORT_SYMBOL(ipmi_register_smi);
+EXPORT_SYMBOL(ipmi_add_smi);
 
 static void deliver_smi_err_response(struct ipmi_smi *intf,
 				     struct ipmi_smi_msg *msg,
diff --git a/include/linux/ipmi_smi.h b/include/linux/ipmi_smi.h
index 4dc66157d872..deec18b8944a 100644
--- a/include/linux/ipmi_smi.h
+++ b/include/linux/ipmi_smi.h
@@ -224,10 +224,14 @@ static inline int ipmi_demangle_device_id(uint8_t netfn, uint8_t cmd,
  * is called, and the lower layer must get the interface from that
  * call.
  */
-int ipmi_register_smi(const struct ipmi_smi_handlers *handlers,
-		      void                     *send_info,
-		      struct device            *dev,
-		      unsigned char            slave_addr);
+int ipmi_add_smi(struct module            *owner,
+		 const struct ipmi_smi_handlers *handlers,
+		 void                     *send_info,
+		 struct device            *dev,
+		 unsigned char            slave_addr);
+
+#define ipmi_register_smi(handlers, send_info, dev, slave_addr) \
+	ipmi_add_smi(THIS_MODULE, handlers, send_info, dev, slave_addr)
 
 /*
  * Remove a low-level interface from the IPMI driver.  This will
-- 
2.17.1

