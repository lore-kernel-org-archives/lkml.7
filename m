Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8AFC282CE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 02:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CC62070B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 02:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfFECCv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 22:02:51 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6958 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726293AbfFECCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 22:02:50 -0400
Received: from DGGEML403-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id C549CAC5FA6598B3CA3A;
        Wed,  5 Jun 2019 10:02:48 +0800 (CST)
Received: from DGGEML421-HUB.china.huawei.com (10.1.199.38) by
 DGGEML403-HUB.china.huawei.com (10.3.17.33) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 5 Jun 2019 10:02:48 +0800
Received: from DGGEML529-MBX.china.huawei.com ([169.254.6.38]) by
 dggeml421-hub.china.huawei.com ([10.1.199.38]) with mapi id 14.03.0439.000;
 Wed, 5 Jun 2019 10:02:40 +0800
From:   Duyanlin <duyanlin@huawei.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zengweilin <zengweilin@huawei.com>
Subject: [PATCH] drivers/usb/host/imx21-hcd.c: fix divide-by-zero in func
 nonisoc_etd_done
Thread-Topic: [PATCH] drivers/usb/host/imx21-hcd.c: fix divide-by-zero in
 func nonisoc_etd_done
Thread-Index: AQHVGgfcZ17K0unPU0i5TlbYCbNWX6aMUaEg
Date:   Wed, 5 Jun 2019 02:02:40 +0000
Message-ID: <52727B2E0D7DFC4A945AFC14D2E3E5A92211C6FE@dggeml529-mbx.china.huawei.com>
References: <1559564879-88739-1-git-send-email-duyanlin@huawei.com>
In-Reply-To: <1559564879-88739-1-git-send-email-duyanlin@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.40.37.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


If the function usb_maxpacket(urb->dev, urb->pipe, usb_pipeout(urb->pipe)) returns 0, that will cause a illegal divide-by-zero operation, unexpected results may occur.
It is best to ensure that the denominator is non-zero before dividing by zero.

Signed-off-by: Yanlin Du <duyanlin@huawei.com>
---
 drivers/usb/host/imx21-hcd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/imx21-hcd.c b/drivers/usb/host/imx21-hcd.c index 6e3dad1..6a47f78 100644
--- a/drivers/usb/host/imx21-hcd.c
+++ b/drivers/usb/host/imx21-hcd.c
@@ -1038,6 +1038,7 @@ static void nonisoc_etd_done(struct usb_hcd *hcd, int etd_num)
 	int cc;
 	u32 bytes_xfrd;
 	int etd_done;
+	unsigned int maxp;
 
 	disactivate_etd(imx21, etd_num);
 
@@ -1104,13 +1105,13 @@ static void nonisoc_etd_done(struct usb_hcd *hcd, int etd_num)
 		break;
 
 	case PIPE_BULK:
+		maxp = usb_maxpacket(urb->dev, urb->pipe,
+				usb_pipeout(urb->pipe));
 		urb->actual_length += bytes_xfrd;
 		if ((urb_priv->state == US_BULK)
 		    && (urb->transfer_flags & URB_ZERO_PACKET)
 		    && urb->transfer_buffer_length > 0
-		    && ((urb->transfer_buffer_length %
-			 usb_maxpacket(urb->dev, urb->pipe,
-				       usb_pipeout(urb->pipe))) == 0)) {
+		    && maxp && (urb->transfer_buffer_length % maxp == 0)) {
 			/* need a 0-packet */
 			urb_priv->state = US_BULK0;
 		} else {
--
1.8.5.6

