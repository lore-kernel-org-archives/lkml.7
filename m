Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9103DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDA120823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553581926;
	bh=12IooVjyAEfCTMMZbwj0jQjOcNrx8uCB2OtNLspzVN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yhw32xDimIhvNzhfhuhHnJFeufxHRVy7GmRoDlXnac89o7+CdP9HQ7t4hMvLLg9V4
	 /vFFUwF1HGULNbly7c5dXf+vSD85ELTVtwttVTm6xw9De7hw0yO77PxhfZQiIOGIq+
	 zCA+0d/JJ0jXDr399MCaugBnIOu1GoP7WmuL3qng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbfCZGcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:32:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731303AbfCZGcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:32:02 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4754220856;
        Tue, 26 Mar 2019 06:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553581922;
        bh=12IooVjyAEfCTMMZbwj0jQjOcNrx8uCB2OtNLspzVN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ji5xdtaDO1uGdo0VaCd94Rjqjef9OrjS/LXmO2VaVrGxavTkPSG02VLUMMwx1Xl2Z
         Rl0qncDo/1AjsLZ2PixbWwWTQAN0XstpPfiF7FoJP4TLteTqISdtI+Esof0KRZtyvp
         uQ62rK5oOyjPbNYN/Hp2gPaqP1WS8jG8iSIyTZgI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.9 25/30] USB: core: only clean up what we allocated
Date:   Tue, 26 Mar 2019 15:30:04 +0900
Message-Id: <20190326042608.413616958@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042607.558087893@linuxfoundation.org>
References: <20190326042607.558087893@linuxfoundation.org>
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
@@ -763,18 +763,21 @@ void usb_destroy_configuration(struct us
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


