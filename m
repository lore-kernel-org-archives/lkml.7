Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FBBFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5010A2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/EJ11lc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405787AbfJPOpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:45:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34418 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388629AbfJPOpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:45:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id j11so28409363wrp.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 07:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lHtHFZLhEpG8KzfGOFtrYqJfvlhhXW1LattUMrUi/vc=;
        b=S/EJ11lcWWxjgm+Vi9jHQgxsecxyVqpjH/r6s3uRNqxOumWTdg8iGRh09WLcNTskfE
         LGK0bU4vm7O9ldBcjUugw9fky3IQ4kHcrrFFGPydZNB2nP9Cp8FL3TI8aVWNe+MHks9O
         1D/TfQUREq1CKuu9+IklISpRADJl2fEeg7dR8fwTVP0sacLIMBRcEdbn1QN9ZhJRDX2o
         g8PKM6cpsb+3lJJDq5FzoiufPxu8fRtgXeC9B2vCNVlRUc4sZNhJh9R1O1JB58ZDWtvM
         Jc8sZYcdru7n7OEBlQBUPGrtGx7DMacLNHQVvYX918iYKp8YPef4xOYQG/+Zvj3wYpLV
         O3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lHtHFZLhEpG8KzfGOFtrYqJfvlhhXW1LattUMrUi/vc=;
        b=kEZ7AJ36wZjqH0yzDhH50ix/XX6VJWB1caqsuTFethLax0tt0XGL5sjJelxPFnWzeN
         PT+RdW2IVqg557vWPsY6Rm+tlGg4wf2hio7vuBnx/egZMCbniMDGPPVw+dbqFVk22dsQ
         RcWzISVcs6zV54ufW7UPizl/BO0gj2tq0CHV5DMIMwyqqHpF1I/xugVBwfp/KsAfx4eM
         oePHkw5wNfr8Y5ZtZ/kP6Oq7leiPEgQ8BsRZS5DJrUMC4xdSUqTyFomPngeS+cR40w2z
         j1H5DOxWhFILASEypWQJ2PaYyXUMBB0Vj5uaSQx7T+cO9ZtHZKN6MGIAWYDoNcV2SlwD
         Krbg==
X-Gm-Message-State: APjAAAUDzCOANEwKwIQecCM2ltM0SdlEJLbTcFnq51de6u0WTvmLp70l
        FVi/U011wFZVYNs+psfYIKU=
X-Google-Smtp-Source: APXvYqxBeZ/OoFkmbB1CqxJ82R73Bo7mQaxdp3ipGfdfXaieUBZcJ2kfKFQnKuuy7zuTs03yFT2IWg==
X-Received: by 2002:a5d:6241:: with SMTP id m1mr3176606wrv.213.1571237145734;
        Wed, 16 Oct 2019 07:45:45 -0700 (PDT)
Received: from debian.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id q3sm22211733wru.33.2019.10.16.07.45.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 07:45:45 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 3/4] parport: load lowlevel driver if ports not found
Date:   Wed, 16 Oct 2019 15:45:39 +0100
Message-Id: <20191016144540.18810-3-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191016144540.18810-1-sudipm.mukherjee@gmail.com>
References: <20191016144540.18810-1-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usually all the distro will load the parport low level driver as part
of their initialization. But we can get into a situation where all the
parallel port drivers are built as module and we unload all the modules
at a later time. Then if we just do "modprobe parport" it will only
load the parport module and will not load the low level driver which
will actually register the ports. So, check the bus if there is any
parport registered, if not, load the low level driver.

We can get into the above situation with all distro but only Suse has
setup the alias for "parport_lowlevel" and so it only works in Suse.
Users of Debian based distro will need to load the lowlevel module
manually.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/share.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 96538b7975e5..d6920ebeabcd 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -230,6 +230,18 @@ static int port_check(struct device *dev, void *dev_drv)
 	return 0;
 }
 
+/*
+ * Iterates through all the devices connected to the bus and return 1
+ * if the device is a parallel port.
+ */
+
+static int port_detect(struct device *dev, void *dev_drv)
+{
+	if (is_parport(dev))
+		return 1;
+	return 0;
+}
+
 /**
  *	parport_register_driver - register a parallel port device driver
  *	@drv: structure describing the driver
@@ -279,6 +291,15 @@ int __parport_register_driver(struct parport_driver *drv, struct module *owner,
 		if (ret)
 			return ret;
 
+		/*
+		 * check if bus has any parallel port registered, if
+		 * none is found then load the lowlevel driver.
+		 */
+		ret = bus_for_each_dev(&parport_bus_type, NULL, NULL,
+				       port_detect);
+		if (!ret)
+			get_lowlevel_driver();
+
 		mutex_lock(&registration_lock);
 		if (drv->match_port)
 			bus_for_each_dev(&parport_bus_type, NULL, drv,
-- 
2.11.0

