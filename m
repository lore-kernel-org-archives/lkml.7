Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B784BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8708520863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582158;
	bh=ZxhIIsd4yMzYRN2zTDXoYcqKWHQZDokiEt5sXKSM5oM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JwQmva6ZXyPQ49nFj+mP1aTYxiii2RNYgEY6EJY+XlAqd6oXwGdFnwl60Q92Wzr5Y
	 x0+twyKOn+at8h/48kEE1JFjMI4G5GjmLaXIav8KWrHKwkqjKUmKqxmHbI3h3vARlW
	 DGaEX9hp9giy/t8REu2lcQ7CADUeANfCM5yc8sX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbfCZGf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:35:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732109AbfCZGfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:35:52 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFE6320823;
        Tue, 26 Mar 2019 06:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582151;
        bh=ZxhIIsd4yMzYRN2zTDXoYcqKWHQZDokiEt5sXKSM5oM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hVySsr3b3jWKteNbkdx/0jybAHdXfQDOMOJ+8qSy/mh8Mx7Og2ZXJh3pxQRigZmG1
         s/wU/bXmQJytc1ipVqKMvovEmHTDx70XIAMlL/4Lqvs1Sg959+EqBetxyxSsPFaEfY
         YSswaFvwQz+uH2rs5mFhik5kB2/aO16L/xFXnO+k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Phong Hoang <phong.hoang.wz@renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 05/45] mmc: renesas_sdhi: limit block count to 16 bit for old revisions
Date:   Tue, 26 Mar 2019 15:29:48 +0900
Message-Id: <20190326042702.969414328@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042702.565683325@linuxfoundation.org>
References: <20190326042702.565683325@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -557,6 +557,7 @@ int renesas_sdhi_probe(struct platform_d
 	struct renesas_sdhi *priv;
 	struct resource *res;
 	int irq, ret, i;
+	u16 ver;
 
 	of_data = of_device_get_match_data(&pdev->dev);
 
@@ -671,12 +672,17 @@ int renesas_sdhi_probe(struct platform_d
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


