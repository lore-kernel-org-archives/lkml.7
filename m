Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C10C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230092082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255601;
	bh=S+yHRpLYRLoy7Pl/tVTtAijz66Dlpyj7D3qXGuEd+NA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tLoTgL0Wz6QSmcZeUYiEd/eZoIN5jWJm+1y5w9eWdElZQ0rPNPi7DGIf1R3rgTjsP
	 eKf4+Z8gRgTDqfWxCS5j+W8dcmOYXV11dsBIUClAHOqFCemJgZno48ogbKPLXBRQ5a
	 UGnf0rXOLWYkBL/+hDw6PINKqDsQyOQ2oigoeF9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733021AbfCVLxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:53:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732802AbfCVLxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:53:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B88B620693;
        Fri, 22 Mar 2019 11:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255595;
        bh=S+yHRpLYRLoy7Pl/tVTtAijz66Dlpyj7D3qXGuEd+NA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=notBCv3CQpMxwbIS3wAAvAsVucH8aze9ZRihv5g1Zk9GZhGRrPVHwyL5XR+Sv+ru/
         1eEsMfJ78ov+19j/I+OjXl2Z7ObZpyjS0Guwy5oSRD0qnJxTQPUb1HgTtuVgQhlll/
         w+TOY2Eon7xt704dyMIk4qwxH0AhchVMkgywxL7c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 4.14 120/183] usb: chipidea: tegra: Fix missed ci_hdrc_remove_device()
Date:   Fri, 22 Mar 2019 12:15:48 +0100
Message-Id: <20190322111250.395778387@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -133,6 +133,7 @@ static int tegra_udc_remove(struct platf
 {
 	struct tegra_udc *udc = platform_get_drvdata(pdev);
 
+	ci_hdrc_remove_device(udc->dev);
 	usb_phy_set_suspend(udc->phy, 1);
 	clk_disable_unprepare(udc->clk);
 


