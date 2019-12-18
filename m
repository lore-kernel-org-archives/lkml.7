Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A725C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 01:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F99D2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 01:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJCOQs/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfLRBTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 20:19:15 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36398 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfLRBTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 20:19:15 -0500
Received: by mail-pj1-f66.google.com with SMTP id n59so78299pjb.1;
        Tue, 17 Dec 2019 17:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=WRq9F02fSNyPBB5Kef/fJ+j1yBJctEoYq/MCWx6Ov/Y=;
        b=fJCOQs/G2GwXu9Tw+ZPeO/cO19LFkQnaJmRBLvLvqkjS+Z9RnrD2AJVp+9Ybfc1Tqy
         kq+2uvn3OmIbRSREWEiTm4iM0JjrALFy2ifJe5HwMoxuZamtNZYxsnmzIvCQSLrDkplW
         8WyIvF+WGcQkwPIKERUZ7ifgz57tTDMCVfhMA4kw0hg1HiFP3Haf/6PjnL2NDyOMFWz0
         WhY9DrgJzs2u9BJz3ShVSLCpSM6zDQf6qUCBBFp3SPn9gZjGxdx1l6UR8V4xv+1zVQAj
         vqo+2+w9WqS2342VjOvnFBsKdz/z0juflgoC95kNuMQcQqCTcmC1VWrONbP0vKu5G7U8
         X65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=WRq9F02fSNyPBB5Kef/fJ+j1yBJctEoYq/MCWx6Ov/Y=;
        b=UGX7xX/mORGtFSFb/sZeyPhY6EbDW0fwBumbYUc63zTCdynhBi/Ktg2o9X0osUevPY
         BT6nz1Aemc1VnOl2TNQe2WRzbwNiPYcgnVjdQAsHKHbjzTYk2LnJAXdNgGt51otyD2Ja
         e7eM/hqDNg0ElQqkGVNEq/W7nqx1vZZgOSsTyZtrJmEF5qtZ9nQ97auPOi+XvHvCPLez
         byFIBVOkp28/Z3D6Xrar7TWXTrl/Rct8T2BYqN1hFE8v2agOwt+5QtbdEPGM0rZFPLDy
         Z3rmA9zhUY9VXPjsFhV7LE4rKKeWjyq0ElJsfcI6Vggv5S+dOTifGJPVgYKPhkpQUmnt
         QMpg==
X-Gm-Message-State: APjAAAXIh1DSdH/DmEGRwqJ27+nk6x8sl0qY1AkXG6+MROaggdVQALWD
        kmnb/lrlIXPCzSc3+uBkwkY90+NB
X-Google-Smtp-Source: APXvYqyuU+DpeC/NKkkzJGfNjsLzfVmRLBror3wABxQqoaMBHiaAt5WNoCqjaOSxZ9Ylrkz+e9Apkg==
X-Received: by 2002:a17:902:48:: with SMTP id 66mr520374pla.182.1576631954521;
        Tue, 17 Dec 2019 17:19:14 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x18sm324398pfr.26.2019.12.17.17.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Dec 2019 17:19:13 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Henry Lin <henryl@nvidia.com>, stable@vger.kernel.org
Subject: [PATCH] usb: xhci: Fix build warning seen with CONFIG_PM=n
Date:   Tue, 17 Dec 2019 17:19:11 -0800
Message-Id: <20191218011911.6907-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following build warning is seen if CONFIG_PM is disabled.

drivers/usb/host/xhci-pci.c:498:13: warning:
	unused function 'xhci_pci_shutdown'

Fixes: f2c710f7dca8 ("usb: xhci: only set D3hot for pci device")
Cc: Henry Lin <henryl@nvidia.com>
Cc: stable@vger.kernel.org	# all stable releases with 2f23dc86c3f8
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/usb/host/xhci-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 2907fe4d78dd..4917c5b033fa 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -519,7 +519,6 @@ static int xhci_pci_resume(struct usb_hcd *hcd, bool hibernated)
 	retval = xhci_resume(xhci, hibernated);
 	return retval;
 }
-#endif /* CONFIG_PM */
 
 static void xhci_pci_shutdown(struct usb_hcd *hcd)
 {
@@ -532,6 +531,7 @@ static void xhci_pci_shutdown(struct usb_hcd *hcd)
 	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
 		pci_set_power_state(pdev, PCI_D3hot);
 }
+#endif /* CONFIG_PM */
 
 /*-------------------------------------------------------------------------*/
 
-- 
2.17.1

