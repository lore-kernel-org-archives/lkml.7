Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9BEECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955A320B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570618144;
	bh=iZdqq4g+rouI4y+bBonKXF4zHGiMTb9gddewiGK6aa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=whvy5ntFNdQBu04EX1Q3oJ+faVTbARH7hHAElo2J55+5898CyFs9rGQF0eKE4PS9w
	 y8P5zsuULIr5fOmCFKPABrAbaXpCkXvEJuWaL7xQ+Ko4sf2aysSURFwsr0m0LgOnDz
	 xwFaOjF7o0a2d5O9F42t6AGEpLQgSaNactp2skIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbfJIKtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 06:49:02 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35948 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfJIKtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:49:01 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so1997781ljj.3;
        Wed, 09 Oct 2019 03:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hpnNo/wLrrqHWo6iUYI3k0Oeb2ujZliIeE/Ue7DBhEk=;
        b=fkwuwcR1x8moZJFbNg5UNTD3MZbsJ/WTv8URL2NtoOcx1zzsYuhvP+w1w129RClj5Y
         9zCAHiRPSRaFDAcS+0J8pxHk5+TV9A+b7lHsqje6gjakdX3IJoEfACM9Pq2ntZmSPvWH
         GPOOM3t+HITiyXn/Zx6dXwyUsNScw8r0xhlblHGACvnofE7ODrgtGfHYf56tQdsbH418
         X7iNOOIInxce8vXidjhTNJGoKzoCKJ4KeVBK17B4fZ+guT6gfNnIXnFupKiKWZHznuYx
         gXQmN+7DP6Z97ImH30b+8XOR5gU7IDAip+Iknrh+WHmWvDaWjasGiNmj5tivaPZsVUw/
         VhfA==
X-Gm-Message-State: APjAAAWundtuUxr3kyGaNmHxbMwsyyNOEwhfQdOifs+74c5KQD3ribjS
        xIAIlugd81sOUEOJh1Fqw3sR/4m6
X-Google-Smtp-Source: APXvYqyLVuDm1GTgl7a58tF/2XvgWyv4UCBSQTOtepqPe8z1dl9e1Q3Zm9HimA0SSZu8TIqRqmVuYw==
X-Received: by 2002:a2e:a41a:: with SMTP id p26mr1783346ljn.15.1570618138521;
        Wed, 09 Oct 2019 03:48:58 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id z26sm356497lji.79.2019.10.09.03.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 03:48:57 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@xi.terra>)
        id 1iI9Wk-0001Yi-Ri; Wed, 09 Oct 2019 12:49:06 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>,
        syzbot+0761012cebf7bdb38137@syzkaller.appspotmail.com
Subject: [PATCH 1/6] USB: iowarrior: fix use-after-free on disconnect
Date:   Wed,  9 Oct 2019 12:48:41 +0200
Message-Id: <20191009104846.5925-2-johan@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191009104846.5925-1-johan@kernel.org>
References: <20191009104846.5925-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent fix addressing a deadlock on disconnect introduced a new bug
by moving the present flag out of the critical section protected by the
driver-data mutex. This could lead to a racing release() freeing the
driver data before disconnect() is done with it.

Due to insufficient locking a related use-after-free could be triggered
also before the above mentioned commit. Specifically, the driver needs
to hold the driver-data mutex also while checking the opened flag at
disconnect().

Fixes: c468a8aa790e ("usb: iowarrior: fix deadlock on disconnect")
Fixes: 946b960d13c1 ("USB: add driver for iowarrior devices.")
Cc: stable <stable@vger.kernel.org>	# 2.6.21
Reported-by: syzbot+0761012cebf7bdb38137@syzkaller.appspotmail.com
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/misc/iowarrior.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index f5bed9f29e56..4fe1d3267b3c 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -866,8 +866,6 @@ static void iowarrior_disconnect(struct usb_interface *interface)
 	dev = usb_get_intfdata(interface);
 	mutex_lock(&iowarrior_open_disc_lock);
 	usb_set_intfdata(interface, NULL);
-	/* prevent device read, write and ioctl */
-	dev->present = 0;
 
 	minor = dev->minor;
 	mutex_unlock(&iowarrior_open_disc_lock);
@@ -878,8 +876,7 @@ static void iowarrior_disconnect(struct usb_interface *interface)
 	mutex_lock(&dev->mutex);
 
 	/* prevent device read, write and ioctl */
-
-	mutex_unlock(&dev->mutex);
+	dev->present = 0;
 
 	if (dev->opened) {
 		/* There is a process that holds a filedescriptor to the device ,
@@ -889,8 +886,10 @@ static void iowarrior_disconnect(struct usb_interface *interface)
 		usb_kill_urb(dev->int_in_urb);
 		wake_up_interruptible(&dev->read_wait);
 		wake_up_interruptible(&dev->write_wait);
+		mutex_unlock(&dev->mutex);
 	} else {
 		/* no process is using the device, cleanup now */
+		mutex_unlock(&dev->mutex);
 		iowarrior_delete(dev);
 	}
 
-- 
2.23.0

