Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1510C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6446222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388491AbfJDNpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:45:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:40870 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387917AbfJDNpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:45:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 01C0AAFAE;
        Fri,  4 Oct 2019 13:45:08 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     wahrenst@gmx.net, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mmc: sdhci-iproc: fix spurious interrupts on Multiblock reads with bcm2711
Date:   Fri,  4 Oct 2019 15:44:52 +0200
Message-Id: <20191004134452.6493-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Raspberry Pi 4 SDHCI hardware seems to automatically issue CMD12
after multiblock reads even when ACMD12 is disabled. This triggers
spurious interrupts after the data transfer is done with the following
message:

  mmc1: Got data interrupt 0x00000002 even though no data operation was in progress.
  mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
  mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00001002
  mmc1: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000000
  mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000033
  mmc1: sdhci: Present:   0x1fff0000 | Host ctl: 0x00000017
  mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000080
  mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
  mmc1: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
  mmc1: sdhci: Int enab:  0x03ff100b | Sig enab: 0x03ff100b
  mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
  mmc1: sdhci: Caps:      0x45ee6432 | Caps_1:   0x0000a525
  mmc1: sdhci: Cmd:       0x00000c1a | Max curr: 0x00080008
  mmc1: sdhci: Resp[0]:   0x00000b00 | Resp[1]:  0x00edc87f
  mmc1: sdhci: Resp[2]:   0x325b5900 | Resp[3]:  0x00400e00
  mmc1: sdhci: Host ctl2: 0x00000001
  mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xf3025208
  mmc1: sdhci: ============================================

Enable SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 to enable ACMD12 on multiblock
reads and suppress the spurious interrupts.

Fixes: f84e411c85be ("mmc: sdhci-iproc: Add support for emmc2 of the BCM2711")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Tested-by: Matthias Brugger <mbrugger@suse.com>
Acked-by: Stefan Wahren <wahrenst@gmx.net>
---

Changes since v1:
- Add Fixes tag and Acked-by

 drivers/mmc/host/sdhci-iproc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 2b9cdcd1dd9d..f4f5f0a70cda 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -262,6 +262,7 @@ static const struct sdhci_iproc_data bcm2835_data = {
 };
 
 static const struct sdhci_pltfm_data sdhci_bcm2711_pltfm_data = {
+	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
 	.ops = &sdhci_iproc_32only_ops,
 };
 
-- 
2.23.0

