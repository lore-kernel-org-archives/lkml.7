Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917EFC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5EB20CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519659;
	bh=1ZYy98CPAyq93GUIgcw6UU4FpMPiCZDurkn4EcsWQtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IXankTf/UE/asUKxm0RBBPMWF5eS8grFYHCvTSMKRyBPWgkurmKM6EiN5aIY11mc9
	 63lwGJzW9Xpg6RvRE4/L8ZH+EwtR0ydN371l1WyEsk+aWjw1j9qSRFTBNsA348JfhK
	 m3kyxNqkchfmuz6+UNLREwmSLT0m72BYeENjdPFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbfLPSHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:07:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:48696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730160AbfLPSHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:07:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B0D0206E0;
        Mon, 16 Dec 2019 18:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519654;
        bh=1ZYy98CPAyq93GUIgcw6UU4FpMPiCZDurkn4EcsWQtw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZvN9HUYOvjI1mVUoN2RoSmbosgAnjA3aFeR0+jVNjfJeG8Emii1x4qNFed2Aw68Pt
         1nxCNnlAJVQCTaCa81Zh4tMXWHIA4BfTaWglYgVlcfi+t/Mvzpql9fZ94cXMYe0zyP
         brE6Z82vNCRBsQk7TlX3XAJfIxa9ZdKt1FRJnD+Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.3 015/180] staging: rtl8712: fix interface sanity check
Date:   Mon, 16 Dec 2019 18:47:35 +0100
Message-Id: <20191216174809.143033848@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174806.018988360@linuxfoundation.org>
References: <20191216174806.018988360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit c724f776f048538ecfdf53a52b7a522309f5c504 upstream.

Make sure to use the current alternate setting when verifying the
interface descriptors to avoid binding to an invalid interface.

Failing to do so could cause the driver to misbehave or trigger a WARN()
in usb_submit_urb() that kernels with panic_on_warn set would choke on.

Fixes: 2865d42c78a9 ("staging: r8712u: Add the new driver to the mainline kernel")
Cc: stable <stable@vger.kernel.org>     # 2.6.37
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20191210114751.5119-3-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/rtl8712/usb_intf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -247,7 +247,7 @@ static uint r8712_usb_dvobj_init(struct
 
 	pdvobjpriv->padapter = padapter;
 	padapter->eeprom_address_size = 6;
-	phost_iface = &pintf->altsetting[0];
+	phost_iface = pintf->cur_altsetting;
 	piface_desc = &phost_iface->desc;
 	pdvobjpriv->nr_endpoint = piface_desc->bNumEndpoints;
 	if (pusbd->speed == USB_SPEED_HIGH) {


