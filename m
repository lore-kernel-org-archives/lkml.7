Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAE9C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA0E20657
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2znzTu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfEPPUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 11:20:01 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42433 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfEPPUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 11:20:01 -0400
Received: by mail-pl1-f195.google.com with SMTP id x15so1785275pln.9;
        Thu, 16 May 2019 08:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oi+wlm47PEX7LyKDr/FEMS8F29TvHMLAHthlHyHgCw4=;
        b=g2znzTu0gAG7G7gDzIQrI4gTupdPnh4NeAzhX2A8m+ERbraut5l2AYG914rVpZXM9C
         8QDH1tidHNaLE3RuDUJLL67Y97PaDSVNUmbL+oQD9EJ5Pk+DOQ4wEO6fXwAURqVt5uju
         u7jkL7O5uVvHON/Idhpkm2K/UjmDxUAAxDep0uJKz1dgRsBY4oKfRmRqpz4v71rvb/K6
         GOSmc67yXMAcPaiWnfkucLJ1w/OOTVyWGYtpdHLaIppb5FRboJ4ZML91mBRf6ixcKQGV
         PVvyjC1z0+aqOlvUi6shhciVNjv+6H8T20h7YgKIk6UyxwS9X5g8ZyaPtSNhtQKlvkXm
         dRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oi+wlm47PEX7LyKDr/FEMS8F29TvHMLAHthlHyHgCw4=;
        b=hxLr3mqFG67GZDyiHeZd9E3oPAOKACxPhy9CGnJBL5KqWfp90BFJ4KxXIHVssrn8fy
         FUsbw61hBdICjD5/6yi001SaKCe2izi5YGTpfjshw42p70WyklF8SZEfC1YH5olNf4WK
         8CPjPDndXeehC5uRGTyd3wNHSI/Cla7+OCRc7rX8emPVZgAhgUTXV7Ibm4GkQl+JLshZ
         Zwlik92i5Z7KSfd70RbLWaeL1f4tyR34IH3CgpJGHIIb6nGyE7E9uHj3sZLna/dg8uj6
         n3hkrYjHBQk4/5i6hKlhaoS+JsBqSHnpe4O6keUEFg8Dk6UCm5Pi7H7LwIS7UcosFctH
         L15Q==
X-Gm-Message-State: APjAAAU69PppWxjXsg5udyVtioOyQBMGrOBwj479EOaPu4UH1Hx/CbCj
        1ZJisESW92GWmEYw0QldEI0=
X-Google-Smtp-Source: APXvYqzIVNDe0Qc03gv4ha2vYaM6bDHoR6Gdz8UlOug8N+KtKW9+9xrWTJL6njhydMem6p/BpBKGTw==
X-Received: by 2002:a17:902:6bc2:: with SMTP id m2mr50196239plt.24.1558020000781;
        Thu, 16 May 2019 08:20:00 -0700 (PDT)
Received: from hydra-Latitude-E5440.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id q20sm6494464pgq.66.2019.05.16.08.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 08:20:00 -0700 (PDT)
From:   parna.naveenkumar@gmail.com
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Naveen Kumar Parna <parna.naveenkumar@gmail.com>
Subject: [PATCH] USB: OHCI: remove space before open square bracket '['
Date:   Thu, 16 May 2019 20:49:23 +0530
Message-Id: <20190516151923.16466-1-parna.naveenkumar@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naveen Kumar Parna <parna.naveenkumar@gmail.com>

This patch removes following checkpatch.pl error in usb/host/ohci-pci.c file.
ERROR: space prohibited before open square bracket '['

Signed-off-by: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
---
 drivers/usb/host/ohci-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-pci.c b/drivers/usb/host/ohci-pci.c
index fbcd34911025..a033f7d855e0 100644
--- a/drivers/usb/host/ohci-pci.c
+++ b/drivers/usb/host/ohci-pci.c
@@ -274,7 +274,7 @@ static const struct ohci_driver_overrides pci_overrides __initconst = {
 	.reset =		ohci_pci_reset,
 };
 
-static const struct pci_device_id pci_ids [] = { {
+static const struct pci_device_id pci_ids[] = { {
 	/* handle any USB OHCI controller */
 	PCI_DEVICE_CLASS(PCI_CLASS_SERIAL_USB_OHCI, ~0),
 	.driver_data =	(unsigned long) &ohci_pci_hc_driver,
-- 
2.17.1

