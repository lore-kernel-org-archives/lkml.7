Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF393CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832792064B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aoy0VAbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731520AbfJVJah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:30:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42219 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730247AbfJVJah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:30:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id f14so9573788pgi.9;
        Tue, 22 Oct 2019 02:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AY3OYRvRF5RCA7yU3JGcqprGc0jtpgyWsjOZL4oHax4=;
        b=Aoy0VAbqaffgC2nbxU/znUht1RKm4xrUw8n/Avw4sTOvXWBbqZ8cENv/vtZzvk7MB1
         VkI1GlRaxUkb08/wZBcP6ZAQmyx3q5Ucl+G4qgWaSWTUx30j7VvLSzOvOgdeHM3DCqnY
         hUEeyCoKOnjUn8/ipMB2QDtUvIflFiUzsHJWRpRn02p8oAQa5hGC0hBsTx2Wu6skueZY
         dLo0qNuxr4oqFbMrpZLqwN1DefSzrCJCSglzo2OYm3McMa7pIvRUhT6SSANYChxhZge/
         Ixw9EF9LaSpjJCCI19MA5+vY5JBWpbsON1DW/o3CqjqGOX0Iyv0daQezVz9GysOcsUzY
         ltsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AY3OYRvRF5RCA7yU3JGcqprGc0jtpgyWsjOZL4oHax4=;
        b=IpVtdDmdCmUMCAK4S6GxUA9q2mhxRbzObju/FZYk00QuBPOXeVAHVsfY2q1W0bIV5o
         ET/CMTKc1cnxWzgEqxvYX5NfdQhGJBShp2JyGZiRmwqsSuhLcySpCYWmTMMxPjA0Ym77
         em2H7BJCp47DfYWiSOnHviCZ1sPoJoQ9ZjJ4pbcjNTPtGXF0nMcSY9g0MfxZ2t54Age3
         vAAoFKBAbGoMZb5ryAHlUK8+CW1qcXCpINukjrSagif8jr2U8dWse4wH4+c/08Hswv9k
         /OimJmR2UFPrVMCWxLNEhUIkg3roLdm+JzVkdICXpxbqqH0sf0hct90hu7gF/zBsBYLM
         O5Eg==
X-Gm-Message-State: APjAAAXw+3GAU3Ag8CAXGp/hc0kzZ5//BNykwRAsFWmA0W49xHJ6tOMu
        DdSw2WERvRP4+GICvm0EzRo=
X-Google-Smtp-Source: APXvYqzkbMAPdGYoCpRe1Zf0/xdLKlHkHiGabYQu7GPEUV0MnRH1OOMXiYrlFI6dNnbB81dXPNkfEg==
X-Received: by 2002:a17:90a:e652:: with SMTP id ep18mr3570699pjb.72.1571736634787;
        Tue, 22 Oct 2019 02:30:34 -0700 (PDT)
Received: from localhost.localdomain ([163.152.162.99])
        by smtp.googlemail.com with ESMTPSA id h8sm2305528pjp.1.2019.10.22.02.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 02:30:34 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        julia.lawall@lip6.fr, valentina.manea.m@gmail.com,
        Suwan Kim <suwan.kim027@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v2] usbip: Fix free of unallocated memory in vhci tx
Date:   Tue, 22 Oct 2019 18:30:17 +0900
Message-Id: <20191022093017.8027-1-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iso_buffer should be set to NULL after use and free in the while loop.
In the case of isochronous URB in the while loop, iso_buffer is
allocated and after sending it to server, buffer is deallocated. And
then, if the next URB in the while loop is not a isochronous pipe,
iso_buffer still holds the previously deallocated buffer address and
kfree tries to free wrong buffer address.

Fixes: ea44d190764b ("usbip: Implement SG support to vhci-hcd and stub driver")
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
v1 - v2: Move the setting NULL after kfree() and add the comment
---
 drivers/usb/usbip/vhci_tx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/usbip/vhci_tx.c b/drivers/usb/usbip/vhci_tx.c
index c3803785f6ef..0ae40a13a9fe 100644
--- a/drivers/usb/usbip/vhci_tx.c
+++ b/drivers/usb/usbip/vhci_tx.c
@@ -147,7 +147,10 @@ static int vhci_send_cmd_submit(struct vhci_device *vdev)
 		}
 
 		kfree(iov);
+		/* This is only for isochronous case */
 		kfree(iso_buffer);
+		iso_buffer = NULL;
+
 		usbip_dbg_vhci_tx("send txdata\n");
 
 		total_size += txsize;
-- 
2.20.1

