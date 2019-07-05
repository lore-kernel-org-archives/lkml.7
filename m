Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9F2C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6010421670
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nejGd5n/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfGEQoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 12:44:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46860 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfGEQoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:44:18 -0400
Received: by mail-pl1-f195.google.com with SMTP id c2so3275599plz.13;
        Fri, 05 Jul 2019 09:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sJeCNY3p/cFJV5YjbkNxBrOSN1fSG/Fhqmle0nH3XgU=;
        b=nejGd5n/U2KC/Kjj4rnjP9Ocyey+yeGL2V2n9eNM74mJLE5Dtq4QX+0Dl6MFotYCqs
         WFFVzbcpq9H+UT1h7lReJDrCEimNiuR8Xi5cUbjzTh5lyCEFrmv2h/E0MiNloi9rX3GH
         e88Qcl172Jpn8nEaOvKfsKxIx8I3JLgeD4IBH5hRw0wG+JNvsw73/cZm5IvIOZileahD
         JGWM9+BeFbSKU/+dvubpvP7rtosuv7effagK9IU1LjpoGXPJAVf2pZB33Qv446jeGMi2
         DnI7uUgUeJ34vAosDhNc6c9IXmPWypcfRGH/dkukuMV98krdhN4OuNk1d7be2Fu9F2Ra
         2tiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sJeCNY3p/cFJV5YjbkNxBrOSN1fSG/Fhqmle0nH3XgU=;
        b=VPNZJAIYDk69MAauJCP6DzHqfF9Zo8pSq4fSOZFT9cPvcj7eRJ/XmlY+hHUKJESa0f
         FqRF8ilXXUZXdzJWGS9gTVJEh0fWmld2AcLBdDhf/ExHGZLyjKasmA+JImFw24WBBhEu
         37p9Zpl7vKj7aUAXd4IQ6WbRU5Z+O4Taf9JN+jvB/lx2zbxyvbhWJEzzecCm2v866dCd
         +X3RMCsKY0//2TuElWFPnLIWDNTKubHtVCrxf1yLK7BIxlAKDsCwrddcZkNp/h3op5vn
         pMWJhIXMCuaM1+4PLNbR5c4f92qfQMB+QnLhLmUgu6c4OZIOIVrUU9LemnyX7Eq2T7M5
         6Lfw==
X-Gm-Message-State: APjAAAUJrfZci5d5tYEy0Hv1hoepO1pzGglnjsYShBnHlV+RyTrGSEGw
        ZvzeLVWgEN+ePTJtyd5NGZ4=
X-Google-Smtp-Source: APXvYqxS0khdI/5kkPIXwsnPaRD4+hSBjMK4KBe2juLmPP4XyBf9RmQm2hgW4W4nofvVZ/1wUvTTfQ==
X-Received: by 2002:a17:902:106:: with SMTP id 6mr6861614plb.64.1562345057870;
        Fri, 05 Jul 2019 09:44:17 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.googlemail.com with ESMTPSA id n89sm22033297pjc.0.2019.07.05.09.44.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 09:44:17 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah@kernel.org, valentina.manea.m@gmail.com,
        stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH v2 0/2] usbip: Implement SG support
Date:   Sat,  6 Jul 2019 01:43:53 +0900
Message-Id: <20190705164355.14025-1-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are bugs on vhci with usb 3.0 storage device. Originally, vhci
doesn't supported SG, so USB storage driver on vhci breaks SG list
into multiple URBs and it causes error that a transfer got terminated
too early because the transfer length for one of the URBs was not
divisible by the maxpacket size.

To support SG, vhci doesn't map and unmap URB for DMA to use native
SG list (urb->num_sgs). In DMA mapping function of vhci, it sets
URB_DMA_MAP_SG flag in urb->transfer_flags if URB has SG list and
this flag will tell the stub driver to use SG list.

In this patch, vhci basically support SG and it sends each SG list
entry to the stub driver. Then, the stub driver sees the total length
of the buffer and allocates SG table and pages according to the total
buffer length calling sgl_alloc(). After the stub driver receives
completed URB, it again sends each SG list entry to vhci.

If HCD of the server doesn't support SG, the stub driver breaks a
single SG reqeust into several URBs and submit them to the server's
HCD. When all the split URBs are completed, the stub driver
reassembles the URBs into a single return command and sends it to
vhci.

Alan fixed vhci bug with the USB 3.0 storage device by modifying
USB storage driver.
("usb-storage: Set virt_boundary_mask to avoid SG overflows")
But the fundamental solution of it is to add SG support to vhci.

This patch works well with the USB 3.0 storage devices without Alan's
patch, and we can revert Alan's patch if it causes some troubles.

Suwan Kim (2):
  usbip: Skip DMA mapping and unmapping for urb at vhci
  usbip: Implement SG support to vhci

 drivers/usb/usbip/stub.h         |   7 +-
 drivers/usb/usbip/stub_main.c    |  52 +++++---
 drivers/usb/usbip/stub_rx.c      | 207 ++++++++++++++++++++++---------
 drivers/usb/usbip/stub_tx.c      | 108 +++++++++++-----
 drivers/usb/usbip/usbip_common.c |  60 +++++++--
 drivers/usb/usbip/vhci_hcd.c     |  29 ++++-
 drivers/usb/usbip/vhci_tx.c      |  49 ++++++--
 7 files changed, 391 insertions(+), 121 deletions(-)

-- 
2.20.1

