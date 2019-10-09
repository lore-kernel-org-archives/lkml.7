Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300ADC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0397C21721
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570618150;
	bh=B01r0ERXQoQn7IbBA+bn58b0ZTkmYMtZrT4YMTMiH1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=axo1I5ipkyDc61tcxuqXM7/TT/CIydyBG7y3/dftWT/g/uSvaVu1Bpul9AgGYObob
	 VxTWYLaRbuTWmxNwrf7Jv5fLAiNSnZH4Mv2PhI2tH8flLpt10+vtxeG2lyuOZ1Q4z3
	 +wyXwHe5aKs2ErZPY+ymZN20bi9dUC4O64F7jYAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbfJIKtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 06:49:09 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33280 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfJIKtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:49:04 -0400
Received: by mail-lf1-f68.google.com with SMTP id y127so1301620lfc.0;
        Wed, 09 Oct 2019 03:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1LQbCixt1QlNE9A03/JuuzZsv5WmNTNPRYC7ctJ1dxk=;
        b=PWmWujvT7DwTCfrXRU3Rtgg7RUAtMigSGvLnXz1hzsq9TIffelQ1+HNYYabTBQzthB
         AR0/aw8L+0fQga0FC8PuTCheeQJW+YpP1CoOe5JGGSjezjsJs8EijYZkGxc27JNSFIM/
         W74mKiHqbiilYRICccMqfv+tmngExxxIpzB7kiXupqldZgTc+W7TOm24AY5yH1BIUNDZ
         68T4OkpKiCJH2qUKvdUBal7WxpqqOT1mQXm3p+tV0DlGPlzjbC0TsrkZsKTo8DP/eU7V
         Z9PKgWQeE3Hib0TQ8KYfnQjLPHCHrusYO/jgFNDLQEAoq4HKgL/cRvE1pbYfU3glrC43
         pu0Q==
X-Gm-Message-State: APjAAAUZThm20/C9tax6epHUvM8KLbLKrsqhhXRA9lnJxXHgy+RPIm/M
        /pSQApessISUVWm7uNc+Wvg=
X-Google-Smtp-Source: APXvYqyNokw0VSwedSu94vAEBosXu8uHXBOyAJhAGRXwcwEHa6TifXsy+6v8MKDUDrAPh6kwTxXFhA==
X-Received: by 2002:ac2:4d05:: with SMTP id r5mr1604787lfi.26.1570618141800;
        Wed, 09 Oct 2019 03:49:01 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id w17sm378114lfl.43.2019.10.09.03.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 03:48:59 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@xi.terra>)
        id 1iI9Wl-0001Yw-3W; Wed, 09 Oct 2019 12:49:07 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/6] USB: iowarrior: drop redundant disconnect mutex
Date:   Wed,  9 Oct 2019 12:48:44 +0200
Message-Id: <20191009104846.5925-5-johan@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191009104846.5925-1-johan@kernel.org>
References: <20191009104846.5925-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the redundant disconnect mutex which was introduced after the
open-disconnect race had been addressed generally in USB core by commit
d4ead16f50f9 ("USB: prevent char device open/deregister race").

Specifically, the rw-semaphore in core guarantees that all calls to
open() will have completed and that no new calls to open() will occur
after usb_deregister_dev() returns. Hence there is no need use the
driver data as an inverted disconnected flag.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/misc/iowarrior.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index f405fa734bcc..d844c2098e42 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -58,7 +58,6 @@ MODULE_LICENSE("GPL");
 static DEFINE_MUTEX(iowarrior_mutex);
 
 static struct usb_driver iowarrior_driver;
-static DEFINE_MUTEX(iowarrior_open_disc_lock);
 
 /*--------------*/
 /*     data     */
@@ -601,16 +600,13 @@ static int iowarrior_open(struct inode *inode, struct file *file)
 		return -ENODEV;
 	}
 
-	mutex_lock(&iowarrior_open_disc_lock);
 	dev = usb_get_intfdata(interface);
 	if (!dev) {
-		mutex_unlock(&iowarrior_open_disc_lock);
 		mutex_unlock(&iowarrior_mutex);
 		return -ENODEV;
 	}
 
 	mutex_lock(&dev->mutex);
-	mutex_unlock(&iowarrior_open_disc_lock);
 
 	/* Only one process can open each device, no sharing. */
 	if (dev->opened) {
@@ -842,7 +838,6 @@ static int iowarrior_probe(struct usb_interface *interface,
 	if (retval) {
 		/* something prevented us from registering this driver */
 		dev_err(&interface->dev, "Not able to get a minor for this device.\n");
-		usb_set_intfdata(interface, NULL);
 		goto error;
 	}
 
@@ -866,16 +861,8 @@ static int iowarrior_probe(struct usb_interface *interface,
  */
 static void iowarrior_disconnect(struct usb_interface *interface)
 {
-	struct iowarrior *dev;
-	int minor;
-
-	dev = usb_get_intfdata(interface);
-	mutex_lock(&iowarrior_open_disc_lock);
-	usb_set_intfdata(interface, NULL);
-
-	minor = dev->minor;
-	mutex_unlock(&iowarrior_open_disc_lock);
-	/* give back our minor - this will call close() locks need to be dropped at this point*/
+	struct iowarrior *dev = usb_get_intfdata(interface);
+	int minor = dev->minor;
 
 	usb_deregister_dev(interface, &iowarrior_class);
 
-- 
2.23.0

