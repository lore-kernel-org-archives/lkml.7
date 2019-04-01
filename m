Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F010C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1631F20856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139740;
	bh=L8CyF+CMgYTZ0IArEemAwUOqqlJgH4yS12nqa93qBxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hbvvpB8CEeN8ZPRlmtDEVhWKlUJz4lSZ2jYCkd/AgrJn0pqftE8lLEH99iKaD94V1
	 JISNwrtk5MonaOaZNu2Dld7QDRlM6TivKAA6GcrdOsrFEnlP8/twdbL3f4s44nTQrK
	 XIF6f+r0o8jWBf7kTzBK6OQk+IgZfd/aLUR9LQFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732874AbfDAR26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732507AbfDAR2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:28:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CE1421852;
        Mon,  1 Apr 2019 17:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139734;
        bh=L8CyF+CMgYTZ0IArEemAwUOqqlJgH4yS12nqa93qBxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mz1ff+jyAb/Ein55jbBDP8cGn4/bfdCxa9fn/u3vQA9eabJrwwfPBcfE8WCrmXxPb
         OVX/DYANLdXydalL9zUuvpBh6u/wnsNBJWGuxDcBZfFvGSm9DoblTz0uiVDXI/e1tF
         MMOaV64Lt4QWKJ/6fGaUy7K7e8OLfunndhqvNjZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.9 55/56] Revert "USB: core: only clean up what we allocated"
Date:   Mon,  1 Apr 2019 19:03:11 +0200
Message-Id: <20190401170106.887083062@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170103.398401360@linuxfoundation.org>
References: <20190401170103.398401360@linuxfoundation.org>
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

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit cf4df407e0d7cde60a45369c2a3414d18e2d4fdd upstream.

This reverts commit 32fd87b3bbf5f7a045546401dfe2894dbbf4d8c3.

Alan wrote a better fix for this...

Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: stable <stable@vger.kernel.org>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/config.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -763,21 +763,18 @@ void usb_destroy_configuration(struct us
 		return;
 
 	if (dev->rawdescriptors) {
-		for (i = 0; i < dev->descriptor.bNumConfigurations &&
-				i < USB_MAXCONFIG; i++)
+		for (i = 0; i < dev->descriptor.bNumConfigurations; i++)
 			kfree(dev->rawdescriptors[i]);
 
 		kfree(dev->rawdescriptors);
 		dev->rawdescriptors = NULL;
 	}
 
-	for (c = 0; c < dev->descriptor.bNumConfigurations &&
-			c < USB_MAXCONFIG; c++) {
+	for (c = 0; c < dev->descriptor.bNumConfigurations; c++) {
 		struct usb_host_config *cf = &dev->config[c];
 
 		kfree(cf->string);
-		for (i = 0; i < cf->desc.bNumInterfaces &&
-				i < USB_MAXINTERFACES; i++) {
+		for (i = 0; i < cf->desc.bNumInterfaces; i++) {
 			if (cf->intf_cache[i])
 				kref_put(&cf->intf_cache[i]->ref,
 					  usb_release_interface_cache);


