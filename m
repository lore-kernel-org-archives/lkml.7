Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285B5C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E836423402
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566494992;
	bh=y/o8gR2vvWI7XQe4CdqvH2MvoSSYXk9D2PFtuVz2B2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O5Ngtyqt81kVY1GTJYkM2Fe1+2kKM99N1tyGRdTlCr1vnAjSXE5k/koCf5HaeMlcI
	 94n4moBWJhXZzOiPbpsrJXKseK67mjPVi2xG7+pPjcNYzKAyLHIB5mE6bCtZPIVirb
	 pEem1GItFq4tCk+DtfW5Y+t9t/NICms204auUQbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392073AbfHVR3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:29:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404697AbfHVR0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:26:19 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7FB423400;
        Thu, 22 Aug 2019 17:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494779;
        bh=y/o8gR2vvWI7XQe4CdqvH2MvoSSYXk9D2PFtuVz2B2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2b8MmEQlJWiccxkPJ3HCE2zrITcpWZcFG6Tr2iS4vsxpPUQVJ421BtUh0VT1wrZ6Z
         heKAknghn7HCgaEgS5PwUvudWfDKOgrUgXj2XlyYuXippT8A4+5y14F0IvtnragNqF
         kJ+XFHR79OuFSjHEn89URBpJbcHRJQYQnkkTqhD4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 85/85] mmc: sdhci-of-arasan: Do now show error message in case of deffered probe
Date:   Thu, 22 Aug 2019 10:19:58 -0700
Message-Id: <20190822171734.734466747@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171731.012687054@linuxfoundation.org>
References: <20190822171731.012687054@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Simek <michal.simek@xilinx.com>

commit 60208a267208c27fa3f23dfd36cbda180471fa98 upstream.

When mmc-pwrseq property is passed mmc_pwrseq_alloc() can return
-EPROBE_DEFER because driver for power sequence provider is not probed
yet. Do not show error message when this situation happens.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-of-arasan.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -788,7 +788,8 @@ static int sdhci_arasan_probe(struct pla
 
 	ret = mmc_of_parse(host->mmc);
 	if (ret) {
-		dev_err(&pdev->dev, "parsing dt failed (%d)\n", ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "parsing dt failed (%d)\n", ret);
 		goto unreg_clk;
 	}
 


