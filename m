Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690B5C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D39208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559923046;
	bh=2fnG7oq6OPEgWewPS9kFsXgF/juGzWp3rCGUmvswdrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZDscjK/fA84rityqDXp4OTF2eujVDKCT05oHfcP14d1AtwgLuArorqSlF2sEEe8N/
	 ItJ2eMYO6E5KxDdOAJ0tCCjZ+FYdYroITHOQe4iG3wCpTsFFqskrnTokDsOEnIwHhd
	 yzshBVwsPHkVU36bPMgA7iIcAAR78hwpwuOrIYog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbfFGP5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:57:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730954AbfFGPny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:43:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B10B621473;
        Fri,  7 Jun 2019 15:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559922234;
        bh=2fnG7oq6OPEgWewPS9kFsXgF/juGzWp3rCGUmvswdrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XNcs1wOz7MT2Tg1UEi9XYkwP7Aoz0agQrMYUhKCeyBNz17dzKpcyixcwzRWF5zD55
         InjB6voI4qs4tH2vTkttFH9zLYEBINm85PMSRCUCzLLkPdWm/CuYvrVqfPhRnZeHJP
         1rNxP6Bk6F3Vw2kjJ3R8UN96Kojhf0XXEQiFtBMU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH 4.19 15/73] media: usb: siano: Fix false-positive "uninitialized variable" warning
Date:   Fri,  7 Jun 2019 17:39:02 +0200
Message-Id: <20190607153850.544665327@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607153848.669070800@linuxfoundation.org>
References: <20190607153848.669070800@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

commit 45457c01171fd1488a7000d1751c06ed8560ee38 upstream.

GCC complains about an apparently uninitialized variable recently
added to smsusb_init_device().  It's a false positive, but to silence
the warning this patch adds a trivial initialization.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-by: kbuild test robot <lkp@intel.com>
CC: <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/siano/smsusb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/usb/siano/smsusb.c
+++ b/drivers/media/usb/siano/smsusb.c
@@ -401,7 +401,7 @@ static int smsusb_init_device(struct usb
 	struct smsusb_device_t *dev;
 	void *mdev;
 	int i, rc;
-	int in_maxp;
+	int in_maxp = 0;
 
 	/* create device object */
 	dev = kzalloc(sizeof(struct smsusb_device_t), GFP_KERNEL);


