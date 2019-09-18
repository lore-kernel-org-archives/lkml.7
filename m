Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74975C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D6C2196F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568788082;
	bh=RbgfYFSCI0fRyEkzo9RTB6m27zZJght3pW/pqs5AJuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zuvco3lzXfBU3+guR0trdeq0JSFcUsw7xLX+hfPrI3tTyUuizlPvTPphSNg85vYju
	 sVnmgCYeHcUSAhz7oB3Fibry7liqhPGu1jDkQL7p91R9QdjSK/vEgREcGZTZuoTE5w
	 Ey0e4vpNlMTHNxaFtIL0CrFiW4spvoZqDLtEFDZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbfIRG2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:28:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730612AbfIRG1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:27:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7844921924;
        Wed, 18 Sep 2019 06:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568788075;
        bh=RbgfYFSCI0fRyEkzo9RTB6m27zZJght3pW/pqs5AJuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iCMFgeH3J5JpBFBVXs3xfKsuwmqbviHbm+zFsnWK3W7NAHMTauJdixSn8NkO822cb
         znj8MRJywaT6RbbJC3wT13f2E5F0leKmU0mm9TN/o/9SSH/L/J7eXlf5L+HH0IGUiR
         kmu8/aFah9/iXur1XGYxT9CSaYmFXCFRezSjHhyM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Peng <benquike@gmail.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.2 84/85] rsi: fix a double free bug in rsi_91x_deinit()
Date:   Wed, 18 Sep 2019 08:19:42 +0200
Message-Id: <20190918061238.025709947@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061234.107708857@linuxfoundation.org>
References: <20190918061234.107708857@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Peng <benquike@gmail.com>

commit 8b51dc7291473093c821195c4b6af85fadedbc2f upstream.

`dev` (struct rsi_91x_usbdev *) field of adapter
(struct rsi_91x_usbdev *) is allocated  and initialized in
`rsi_init_usb_interface`. If any error is detected in information
read from the device side,  `rsi_init_usb_interface` will be
freed. However, in the higher level error handling code in
`rsi_probe`, if error is detected, `rsi_91x_deinit` is called
again, in which `dev` will be freed again, resulting double free.

This patch fixes the double free by removing the free operation on
`dev` in `rsi_init_usb_interface`, because `rsi_91x_deinit` is also
used in `rsi_disconnect`, in that code path, the `dev` field is not
 (and thus needs to be) freed.

This bug was found in v4.19, but is also present in the latest version
of kernel. Fixes CVE-2019-15504.

Reported-by: Hui Peng <benquike@gmail.com>
Reported-by: Mathias Payer <mathias.payer@nebelwelt.net>
Signed-off-by: Hui Peng <benquike@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/rsi/rsi_91x_usb.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/net/wireless/rsi/rsi_91x_usb.c
+++ b/drivers/net/wireless/rsi/rsi_91x_usb.c
@@ -645,7 +645,6 @@ fail_rx:
 	kfree(rsi_dev->tx_buffer);
 
 fail_eps:
-	kfree(rsi_dev);
 
 	return status;
 }


