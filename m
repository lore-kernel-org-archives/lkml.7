Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D2DC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393E1217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRqnUaHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403989AbfHHPyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 11:54:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33022 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732698AbfHHPyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 11:54:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id n190so3470199pgn.0;
        Thu, 08 Aug 2019 08:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VyDwokBh+gB+QLTu7/5jPeaY9NH0VqDoEKwNk/RbWhI=;
        b=DRqnUaHfOxk+ETyvJEDDHGkCxanT22pETczAlBqhhChYFsDcmlSAQXssX3qlQ8gu24
         iInQMFtgNm2IoJsqLqZmy7uoAWNNl74yXXv/VRFcj9zZzm3OSPT6BuTME1fV7ZWylxnW
         qb/mGllJLsLbCqlB7TzXNybSoWP6tJPk43C7wTB/ewsmlejDLbbVksbODiRJYs87uube
         Ww5WBmTOxe0PO4uIS5qlEjklwfQUHl3m3aSPvM7TsWyZ2B4ROyHUoVMTOKOArUXCy7vZ
         kucmt5wEr4WkMVHEpmjmAuQMfP8N+F1e0CpurDUT2cTlIlhI1AAO2nOZxb+HKDPFO5M6
         2l1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VyDwokBh+gB+QLTu7/5jPeaY9NH0VqDoEKwNk/RbWhI=;
        b=bk/oYqefzQGcUergNTVslCoyE9U4eWGQWhpRRLR13nNtoujYDLtZQxMfC1vfdwxjtH
         GXp+EGOYEpaoCym7T1IvvxiNCfsTDv5oTeByk2HKVmxkByaPRjIZ9Hj5y31f7Kaj3AOX
         FqKL/p8huTVq0JnDAffXLI+nLRw8z/LILtEEedrGFUXjA/HQzKPNvIAJNGtdwFxCBSji
         ro+HfKs7TKexh/IJltDelLSS6JG21wJusJotKcfYUszM/2Sad6n6lXMbKvKYXSfosjWE
         Zxbac9NaKigNCO80PIK5De6bDNkJU2lZnlIG9ALusbiPKxRrFrgByzx/Ovk7HdmqwucT
         pCdg==
X-Gm-Message-State: APjAAAVu0BKWpk6VVwxS1h9b0v8M6IuqiIfwXpxgnNSoSxaCrLjD4qYN
        X1w9rjujNBE1XZaBYx/NgwQ=
X-Google-Smtp-Source: APXvYqw9ZQSQO7vlV6Y49qafIy9gSFCGZHMottQSp/lScMuom31vWWKU37bJ6r9q7/wIbeIM9G7CxQ==
X-Received: by 2002:a63:2004:: with SMTP id g4mr12726284pgg.97.1565279691949;
        Thu, 08 Aug 2019 08:54:51 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.googlemail.com with ESMTPSA id c98sm3054805pje.1.2019.08.08.08.54.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 08:54:51 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah@kernel.org, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH v5 0/2] usbip: Implement SG support
Date:   Fri,  9 Aug 2019 00:54:33 +0900
Message-Id: <20190808155435.10050-1-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are bugs on vhci with usb 3.0 storage device. In USB, each SG
list entry buffer should be divisible by the bulk max packet size.
But with native SG support, this problem doesn't matter because the
SG buffer is treated as contiguous buffer. But without native SG
support, USB storage driver breaks SG list into several URBs and the
error occurs because of a buffer size of URB that cannot be divided
by the bulk max packet size. The error situation is as follows.

When USB Storage driver requests 31.5 KB data and has SG list which
has 3584 bytes buffer followed by 7 4096 bytes buffer for some
reason. USB Storage driver splits this SG list into several URBs
because VHCI doesn't support SG and sends them separately. So the
first URB buffer size is 3584 bytes. When receiving data from device,
USB 3.0 device sends data packet of 1024 bytes size because the max
packet size of BULK pipe is 1024 bytes. So device sends 4096 bytes.
But the first URB buffer has only 3584 bytes buffer size. So host
controller terminates the transfer even though there is more data to
receive. So, vhci needs to support SG transfer to prevent this error.

In this patch, vhci supports SG regardless of whether the server's
host controller supports SG or not, because stub driver splits SG
list into several URBs if the server's host controller doesn't
support SG.

To support SG, vhci_map_urb_for_dma() sets URB_DMA_MAP_SG flag in
urb->transfer_flags if URB has SG list and this flag will tell stub
driver to use SG list.

vhci sends each SG list entry to stub driver. Then, stub driver sees
the total length of the buffer and allocates SG table and pages
according to the total buffer length calling sgl_alloc(). After stub
driver receives completed URB, it again sends each SG list entry to
vhci.

If the server's host controller doesn't support SG, stub driver
breaks a single SG request into several URBs and submits them to
the server's host controller. When all the split URBs are completed,
stub driver reassembles the URBs into a single return command and
sends it to vhci.

Alan fixed vhci bug with the USB 3.0 storage device by modifying
USB storage driver.
("usb-storage: Set virt_boundary_mask to avoid SG overflows")
But the fundamental solution of it is to add SG support to vhci.

This patch works well with the USB 3.0 storage devices without Alan's
patch, and we can revert Alan's patch if it causes some troubles.

Suwan Kim (2):
  usbip: Skip DMA mapping and unmapping for urb at vhci
  usbip: Implement SG support to vhci-hcd and stub driver

 drivers/usb/usbip/stub.h         |   7 +-
 drivers/usb/usbip/stub_main.c    |  57 ++++++---
 drivers/usb/usbip/stub_rx.c      | 204 ++++++++++++++++++++++---------
 drivers/usb/usbip/stub_tx.c      |  99 +++++++++++----
 drivers/usb/usbip/usbip_common.c |  59 ++++++---
 drivers/usb/usbip/vhci_hcd.c     |  34 +++++-
 drivers/usb/usbip/vhci_tx.c      |  63 ++++++++--
 7 files changed, 396 insertions(+), 127 deletions(-)

-- 
2.20.1

