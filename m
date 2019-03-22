Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF3EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CDAE2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257778;
	bh=TkkzbFF0Trrq+Vazt0h22jWF1kJEioLDHN9eFcZuf2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xphKoKj2pvt4SbDYe+5gVx89ke9VhErNVb0dOecWcNgZAOfRnXyThJ4CBIqn55Sqs
	 f+LeRaMY4nKug1ioS4TdUQB65WLPiMaGzC08OXe+OsBKGRGcd/KFGKctbWo5JCQW6h
	 nC1g944zG+Zaqx6bW5y8RYK2W+jKyss38WzIL1Gc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390798AbfCVM3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:29:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390197AbfCVMTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:19:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62F802054F;
        Fri, 22 Mar 2019 12:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257142;
        bh=TkkzbFF0Trrq+Vazt0h22jWF1kJEioLDHN9eFcZuf2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iv6RiGurx5gZzGMJysex8/kWzDEJGjjizzGstBVqsYsBWpBNcR9XAYGkvBW1GBC1v
         MB0sicjgTFsdG4ggASdgFyGzzyS0RbxW8Wx1yxL+jh8BuGN3tAzvYQCtAYKd9/ktw+
         zWFO+KrAfZdr/vETHemsOkFwZLRl1lKKGhsH23Vw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 5.0 145/238] usb: chipidea: tegra: Fix missed ci_hdrc_remove_device()
Date:   Fri, 22 Mar 2019 12:16:04 +0100
Message-Id: <20190322111306.932578484@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

From: Dmitry Osipenko <digetx@gmail.com>

commit 563b9372f7ec57e44e8f9a8600c5107d7ffdd166 upstream.

The ChipIdea's platform device need to be unregistered on Tegra's driver
module removal.

Fixes: dfebb5f43a78827a ("usb: chipidea: Add support for Tegra20/30/114/124")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Peter Chen <peter.chen@nxp.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/chipidea/ci_hdrc_tegra.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/chipidea/ci_hdrc_tegra.c
+++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
@@ -130,6 +130,7 @@ static int tegra_udc_remove(struct platf
 {
 	struct tegra_udc *udc = platform_get_drvdata(pdev);
 
+	ci_hdrc_remove_device(udc->dev);
 	usb_phy_set_suspend(udc->phy, 1);
 	clk_disable_unprepare(udc->clk);
 


