Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7048FC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 04:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429AB2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 04:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TAGAg/gA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfKUETn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 23:19:43 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15600 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKUETm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 23:19:42 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dd6105e0000>; Wed, 20 Nov 2019 20:19:43 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 20 Nov 2019 20:19:42 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 20 Nov 2019 20:19:42 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 Nov
 2019 04:19:41 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 Nov
 2019 04:19:40 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 21 Nov 2019 04:19:40 +0000
Received: from henryl-tu10x.nvidia.com (Not Verified[10.19.109.104]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dd6105b0000>; Wed, 20 Nov 2019 20:19:40 -0800
From:   Henry Lin <henryl@nvidia.com>
CC:     Henry Lin <henryl@nvidia.com>, Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Romain Izard <romain.izard.pro@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: gadget: f_ncm: fix wrong usb_ep
Date:   Thu, 21 Nov 2019 12:18:57 +0800
Message-ID: <20191121041858.15746-1-henryl@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574309983; bh=EL2BQGDO8oGg4dJi/hYdF+5hmA52O9yZOuCrfBec8eY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=TAGAg/gA4c2DhV7MT/+D/f8eACascD0i3gQ8mFFxxInznvJlDX7f++LfCCzosojTZ
         pmXT5/qGYOoVr11ba333LTA9LvTvfDkzy3dNC6ycwQGAFVsSHnV55u79pcyiOnIlJG
         gE+gssDA2CwR4vd40IJ/LM2zeVMimngRnqEGGJpcn7ceIxupEghjGzwHWSnb2XhvMF
         8t85ctBxY291ixwMGGsZX0urtCFdNVmNPt30LU4yE0E/PiyOeT4a97v9LdPbsL9lZC
         T8ri4PnX7UlJYTL1Jmgk7GexpUUYsoLA8s7Xird1gqH1CfTNILVNdsfhV1d4V37tot
         hCD4tepLrLwQw==
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gadget driver should always use config_ep_by_speed() to initialize
usb_ep struct according to usb device's operating speed. Otherwise,
usb_ep struct may be wrong if usb devcie's operating speed is changed.

Signed-off-by: Henry Lin <henryl@nvidia.com>
---
 drivers/usb/gadget/function/f_ncm.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index 2d6e76e4cffa..420b9c96f2fe 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -870,11 +870,10 @@ static int ncm_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 		DBG(cdev, "reset ncm control %d\n", intf);
 		usb_ep_disable(ncm->notify);
 
-		if (!(ncm->notify->desc)) {
-			DBG(cdev, "init ncm ctrl %d\n", intf);
-			if (config_ep_by_speed(cdev->gadget, f, ncm->notify))
-				goto fail;
-		}
+		DBG(cdev, "init ncm ctrl %d\n", intf);
+		if (config_ep_by_speed(cdev->gadget, f, ncm->notify))
+			goto fail;
+
 		usb_ep_enable(ncm->notify);
 
 	/* Data interface has two altsettings, 0 and 1 */
@@ -897,17 +896,14 @@ static int ncm_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 		if (alt == 1) {
 			struct net_device	*net;
 
-			if (!ncm->port.in_ep->desc ||
-			    !ncm->port.out_ep->desc) {
-				DBG(cdev, "init ncm\n");
-				if (config_ep_by_speed(cdev->gadget, f,
-						       ncm->port.in_ep) ||
-				    config_ep_by_speed(cdev->gadget, f,
-						       ncm->port.out_ep)) {
-					ncm->port.in_ep->desc = NULL;
-					ncm->port.out_ep->desc = NULL;
-					goto fail;
-				}
+			DBG(cdev, "init ncm\n");
+			if (config_ep_by_speed(cdev->gadget, f,
+					       ncm->port.in_ep) ||
+			    config_ep_by_speed(cdev->gadget, f,
+					       ncm->port.out_ep)) {
+				ncm->port.in_ep->desc = NULL;
+				ncm->port.out_ep->desc = NULL;
+				goto fail;
 			}
 
 			/* TODO */
-- 
2.17.1

