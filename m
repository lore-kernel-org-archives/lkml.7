Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED57C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB4D223C0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qio959Zi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbfDPOHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:07:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34045 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfDPOHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:07:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so27304156wrq.1;
        Tue, 16 Apr 2019 07:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+HY91w5f+9s/uMWknBV9UYHwFztj3VHolQha5X2UoMo=;
        b=Qio959ZiEBsMV5cgyIL2Qrz7WLWDgXeDQwsbiGUGy+2xJTIG3a78Ic+Czz10YgM57Y
         ZgXi9xHjuOtBmSWkoZl68+gxA2uZkFr23Hb93WwFWpih+K+eEoB9B3re0Mh96Jyax5tw
         9uczqVpHHU5Ka4bd8MGXqCayDf8ZtIIrXh9FJvKnME+rGC37mKX1EZ/i4ttS7TGgXPx1
         w8xQousk+zZPlqledwVBFB1y0Ttpum1E+LO+1A6wsZaB87PgktBlBbAONku5YNi8y7QA
         XdIlBqvUcdKKQKZSD1iT40EpEG8fUEHynFuYNinLTV9uN9eY23T7Nth8xvqOtKeBQov5
         oaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+HY91w5f+9s/uMWknBV9UYHwFztj3VHolQha5X2UoMo=;
        b=DF44tSfPtwnHAKsiczppUKQIiOb64l5Qw6zAM2rWjPzMVIMPDcYisYKDFrKWNFLhh7
         y/4oCP7/1rTAa2dDEMC4iNJ0HC9BlxEObye8rAYq4Q9HnTssmH+v1VObFNIoakWLBF9Q
         B1p/t0pS3cgfE5orY8eiehRcC8jMkgbzN2NNBoiXkvaDftm5EEcsd1ZO3uXBFXCKED3i
         1khEmuq2oAtD7Gab9ulSKnT+ozCQLf8JhbiZtOoHebp9/a6dyOVXFXUx81/1T0wa8+lM
         /qXi372GgzXD7EDpJGQpuPS4z9uRPQqyKt/VySjXVgx48beWL5/uMp6YpW7sXm13tX+B
         6DXQ==
X-Gm-Message-State: APjAAAVCN6n04m1nX883L8zC6j6+PP+19TtosuDfMyWF9Ft2Agf+b4mk
        thB7kjyNcUm/WqB3BHDh4nk=
X-Google-Smtp-Source: APXvYqwQUpN2z/xMJdGlvthSFTSeOI6pMVEPRSldxsbz2UKDArc7VW0qrmFuFAu9dAkuqezWDHaGBw==
X-Received: by 2002:adf:ed8f:: with SMTP id c15mr28853326wro.144.1555423670848;
        Tue, 16 Apr 2019 07:07:50 -0700 (PDT)
Received: from 5WDYG62.mdi (static-css-cqn-143221.business.bouyguestelecom.com. [176.149.143.221])
        by smtp.gmail.com with ESMTPSA id v192sm24008494wme.24.2019.04.16.07.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 07:07:49 -0700 (PDT)
From:   Romain Izard <romain.izard.pro@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH 2/2] usb: gadget: f_ncm: Add OS descriptor support
Date:   Tue, 16 Apr 2019 16:07:32 +0200
Message-Id: <20190416140732.21941-2-romain.izard.pro@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190416140732.21941-1-romain.izard.pro@gmail.com>
References: <20190416140732.21941-1-romain.izard.pro@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to use the default USB class drivers available in Microsoft
Windows, we need to add OS descriptors to the exported USB gadget to
tell the OS that we are compatible with the built-in drivers.

Copy the OS descriptor support from f_rndis into f_ncm. As a result,
using the WINNCM compatible ID, the UsbNcm driver is loaded on
enumeration without the need for a custom driver or inf file.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 drivers/usb/gadget/function/f_ncm.c | 47 +++++++++++++++++++++++++++--
 drivers/usb/gadget/function/u_ncm.h |  3 ++
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index d5c47e7a7f61..2d6e76e4cffa 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -23,6 +23,7 @@
 #include "u_ether.h"
 #include "u_ether_configfs.h"
 #include "u_ncm.h"
+#include "configfs.h"
 
 /*
  * This function is a "CDC Network Control Model" (CDC NCM) Ethernet link.
@@ -1391,6 +1392,16 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 		return -EINVAL;
 
 	ncm_opts = container_of(f->fi, struct f_ncm_opts, func_inst);
+
+	if (cdev->use_os_string) {
+		f->os_desc_table = kzalloc(sizeof(*f->os_desc_table),
+					   GFP_KERNEL);
+		if (!f->os_desc_table)
+			return -ENOMEM;
+		f->os_desc_n = 1;
+		f->os_desc_table[0].os_desc = &ncm_opts->ncm_os_desc;
+	}
+
 	/*
 	 * in drivers/usb/gadget/configfs.c:configfs_composite_bind()
 	 * configurations are bound in sequence with list_for_each_entry,
@@ -1404,13 +1415,15 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 		status = gether_register_netdev(ncm_opts->net);
 		mutex_unlock(&ncm_opts->lock);
 		if (status)
-			return status;
+			goto fail;
 		ncm_opts->bound = true;
 	}
 	us = usb_gstrings_attach(cdev, ncm_strings,
 				 ARRAY_SIZE(ncm_string_defs));
-	if (IS_ERR(us))
-		return PTR_ERR(us);
+	if (IS_ERR(us)) {
+		status = PTR_ERR(us);
+		goto fail;
+	}
 	ncm_control_intf.iInterface = us[STRING_CTRL_IDX].id;
 	ncm_data_nop_intf.iInterface = us[STRING_DATA_IDX].id;
 	ncm_data_intf.iInterface = us[STRING_DATA_IDX].id;
@@ -1427,6 +1440,10 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	ncm_control_intf.bInterfaceNumber = status;
 	ncm_union_desc.bMasterInterface0 = status;
 
+	if (cdev->use_os_string)
+		f->os_desc_table[0].if_id =
+			ncm_iad_desc.bFirstInterface;
+
 	status = usb_interface_id(c, f);
 	if (status < 0)
 		goto fail;
@@ -1506,6 +1523,9 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	return 0;
 
 fail:
+	kfree(f->os_desc_table);
+	f->os_desc_n = 0;
+
 	if (ncm->notify_req) {
 		kfree(ncm->notify_req->buf);
 		usb_ep_free_request(ncm->notify, ncm->notify_req);
@@ -1560,16 +1580,22 @@ static void ncm_free_inst(struct usb_function_instance *f)
 		gether_cleanup(netdev_priv(opts->net));
 	else
 		free_netdev(opts->net);
+	kfree(opts->ncm_interf_group);
 	kfree(opts);
 }
 
 static struct usb_function_instance *ncm_alloc_inst(void)
 {
 	struct f_ncm_opts *opts;
+	struct usb_os_desc *descs[1];
+	char *names[1];
+	struct config_group *ncm_interf_group;
 
 	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
 	if (!opts)
 		return ERR_PTR(-ENOMEM);
+	opts->ncm_os_desc.ext_compat_id = opts->ncm_ext_compat_id;
+
 	mutex_init(&opts->lock);
 	opts->func_inst.free_func_inst = ncm_free_inst;
 	opts->net = gether_setup_default();
@@ -1578,8 +1604,20 @@ static struct usb_function_instance *ncm_alloc_inst(void)
 		kfree(opts);
 		return ERR_CAST(net);
 	}
+	INIT_LIST_HEAD(&opts->ncm_os_desc.ext_prop);
+
+	descs[0] = &opts->ncm_os_desc;
+	names[0] = "ncm";
 
 	config_group_init_type_name(&opts->func_inst.group, "", &ncm_func_type);
+	ncm_interf_group =
+		usb_os_desc_prepare_interf_dir(&opts->func_inst.group, 1, descs,
+					       names, THIS_MODULE);
+	if (IS_ERR(ncm_interf_group)) {
+		ncm_free_inst(&opts->func_inst);
+		return ERR_CAST(ncm_interf_group);
+	}
+	opts->ncm_interf_group = ncm_interf_group;
 
 	return &opts->func_inst;
 }
@@ -1605,6 +1643,9 @@ static void ncm_unbind(struct usb_configuration *c, struct usb_function *f)
 
 	hrtimer_cancel(&ncm->task_timer);
 
+	kfree(f->os_desc_table);
+	f->os_desc_n = 0;
+
 	ncm_string_defs[0].id = 0;
 	usb_free_all_descriptors(f);
 
diff --git a/drivers/usb/gadget/function/u_ncm.h b/drivers/usb/gadget/function/u_ncm.h
index d483e45c0f77..70da3201a1d0 100644
--- a/drivers/usb/gadget/function/u_ncm.h
+++ b/drivers/usb/gadget/function/u_ncm.h
@@ -20,6 +20,9 @@ struct f_ncm_opts {
 	struct net_device		*net;
 	bool				bound;
 
+	struct config_group		*ncm_interf_group;
+	struct usb_os_desc		ncm_os_desc;
+	char				ncm_ext_compat_id[16];
 	/*
 	 * Read/write access to configfs attributes is handled by configfs.
 	 *
-- 
2.17.1

