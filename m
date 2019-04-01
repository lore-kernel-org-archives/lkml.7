Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5FFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D11821924
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138545;
	bh=HHytAitnojGgXXVYEVB1+wL4Jhzp3lvF1XRQVTMWr98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S4ayddIF6WL1xnOK63VXHfNH5l/o6vjzO9rDCybAFecwUQUdSWrKycs6uTbl5axlq
	 w/szP+BDbr1NpQzNiEf3rmDx+5zberuu5lpjI2Fb/EcN+sAu1WoyjvWrDPVuBtx56b
	 imaia1eoVPGLP8Xwz724FpS5uFAXR2Ft28EC03DQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbfDARJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:09:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729052AbfDARJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:09:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E422206B8;
        Mon,  1 Apr 2019 17:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138541;
        bh=HHytAitnojGgXXVYEVB1+wL4Jhzp3lvF1XRQVTMWr98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WPixpkJE03WzkKATakwganlTzvtqPd7YjnW7tK2E2Tt0phnFf1bLl1EReldkga2Ob
         HJDQgXLIX+lkndxU7pa9arsEqOOouhaKMhkoEzgi8larhKDufC7zjK0NJyQ0VpWrN0
         Mfc5v9KHKIDNenSVKkPOBqTVXe5OoWT2a9LBznDk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kristian Evensen <kristian.evensen@gmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.0 097/146] USB: serial: option: add support for Quectel EM12
Date:   Mon,  1 Apr 2019 19:01:49 +0200
Message-Id: <20190401170057.002952249@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

From: Kristian Evensen <kristian.evensen@gmail.com>

commit d1252f0237238b912c3e7a51bf237acf34c97983 upstream.

The Quectel EM12 is a Cat. 12 LTE modem. It behaves in the exactly the
same way as the EP06 (including the dynamic configuration behavior), so
the same checks on reserved interfaces, etc. are needed.

Signed-off-by: Kristian Evensen <kristian.evensen@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/option.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -246,6 +246,7 @@ static void option_instat_callback(struc
 #define QUECTEL_PRODUCT_EC25			0x0125
 #define QUECTEL_PRODUCT_BG96			0x0296
 #define QUECTEL_PRODUCT_EP06			0x0306
+#define QUECTEL_PRODUCT_EM12			0x0512
 
 #define CMOTECH_VENDOR_ID			0x16d8
 #define CMOTECH_PRODUCT_6001			0x6001
@@ -1088,6 +1089,9 @@ static const struct usb_device_id option
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06, 0xff, 0xff, 0xff),
 	  .driver_info = RSVD(1) | RSVD(2) | RSVD(3) | RSVD(4) | NUMEP2 },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM12, 0xff, 0xff, 0xff),
+	  .driver_info = RSVD(1) | RSVD(2) | RSVD(3) | RSVD(4) | NUMEP2 },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM12, 0xff, 0, 0) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_CMU_300) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6003),


