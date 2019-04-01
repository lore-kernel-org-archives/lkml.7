Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1B8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05C520880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139550;
	bh=fV33FAJV2h00IzQU5/+0rcb/2+89+QrngWNJIYeRIo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0uBKosZi0/etn881skG3OE5AtpZs2MClgrSdMND8zJun4j3+48CUNqdkMz/qXPboo
	 +cbP0QRVwzFVvSW2HohEBhyF0Dn/QjaNmK4pmKIgv3MVVSM8mFU6k8+ikN6Jzqe6ou
	 +7YNtYvq50Znu1pkpz11797MRRDM9ievUg0FkDiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732463AbfDARZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:25:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732452AbfDARZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:25:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA39720880;
        Mon,  1 Apr 2019 17:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139543;
        bh=fV33FAJV2h00IzQU5/+0rcb/2+89+QrngWNJIYeRIo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UdzVZ8ST8mmNmdz31rcvAZSlMc0N4HIm8+Ukbmpk3DOAx2oNu3aUeZi8sxAH9BOLe
         fQwEXYeP+fUB9UVw8/hbTCbMqt1uyrh+7KmUQuTCJixaIIZX4EYYJeaQLuWdPsl1ML
         lVsmMxIrPbMm0/psRe8qbi0grbB8avPJCQoCh34o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.14 106/107] Revert "USB: core: only clean up what we allocated"
Date:   Mon,  1 Apr 2019 19:03:01 +0200
Message-Id: <20190401170055.459278477@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -768,21 +768,18 @@ void usb_destroy_configuration(struct us
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


