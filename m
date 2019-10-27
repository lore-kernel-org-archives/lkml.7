Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6900CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EEB6222CB
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210201;
	bh=vSzc9HsvO8864r7VU+6QocCqs8J+dgGiZwvufdgUIlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DELVh3OMSjnNmODgFxcJE1zKfTHK/dr0jwQiiYBrvYYT6Q3Dz/rAylBLytgEKEc/k
	 dZ/eKdFX8DWXndk9J0/ePfR3KDn8V+jBcOOgSaKRirNyRNQAkrH56lu7UfC/ZDWFqU
	 NjZSDkO6LC2I/dMDIQCKIt9HIQlnm1azG6xWTnpc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfJ0VDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:03:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728261AbfJ0VDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:03:15 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD4C02064A;
        Sun, 27 Oct 2019 21:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210193;
        bh=vSzc9HsvO8864r7VU+6QocCqs8J+dgGiZwvufdgUIlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SCBlHhrrjIDX4vwvvI6hLWj2aJE07T4B82u95tI96AU1woPt47qTXEuVdXnorTRsg
         C9rbdkFXSF6KmjhYhMZ0KUtXZWF5X7AUrOYkASDXK7kQJoLm4AV0MHuabL43dU/iY/
         ADQ5CtqRAm9aWOvAJ93OYpFTmOJyTrN31syUmUW0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 22/41] USB: ldusb: fix memleak on disconnect
Date:   Sun, 27 Oct 2019 22:01:00 +0100
Message-Id: <20191027203118.572227650@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203056.220821342@linuxfoundation.org>
References: <20191027203056.220821342@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit b14a39048c1156cfee76228bf449852da2f14df8 upstream.

If disconnect() races with release() after a process has been
interrupted, release() could end up returning early and the driver would
fail to free its driver data.

Fixes: 2824bd250f0b ("[PATCH] USB: add ldusb driver")
Cc: stable <stable@vger.kernel.org>     # 2.6.13
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20191010125835.27031-2-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/ldusb.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/usb/misc/ldusb.c
+++ b/drivers/usb/misc/ldusb.c
@@ -384,10 +384,7 @@ static int ld_usb_release(struct inode *
 		goto exit;
 	}
 
-	if (mutex_lock_interruptible(&dev->mutex)) {
-		retval = -ERESTARTSYS;
-		goto exit;
-	}
+	mutex_lock(&dev->mutex);
 
 	if (dev->open_count != 1) {
 		retval = -ENODEV;


