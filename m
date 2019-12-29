Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CB6C2D0DA
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB871222D9
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642225;
	bh=xX3GXCkwGmfzTgKVsOuf/rk8GZHWLEOBxb3PJ8lKHuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=11yZSAT8BSwbBtsiKnR4OKZg1Wvb2qOaevTZ7neLbFjE0EdOQ7Ns4zeIueGs7hFnx
	 /GRtJ2cURX+lPYf4OyyLwu7nlTi+dLovcOrrgFLRlDXuuJMds9MjU1cMVETGZvT1IO
	 8H3wcbRUxd6iRa9FwnZO9MFWmQgrS97GbAqC/EoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733182AbfL2R5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:57:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:47100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733173AbfL2R5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:57:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FAC0222C3;
        Sun, 29 Dec 2019 17:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642220;
        bh=xX3GXCkwGmfzTgKVsOuf/rk8GZHWLEOBxb3PJ8lKHuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MLwqp6gS6OYOf3WO0ejg/yeUnwzocZLPTvLGakW4nTNoT5X36dgfYvEBB+tdgOwf8
         mSzh1m+BoHJBgPDbRxTv8xfxb00meOBAwqCy3XZIS4YOv61Yxlu1vxOYqPMEOc0hZX
         t+mlrLNAlVY3Lg5H29vtlTxaxz9iGNThEvXfmoOI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 5.4 392/434] spi: fsl: use platform_get_irq() instead of of_irq_to_resource()
Date:   Sun, 29 Dec 2019 18:27:25 +0100
Message-Id: <20191229172728.361631424@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit 63aa6a692595d47a0785297b481072086b9272d2 upstream.

Unlike irq_of_parse_and_map() which has a dummy definition on SPARC,
of_irq_to_resource() hasn't.

But as platform_get_irq() can be used instead and is generic, use it.

Reported-by: kbuild test robot <lkp@intel.com>
Suggested-by: Mark Brown <broonie@kernel.org>
Fixes: 	3194d2533eff ("spi: fsl: don't map irq during probe")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Link: https://lore.kernel.org/r/091a277fd0b3356dca1e29858c1c96983fc9cb25.1576172743.git.christophe.leroy@c-s.fr
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-fsl-spi.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -736,9 +736,9 @@ static int of_fsl_spi_probe(struct platf
 	if (ret)
 		goto err;
 
-	irq = of_irq_to_resource(np, 0, NULL);
-	if (irq <= 0) {
-		ret = -EINVAL;
+	irq = platform_get_irq(ofdev, 0);
+	if (irq < 0) {
+		ret = irq;
 		goto err;
 	}
 


