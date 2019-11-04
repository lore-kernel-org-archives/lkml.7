Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD33CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B071C2084D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572905420;
	bh=POiwKFsH0Wle4YX/WH4j8W3xRz5qrUbxx3XDCsvrQbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OAr61TZUzNA7HUHk+IGxnLVrMokR3EYCOUm1n06Uo/oA7l/HK2R7bmLH/1DbYj7lw
	 3hmOzea3Vz9l7jsviOx5gkCfIwKIfFEHQdaajy0Q+4+r/Z8zE7nRnNCbc7Htk+eaKs
	 exgU/CiYL7C74gLcDV5LkYki+mofXyGo7LfFAlyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390521AbfKDWKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:10:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:43406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387536AbfKDWKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:10:14 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A6BD20650;
        Mon,  4 Nov 2019 22:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572905412;
        bh=POiwKFsH0Wle4YX/WH4j8W3xRz5qrUbxx3XDCsvrQbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H9lcvuO4E8PC6fdOx356cj9B667GuN8Q6RcL3LJttWw4FOuIDgaI/8MTMcBO2fvTg
         z2Qlfcq8/eKNxagd+9gLvDwETfOgOmjg5Fin4wo/Hok7UnWD4x+6KtBaNNVB2KX3qj
         pbg/XvtlKMjunDazUa9xzZFGn03Lz/xiMlNOuawI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@vger.kernel,
        Robin Gong <yibin.gong@nxp.com>,
        Jurgen Lambrecht <J.Lambrecht@TELEVIC.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.3 135/163] dmaengine: imx-sdma: fix size check for sdma script_number
Date:   Mon,  4 Nov 2019 22:45:25 +0100
Message-Id: <20191104212150.121863340@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212140.046021995@linuxfoundation.org>
References: <20191104212140.046021995@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

commit bd73dfabdda280fc5f05bdec79b6721b4b2f035f upstream.

Illegal memory will be touch if SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3
(41) exceed the size of structure sdma_script_start_addrs(40),
thus cause memory corrupt such as slob block header so that kernel
trap into while() loop forever in slob_free(). Please refer to below
code piece in imx-sdma.c:
for (i = 0; i < sdma->script_number; i++)
	if (addr_arr[i] > 0)
		saddr_arr[i] = addr_arr[i]; /* memory corrupt here */
That issue was brought by commit a572460be9cf ("dmaengine: imx-sdma: Add
support for version 3 firmware") because SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3
(38->41 3 scripts added) not align with script number added in
sdma_script_start_addrs(2 scripts).

Fixes: a572460be9cf ("dmaengine: imx-sdma: Add support for version 3 firmware")
Cc: stable@vger.kernel
Link: https://www.spinics.net/lists/arm-kernel/msg754895.html
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Reported-by: Jurgen Lambrecht <J.Lambrecht@TELEVIC.com>
Link: https://lore.kernel.org/r/1569347584-3478-1-git-send-email-yibin.gong@nxp.com
[vkoul: update the patch title]
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/imx-sdma.c                     |    8 ++++++++
 include/linux/platform_data/dma-imx-sdma.h |    3 +++
 2 files changed, 11 insertions(+)

--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1707,6 +1707,14 @@ static void sdma_add_scripts(struct sdma
 	if (!sdma->script_number)
 		sdma->script_number = SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1;
 
+	if (sdma->script_number > sizeof(struct sdma_script_start_addrs)
+				  / sizeof(s32)) {
+		dev_err(sdma->dev,
+			"SDMA script number %d not match with firmware.\n",
+			sdma->script_number);
+		return;
+	}
+
 	for (i = 0; i < sdma->script_number; i++)
 		if (addr_arr[i] > 0)
 			saddr_arr[i] = addr_arr[i];
--- a/include/linux/platform_data/dma-imx-sdma.h
+++ b/include/linux/platform_data/dma-imx-sdma.h
@@ -51,7 +51,10 @@ struct sdma_script_start_addrs {
 	/* End of v2 array */
 	s32 zcanfd_2_mcu_addr;
 	s32 zqspi_2_mcu_addr;
+	s32 mcu_2_ecspi_addr;
 	/* End of v3 array */
+	s32 mcu_2_zqspi_addr;
+	/* End of v4 array */
 };
 
 /**


