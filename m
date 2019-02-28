Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD955C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316EE218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="IpITimNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732168AbfB1Ttp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:49:45 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50988 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbfB1Tto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 14:49:44 -0500
Received: by mail-wm1-f67.google.com with SMTP id x7so10352552wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 11:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RJHJp0v8q0EwV9djfl2B0HUEURFjv69zVjwgW24PDFc=;
        b=IpITimNUIv+V0W8Uqqmg/YLXBEsLaGRBsOda2JUBABdbBjOffSAKDKwBexClRIPr3P
         T/rzuqkpd19cRJwtr6JRSbA+IPzItgSGNYx52mX3sCFBp4UFq7YKbgTrQakm1YOmZulH
         YvzA6SdgibJ5Hy9Qt1pcvj5hsmonafR8NO6uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RJHJp0v8q0EwV9djfl2B0HUEURFjv69zVjwgW24PDFc=;
        b=ORKAi5t8hokhlFRD+F69oZd6ATgKSNQIOZXpHDeVHhfjP/+ThwQWaIj+lq7sLcdIT3
         7Udmno/HX/S9trGtABZEl9yBVZHMOFplIfZBskCJd31vcrHszMNqj2mF4APig/3oeFoF
         TPd48wzn5z60MFe/IkPtpSskvlG8yrjm2ozpEcoDRhYM2wYC8ytNgTl57sMd68yoRd2Z
         Re+i6be2g/0l9GjICc2YxdFOAenJ+aVbEXu8IzBEtL3q8/UkULoZRHtJXCNa6VpYju25
         s+NpQJOXnysbhlwqBhx8R41n96nCoJ0z17uC8tIVO2w3koyy0jge2FKOjakJ5hEaawX2
         2pvw==
X-Gm-Message-State: APjAAAXuPTRgCIrzg973MEcxUqOsaZA36yhLXlzYsCm0ExH9Qu99dKAx
        Gtx5WDO65a3XekX3GXZAeMxrcQ==
X-Google-Smtp-Source: AHgI3IbXMI5KkeIg9rjItUHrgzQkuxyNdlblcx3MgAvZqurY9vkMhNDjydtAQuY97AlmYMAarP+vRw==
X-Received: by 2002:a1c:6643:: with SMTP id a64mr857690wmc.90.1551383382697;
        Thu, 28 Feb 2019 11:49:42 -0800 (PST)
Received: from localhost.localdomain ([213.205.198.100])
        by smtp.gmail.com with ESMTPSA id y22sm3928323wmj.6.2019.02.28.11.49.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 11:49:42 -0800 (PST)
From:   Louis Taylor <louis@kragniz.eu>
To:     alex.williamson@redhat.com
Cc:     aik@ozlabs.ru, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, ndesaulniers@google.com,
        jflat@chromium.org, Louis Taylor <louis@kragniz.eu>
Subject: [PATCH] vfio/pci: use correct format characters
Date:   Thu, 28 Feb 2019 19:48:12 +0000
Message-Id: <20190228194812.30929-1-louis@kragniz.eu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling with -Wformat, clang emits the following warnings:

drivers/vfio/pci/vfio_pci.c:1601:5: warning: format specifies type
      'unsigned short' but the argument has type 'unsigned int' [-Wformat]
                                vendor, device, subvendor, subdevice,
                                ^~~~~~

drivers/vfio/pci/vfio_pci.c:1601:13: warning: format specifies type
      'unsigned short' but the argument has type 'unsigned int' [-Wformat]
                                vendor, device, subvendor, subdevice,
                                        ^~~~~~

drivers/vfio/pci/vfio_pci.c:1601:21: warning: format specifies type
      'unsigned short' but the argument has type 'unsigned int' [-Wformat]
                                vendor, device, subvendor, subdevice,
                                                ^~~~~~~~~

drivers/vfio/pci/vfio_pci.c:1601:32: warning: format specifies type
      'unsigned short' but the argument has type 'unsigned int' [-Wformat]
                                vendor, device, subvendor, subdevice,
                                                           ^~~~~~~~~

drivers/vfio/pci/vfio_pci.c:1605:5: warning: format specifies type
      'unsigned short' but the argument has type 'unsigned int' [-Wformat]
                                vendor, device, subvendor, subdevice,
                                ^~~~~~

drivers/vfio/pci/vfio_pci.c:1605:13: warning: format specifies type
      'unsigned short' but the argument has type 'unsigned int' [-Wformat]
                                vendor, device, subvendor, subdevice,
                                        ^~~~~~

drivers/vfio/pci/vfio_pci.c:1605:21: warning: format specifies type
      'unsigned short' but the argument has type 'unsigned int' [-Wformat]
                                vendor, device, subvendor, subdevice,
                                                ^~~~~~~~~

drivers/vfio/pci/vfio_pci.c:1605:32: warning: format specifies type
      'unsigned short' but the argument has type 'unsigned int' [-Wformat]
                                vendor, device, subvendor, subdevice,
                                                           ^~~~~~~~~
The types of these arguments are unconditionally defined, so this patch
updates the format character to the correct ones for unsigned ints.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Louis Taylor <louis@kragniz.eu>
---
 drivers/vfio/pci/vfio_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index a25659b5a5d1..3fa20e95a6bb 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1661,11 +1661,11 @@ static void __init vfio_pci_fill_ids(void)
 		rc = pci_add_dynid(&vfio_pci_driver, vendor, device,
 				   subvendor, subdevice, class, class_mask, 0);
 		if (rc)
-			pr_warn("failed to add dynamic id [%04hx:%04hx[%04hx:%04hx]] class %#08x/%08x (%d)\n",
+			pr_warn("failed to add dynamic id [%04x:%04x[%04x:%04x]] class %#08x/%08x (%d)\n",
 				vendor, device, subvendor, subdevice,
 				class, class_mask, rc);
 		else
-			pr_info("add [%04hx:%04hx[%04hx:%04hx]] class %#08x/%08x\n",
+			pr_info("add [%04x:%04x[%04x:%04x]] class %#08x/%08x\n",
 				vendor, device, subvendor, subdevice,
 				class, class_mask);
 	}
-- 
2.20.1

