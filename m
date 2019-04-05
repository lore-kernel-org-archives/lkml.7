Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA1FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0777F217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ntTFE+5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbfDEAO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:14:26 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11293 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730291AbfDEAOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 20:14:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca69ddd0000>; Thu, 04 Apr 2019 17:14:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Apr 2019 17:14:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Apr 2019 17:14:23 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Apr
 2019 00:14:23 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 5 Apr 2019 00:14:23 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.48]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ca69dde0000>; Thu, 04 Apr 2019 17:14:22 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V2 02/20] spi: tegra114: use unpacked mode for below 4 bytes
Date:   Thu, 4 Apr 2019 17:14:01 -0700
Message-ID: <1554423259-26056-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554423261; bh=NxSfVg0/vtVUkdE/HrUoF3WbI4gXkUlKWeU8EHPEa88=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ntTFE+5MYSCXIqVshpRs/Z8GGvt79tr1bdmSDEQR7lpIpCEfFjyzrVIg6W2Ax43DG
         qAe+qbz5/nhwkObzQMoOrnanPT7mKdzvayq8MSYSgUej2JOQbZ2exVZfQKe8PQsvRt
         /0XpMyvN0O6E/UDdyYs7fkGFWzLMon2UeWAw9O0i6qA8htEeFltFDGhtH03KJ+xffF
         mgwO1C9NXKzsPkd7m6aa6FPeZV3CpuniYFwMZOdHdMO8iBEKiEZdjalYsa4T6mQ7zT
         M8f5udTJJIEH3FlQgnukBMMgQrk0Dy+HC+AZgSYnYp+M0ForGuxLmfvLy6/M3xBurH
         XQwV3b1aUuqbQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Packed mode expects minimum transfer length of 4 bytes.

This patch fixes this by using unpacked mode for transfers less
than 4 bytes.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index ba1639310282..3042521c3785 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -259,7 +259,8 @@ static unsigned tegra_spi_calculate_curr_xfer_param(
 
 	tspi->bytes_per_word = DIV_ROUND_UP(bits_per_word, 8);
 
-	if (bits_per_word == 8 || bits_per_word == 16 || bits_per_word == 32) {
+	if ((bits_per_word == 8 || bits_per_word == 16 ||
+	     bits_per_word == 32) && t->len > 3) {
 		tspi->is_packed = 1;
 		tspi->words_per_32bit = 32/bits_per_word;
 	} else {
-- 
2.7.4

