Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5235CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235002070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582063;
	bh=vD24KTYdgdJB3spyUTLMyzy0NJeiqJF0oQ4Yi7k3LRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SxHmOnJBYJ17ND2BwrOo70lT0z3afx9iGMxzUkjdA30hrO8jq1Q+LYs1YKT32MY/o
	 IjVDJXCI6MhmriuUZCA9SMk+N7Jc/oaqraKizs20Aljy9Ov7uif78aV6w2FcAkJade
	 8AoI3iBCa8leNn+GArJXEiCnQHTzOuXAdcP7FI+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbfCZGeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:34:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731441AbfCZGeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:34:17 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B00C9206C0;
        Tue, 26 Mar 2019 06:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582056;
        bh=vD24KTYdgdJB3spyUTLMyzy0NJeiqJF0oQ4Yi7k3LRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NGVz+Z2vIhxBJ8Y0EUR8fN3A3l3QxYZE6/awsRK61KMjrvVS/+h8bbkHnjHGauPXJ
         Ts53pefnpHlqPLjqDQyhecWfLYtSu+qIb438umxMfUi79P7fNvvEYlOeGNeBmLZ44B
         sa/DcPEtxE5SmSvty3xwEh6qUrLczpH2LvxyJevg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.14 32/41] USB: core: only clean up what we allocated
Date:   Tue, 26 Mar 2019 15:30:09 +0900
Message-Id: <20190326042651.655316226@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042649.889479098@linuxfoundation.org>
References: <20190326042649.889479098@linuxfoundation.org>
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
@@ -768,18 +768,21 @@ void usb_destroy_configuration(struct us
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


