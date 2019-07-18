Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44FAC76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB052053B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419577;
	bh=ygdv+YsAuveBpw2fT4ksARAzgv+byXQjMTAXBDwhsPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZlyZUaT+Y92hWmE3bE/rY0A2pwAQuj5uue4mAITWcYFli9lFn9k2QEPJpab3y6qXw
	 Jr0Z/Wu+bgx7Ezhpw5sJAhALq0bR6ZqtHUlfd2n79P7mVfzqhsypV4LOuVp/WW6e9Y
	 uk4C6LAkjupen0lQb85oLci3ZXHtkbThiXlhSIA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391551AbfGRDM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:12:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390133AbfGRDMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:12:50 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48C2A2077C;
        Thu, 18 Jul 2019 03:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419569;
        bh=ygdv+YsAuveBpw2fT4ksARAzgv+byXQjMTAXBDwhsPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=enfB4sbO7wdAMbADHExSHSMUAYvaTz7hw2D5y29vj8RjfJaK+CEy6blO0STbwVvuS
         /rasRk3vYv7xiicfdiSSAjcmnBd1fvlbSAw/J8qtGlDQ6yG57tTs8uw4qqsxf6Q6Yp
         3Z6Pj0K45A0x0OUPnNiIJiQSb8dUYmDKrpsx4xTE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?J=C3=B6rgen=20Storvist?= <jorgen.storvist@gmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 30/54] USB: serial: option: add support for GosunCn ME3630 RNDIS mode
Date:   Thu, 18 Jul 2019 12:02:00 +0900
Message-Id: <20190718030051.759454682@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030048.392549994@linuxfoundation.org>
References: <20190718030048.392549994@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jörgen Storvist <jorgen.storvist@gmail.com>

commit aed2a26283528fb69c38e414f649411aa48fb391 upstream.

Added USB IDs for GosunCn ME3630 cellular module in RNDIS mode.

T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=03 Dev#= 18 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=19d2 ProdID=0601 Rev=03.18
S:  Manufacturer=Android
S:  Product=Android
S:  SerialNumber=b950269c
C:  #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=500mA
I:  If#=0x0 Alt= 0 #EPs= 1 Cls=e0(wlcon) Sub=01 Prot=03 Driver=rndis_host
I:  If#=0x1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
I:  If#=0x2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
I:  If#=0x3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#=0x4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option

Signed-off-by: Jörgen Storvist <jorgen.storvist@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/option.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1338,6 +1338,7 @@ static const struct usb_device_id option
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0414, 0xff, 0xff, 0xff) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0417, 0xff, 0xff, 0xff) },
+	{ USB_DEVICE_INTERFACE_CLASS(ZTE_VENDOR_ID, 0x0601, 0xff) },	/* GosunCn ZTE WeLink ME3630 (RNDIS mode) */
 	{ USB_DEVICE_INTERFACE_CLASS(ZTE_VENDOR_ID, 0x0602, 0xff) },	/* GosunCn ZTE WeLink ME3630 (MBIM mode) */
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x1008, 0xff, 0xff, 0xff),
 	  .driver_info = RSVD(4) },


