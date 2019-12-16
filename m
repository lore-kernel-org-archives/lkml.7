Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B67AC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47739206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519040;
	bh=U+Zy8WDW51twCqB13+h4TM2bIhnae75Z5rp9vowzhX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LNX8UIXwAIlUGGDl8LTH8w0Yl1c7mUFUUVcP5+HdsOMOdBg+6W3RBeZxdXKnMuteC
	 9ZvfpMFzPIk0icYvk+kkI5VvKEuD190WoDEEOuWvagxM3/gf7axzv9MzaH6fh6Ei22
	 Q7NOhZyPICNMS4d/TlbfgHUZqmGaFc6xxlm13UFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfLPR5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:57:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:55948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728179AbfLPR5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:57:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1101F24650;
        Mon, 16 Dec 2019 17:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519034;
        bh=U+Zy8WDW51twCqB13+h4TM2bIhnae75Z5rp9vowzhX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=azbwnre81KjivkWrvrbHjzyRkccz9pqBAmp+8lCyRbEIy4JAwrX22AZAnwkybTxWp
         bBfFzNr1GMzUZFbPKE6P/TKsTQ/lP8FMyT5tkQSGgTnkOR8QSbBG73cu/66szR6LFT
         boNRPyB+D0exJ9iXFePNsegtZhUtoFipQE7wi16g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tilman Schmidt <tilman@imap.cc>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.14 168/267] staging: gigaset: fix illegal free on probe errors
Date:   Mon, 16 Dec 2019 18:48:14 +0100
Message-Id: <20191216174911.706527380@linuxfoundation.org>
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

commit 84f60ca7b326ed8c08582417493982fe2573a9ad upstream.

The driver failed to initialise its receive-buffer pointer, something
which could lead to an illegal free on late probe errors.

Fix this by making sure to clear all driver data at allocation.

Fixes: 2032e2c2309d ("usb_gigaset: code cleanup")
Cc: stable <stable@vger.kernel.org>     # 2.6.33
Cc: Tilman Schmidt <tilman@imap.cc>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20191202085610.12719-3-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/isdn/gigaset/usb-gigaset.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/drivers/isdn/gigaset/usb-gigaset.c
+++ b/drivers/isdn/gigaset/usb-gigaset.c
@@ -574,8 +574,7 @@ static int gigaset_initcshw(struct cards
 {
 	struct usb_cardstate *ucs;
 
-	cs->hw.usb = ucs =
-		kmalloc(sizeof(struct usb_cardstate), GFP_KERNEL);
+	cs->hw.usb = ucs = kzalloc(sizeof(struct usb_cardstate), GFP_KERNEL);
 	if (!ucs) {
 		pr_err("out of memory\n");
 		return -ENOMEM;
@@ -587,9 +586,6 @@ static int gigaset_initcshw(struct cards
 	ucs->bchars[3] = 0;
 	ucs->bchars[4] = 0x11;
 	ucs->bchars[5] = 0x13;
-	ucs->bulk_out_buffer = NULL;
-	ucs->bulk_out_urb = NULL;
-	ucs->read_urb = NULL;
 	tasklet_init(&cs->write_tasklet,
 		     gigaset_modem_fill, (unsigned long) cs);
 


