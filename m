Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEE3C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E072146E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvi9/wHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403779AbfFKFuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 01:50:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54603 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390485AbfFKFuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 01:50:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id g135so1437698wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 22:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=luMUphPTUItEvu7Yvl1pymkCcMxfGlVnxTLaFSA/45U=;
        b=lvi9/wHhpNt2n0xuCFni5c+8hs3SIwI5s8apvu43t5A2XIphAaR1l7Xlj8aTDow+vJ
         ybe6B7WY2dK4tkBafd5vY+ErM3tCZrjYQeuKaYBb8O5IVYnW3xTUYWYqH81rq/ozH+9M
         43QWxVlx1JzmFEzbJZmRG8xmEix0wz1YuGQIuk12gsAuhIVi4FNxJDmtOEFMu+5WbRKA
         iCcb6FgsIY46FShYiEvXmGTm0TDM8YBlNLbWTH0H8Re51x2NCepRpWpoTZyQqSRbs5Ed
         5YpvRY2id1DGllQkHgOLGtOCtCwYOHBvTPWp58RgW7XMvyQbNo9IYLVD1penIGbbJ749
         gYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=luMUphPTUItEvu7Yvl1pymkCcMxfGlVnxTLaFSA/45U=;
        b=eTrVQcrWPpka10twjgGrLEZBsCfxuYDmRzhE+UKwlx1g+vFeeHs4WY6txZ/77vVaed
         VkxZmsomr5Xq5wzTQ30kAaqo5phCBheEHDjh5SyALgWcV/6jbEb9nynlhfzLVRuWqW9j
         68R7DvXcClyTKa7n09Zq29IH7XdFcvsYdSE5H9ePsAicswcVvoaesIJfi+UY/n0bKf5N
         VRJbvV8rJUsxFJCE3RByOKx4WKkYApFASJADQITzUZrlrNfHJRqichRcm2cuRKHUPLTc
         oWmBKFDeB5kOvHdQXY4c4kBgL4DxPIVmsus/fWnT5oMRoOO5JyZ+B7qsMhzX3BkiulF6
         BfJg==
X-Gm-Message-State: APjAAAUILVqB4X9nnqGsXTkQLCI/t9phGc2yCBYUsFCo8KZFsMXAwb88
        FvkkuCyc9aSxi6/LGeXkOizr92NRwWA=
X-Google-Smtp-Source: APXvYqzUKt6cJmco8x1nTJBAsKU0iK1prZvtfwvaLbGaWrGi2d5dX/NNXOlJuV6J9d1wh7Jc7bwxLg==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr16954524wmk.67.1560232248186;
        Mon, 10 Jun 2019 22:50:48 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id j8sm11968056wrr.64.2019.06.10.22.50.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 22:50:47 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 0/8] Fixing DMA mask issues in habanalabs driver
Date:   Tue, 11 Jun 2019 08:50:37 +0300
Message-Id: <20190611055045.15945-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set changes the way the Goya internal CPU access memory on the
Host machine. This is needed to prevent the non-standard way the driver
used the PCI DMA set mask kernel API so far.

The DMA set mask should be called only once at the start of the driver.
This is because changing the DMA mask to a new value after allocations
were made using a previous mask value, might cause the previous allocations
to become unaccessible (usually if there is IOMMU present).

The driver did that because of a limitation in Goya's internal CPU. The
limitation was that the internal CPU can only access 40-bit addresses,
while the entire ASIC can access 50-bit addresses. Therefore, the driver
set the DMA mask to 39-bits, allocated memory for the internal CPU on the
host and then changed the DMA mask to 48-bits.

This patch-set eliminates the double DMA set by using Goya's MMU to
overcome the limitation. The driver now sets the DMA mask only once to
48-bits and allocates a single DMA region of 2MB for the internal CPU. It
then maps that region in Goya's MMU to a device virtual address under 40-bits.

In addition, this patch-set enables the use of 64-bit mask on POWER9
systems. POWER9 DMA mask can be set ONLY to 32-bit or 64-bit. To use
64-bit, the device must set bit 59 to 1 in all its outbound transactions. 
This is achieved by setting a special configuration in Goya's PCIe
controller. The configuration must be done only in POWER9 machines, as it
will make the device non-functional on other architectures 
(e.g. x86-64, ARM).

Thanks,
Oded

Oded Gabbay (8):
  habanalabs: initialize device CPU queues after MMU init
  habanalabs: de-couple MMU and VM module initialization
  habanalabs: initialize MMU context for driver
  habanalabs: add MMU mappings for Goya CPU
  habanalabs: set Goya CPU to use ASIC MMU
  habanalabs: remove DMA mask hack for Goya
  habanalabs: add WARN in case of bad MMU mapping
  habanalabs: enable 64-bit DMA mask in POWER9

 drivers/misc/habanalabs/asid.c           |   2 +-
 drivers/misc/habanalabs/context.c        |   7 +
 drivers/misc/habanalabs/debugfs.c        |   7 +-
 drivers/misc/habanalabs/device.c         |  45 +++--
 drivers/misc/habanalabs/goya/goya.c      | 234 +++++++++++++++++------
 drivers/misc/habanalabs/goya/goyaP.h     |  12 +-
 drivers/misc/habanalabs/habanalabs.h     |   9 +-
 drivers/misc/habanalabs/habanalabs_drv.c |   7 +
 drivers/misc/habanalabs/memory.c         |  13 +-
 drivers/misc/habanalabs/mmu.c            |  20 +-
 drivers/misc/habanalabs/pci.c            |   7 +-
 11 files changed, 259 insertions(+), 104 deletions(-)

-- 
2.17.1

