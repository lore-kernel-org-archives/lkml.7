Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A27BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFABB20896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140906;
	bh=MQU1huIRTwizLcAd7W9erJ+rKdHKLdkaygxgCzXOPp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rZ5p1sfszMmA2GCPggng9aCQCYxslvX2T7Xe1qFATVb1KdIopzTHrF8Tq1Df/DRl1
	 yRZd2a54/chzT2z6US/fkODvIvR8GFeOdkxLulr7kvLBD61HCUWambwB/ubdjC5oNS
	 cPPruDQ0BWlmaZcKrZqHAf9wZFDRRMCW2/bLIWE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733217AbfDARbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:31:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733181AbfDARbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:31:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 201AC2171F;
        Mon,  1 Apr 2019 17:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139863;
        bh=MQU1huIRTwizLcAd7W9erJ+rKdHKLdkaygxgCzXOPp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IPt9SclqxWWz3eZMz+a7yQw5vz7ZW0GinB/aC3qm+vUbUjcEbW99Fe54ZismBZYNY
         MHrXUsyhEJr3hbaGzjIuFmlxbeM+PsERTXMF4a1TtEHPY8BXo/raaN3UuceOyeXUi8
         YDz24J/3I5oKFUaZR+YnOCBeB6r02TKn8/Bl9TkU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 035/131] USB: core: only clean up what we allocated
Date:   Mon,  1 Apr 2019 19:01:45 +0200
Message-Id: <20190401170055.175465457@linuxfoundation.org>
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

From: Andrey Konovalov <andreyknvl@google.com>

commit 32fd87b3bbf5f7a045546401dfe2894dbbf4d8c3 upstream.

When cleaning up the configurations, make sure we only free the number
of configurations and interfaces that we could have allocated.

Reported-by: Andrey Konovalov <andreyknvl@google.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/config.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -734,18 +734,21 @@ void usb_destroy_configuration(struct us
 		return;
 
 	if (dev->rawdescriptors) {
-		for (i = 0; i < dev->descriptor.bNumConfigurations; i++)
+		for (i = 0; i < dev->descriptor.bNumConfigurations &&
+				i < USB_MAXCONFIG; i++)
 			kfree(dev->rawdescriptors[i]);
 
 		kfree(dev->rawdescriptors);
 		dev->rawdescriptors = NULL;
 	}
 
-	for (c = 0; c < dev->descriptor.bNumConfigurations; c++) {
+	for (c = 0; c < dev->descriptor.bNumConfigurations &&
+			c < USB_MAXCONFIG; c++) {
 		struct usb_host_config *cf = &dev->config[c];
 
 		kfree(cf->string);
-		for (i = 0; i < cf->desc.bNumInterfaces; i++) {
+		for (i = 0; i < cf->desc.bNumInterfaces &&
+				i < USB_MAXINTERFACES; i++) {
 			if (cf->intf_cache[i])
 				kref_put(&cf->intf_cache[i]->ref,
 					  usb_release_interface_cache);


