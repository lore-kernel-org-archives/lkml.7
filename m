Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A380DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703DC2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="obRVUzr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbfCZLBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:01:12 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43140 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfCZLBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:01:11 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2QB19p7102305;
        Tue, 26 Mar 2019 06:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553598069;
        bh=ku81oAsnqeZFdnG26RoMO4726reaQTO8lKP1ZDSFY0A=;
        h=From:To:CC:Subject:Date;
        b=obRVUzr1/3UQmwEJ2hv8PSn2EOlfMU9pt/QsR7dnuARNuoM7c3DCnyHtSJJvqWe4V
         CEGckrULZms2XLXiqIkF45FwMEyZKPxNVIsa75p88xQOfzxKCeBOMYWQOrOCijZITK
         JuxiscamXmE6ihK9Zp+h40QX37iGJKeVSOjr3zFI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2QB19eU059993
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Mar 2019 06:01:09 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 26
 Mar 2019 06:01:08 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 26 Mar 2019 06:01:08 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2QB16Sg101424;
        Tue, 26 Mar 2019 06:01:06 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <kishon@ti.com>,
        <adrian.hunter@intel.com>, <faiz_abbas@ti.com>
Subject: [PATCH v4 0/2] Fix command errors during tuning
Date:   Tue, 26 Mar 2019 16:30:55 +0530
Message-ID: <20190326110057.7055-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches fix the following error message in dra7xx boards:

[4.833198] mmc1: Got data interrupt 0x00000002 even though no data
operation was in progress.

Tested with 100 times boot tests on dra71x-evm, dra72x-evm and
dra7xx-evm.

v4:
Fixed commit description for patch 1.
Added SDHCI_INT_TIMEOUT to CMD_ERR_MASK in patch 2.

v3:
Removed the command error specific callback and using the already
existing sdhci_irq callback instead. No measurable drop in performance.

v2:
Added EXPORT_SYMBOL_GPL for sdhci_cmd_err and sdhci_send_command to fix
errors when built as module.

Faiz Abbas (2):
  mmc: sdhci: Export sdhci_finish_command()
  mmc: sdhci-omap: Don't finish_mrq() on a command error during tuning

 drivers/mmc/host/sdhci-omap.c | 37 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c      |  3 ++-
 drivers/mmc/host/sdhci.h      |  1 +
 3 files changed, 40 insertions(+), 1 deletion(-)

-- 
2.19.2

