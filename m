Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66224C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0792064A
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566494855;
	bh=WnhuJW6nC1WT6N6IbmLrIhYxRTp9DB5RtGXOZ97LhuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dq5NO36iYxH+sMGCNhowGZPTCt4Z/ONknDnWdm9DWgbes8ATkYlVmVLr+eyHEMQdC
	 JA7/6bOlVJcxsUN5gNM+BDvJKWsInDyzZt/jw1rwlWIO9DRfvH2BWYKCawBtlKizH0
	 nC6nqVKoVObKrL8+q6TGRW1YPo1GtlI1K3/L4O4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404564AbfHVR1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404582AbfHVR0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:26:03 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C2122064A;
        Thu, 22 Aug 2019 17:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494762;
        bh=WnhuJW6nC1WT6N6IbmLrIhYxRTp9DB5RtGXOZ97LhuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yvrRNSn1dTaLsjz17onJrAXsGXr5Msmg+HqxQIDgJPf2ksaSxdnxvFPljFG8wIZ4N
         hFN5j9mKPUZNsO2feuawt947Age8jEDAIun930K2gv/QO4FMKOJmhBZJIcJORAuNw1
         JYa1Ek6TgXTQZ2vIKuW5kFR6FzC3YZUSk3JA6MsQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Hiroyuki Yamamoto <hyamamo@allied-telesis.co.jp>,
        Yoshiaki Okamoto <yokamoto@allied-telesis.co.jp>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.19 64/85] USB: serial: option: Add support for ZTE MF871A
Date:   Thu, 22 Aug 2019 10:19:37 -0700
Message-Id: <20190822171733.998793276@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171731.012687054@linuxfoundation.org>
References: <20190822171731.012687054@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yoshiaki Okamoto <yokamoto@allied-telesis.co.jp>

commit 7e7ae38bf928c5cfa6dd6e9a2cf8b42c84a27c92 upstream.

This patch adds support for MF871A USB modem (aka Speed USB STICK U03)
to option driver. This modem is manufactured by ZTE corporation, and
sold by KDDI.

Interface layout:
0: AT
1: MODEM

usb-devices output:
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  9 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=19d2 ProdID=1481 Rev=52.87
S:  Manufacturer=ZTE,Incorporated
S:  Product=ZTE Technologies MSM
S:  SerialNumber=1234567890ABCDEF
C:  #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option

Co-developed-by: Hiroyuki Yamamoto <hyamamo@allied-telesis.co.jp>
Signed-off-by: Hiroyuki Yamamoto <hyamamo@allied-telesis.co.jp>
Signed-off-by: Yoshiaki Okamoto <yokamoto@allied-telesis.co.jp>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/option.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1549,6 +1549,7 @@ static const struct usb_device_id option
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x1428, 0xff, 0xff, 0xff),  /* Telewell TW-LTE 4G v2 */
 	  .driver_info = RSVD(2) },
 	{ USB_DEVICE_INTERFACE_CLASS(ZTE_VENDOR_ID, 0x1476, 0xff) },	/* GosunCn ZTE WeLink ME3630 (ECM/NCM mode) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x1481, 0xff, 0x00, 0x00) }, /* ZTE MF871A */
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x1533, 0xff, 0xff, 0xff) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x1534, 0xff, 0xff, 0xff) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x1535, 0xff, 0xff, 0xff) },


