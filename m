Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806C2C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D61220721
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420450;
	bh=m9VhWDbXbHgBh8aFo56pVeSLUAJfO+QY+O/6sQJbDBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X7UbBwReq0O+Ovgwpq7n3mAdsyzwo7BEyp24tbeas6fD9OJ9rvhsdxJ82IKwJydVC
	 ZCb61Zz78khZ1pMEiwG/MeOZ+YFKzQ3eiLX46TIAswQGuWT+bqVfKjG7KUrpWEOWZ3
	 OtTSVxl8tjImFYaOaGkN418cyXCKgohtWNo+JyBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbfKVLAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:00:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:53222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730440AbfKVLAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:00:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0CE92073B;
        Fri, 22 Nov 2019 11:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420445;
        bh=m9VhWDbXbHgBh8aFo56pVeSLUAJfO+QY+O/6sQJbDBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VErxQdVBMubsjiIEmWqcnAVuPORKjr4GlqhgCCl2jWdZSSkIPh3W27Dv7uO5RoCH7
         o4TbVYzIrrsbIichdo1sqLKcxRT+iGwE0FLFX4lCDOn7ZrEh8xnNX10fP2Bb5h/667
         dZXMQbCdtnABpZUz/WevfQ9lN9S9zPdTI769Lqxw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, SolidHal <hal@halemmerich.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 108/220] usb: dwc2: disable power_down on rockchip devices
Date:   Fri, 22 Nov 2019 11:27:53 +0100
Message-Id: <20191122100920.538922656@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SolidHal <hal@halemmerich.com>

[ Upstream commit c216765d3a1defda5e7e2dabd878f99f0cd2ebf2 ]

 The bug would let the usb controller enter partial power down,
 which was formally known as hibernate, upon boot if nothing was plugged
 in to the port. Partial power down couldn't be exited properly, so any
 usb devices plugged in after boot would not be usable.

 Before the name change, params.hibernation was false by default, so
 _dwc2_hcd_suspend() would skip entering hibernation. With the
 rename, _dwc2_hcd_suspend() was changed to use  params.power_down
 to decide whether or not to enter partial power down.

 Since params.power_down is non-zero by default, it needs to be set
 to 0 for rockchip devices to restore functionality.

 This bug was reported in the linux-usb thread:
 REGRESSION: usb: dwc2: USB device not seen after boot

 The commit that caused this regression is:
6d23ee9caa6790aea047f9aca7f3c03cb8d96eb6

Signed-off-by: SolidHal <hal@halemmerich.com>
Acked-by: Minas Harutyunyan <hminas@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc2/params.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index dff2c6e8d797c..a93415f33bf36 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -88,6 +88,7 @@ static void dwc2_set_rk_params(struct dwc2_hsotg *hsotg)
 	p->host_perio_tx_fifo_size = 256;
 	p->ahbcfg = GAHBCFG_HBSTLEN_INCR16 <<
 		GAHBCFG_HBSTLEN_SHIFT;
+	p->power_down = 0;
 }
 
 static void dwc2_set_ltq_params(struct dwc2_hsotg *hsotg)
-- 
2.20.1



