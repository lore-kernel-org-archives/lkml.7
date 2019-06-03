Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FC2C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5760521923
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559553181;
	bh=VG3xzaa3A1jhxtOHs99V4fP62LFPsrwnGOwBUKvbhmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0LOceXnvTq5u8qwNHGzLWNN4WTfMAoH5ft6IsTn3uciAaRWGsDpy5ZQq8Ppfokfnx
	 r5HYWc94QTSJ1z1t/F5ume6X1sdTTZC8ZHaNJNWXmlCwv+dqF1aCGg5vVIN+th3Dwc
	 dTNnnQGcnvBkTGpyx2NtJiP0D0BYU7AmovTIxVIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfFCJM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:12:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:32952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728727AbfFCJMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:12:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7F1F245DF;
        Mon,  3 Jun 2019 09:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559553175;
        bh=VG3xzaa3A1jhxtOHs99V4fP62LFPsrwnGOwBUKvbhmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BpmY4ciLJ9enEOimwMny0oPC7QbhZisX6U8XqkOpr+y89v+LgD/syAQlqpcSyGSAA
         H/wwbMTZcnb5CvPmW/+GiimNMu1x4rNTa3mPWSRPcmZSBrlj3vhkmh7fGOmuYKg5Tt
         HtXeqagfX1FPDwfttAbYekQErWAjEgS2VoavWl7o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
        Fugang Duan <fugang.duan@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 12/40] net: fec: fix the clk mismatch in failed_reset path
Date:   Mon,  3 Jun 2019 11:09:05 +0200
Message-Id: <20190603090523.383697353@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603090522.617635820@linuxfoundation.org>
References: <20190603090522.617635820@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Duan <fugang.duan@nxp.com>

[ Upstream commit ce8d24f9a5965a58c588f9342689702a1024433c ]

Fix the clk mismatch in the error path "failed_reset" because
below error path will disable clk_ahb and clk_ipg directly, it
should use pm_runtime_put_noidle() instead of pm_runtime_put()
to avoid to call runtime resume callback.

Reported-by: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Tested-by: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/fec_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3556,7 +3556,7 @@ failed_init:
 	if (fep->reg_phy)
 		regulator_disable(fep->reg_phy);
 failed_reset:
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 failed_regulator:
 	clk_disable_unprepare(fep->clk_ahb);


