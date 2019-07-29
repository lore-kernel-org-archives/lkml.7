Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E709C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 06:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44975206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 06:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfG2GnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 02:43:13 -0400
Received: from inva020.nxp.com ([92.121.34.13]:36904 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfG2GnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 02:43:12 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0BBBD1A00ED;
        Mon, 29 Jul 2019 08:43:11 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9DE3F1A13EB;
        Mon, 29 Jul 2019 08:43:06 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id EDFDC402F1;
        Mon, 29 Jul 2019 14:43:00 +0800 (SGT)
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Cc:     yinbo.zhu@nxp.com, xiaobo.xie@nxp.com, jiafei.pan@nxp.com,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v1] usb: dwc3: remove the call trace of USBx_GFLADJ
Date:   Mon, 29 Jul 2019 14:46:07 +0800
Message-Id: <20190729064607.8131-1-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

layerscape board sometimes reported some usb call trace, that is due to
kernel sent LPM tokerns automatically when it has no pending transfers
and think that the link is idle enough to enter L1, which procedure will
ask usb register has a recovery,then kernel will compare USBx_GFLADJ and
set GFLADJ_30MHZ, GFLADJ_30MHZ_REG until GFLADJ_30MHZ is equal 0x20, if
the conditions were met then issue occur, but whatever the conditions
whether were met that usb is all need keep GFLADJ_30MHZ of value is 0x20
(xhci spec ask use GFLADJ_30MHZ to adjust any offset from clock source
that generates the clock that drives the SOF counter, 0x20 is default
value of it)That is normal logic, so need remove the call trace.

Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 drivers/usb/dwc3/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 98bce85c29d0..a133d8490322 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -300,8 +300,7 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
 
 	reg = dwc3_readl(dwc->regs, DWC3_GFLADJ);
 	dft = reg & DWC3_GFLADJ_30MHZ_MASK;
-	if (!dev_WARN_ONCE(dwc->dev, dft == dwc->fladj,
-	    "request value same as default, ignoring\n")) {
+	if (dft != dwc->fladj) {
 		reg &= ~DWC3_GFLADJ_30MHZ_MASK;
 		reg |= DWC3_GFLADJ_30MHZ_SDBND_SEL | dwc->fladj;
 		dwc3_writel(dwc->regs, DWC3_GFLADJ, reg);
-- 
2.17.1

