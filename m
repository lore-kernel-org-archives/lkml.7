Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE7DC10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E650208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hbgt3b81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732891AbfC0F5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:57:10 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17586 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732652AbfC0F5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:57:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9b10b60000>; Tue, 26 Mar 2019 22:57:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 Mar 2019 22:57:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 26 Mar 2019 22:57:07 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 05:57:07 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 Mar 2019 05:57:07 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.161.83]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c9b10b10000>; Tue, 26 Mar 2019 22:57:06 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V1 04/26] spi: tegra114: use packed mode for 32 bits per word
Date:   Tue, 26 Mar 2019 22:56:25 -0700
Message-ID: <1553666207-11414-4-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553666230; bh=nxJ/g70fxh4cHoVO3iraTDJRTIxjf17l/F7PI++MEec=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=hbgt3b81vgBbYiXi+ub6FN+GB1/Tix7j3u6dD0WXJb3r//GFiWOUjxoz8nvblzRsh
         RZV6M5JwIXduk3MEOqQjtGGjH1R84zrVHidxEDVY2aPRYvS3jkJioID2ZKFK0Nomn7
         XYp7+25+AI/mZSEFZ7MWmsNhaQ8SFDBsqo1Mz4xtYq8Pgmck60wJ00XcIFDIy/ct1k
         PxDw+0jvVApbDvxXX7cg9VR0SG0BJMzP81K2JlVC0uHIvC/FZJH31Mz1kJUEOL3GRR
         BzxREulV7QF2CFFhtksTBqm8wjIanI/imrSL9hHrvSGYl1pblUg7p40MC2w9O8EdB3
         9384issVnNhig==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: Use packed mode for 32 bits per word transfers to increase
performance as each packet is a full 32-bit word.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index fdba302eb3b6..dc63536dbda4 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -259,7 +259,7 @@ static unsigned tegra_spi_calculate_curr_xfer_param(
 
 	tspi->bytes_per_word = DIV_ROUND_UP(bits_per_word, 8);
 
-	if (bits_per_word == 8 || bits_per_word == 16) {
+	if (bits_per_word == 8 || bits_per_word == 16 || bits_per_word == 32) {
 		tspi->is_packed = 1;
 		tspi->words_per_32bit = 32/bits_per_word;
 	} else {
-- 
2.7.4

