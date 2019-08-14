Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6943FC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3ED2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802243;
	bh=z+Yin1l0uC3EEV8udrsuSZXDzBL1PiKwdzmYceVqWxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fW87ADn19tgqyJ7khQA4rk8aKFC5pocrv+X89T/vqXQDEDVYptiLkoW9vr9+bgtvh
	 ygvL0AEVCLRRFRqWMTnibkL4E1JqIjMdSBRsKxeXiMjhfbSw4wWvOzMZpjJhBcxoy8
	 PZ4szwyOEqV0JH1atRC71dbQx5+QQeWpEciNJHHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbfHNREC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:04:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729089AbfHNRD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:03:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9638621721;
        Wed, 14 Aug 2019 17:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802238;
        bh=z+Yin1l0uC3EEV8udrsuSZXDzBL1PiKwdzmYceVqWxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lkQ1Ny3dNjFRL5yKJsA+Z4dgLf0CfItJZv5iFoXUdLDLjOguTjPJcHtRXDz6zAmXR
         tqfZWdHcE5FJJt0NHq010F5FToqUFZQdcWTeiM0wWUH4CEMeSYPOggrT+mglgDAeNu
         CcFLL3vexFq3kJMw6YADd6ga7+dOqVOkFWtKSJqc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.2 047/144] can: flexcan: fix an use-after-free in flexcan_setup_stop_mode()
Date:   Wed, 14 Aug 2019 19:00:03 +0200
Message-Id: <20190814165801.795811337@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165759.466811854@linuxfoundation.org>
References: <20190814165759.466811854@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>

commit e9f2a856e102fa27715b94bcc2240f686536d29b upstream.

The gpr_np variable is still being used in dev_dbg() after the
of_node_put() call, which may result in use-after-free.

Fixes: de3578c198c6 ("can: flexcan: add self wakeup support")
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: linux-stable <stable@vger.kernel.org> # >= v5.0
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/flexcan.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1455,10 +1455,10 @@ static int flexcan_setup_stop_mode(struc
 
 	priv = netdev_priv(dev);
 	priv->stm.gpr = syscon_node_to_regmap(gpr_np);
-	of_node_put(gpr_np);
 	if (IS_ERR(priv->stm.gpr)) {
 		dev_dbg(&pdev->dev, "could not find gpr regmap\n");
-		return PTR_ERR(priv->stm.gpr);
+		ret = PTR_ERR(priv->stm.gpr);
+		goto out_put_node;
 	}
 
 	priv->stm.req_gpr = out_val[1];
@@ -1473,7 +1473,9 @@ static int flexcan_setup_stop_mode(struc
 
 	device_set_wakeup_capable(&pdev->dev, true);
 
-	return 0;
+out_put_node:
+	of_node_put(gpr_np);
+	return ret;
 }
 
 static const struct of_device_id flexcan_of_match[] = {


