Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09AFC7618E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 07:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999E7214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 07:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nasledov.com header.i=@nasledov.com header.b="Pa5C7HU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfGOHSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 03:18:48 -0400
Received: from smtpauth.rollernet.us ([208.79.240.5]:48342 "EHLO
        smtpauth.rollernet.us" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728933AbfGOHSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 03:18:47 -0400
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jul 2019 03:18:47 EDT
Received: from smtpauth.rollernet.us (localhost [127.0.0.1])
        by smtpauth.rollernet.us (Postfix) with ESMTP id 6731F280004A;
        Mon, 15 Jul 2019 00:11:59 -0700 (PDT)
Received: from nasledov.com (nasledov.com [75.144.249.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by smtpauth.rollernet.us (Postfix) with ESMTPSA;
        Mon, 15 Jul 2019 00:11:49 -0700 (PDT)
Received: by nasledov.com (Postfix, from userid 1000)
        id A807C14829BD; Mon, 15 Jul 2019 00:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nasledov.com; s=mail;
        t=1563174709; bh=TtNNBwEpjBsBg6ISjw7/qkj3/mPcz2YfzwhjRZvZjPM=;
        h=Date:From:To:Cc:Subject:From;
        b=Pa5C7HU/YCGNsub8ChHmDuu+7DgMi5nmstTWfGH/IGIHJD56/NYLRzfowIYMaf7kU
         F95nvH40wfIcc279lmjt0G+DsrK+ycExG35cxceu3VP+W8acMcGs9ZQFAdIso+NEkO
         yRAmnEeJ8uAIIzrTgoT17T/itlNVvH0DsKg/S96A2wAQkWaYaUuSJ6367dnCd6w26M
         8oWYG2zVu2TdCACAATzpVROm8sxEWqe8bVEyMFZlZquZUqrtS9/xhBHIuBxjq2V9RN
         VFQP9HJDdtt+M4Yf9jXZJLdsItwVT25OZ3enDD5Kod01YItFBJGhneV6kAuoXCQmmd
         gzyC3FEcHIWZw==
Date:   Mon, 15 Jul 2019 00:11:49 -0700
From:   Misha Nasledov <misha@nasledov.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NVME: ignore subnqn for ADATA SX6000LNP
Message-ID: <20190715071149.GA24206@nasledov.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Rollernet-Abuse: Processed by Roller Network Mail Services. Contact abuse@rollernet.us to report violations. Abuse policy: http://www.rollernet.us/policy
X-Rollernet-Submit: Submit ID 4097.5d2c2735.e998b.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADATA SX6000LNP NVMe SSDs have the same subnqn and, due to this,
a system with more than one of these SSDs will only have one usable.

[ 0.942706] nvme nvme1: ignoring ctrl due to duplicate subnqn (nqn.2018-05.com.example:nvme:nvm-subsystem-OUI00E04C).
[ 0.943017] nvme nvme1: Removing after probe failure status: -22

# lspci | grep Non-Volatile
02:00.0 Non-Volatile memory controller [0108]: Realtek Semiconductor Co., Ltd. Device [10ec:5762] (rev 01)
71:00.0 Non-Volatile memory controller [0108]: Realtek Semiconductor Co., Ltd. Device [10ec:5762] (rev 01)

There are no firmware updates available from the vendor,
unfortunately. Applying the NVME_QUIRK_IGNORE_DEV_SUBNQN quirk for
these SSDs resolves the issue, and they all work after this patch:

# nvme list
/dev/nvme0n1     2J1120050420         ADATA SX6000LNP [...]
/dev/nvme1n1     2J1120050540         ADATA SX6000LNP [...]

Signed-off-by: Misha Nasledov <misha@nasledov.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 189352081994..762ae6927689 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3005,6 +3005,8 @@ static const struct pci_device_id nvme_id_table[] = {
        { PCI_VDEVICE(INTEL, 0x5845),   /* Qemu emulated controller */
                .driver_data = NVME_QUIRK_IDENTIFY_CNS |
                                NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+       { PCI_DEVICE(0x10ec, 0x5762),   /* ADATA SX6000LNP */
+               .driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
        { PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
                .driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
        { PCI_DEVICE(0x1c58, 0x0003),   /* HGST adapter */

-- 
Misha Nasledov <misha@nasledov.com>
GPG: A063 B99A 2BD3 2D48 F2D7 8E68 0F27 4D21 948F 8F06
