Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD04FA372F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87331207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264413;
	bh=vUuNRPi0giYYGTuJjTLfH79nTUgyyKJXjKsXqgR5Pg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oq2OECKZiKX9i1OQ7eNDi8HHo58xvexFFcjZnqv/yzLS7xRIGBVviMzu2ob+jSwjp
	 p4g7DvxExdnWh0ocFngk5hbLwoSH9+ojpY8yLhBphZ9jB7HMFN8uLqfE++oW4uO8M3
	 Zr8q4fhVv9nprnSGg899s25sz4o3FG51orG6mMxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405752AbfJPWUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:20:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394914AbfJPVxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:53:53 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E806B21928;
        Wed, 16 Oct 2019 21:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262833;
        bh=vUuNRPi0giYYGTuJjTLfH79nTUgyyKJXjKsXqgR5Pg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aESJMlQYAs9uhbNenSr5CfBsbPgr/ogbmQEalr5qAy6ggpq7nL/rqZBtdv1jfz48P
         rJEGr3m5BUBWettEixMgs1VkYQZ+clZLOsiGYZaotTcLs6KDTCx4wPRYvxeeJDFzxw
         N7j0uHj6c7awzr9Rxr/avclT3ryON6Unr/eztBLI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 76/79] media: stkwebcam: fix runtime PM after driver unbind
Date:   Wed, 16 Oct 2019 14:50:51 -0700
Message-Id: <20191016214833.510973225@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214729.758892904@linuxfoundation.org>
References: <20191016214729.758892904@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 30045f2174aab7fb4db7a9cf902d0aa6c75856a7 upstream.

Since commit c2b71462d294 ("USB: core: Fix bug caused by duplicate
interface PM usage counter") USB drivers must always balance their
runtime PM gets and puts, including when the driver has already been
unbound from the interface.

Leaving the interface with a positive PM usage counter would prevent a
later bound driver from suspending the device.

Note that runtime PM has never actually been enabled for this driver
since the support_autosuspend flag in its usb_driver struct is not set.

Fixes: c2b71462d294 ("USB: core: Fix bug caused by duplicate interface PM usage counter")
Cc: stable <stable@vger.kernel.org>
Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20191001084908.2003-5-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/stkwebcam/stk-webcam.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/media/usb/stkwebcam/stk-webcam.c
+++ b/drivers/media/usb/stkwebcam/stk-webcam.c
@@ -642,8 +642,7 @@ static int v4l_stk_release(struct file *
 		dev->owner = NULL;
 	}
 
-	if (is_present(dev))
-		usb_autopm_put_interface(dev->interface);
+	usb_autopm_put_interface(dev->interface);
 	mutex_unlock(&dev->lock);
 	return v4l2_fh_release(fp);
 }


