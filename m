Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BABC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB2E216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355485;
	bh=mKAMmo5lwnwFG02xpzRZChvX/xc2kbA2BzCwLAZ1sE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GeEh2vrNGYNDQpThP37risS4WZwj0tWzxgdXmDvn22AXE6D2mmvX/6rkIoT7yiR7a
	 M3gDglivgqYiMio7l0P+LTSiTl3MNxwkxhNVC0tk3I5npgEyyo0J2vE7nAqDfeymPs
	 EmwHbeBn0csxTayIoNh8Szste2/Tr46sddIOeET8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389894AbfETMbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:31:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732749AbfETMbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:31:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 422A120675;
        Mon, 20 May 2019 12:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355479;
        bh=mKAMmo5lwnwFG02xpzRZChvX/xc2kbA2BzCwLAZ1sE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pyJVsAz/lXOn+ivtpbf2k+FQQYbP6SaSgzlpVkIpvpMeZFxhPxzViyqXlZUFInrJ7
         XOSq7vDsWQKFJIVCNJtdeQ40WTDM0zP84mfAtse+fgisN/Jjkvw3k/VFmfYd0UTjfq
         Bqt9IYXx74KfEZJ8GDwk2YrqBJB24jCubdoXC4zM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.1 011/128] mmc: sdhci-of-arasan: Add DTS property to disable DCMDs.
Date:   Mon, 20 May 2019 14:13:18 +0200
Message-Id: <20190520115250.215156422@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115249.449077487@linuxfoundation.org>
References: <20190520115249.449077487@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Muellner <christoph.muellner@theobroma-systems.com>

commit 7bda9482e7ed4d27d83c1f9cb5cbe3b34ddac3e8 upstream.

Direct commands (DCMDs) are an optional feature of eMMC 5.1's command
queue engine (CQE). The Arasan eMMC 5.1 controller uses the CQHCI,
which exposes a control register bit to enable the feature.
The current implementation sets this bit unconditionally.

This patch allows to suppress the feature activation,
by specifying the property disable-cqe-dcmd.

Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: 84362d79f436 ("mmc: sdhci-of-arasan: Add CQHCI support for arasan,sdhci-5.1")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-of-arasan.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -832,7 +832,10 @@ static int sdhci_arasan_probe(struct pla
 		host->mmc_host_ops.start_signal_voltage_switch =
 					sdhci_arasan_voltage_switch;
 		sdhci_arasan->has_cqe = true;
-		host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
+		host->mmc->caps2 |= MMC_CAP2_CQE;
+
+		if (!of_property_read_bool(np, "disable-cqe-dcmd"))
+			host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
 	}
 
 	ret = sdhci_arasan_add_host(sdhci_arasan);


