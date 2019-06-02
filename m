Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2595C28CC3
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 01:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57E3277EF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 01:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfFBB3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 21:29:37 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:34600 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfFBB3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 21:29:10 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id B2BBD27E40; Sat,  1 Jun 2019 21:29:06 -0400 (EDT)
Message-Id: <cover.1559438652.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 0/7] NCR5380 drivers: fixes and improvements
Date:   Sun, 02 Jun 2019 11:24:12 +1000
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "Michael Schmitz" <schmitzmic@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        "Joshua Thompson" <funaho@jurai.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Among other improvements, this patch series fixes a data corruption bug
in the mac_scsi driver and a bug in the EH abort routine in the core
5380 driver.

For consistency I have ignored certain checkpatch.pl complaints about
the indentation in mac_scsi.c. The remaining complaints seem to be
false positives.

Some of these patches are not trivial to backport. Those patches have
been nominated for recent -stable branches only.


Finn Thain (7):
  Revert "scsi: ncr5380: Increase register polling limit"
  scsi: NCR5380: Always re-enable reselection interrupt
  scsi: NCR5380: Handle PDMA failure reliably
  scsi: mac_scsi: Increase PIO/PDMA transfer length threshold
  scsi: mac_scsi: Fix pseudo DMA implementation, take 2
  scsi: mac_scsi: Enable PDMA on Mac IIfx
  scsi: mac_scsi: Treat Last Byte Sent time-out as failure

 arch/m68k/include/asm/mac_pdma.h | 179 ++++++++++++++++++++++
 arch/m68k/mac/config.c           |  10 +-
 drivers/scsi/NCR5380.c           |  18 +--
 drivers/scsi/NCR5380.h           |   2 +-
 drivers/scsi/mac_scsi.c          | 249 +++++++++++--------------------
 5 files changed, 280 insertions(+), 178 deletions(-)
 create mode 100644 arch/m68k/include/asm/mac_pdma.h

-- 
2.21.0

