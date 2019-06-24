Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B182C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FDC20645
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561370850;
	bh=vZY1sdaiS/R0D2sdp0wenPN2tIfc4eqi6KlHN8c41bY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r6AflzRL7B5IG/JDEjfxaPzcGKm2kuwmF2oKJ3Q6m+53LDSH88ymoJck1VRbjaJUZ
	 OT0w+yq0FAsni8imCmAGC1mgb77/PEC98h1Qb94Pc0eUXV/bP/9BLQ68Cwwm3VT5bi
	 ujRu6x+DBs6zy/1SSXABd/ddsBe3HS2/LJAAUH8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbfFXKH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:07:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730289AbfFXKHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:07:19 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B96782089F;
        Mon, 24 Jun 2019 10:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561370838;
        bh=vZY1sdaiS/R0D2sdp0wenPN2tIfc4eqi6KlHN8c41bY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X3FZ8jYhucJIoJ57xxHP4ugaXLGWcg5JE8u8qUVijKnkxZjXxT0T+A5qOYrXJjAWT
         fvjk2BaTBosUYYPdESdjHggk1oCqX2XOXHFRDr9R2WdeklkGBnellmF7MHB3vbe0sr
         cWm2vNAD5C3SvU6Xff33ls1xviGd9ax+zJLzqTfA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Raul E Rangel <rrangel@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.1 002/121] mmc: sdhci: sdhci-pci-o2micro: Correctly set bus width when tuning
Date:   Mon, 24 Jun 2019 17:55:34 +0800
Message-Id: <20190624092320.788914733@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092320.652599624@linuxfoundation.org>
References: <20190624092320.652599624@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raul E Rangel <rrangel@chromium.org>

commit 0f7b79a44e7d7dd3ef1f59758c1a341f217ff5e5 upstream.

The O2Micro controller only supports tuning at 4-bits. So the host driver
needs to change the bus width while tuning and then set it back when done.

There was a bug in the original implementation in that mmc->ios.bus_width
also wasn't updated. Thus setting the incorrect blocksize in
sdhci_send_tuning which results in a tuning failure.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Fixes: 0086fc217d5d7 ("mmc: sdhci: Add support for O2 hardware tuning")
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-pci-o2micro.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -124,6 +124,7 @@ static int sdhci_o2_execute_tuning(struc
 	 */
 	if (mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
 		current_bus_width = mmc->ios.bus_width;
+		mmc->ios.bus_width = MMC_BUS_WIDTH_4;
 		sdhci_set_bus_width(host, MMC_BUS_WIDTH_4);
 	}
 
@@ -135,8 +136,10 @@ static int sdhci_o2_execute_tuning(struc
 
 	sdhci_end_tuning(host);
 
-	if (current_bus_width == MMC_BUS_WIDTH_8)
+	if (current_bus_width == MMC_BUS_WIDTH_8) {
+		mmc->ios.bus_width = MMC_BUS_WIDTH_8;
 		sdhci_set_bus_width(host, current_bus_width);
+	}
 
 	host->flags &= ~SDHCI_HS400_TUNING;
 	return 0;


