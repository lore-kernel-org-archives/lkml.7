Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0F5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111D4208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140159;
	bh=is1eLUR4KJx7GmFXAB4e8gPubwfVkMldpxviVPJt+wY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m7b8AeeFhO2rkwkd2CaIVC9StcApTcrfBWG6JibUz/QrR+zN9q1Gg9uczYYirA6V1
	 jn/wGQqG3LMJ6Fo0yZzXGGyx43kS1qzfkh627Whuotgc9TXwScvfcK4LUjxqV/oMPx
	 zOikQSoM2Wd+BGmunIUa+g4SWFh2iN25ZZQiMwOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387963AbfDARf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:35:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729666AbfDARfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:35:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 347AB20880;
        Mon,  1 Apr 2019 17:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140145;
        bh=is1eLUR4KJx7GmFXAB4e8gPubwfVkMldpxviVPJt+wY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HyCjeKcKYmG3NzpHuZnZo7F+aTw/uQ2RpH8AJSB+MQWyaQkVSeeMp85BuZf/VXwDI
         wXY5laSZmJi4Oxvyr+WqjtHtvaTJJp2z/eYcoZgipq4E7yeTV8LPE5EDUASzZoc3VP
         RVxKKMcifyMWDvYKsgTerQGulw4SEyjHvx2XjtVw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lin Yi <teroincn@163.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 118/131] USB: serial: mos7720: fix mos_parport refcount imbalance on error path
Date:   Mon,  1 Apr 2019 19:03:08 +0200
Message-Id: <20190401170101.463480224@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lin Yi <teroincn@163.com>

commit 2908b076f5198d231de62713cb2b633a3a4b95ac upstream.

The write_parport_reg_nonblock() helper takes a reference to the struct
mos_parport, but failed to release it in a couple of error paths after
allocation failures, leading to a memory leak.

Johan said that move the kref_get() and mos_parport assignment to the
end of urbtrack initialisation is a better way, so move it. and
mos_parport do not used until urbtrack initialisation.

Signed-off-by: Lin Yi <teroincn@163.com>
Fixes: b69578df7e98 ("USB: usbserial: mos7720: add support for parallel port on moschip 7715")
Cc: stable <stable@vger.kernel.org>     # 2.6.35
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/mos7720.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -368,8 +368,6 @@ static int write_parport_reg_nonblock(st
 	if (!urbtrack)
 		return -ENOMEM;
 
-	kref_get(&mos_parport->ref_count);
-	urbtrack->mos_parport = mos_parport;
 	urbtrack->urb = usb_alloc_urb(0, GFP_ATOMIC);
 	if (!urbtrack->urb) {
 		kfree(urbtrack);
@@ -390,6 +388,8 @@ static int write_parport_reg_nonblock(st
 			     usb_sndctrlpipe(usbdev, 0),
 			     (unsigned char *)urbtrack->setup,
 			     NULL, 0, async_complete, urbtrack);
+	kref_get(&mos_parport->ref_count);
+	urbtrack->mos_parport = mos_parport;
 	kref_init(&urbtrack->ref_count);
 	INIT_LIST_HEAD(&urbtrack->urblist_entry);
 


