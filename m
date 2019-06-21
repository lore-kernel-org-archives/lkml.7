Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DF6C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6122084A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aK6rakns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfFUBIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 21:08:47 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33909 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFUBIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 21:08:46 -0400
Received: by mail-io1-f68.google.com with SMTP id k8so820983iot.1;
        Thu, 20 Jun 2019 18:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=OQMetjZyUoUPsTFn8SOJEsiqJU03SCmw6h6Ex7ggGOM=;
        b=aK6raknsrvrRPolS7lAcqPknBT9z1hipNuKzyvLgR3QnZ+e6JJzskUaz2NL64NxNPX
         /E3oo8PJrp2AEByUrirS3wV/u8hFtoJA+WQm9LJWpA9muaKz6OFQhLwfeG9jRIRll5N6
         C3ca7J9kFjfye3zcsxF/heZC/+7vdhMvrXxpq8U3D6QDDPF3ElF9uUKyXQLWwrhDpSEh
         RVMBDCBtlihfE4gTshXd07ghhcSWAaHkyBhALm8iDmdijS6uu9UBKHmgkpWc1s2FlJ/m
         9T9iE+C+JJ8/E1IfgaeQtF/RIJMJu0A9pyZbOT1NrYBoyAxSbAM2TZuiI+PlhBHGVEdo
         ZrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=OQMetjZyUoUPsTFn8SOJEsiqJU03SCmw6h6Ex7ggGOM=;
        b=LJOzaxTTcr4u68F7SosvHO3QVzPn57n7Ma07Sq1UsZ1Qn9z5s2K5/n6+v56ersIE/W
         SU6b/lNRbdd3g75+L6fJ456xwfRCT7xYmLfQybg8fu5qS1FDmlgm7wCc8H//hiUmTPge
         EiDu9kbdZTlJHqOQRuckti5e8+m2vsb5QB0U4G3uFwfuucoBgdHiVJpr0XOlsPhX/8wH
         OP5lmIweWV3sWgrIgEHup9DiLNj4kufISmm5wwrIfUq/7howTEBaigJlr9dYVtme9uWb
         ow2ITsg7dVQ7s2aYA5aeUEoAlqCnSX7HXCrYXb1d0ukFKJAGyo/vAL6wAF4HmSeWuEWG
         sl8Q==
X-Gm-Message-State: APjAAAW1+MPG1QCChCWxlEoyWh+LOxUifJjq3iQOHv11HsIUBwcHt5Rz
        f663i+SN8C70xMhICaarkD0=
X-Google-Smtp-Source: APXvYqz5xJA4rHilmB13nL0BZpDwoS4B9iQghmci4gARVVr5cxYmXdZfoVZXl44hYYfeG7ksdtEfGg==
X-Received: by 2002:a02:aa8f:: with SMTP id u15mr95274817jai.39.1561079325719;
        Thu, 20 Jun 2019 18:08:45 -0700 (PDT)
Received: from AlexPC (CPEac9e17937810-CM64777dd8e660.cpe.net.cable.rogers.com. [174.112.199.101])
        by smtp.gmail.com with ESMTPSA id t133sm2863100iof.21.2019.06.20.18.08.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 18:08:44 -0700 (PDT)
From:   <alex.bou9@gmail.com>
To:     "'Dan Carpenter'" <dan.carpenter@oracle.com>,
        "'Andrew Morton'" <akpm@linux-foundation.org>
Cc:     "'Ira Weiny'" <ira.weiny@intel.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "'Matt Porter'" <mporter@kernel.crashing.org>
References: <20190529110601.GB19119@mwanda>
In-Reply-To: <20190529110601.GB19119@mwanda>
Subject: RE: [PATCH] rapidio/mport_cdev: NUL terminate some strings
Date:   Thu, 20 Jun 2019 21:08:43 -0400
Message-ID: <001101d527cd$e03b0180$a0b10480$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHqSTig6vd4VCxw0340JcsQqG4IG6Z7CPbw
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Alexandre Bounine <alex.bou9@gmail.com>  

-----Original Message-----
From: Dan Carpenter <dan.carpenter@oracle.com> 
Sent: Wednesday, May 29, 2019 7:06 AM
To: Matt Porter <mporter@kernel.crashing.org>
Cc: Alexandre Bounine <alex.bou9@gmail.com>; Andrew Morton
<akpm@linux-foundation.org>; Ira Weiny <ira.weiny@intel.com>;
linux-kernel@vger.kernel.org; kernel-janitors@vger.kernel.org
Subject: [PATCH] rapidio/mport_cdev: NUL terminate some strings

The dev_info.name[] array has space for RIO_MAX_DEVNAME_SZ + 1
characters.  But the problem here is that we don't ensure that the user
put a NUL terminator on the end of the string.  It could lead to an out
of bounds read.

Fixes: e8de370188d0 ("rapidio: add mport char device driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/rapidio/devices/rio_mport_cdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c
b/drivers/rapidio/devices/rio_mport_cdev.c
index 4a4a75fa26d5..3440b3e8e578 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -1690,6 +1690,7 @@ static int rio_mport_add_riodev(struct mport_cdev_priv
*priv,
 
 	if (copy_from_user(&dev_info, arg, sizeof(dev_info)))
 		return -EFAULT;
+	dev_info.name[sizeof(dev_info.name) - 1] = '\0';
 
 	rmcd_debug(RDEV, "name:%s ct:0x%x did:0x%x hc:0x%x", dev_info.name,
 		   dev_info.comptag, dev_info.destid, dev_info.hopcount);
@@ -1821,6 +1822,7 @@ static int rio_mport_del_riodev(struct mport_cdev_priv
*priv, void __user *arg)
 
 	if (copy_from_user(&dev_info, arg, sizeof(dev_info)))
 		return -EFAULT;
+	dev_info.name[sizeof(dev_info.name) - 1] = '\0';
 
 	mport = priv->md->mport;
 
-- 
2.20.1

