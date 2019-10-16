Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5515AFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB0821D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263055;
	bh=mROoGw3K30hCRnp8qGru45WqsaXtMc1lRQErYgNGCVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h/cVrmNuk4/3akxKAqeuLIDDQDBPXeXXPvOvAwYPaIKqSk6GKiTAz6s74UU2MgmUP
	 erPPBeTfJM0aq0gdpdQ5M2SOhcLvz3TkE3cp6AmdshoU2FOucpoqVOyZ+VCPVjbGeA
	 GRlWO+2GVVeaaVHaUpIIKj3SXg4iT3UFhO/DHBpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406677AbfJPV5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:57:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404011AbfJPV4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:56:54 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0C3821A49;
        Wed, 16 Oct 2019 21:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263013;
        bh=mROoGw3K30hCRnp8qGru45WqsaXtMc1lRQErYgNGCVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rwwzClxL9DyoxmnvAtJzUePJvNHtqImfTcETM5HOWAUmns2X/elyFNMeoaEigTTBr
         BSiLfvPZ8s7XcZzieGaaPBhKAH5/72mNkpXjmxPVNNwcb7o/YuuPlOidcGOinMV5V4
         sZ03w9iBQGzE7mLxcelIdLZrYNOEfCkRKi++T2Hg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+0243cb250a51eeefb8cc@syzkaller.appspotmail.com,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.19 15/81] USB: adutux: fix use-after-free on disconnect
Date:   Wed, 16 Oct 2019 14:50:26 -0700
Message-Id: <20191016214820.197503740@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214805.727399379@linuxfoundation.org>
References: <20191016214805.727399379@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 44efc269db7929f6275a1fa927ef082e533ecde0 upstream.

The driver was clearing its struct usb_device pointer, which it used as
an inverted disconnected flag, before deregistering the character device
and without serialising against racing release().

This could lead to a use-after-free if a racing release() callback
observes the cleared pointer and frees the driver data before
disconnect() is finished with it.

This could also lead to NULL-pointer dereferences in a racing open().

Fixes: f08812d5eb8f ("USB: FIx locks and urb->status in adutux (updated)")
Cc: stable <stable@vger.kernel.org>     # 2.6.24
Reported-by: syzbot+0243cb250a51eeefb8cc@syzkaller.appspotmail.com
Tested-by: syzbot+0243cb250a51eeefb8cc@syzkaller.appspotmail.com
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20190925092913.8608-1-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/adutux.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/usb/misc/adutux.c
+++ b/drivers/usb/misc/adutux.c
@@ -764,14 +764,15 @@ static void adu_disconnect(struct usb_in
 
 	dev = usb_get_intfdata(interface);
 
-	mutex_lock(&dev->mtx);	/* not interruptible */
-	dev->udev = NULL;	/* poison */
 	usb_deregister_dev(interface, &adu_class);
-	mutex_unlock(&dev->mtx);
 
 	mutex_lock(&adutux_mutex);
 	usb_set_intfdata(interface, NULL);
 
+	mutex_lock(&dev->mtx);	/* not interruptible */
+	dev->udev = NULL;	/* poison */
+	mutex_unlock(&dev->mtx);
+
 	/* if the device is not opened, then we clean up right now */
 	if (!dev->open_count)
 		adu_delete(dev);


