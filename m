Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672B0C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361392087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049690;
	bh=+wVsI0b/eC5v9Jvwe7w2dForb3YOMRTBCUBwDN9PU2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q1zjHj6HHTnqKm67fU4euigVRFUPuhaD3sg1n2/hsFUdT3epks9Xu7wqc6Q8omIC8
	 9Ypfeu58x3tEpLiEorLKVbMibHCJ0rGAnIJp80QftNF3lg3QAzTn9WylMaEDydkwop
	 80Gw5jlwDuJ9Oddm6yKqL4M4CdJ0/zPjCkQ85r1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfCHMyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:54:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:58648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727378AbfCHMyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:54:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6A9C208E4;
        Fri,  8 Mar 2019 12:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049684;
        bh=+wVsI0b/eC5v9Jvwe7w2dForb3YOMRTBCUBwDN9PU2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bZTVSMswsXB5fRk6xT0b3fxHLPBS09mwjR8BZfwIw/s0RpU2U0l1H4AgmrTOuLDnL
         +amHa+fuCTFxB/uUBTM49LcqESuyfbT5RtA66RgB6DBEWDicEtWPVJaeJzyVs8ptvt
         PmAF+bGleBgafxm5QbsyJ8e/EUCiBdzkf9QnXlcQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.20 04/76] USB: serial: option: add Telit ME910 ECM composition
Date:   Fri,  8 Mar 2019 13:49:16 +0100
Message-Id: <20190308124914.946777387@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
References: <20190308124914.789210760@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1148,6 +1148,8 @@ static const struct usb_device_id option
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(3) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910_DUAL_MODEM),
 	  .driver_info = NCTRL(0) | RSVD(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1102, 0xff),	/* Telit ME910 (ECM) */
+	  .driver_info = NCTRL(0) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE910),
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE910_USBCFG4),


