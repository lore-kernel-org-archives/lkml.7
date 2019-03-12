Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC805C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749AB206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411858;
	bh=+Cmo8Zzay1P4Aw4vEJP13dIaYoyQQwh5Yl0IT40REGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CRLteyZKRfIkxwdr6QYTtvLrqRMcYV5uZdQWQv0KUH+RUQo8nVKiVVS6rXq/KiDPN
	 h65Uie7Iw48rz86vIwMVzg3yf8/+q0UHQ9Ge2j4oS+VCxinkmEdrI6ZXk1jL/ThpKK
	 Mo4eITLkR8DOxV9AuIPeFpi6jcqsrbvrHsvS7+yA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfCLRa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:30:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729495AbfCLRRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:13 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9FB5217D4;
        Tue, 12 Mar 2019 17:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411032;
        bh=+Cmo8Zzay1P4Aw4vEJP13dIaYoyQQwh5Yl0IT40REGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xu3AQ/Y0dU+u0skf0ahiYcHsmjIeq+feZ4wKIE5RWLsIaR5xjdjkIShYbKCH6a6ze
         /6XSG/9yNYnbTBHXAddb4zcQ4TDoOTKSZDrPJbkpa8of/zTuRcIb5qm1CLNGEGsHXM
         2ZY1Y23Ylye+XED2D/VdaS1cUMQEjkYVJiiwfmAA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 01/96] USB: serial: option: add Telit ME910 ECM composition
Date:   Tue, 12 Mar 2019 10:09:19 -0700
Message-Id: <20190312171034.649356692@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniele Palmas <dnlplm@gmail.com>

commit 6431866b6707d27151be381252d6eef13025cfce upstream.

This patch adds Telit ME910 family ECM composition 0x1102.

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/option.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1147,6 +1147,8 @@ static const struct usb_device_id option
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(3) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910_DUAL_MODEM),
 	  .driver_info = NCTRL(0) | RSVD(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1102, 0xff),	/* Telit ME910 (ECM) */
+	  .driver_info = NCTRL(0) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE910),
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE910_USBCFG4),


