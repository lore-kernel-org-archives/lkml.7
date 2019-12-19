Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD7AC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8ED62467F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576780710;
	bh=V9wWOpAJ6p77csYinS0v1hmyOlCVe7A4SXU7cghYdv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xZILbL2C7IzTv8UwwbWOdZDeUK1byveipQRo1xnxHSbPr5EDrjpMCsHAJu+Fcxs0q
	 phD1PaqPBEov4+L7ZbjJQ54MWeg/9kMgr/t7unTGgebZ4+nQUEFSHo4I2D7IN5wO+f
	 ZcnkqSATnwhhHRS0nj1z/8kf+GONuqXwmarEsF7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbfLSSi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:38:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:56398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbfLSSiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:38:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFAC5222C2;
        Thu, 19 Dec 2019 18:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780705;
        bh=V9wWOpAJ6p77csYinS0v1hmyOlCVe7A4SXU7cghYdv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oe7BrX/pdhQ/Do6qwx+jJQXOF0Cm6JwjY9Uu5xJieYfnufap7d3hdHXieqgx0qU6I
         EFL/mUYLsUqBM4G49DIUsAcikq/BaHav+bpoA4kEMqU3JrVGu6yRkGRoHXspvlwr7/
         ZWEDSkIkTBBDwf/GldvPakgZpi7ecyx/XHg7lGGg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 084/162] staging: rtl8188eu: fix interface sanity check
Date:   Thu, 19 Dec 2019 19:33:12 +0100
Message-Id: <20191219183212.909108681@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183150.477687052@linuxfoundation.org>
References: <20191219183150.477687052@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 74ca34118a0e05793935d804ccffcedd6eb56596 upstream.

Make sure to use the current alternate setting when verifying the
interface descriptors to avoid binding to an invalid interface.

Failing to do so could cause the driver to misbehave or trigger a WARN()
in usb_submit_urb() that kernels with panic_on_warn set would choke on.

Fixes: c2478d39076b ("staging: r8188eu: Add files for new driver - part 20")
Cc: stable <stable@vger.kernel.org>     # 3.12
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20191210114751.5119-2-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/rtl8188eu/os_dep/usb_intf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/rtl8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
@@ -82,7 +82,7 @@ static struct dvobj_priv *usb_dvobj_init
 	phost_conf = pusbd->actconfig;
 	pconf_desc = &phost_conf->desc;
 
-	phost_iface = &usb_intf->altsetting[0];
+	phost_iface = usb_intf->cur_altsetting;
 	piface_desc = &phost_iface->desc;
 
 	pdvobjpriv->NumInterfaces = pconf_desc->bNumInterfaces;


