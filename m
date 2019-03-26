Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3B5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFE72087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582329;
	bh=ZYkinD2QvCwncyJKQKp02rtjgOZSAVqW29jVdDmjfR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rh11+HMWaLsQeoRk+uE5VaGNRY1m+y28uUucwnxbH1Zcsejhe8Biavzf8mTZhEe3i
	 8aFoS0zR3Pxe4yXfLRJI5K4RDHQhxO1s7vUNvm2XCooHB2vNmEQx+ySpc0T1d9OC1m
	 ScFOa/QG/RMr9FVSvWWiIs0r4HcZ9lrKMXvpzSsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbfCZGir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:38:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732579AbfCZGio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:38:44 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5F1D2087C;
        Tue, 26 Mar 2019 06:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582324;
        bh=ZYkinD2QvCwncyJKQKp02rtjgOZSAVqW29jVdDmjfR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gGY8N1KVKt2wja/cmabvRtK6TsS6pBnZ92VcVsOEU7RPkxZeLeJWANV4Ipozfo+gY
         JBXRXjSUDOBqQZyGm6lFAkWHIw1CvZ2PpwnjMBRMCyrU8lJWGk0ymIHCrWRiEfX7iQ
         /w4rkYPR8zwXn8UW2drvd8Ba7aogvecadS4n7WtM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Phong Hoang <phong.hoang.wz@renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.0 06/52] mmc: renesas_sdhi: limit block count to 16 bit for old revisions
Date:   Tue, 26 Mar 2019 15:29:53 +0900
Message-Id: <20190326042701.287677548@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
References: <20190326042700.963224437@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit c9a9497ccef205ed4ed2e247011382627876d831 upstream.

R-Car Gen2 has two different SDHI incarnations in the same chip. The
older one does not support the recently introduced 32 bit register
access to the block count register. Make sure we use this feature only
after the first known version.

Thanks to the Renesas Testing team for this bug report!

Fixes: 5603731a15ef ("mmc: tmio: fix access width of Block Count Register")
Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Tested-by: Phong Hoang <phong.hoang.wz@renesas.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/renesas_sdhi_core.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -634,6 +634,7 @@ int renesas_sdhi_probe(struct platform_d
 	struct renesas_sdhi *priv;
 	struct resource *res;
 	int irq, ret, i;
+	u16 ver;
 
 	of_data = of_device_get_match_data(&pdev->dev);
 
@@ -766,12 +767,17 @@ int renesas_sdhi_probe(struct platform_d
 	if (ret)
 		goto efree;
 
+	ver = sd_ctrl_read16(host, CTL_VERSION);
+	/* GEN2_SDR104 is first known SDHI to use 32bit block count */
+	if (ver < SDHI_VER_GEN2_SDR104 && mmc_data->max_blk_count > U16_MAX)
+		mmc_data->max_blk_count = U16_MAX;
+
 	ret = tmio_mmc_host_probe(host);
 	if (ret < 0)
 		goto edisclk;
 
 	/* One Gen2 SDHI incarnation does NOT have a CBSY bit */
-	if (sd_ctrl_read16(host, CTL_VERSION) == SDHI_VER_GEN2_SDR50)
+	if (ver == SDHI_VER_GEN2_SDR50)
 		mmc_data->flags &= ~TMIO_MMC_HAVE_CBSY;
 
 	/* Enable tuning iff we have an SCC and a supported mode */


