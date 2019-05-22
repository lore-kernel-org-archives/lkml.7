Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1461CC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E427C20863
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbfEVO1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 10:27:54 -0400
Received: from inva020.nxp.com ([92.121.34.13]:42188 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728491AbfEVO1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 10:27:54 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 060FD1A0197;
        Wed, 22 May 2019 16:27:52 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id ED9B11A000F;
        Wed, 22 May 2019 16:27:51 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.82.13])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 6C72E205ED;
        Wed, 22 May 2019 16:27:51 +0200 (CEST)
From:   laurentiu.tudor@nxp.com
To:     hch@lst.de, stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, marex@denx.de
Cc:     leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, noring@nocrew.org, JuergenUrban@gmx.de,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v6 0/5] prerequisites for device reserved local mem rework
Date:   Wed, 22 May 2019 17:27:43 +0300
Message-Id: <20190522142748.10078-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

For HCs that have local memory, replace the current DMA API usage
with a genalloc generic allocator to manage the mappings for these
devices.
This is in preparation for dropping the existing "coherent" dma
mem declaration APIs. Current implementation was relying on a short
circuit in the DMA API that in the end, was acting as an allocator
for these type of devices.

Only compiled tested, so any volunteers willing to test are most welcome.

Thank you!

For context, see thread here: https://lkml.org/lkml/2019/4/22/357

Changes in v6:
 - drop some unneeded initializations (Alan)
 - use device name for genpool instead of misleading "ohci-hcd" (Alan)
 - updated some comments (Alan, Fredrik)
 - added Tested-By tags

Changes in v5:
 - updated first patch to preserve bisectability (Christoph, Greg)
 - fixed a few more places where dma api was still being
   used (e.g. td_alloc, ed_alloc) (Fredrik)
 - included patch from Fredrik adding gen_pool_dma_zalloc() api
 - added patch that drops HCD_LOCAL_MEM altogether (Greg)
 - set td_cache / ed_cache to null for devices with local mem (Fredrik)
 - introduce usb_hcd_setup_local_mem() that sets up the genalloc
   pool for drivers and updated drivers to use it

Changes in v4:
 - created mapping for local mem
 - fix genalloc misuse

Changes in v3:
 - rearranged calls into genalloc simplifying the code a bit (Christoph)
 - dropped RFC prefix

Changes in v2:
 - use genalloc also in core usb (based on comment from Robin)
 - moved genpool decl to usb_hcd to be accesible from core usb

Fredrik Noring (1):
  lib/genalloc.c: Add gen_pool_dma_zalloc() for zeroed DMA allocations

Laurentiu Tudor (4):
  USB: use genalloc for USB HCs with local memory
  usb: host: ohci-sm501: init genalloc for local memory
  usb: host: ohci-tmio: init genalloc for local memory
  USB: drop HCD_LOCAL_MEM flag

 drivers/usb/core/buffer.c      | 17 ++++++++----
 drivers/usb/core/hcd.c         | 51 ++++++++++++++++++++++++++++------
 drivers/usb/host/ehci-hcd.c    |  2 +-
 drivers/usb/host/fotg210-hcd.c |  2 +-
 drivers/usb/host/ohci-hcd.c    | 25 +++++++++++++----
 drivers/usb/host/ohci-mem.c    | 35 ++++++++++++++++++++---
 drivers/usb/host/ohci-sm501.c  | 50 +++++++++++++++------------------
 drivers/usb/host/ohci-tmio.c   | 15 ++++------
 drivers/usb/host/ohci.h        |  2 ++
 drivers/usb/host/uhci-hcd.c    |  2 +-
 include/linux/genalloc.h       |  1 +
 include/linux/usb/hcd.h        |  6 +++-
 lib/genalloc.c                 | 29 ++++++++++++++++++-
 13 files changed, 171 insertions(+), 66 deletions(-)

-- 
2.17.1

