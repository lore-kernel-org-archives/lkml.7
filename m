Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80C6C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A442075C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="gL5WcT4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfLFBAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 20:00:35 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:47598 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfLFBAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 20:00:35 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 47TZ5G4PV7z9vhZV
        for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2019 01:00:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YlOAEJl9qgJ9 for <linux-kernel@vger.kernel.org>;
        Thu,  5 Dec 2019 19:00:34 -0600 (CST)
Received: from mail-yw1-f70.google.com (mail-yw1-f70.google.com [209.85.161.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 47TZ5G2sC1z9vhZK
        for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2019 19:00:34 -0600 (CST)
Received: by mail-yw1-f70.google.com with SMTP id a16so3959025ywa.18
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 17:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=n838+sn4bG9Uk+EUak61BRvfIERSwMTFakidd6XsXRg=;
        b=gL5WcT4Mc0H8rePtZqFSwH1R6vC2OZAqlrtr8KDt6orBDMV46jVFTGxRTyV2ujEFJz
         gSS0SUfMwRB47vPHryM1EH6SejcdhhmNwcg/v3D++KlJ5dWoxjJ5sdCF7HaJHJvcX6Xg
         eMnfXSNd+uoEHLE8PC9ae9K0mdbL+EqHbwzXYsxJHCqMltL5JmzktEQEsR6TCw12id1a
         +8L2Kp9vt0naxloHBBzJmm6A7sPTzfGue2FqPGKsiMqluJdu8dn0tL97IwpnAArOc16b
         au8VP1YkUI3dWmiffTTvsoi0VPpFJb9w+JrSAcb1SG/ZmdDDmSCJ2zLxiECF4h72LD6B
         no2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n838+sn4bG9Uk+EUak61BRvfIERSwMTFakidd6XsXRg=;
        b=Cx6WrsF462RKFEg8xzzxx1BMH3QD/1PAQ0LXLZDxlU5BsPWeoL44MsXqaWM0mJm4iy
         +ZR0tgsqVtQg9leBfXP3KlN0UpkQTGv+H1GGrdPul4rno4H/26siDTFMH/iqgm9erJ8u
         n+tJ97IV7yygxtTHsLSK+tZL2akMcnE0JhLCIfxYuVdIaZGL1PO7TzsMYEXA/3Jc/lKu
         so/7raze/Xpoz5lo9tzyOIaM7QDyMaIcwiCIDDD997yetmnptp2RKgAs1jpKzZZC5/sB
         PCmkujMAEfG2PJ5kqPLSLSbW7ucUKMUrbxEY+pqB2sxfVqKftWHj3SQNBlrtdkJr3Pv3
         zGXA==
X-Gm-Message-State: APjAAAURmHHlU3eLEWS3kv3LtLeRpo4h+3DUBb9V25H9Usxc1A8n447j
        kHRQi61m8M4cAgHPtmnmdrHmeh0HaNOrkGz5euqSGWfzvwRsOTfd5P/84+jGsrmit2QhmP3bGZ2
        fAzWOXFwAWeqYfkS3F93TCY3eIkR4
X-Received: by 2002:a81:9bc4:: with SMTP id s187mr8306895ywg.285.1575594033842;
        Thu, 05 Dec 2019 17:00:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqzIMImCE7iR91PGFys8iHvLY0Z0Z84gHtI2rM2xFVcCXCRRE1hLDFaC7Nzy3+dB8iGSwEDWjA==
X-Received: by 2002:a81:9bc4:: with SMTP id s187mr8306879ywg.285.1575594033599;
        Thu, 05 Dec 2019 17:00:33 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id d80sm5567735ywa.58.2019.12.05.17.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 17:00:33 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: davinci/vpfe_capture.c: Avoid BUG_ON for register failure
Date:   Thu,  5 Dec 2019 19:00:29 -0600
Message-Id: <20191206010029.14265-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vpfe_register_ccdc_device(), failure to allocate dev->hw_ops
invokes calls to BUG_ON(). This patch returns the error to callers
instead of crashing.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/media/platform/davinci/vpfe_capture.c | 21 ++++++-------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/media/platform/davinci/vpfe_capture.c b/drivers/media/platform/davinci/vpfe_capture.c
index 916ed743d716..6d394a006977 100644
--- a/drivers/media/platform/davinci/vpfe_capture.c
+++ b/drivers/media/platform/davinci/vpfe_capture.c
@@ -168,21 +168,11 @@ int vpfe_register_ccdc_device(const struct ccdc_hw_device *dev)
 	int ret = 0;
 	printk(KERN_NOTICE "vpfe_register_ccdc_device: %s\n", dev->name);
 
-	BUG_ON(!dev->hw_ops.open);
-	BUG_ON(!dev->hw_ops.enable);
-	BUG_ON(!dev->hw_ops.set_hw_if_params);
-	BUG_ON(!dev->hw_ops.configure);
-	BUG_ON(!dev->hw_ops.set_buftype);
-	BUG_ON(!dev->hw_ops.get_buftype);
-	BUG_ON(!dev->hw_ops.enum_pix);
-	BUG_ON(!dev->hw_ops.set_frame_format);
-	BUG_ON(!dev->hw_ops.get_frame_format);
-	BUG_ON(!dev->hw_ops.get_pixel_format);
-	BUG_ON(!dev->hw_ops.set_pixel_format);
-	BUG_ON(!dev->hw_ops.set_image_window);
-	BUG_ON(!dev->hw_ops.get_image_window);
-	BUG_ON(!dev->hw_ops.get_line_length);
-	BUG_ON(!dev->hw_ops.getfid);
+	if (!dev->hw_ops) {
+		printk(KERN_ERR "could not allocate hw_ops\n");
+		ret = -EINVAL;
+		goto rvalue;
+	}
 
 	mutex_lock(&ccdc_lock);
 	if (!ccdc_cfg) {
@@ -211,6 +201,7 @@ int vpfe_register_ccdc_device(const struct ccdc_hw_device *dev)
 	ccdc_dev = dev;
 unlock:
 	mutex_unlock(&ccdc_lock);
+rvalue:
 	return ret;
 }
 EXPORT_SYMBOL(vpfe_register_ccdc_device);
-- 
2.17.1

