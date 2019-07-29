Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C516EC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C6A2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="gV9r2Pvw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfG2WwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 18:52:24 -0400
Received: from gateway36.websitewelcome.com ([192.185.195.25]:20352 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727091AbfG2WwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 18:52:23 -0400
X-Greylist: delayed 1220 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jul 2019 18:52:23 EDT
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 9AB56400C88CF
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 17:16:29 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id sEVDhVwGUiQersEVDhv13B; Mon, 29 Jul 2019 17:52:23 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RGM1QOf7Ifka8Lzj21bKpD9jnLg3f9Vd1ITqzxm/VOU=; b=gV9r2PvwJ6rxIRIgwFC2X2SCdZ
        g7/+BkFcoDz0V9uUOGllyxNtsuluzDThOjYowlhrij65SbkzuX75rigaZDRftzgUiV0o1DPAYUTGb
        oZrWQybdnVtt/4v1P7Rusa2Q1rTb/30pyx4ExZe2xPRlFQfh/Y/2E8OKwJ448mqa7mUmWwvnwFoLk
        N5zW03DPfInXg5UpRiUBT5MpkOyVO3BLu5XNZ3fi7uz5wu8vIArdm+DT4elWgYkmikAC/wbkQTP8V
        a8cEFs8pUOoQmOwXYBaP2ZQsuJWBuIdHKwgY3BlCb8Ix150TlM+sOJanfZFuzXIQNbiBWAQIpRLcT
        wumxlobw==;
Received: from [187.192.11.120] (port=60908 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hsEVB-002HF4-S4; Mon, 29 Jul 2019 17:52:22 -0500
Date:   Mon, 29 Jul 2019 17:52:21 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] dmaengine: imx-dma: Mark expected switch fall-through
Message-ID: <20190729225221.GA24269@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hsEVB-002HF4-S4
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:60908
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 54
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warning (Building: arm):

drivers/dma/imx-dma.c: In function ‘imxdma_xfer_desc’:
drivers/dma/imx-dma.c:542:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (slot == IMX_DMA_2D_SLOT_A) {
      ^
drivers/dma/imx-dma.c:559:2: note: here
  case IMXDMA_DESC_MEMCPY:
  ^~~~

Notice that, in this particular case, the code comment is
modified in accordance with what GCC is expecting to find.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/dma/imx-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index 00a089e24150..5c0fb3134825 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -556,6 +556,7 @@ static int imxdma_xfer_desc(struct imxdma_desc *d)
 		 * We fall-through here intentionally, since a 2D transfer is
 		 * similar to MEMCPY just adding the 2D slot configuration.
 		 */
+		/* Fall through */
 	case IMXDMA_DESC_MEMCPY:
 		imx_dmav1_writel(imxdma, d->src, DMA_SAR(imxdmac->channel));
 		imx_dmav1_writel(imxdma, d->dest, DMA_DAR(imxdmac->channel));
-- 
2.22.0

