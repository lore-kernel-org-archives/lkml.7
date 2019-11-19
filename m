Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBADC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01352218BA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142284;
	bh=36z5BUggWpUohDKvMWsMdKHgnLJ/TsBubSnnojh1NdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=azfyCIwCyanox8SAVUFx+B7SiDJjx3FOQGtGaEnmMb5yy4ij8ltzkXl0tsP+bKh+p
	 Ea8ZfYU0wlLKgwV+g00/+orROqS0527otmOmoDE/Ca/KmKIAj1fVP18+qOCQ5mihcc
	 UTwZ8eAPSfZPA/uJrd56vFJKyMtssaTupqKw1Gz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbfKSFom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:44:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:40098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729374AbfKSFok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:44:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18E10208C3;
        Tue, 19 Nov 2019 05:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142279;
        bh=36z5BUggWpUohDKvMWsMdKHgnLJ/TsBubSnnojh1NdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZZ0pEnbA6sOiGvmT9BM7ttzQJJ/E5F/Nh06sz6AngDfTYd81/m4J+tMV41E2dXwCH
         0GWvWRtVzTvwSOOIiGzAQKdCxodBrkdGj5ASRJRXySe0JsHMso6oU2UDyPmHFqngpT
         eKzgVTujZS21AnE3hao8wGtROADWdG+rDUJVc/gQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.14 027/239] mmc: sdhci-of-at91: fix quirk2 overwrite
Date:   Tue, 19 Nov 2019 06:17:07 +0100
Message-Id: <20191119051303.020618457@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

commit fed23c5829ecab4ddc712d7b0046e59610ca3ba4 upstream.

The quirks2 are parsed and set (e.g. from DT) before the quirk for broken
HS200 is set in the driver.
The driver needs to enable just this flag, not rewrite the whole quirk set.

Fixes: 7871aa60ae00 ("mmc: sdhci-of-at91: add quirk for broken HS200")
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-of-at91.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -365,7 +365,7 @@ static int sdhci_at91_probe(struct platf
 	pm_runtime_use_autosuspend(&pdev->dev);
 
 	/* HS200 is broken at this moment */
-	host->quirks2 = SDHCI_QUIRK2_BROKEN_HS200;
+	host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
 
 	ret = sdhci_add_host(host);
 	if (ret)


