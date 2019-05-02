Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01817C04AAA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD08F2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556810520;
	bh=OYTIbF2jgOSmXqzbTcTHi5tWBXlnP5dmRSJdcUoc7M8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xw0JPTTQw6V2PrBEm3eLsrx92JGitDpzjo1mhPGk6X6B0HTwAHPYipkUl0SesHRyP
	 HtH2F8pYoCiH/HopN83AMUzy7STDTmvuh/3vH/nH2tYj0BSaZcx42G13JyweeuPbv5
	 54DP7yiOs62sJCw0FH5YMcFkMlrTU4PF8q2TIebg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfEBPWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:22:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfEBPV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:21:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 829CF2133F;
        Thu,  2 May 2019 15:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810517;
        bh=OYTIbF2jgOSmXqzbTcTHi5tWBXlnP5dmRSJdcUoc7M8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kyJqrUXbfjw2owVbF1r4s+BiQK9PaLMpDvZCpoboku4rlm5KjAgbnO+glSSADtlAV
         dNKQkrKK+6p0MoqJyl8iOXU1Jqwu4ZyQVn3uJCZGK2L/AAtJh2Y3Q2tNqt46HODgd+
         WAUdSP5rSurByNNeBDTcnO/Wjq2va6EjYTi/SnW0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.9 02/32] usbnet: ipheth: fix potential null pointer dereference in ipheth_carrier_set
Date:   Thu,  2 May 2019 17:20:48 +0200
Message-Id: <20190502143315.648326898@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143314.649935114@linuxfoundation.org>
References: <20190502143314.649935114@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo A. R. Silva <garsilva@embeddedor.com>

commit 61c59355e0154a938b28710dfa6c1d8be2ddcefa upstream.

_dev_ is being dereferenced before it is null checked, hence there
is a potential null pointer dereference.

Fix this by moving the pointer dereference after _dev_ has been null
checked.

Addresses-Coverity-ID: 1462020
Fixes: bb1b40c7cb86 ("usbnet: ipheth: prevent TX queue timeouts when device not ready")
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/usb/ipheth.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -290,12 +290,15 @@ static void ipheth_sndbulk_callback(stru
 
 static int ipheth_carrier_set(struct ipheth_device *dev)
 {
-	struct usb_device *udev = dev->udev;
+	struct usb_device *udev;
 	int retval;
+
 	if (!dev)
 		return 0;
 	if (!dev->confirmed_pairing)
 		return 0;
+
+	udev = dev->udev;
 	retval = usb_control_msg(udev,
 			usb_rcvctrlpipe(udev, IPHETH_CTRL_ENDP),
 			IPHETH_CMD_CARRIER_CHECK, /* request */


