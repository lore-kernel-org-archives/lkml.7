Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A781C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E41B2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521935;
	bh=y6rnEU77n16s4mST6pvUdKrdxHfmcibG65MT/rSN5tE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V2ZJUUfuVb7wJZkFRKlopuoi+zY1q2zzXBHTClIcm6BV7oVumcZUaPXpeoS/elJhB
	 Sjqmqx8YeJMRWNkTozMPZOxo4vbmR7Yhwjm7dnsXJCft7CUGdGUtSk/V3ojd3aitUB
	 XNerI3BGw53vYb7FsyVYS5J/fIxUqG8KgW0ha7RM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfLPR5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:57:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:55720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbfLPR5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:57:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4581206B7;
        Mon, 16 Dec 2019 17:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519027;
        bh=y6rnEU77n16s4mST6pvUdKrdxHfmcibG65MT/rSN5tE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GpJ8LpCwW2QI4BTLvAlWrSPj7aLqRJdVdXFLf7aUvR5Qe5X/X3b+KTdLN/f4Umlau
         DyEuOWT4IELsR2tx8LgtQrZaFC6t5clrKplPnHjnBmPQ7nSrQMwQll1BnDEfv54+pD
         ecA79ZdOPeg2DHMMGttRPtLoLEik4g48Qaxl1FA8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.14 165/267] staging: rtl8188eu: fix interface sanity check
Date:   Mon, 16 Dec 2019 18:48:11 +0100
Message-Id: <20191216174911.543956751@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
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
@@ -78,7 +78,7 @@ static struct dvobj_priv *usb_dvobj_init
 	phost_conf = pusbd->actconfig;
 	pconf_desc = &phost_conf->desc;
 
-	phost_iface = &usb_intf->altsetting[0];
+	phost_iface = usb_intf->cur_altsetting;
 	piface_desc = &phost_iface->desc;
 
 	pdvobjpriv->NumInterfaces = pconf_desc->bNumInterfaces;


