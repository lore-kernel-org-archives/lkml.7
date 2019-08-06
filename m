Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B5FC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA802070D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osk5U+XL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbfHFMcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 08:32:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44972 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfHFMcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 08:32:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so41530001pgl.11;
        Tue, 06 Aug 2019 05:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lV1YuQZ99UGBOPq70HJCVidBBglRZM90VerjusEDXcg=;
        b=osk5U+XLfVNbOfnfzlWLJc5+XUjU+JSOMH33BsfpqN9hP+1ET9L3db+UChl+HcfXGv
         eYsD1mp+f+aPsYq3vTfrsOR29noCbz0VzSyWJ+lq7CVpGKI88V/B5HQu+S3kJfvN66kG
         +QCWetDGPLqYuqThQBKpc4Ei5VWO/cRMmLn1KSOZvPuEgE1/YKcOQXEpPJQQekJzIh23
         eVSrL8ZQgjQiY0GOi0U8I2YmmO3Z9hl4Ne+RsrfTKWITCIDrENMS2QE2TLspRUIhMBin
         gQj1yDb355TF0eXcy4gzvEKwT+rLNQpROsjLrGZGhzC6JDaa605K25zACSiku97N7YLh
         lrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lV1YuQZ99UGBOPq70HJCVidBBglRZM90VerjusEDXcg=;
        b=WwLTeFjDqUlmWFv29WNK9spY5xpMSJJHpJYmfWlnkJtzJJbKdvtZ65jFBzmEtm9nVy
         FvCetiwWyzOxV+xhKjwBaIJ5gw6CWsE976URmowN0qxIqzo424tfnRGGGowHCKU7138C
         egrC4I0wk9Hb4QF7Z1D8IqHA82sEb/LxPoBkpM5Un62nDMK6U/G02OBShWgVYTy1PW2t
         gEbLOPIvMALiWSM4mFqWyLEw3lbz4zcO+Xc9r8hIIb1LXX+N+swVVt0y1BGSOapiRW2Q
         S0XLwtJSln8AZj7bYjR9yTa2U8BotyiHfVRXsT77ti1vlKKmAbRd05MFJsc7yGwhelTf
         sjoQ==
X-Gm-Message-State: APjAAAV/YP1sMKVhwj530+yaRh1g5EUo2ULtBPbH/CWbjtBWlxUgqufv
        OUdNmvLnWCjMpFZ8RUmDk3I=
X-Google-Smtp-Source: APXvYqyZXAWV0qNHDN63ndGyjzMoplTKc4ZgwZrvN8P/S8XfQ+a9QtS81uIKiw433oqThV/xDp12Wg==
X-Received: by 2002:a17:90a:3aed:: with SMTP id b100mr2978568pjc.63.1565094729807;
        Tue, 06 Aug 2019 05:32:09 -0700 (PDT)
Received: from localhost.localdomain ([163.152.162.125])
        by smtp.googlemail.com with ESMTPSA id a12sm15427778pgv.48.2019.08.06.05.32.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 05:32:08 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah@kernel.org, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH v4 0/2] usbip: Implement SG support
Date:   Tue,  6 Aug 2019 21:31:52 +0900
Message-Id: <20190806123154.23798-1-suwan.kim027@gmail.com>
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
 drivers/usb/usbip/stub_main.c    |  55 ++++++---
 drivers/usb/usbip/stub_rx.c      | 204 ++++++++++++++++++++++---------
 drivers/usb/usbip/stub_tx.c      |  99 +++++++++++----
 drivers/usb/usbip/usbip_common.c |  59 ++++++---
 drivers/usb/usbip/vhci_hcd.c     |  34 +++++-
 drivers/usb/usbip/vhci_tx.c      |  63 ++++++++--
 7 files changed, 395 insertions(+), 126 deletions(-)

-- 
2.20.1

