Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFFAFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05840207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264232;
	bh=VSbXwjB/rESacjz5cqElma2cY0HPqi2u7mtCeUhEyZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kTOn/wdSocvM7bxPLzbWh8DJTkmSTVegCMxP3yyhcDi+GuxaQu2Lkpxtxq/aUmmWZ
	 r82ydzrCNWGZu12et8U2xjV6DaowIXpNiMhUxA20Z1gzMQZCQ/tAHfRv0cgV2ZyTD+
	 3DNYdeSrzbnBvVYjEfVJiYuTKbA/l9Smyz4iekGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395112AbfJPVy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:54:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390245AbfJPVyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:54:51 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C14D20872;
        Wed, 16 Oct 2019 21:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262890;
        bh=VSbXwjB/rESacjz5cqElma2cY0HPqi2u7mtCeUhEyZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zBQ7Vlp7OPtns3VJbGF8JftDCop5d3lUOHJF56V1Dvd2EunBvNiHeAeDpKCn1ECI4
         RugevvriTnKldO3xRXEsIcFH8XdC6o/8jMHw3Ylshv2hvJ0z90KQA3lb43yUJWol52
         6YE4rpWHZ/LoAnUAmfuHEKTm8JW7k5BGt7RaG7Xs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>
Subject: [PATCH 4.9 47/92] USB: adutux: remove redundant variable minor
Date:   Wed, 16 Oct 2019 14:50:20 -0700
Message-Id: <20191016214834.728835208@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214759.600329427@linuxfoundation.org>
References: <20191016214759.600329427@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

commit 8444efc4a052332d643ed5c8aebcca148c7de032 upstream.

Variable minor is being assigned but never read, hence it is redundant
and can be removed. Cleans up clang warning:

drivers/usb/misc/adutux.c:770:2: warning: Value stored to 'minor' is
never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/adutux.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/usb/misc/adutux.c
+++ b/drivers/usb/misc/adutux.c
@@ -789,13 +789,11 @@ error:
 static void adu_disconnect(struct usb_interface *interface)
 {
 	struct adu_device *dev;
-	int minor;
 
 	dev = usb_get_intfdata(interface);
 
 	mutex_lock(&dev->mtx);	/* not interruptible */
 	dev->udev = NULL;	/* poison */
-	minor = dev->minor;
 	usb_deregister_dev(interface, &adu_class);
 	mutex_unlock(&dev->mtx);
 


