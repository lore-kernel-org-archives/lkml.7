Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C7EC3276E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D3B22314
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003404;
	bh=70aTdiQgJsFIJCW4mqmXNycIive18GHAshoWKj+6q18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ETaChexBan1WGoAA/uw/anC9V4Elwgxd6agm8om1742fscKqC9uldDy8mPGJmrK/v
	 e68lr1vEbKGZLMLgqF6HPeR8011rBPvkHA6Wb/iNaPikckMZieccONkhCCeOY2dXaE
	 qiLwW44P6pl+CCJXkkOr22A5qBI/UkgEug3Eg2YQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgABWQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:16:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:58738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728282AbgABWQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:16:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCD2F21582;
        Thu,  2 Jan 2020 22:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003399;
        bh=70aTdiQgJsFIJCW4mqmXNycIive18GHAshoWKj+6q18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IheE8AvifDFTdXJvS7181Au0de7jz4sJ1lUYjpSNPWHsYohsM0iw3joAH8pWeevoX
         zgOi6lZHluZsCXmXNSXtLwzQWU0Mo6hArkZAy5uPOJsQAQcz7P1k49cEZoOS1ILXrB
         H48Brb8jwQotYG3lBMj1k+wmOAI8zvPy9xTjU/bU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 119/191] mailbox: imx: Clear the right interrupts at shutdown
Date:   Thu,  2 Jan 2020 23:06:41 +0100
Message-Id: <20200102215842.592971839@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

[ Upstream commit 5f0af07e89199ac51cdd4f25bc303bdc703f4e9c ]

Make sure to only clear enabled interrupts keeping count
of the connection type.

Suggested-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/imx-mailbox.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 9f74dee1a58c..d28bbd47ff88 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -217,8 +217,19 @@ static void imx_mu_shutdown(struct mbox_chan *chan)
 	if (cp->type == IMX_MU_TYPE_TXDB)
 		tasklet_kill(&cp->txdb_tasklet);
 
-	imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_TIEn(cp->idx) |
-		       IMX_MU_xCR_RIEn(cp->idx) | IMX_MU_xCR_GIEn(cp->idx));
+	switch (cp->type) {
+	case IMX_MU_TYPE_TX:
+		imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_TIEn(cp->idx));
+		break;
+	case IMX_MU_TYPE_RX:
+		imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_RIEn(cp->idx));
+		break;
+	case IMX_MU_TYPE_RXDB:
+		imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_GIEn(cp->idx));
+		break;
+	default:
+		break;
+	}
 
 	free_irq(priv->irq, chan);
 }
-- 
2.20.1



