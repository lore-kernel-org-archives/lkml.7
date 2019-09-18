Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2986FC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0E021906
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568788200;
	bh=Ijnvi18yIb3tKJGAmf6kgahLWvjc+PpNXmwU2/JVY60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1MIAXnnGT97aZuaLHHN04uXrqcfK/k2quzbK01ym9WBSA2EpRVkdG0Mr17ECUUMdT
	 VQZFz1evFBuoz78Hq87JAPr8oPjLc6A24o+PChte3YVxa5f1NrHqJrLPkV8zdvJqLt
	 jx5xU+uYLg/fE+Squ6nnpgxwP6gwmM1ipabxyQa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbfIRGZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:25:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730076AbfIRGZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:25:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 414E121928;
        Wed, 18 Sep 2019 06:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568787911;
        bh=Ijnvi18yIb3tKJGAmf6kgahLWvjc+PpNXmwU2/JVY60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DG9TvzeNhwoifb6/sUSCkBNGgatH8AmZOnNDaV1tgFB5HjgoyBEER7e5WfqUH0aSC
         khsKOiuP8kgryytTF9oej5ey59TauegfTO/a2VM/YUR6915/ltov7+4pABpiQsMKXT
         zIGG67zg06Gu1VNQDC86IBP+/pZWPnH9cFgiTB+k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.2 29/85] Revert "mmc: sdhci: Remove unneeded quirk2 flag of O2 SD host controller"
Date:   Wed, 18 Sep 2019 08:18:47 +0200
Message-Id: <20190918061235.078125892@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061234.107708857@linuxfoundation.org>
References: <20190918061234.107708857@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Drake <drake@endlessm.com>

commit 49baa01c8b99ef92958e18fb58ebeb5dfdcde8af upstream.

This reverts commit 414126f9e5abf1973c661d24229543a9458fa8ce.

This commit broke eMMC storage access on a new consumer MiniPC based on
AMD SoC, which has eMMC connected to:

02:00.0 SD Host controller: O2 Micro, Inc. Device 8620 (rev 01) (prog-if 01)
	Subsystem: O2 Micro, Inc. Device 0002

During probe, several errors are seen including:

  mmc1: Got data interrupt 0x02000000 even though no data operation was in progress.
  mmc1: Timeout waiting for hardware interrupt.
  mmc1: error -110 whilst initialising MMC card

Reverting this commit allows the eMMC storage to be detected & usable
again.

Signed-off-by: Daniel Drake <drake@endlessm.com>
Fixes: 414126f9e5ab ("mmc: sdhci: Remove unneeded quirk2 flag of O2 SD host
controller")
Cc: stable@vger.kernel.org # v5.1+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-pci-o2micro.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -432,7 +432,6 @@ int sdhci_pci_o2_probe_slot(struct sdhci
 					mmc_hostname(host->mmc));
 				host->flags &= ~SDHCI_SIGNALING_330;
 				host->flags |= SDHCI_SIGNALING_180;
-				host->quirks2 |= SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD;
 				host->mmc->caps2 |= MMC_CAP2_NO_SD;
 				host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
 				pci_write_config_dword(chip->pdev,
@@ -682,6 +681,7 @@ static const struct sdhci_ops sdhci_pci_
 const struct sdhci_pci_fixes sdhci_o2 = {
 	.probe = sdhci_pci_o2_probe,
 	.quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.quirks2 = SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD,
 	.probe_slot = sdhci_pci_o2_probe_slot,
 #ifdef CONFIG_PM_SLEEP
 	.resume = sdhci_pci_o2_resume,


