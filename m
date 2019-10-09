Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2311ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD39A21721
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570618157;
	bh=3BSgJs/n43Bhn9gktqoW/EpmMThVE8QNmR/TecEWfWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W4gZhJRs+JtdNvctDeCLxXY86VbvUVOds1+3awR7b2/A/E0EKgdmlzALKYlONDDVO
	 6Y+/qYZXqb+LrqBoyx+dBW8SmzFnuMdVgYtcsfoRA6tZ8gdyJRc92KJtwRZtemnKIN
	 OlyQnWZ+a1bTr4UOTbPiOAiTVQnmi/ijhkdvgF3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbfJIKtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 06:49:16 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38714 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730988AbfJIKtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:49:06 -0400
Received: by mail-lj1-f196.google.com with SMTP id b20so1979683ljj.5;
        Wed, 09 Oct 2019 03:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yqwtz3pnYTZFkAJLkDd3CcxBJSehR/4/DPuBsJC1vEI=;
        b=jSuZPceVBXAZrD8V5lDqK15JlunJcTtrCV1bOkGzfblloeRHdbIs5OkC2xyZmEXdwb
         +4bFsHjePl3h1fSjOzLUIb+F0Gu1VBKL+FuTsCLTCLj+KBm60LKuodLalgwbF+8HKpAs
         gqT2P7vxvHYAN47UWD1PgE9w4lrnHreRkUWqwK56BVbP9WwfdWwDMuMH5IyPF6egFkm2
         asgLXO4Y/Wctagbumf06A621unSVnb/65JIVmk5qLjzkktL/ywadG5VkVGH/T4VMGVNS
         isAAqsmej7hjC/g2gbLFrh9WZ2RJ9saiIUu08KUPB8klL5ImPOat+lopysIID75ckPm2
         psug==
X-Gm-Message-State: APjAAAVSxtceosmQRQu4lgy9f967ShlDApKpA25DPZDZVMx9dO7TI9nH
        aXCY3sxv7zccAozUXgPrXgQ=
X-Google-Smtp-Source: APXvYqyZnzB7/JvvG4Aj/xXx3JeHh1OgS8DJA5y66iuhkyNtEK+2RKT8lp5KyrTW03ALpxTUgkUxKA==
X-Received: by 2002:a2e:97ca:: with SMTP id m10mr346806ljj.168.1570618143045;
        Wed, 09 Oct 2019 03:49:03 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id j26sm344555lja.25.2019.10.09.03.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 03:49:01 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@xi.terra>)
        id 1iI9Wl-0001Z1-6i; Wed, 09 Oct 2019 12:49:07 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 5/6] USB: iowarrior: drop redundant iowarrior mutex
Date:   Wed,  9 Oct 2019 12:48:45 +0200
Message-Id: <20191009104846.5925-6-johan@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191009104846.5925-1-johan@kernel.org>
References: <20191009104846.5925-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the redundant iowarrior mutex introduced by commit 925ce689bb31
("USB: autoconvert trivial BKL users to private mutex") which replaced
an earlier BKL use.

The lock serialised calls to open() against other open() and ioctl(),
but neither is needed.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/misc/iowarrior.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index d844c2098e42..ad29ef51e53f 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -54,9 +54,6 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
-/* Module parameters */
-static DEFINE_MUTEX(iowarrior_mutex);
-
 static struct usb_driver iowarrior_driver;
 
 /*--------------*/
@@ -480,8 +477,6 @@ static long iowarrior_ioctl(struct file *file, unsigned int cmd,
 	if (!buffer)
 		return -ENOMEM;
 
-	/* lock this object */
-	mutex_lock(&iowarrior_mutex);
 	mutex_lock(&dev->mutex);
 
 	/* verify that the device wasn't unplugged */
@@ -574,7 +569,6 @@ static long iowarrior_ioctl(struct file *file, unsigned int cmd,
 error_out:
 	/* unlock the device */
 	mutex_unlock(&dev->mutex);
-	mutex_unlock(&iowarrior_mutex);
 	kfree(buffer);
 	return retval;
 }
@@ -589,22 +583,18 @@ static int iowarrior_open(struct inode *inode, struct file *file)
 	int subminor;
 	int retval = 0;
 
-	mutex_lock(&iowarrior_mutex);
 	subminor = iminor(inode);
 
 	interface = usb_find_interface(&iowarrior_driver, subminor);
 	if (!interface) {
-		mutex_unlock(&iowarrior_mutex);
 		printk(KERN_ERR "%s - error, can't find device for minor %d\n",
 		       __func__, subminor);
 		return -ENODEV;
 	}
 
 	dev = usb_get_intfdata(interface);
-	if (!dev) {
-		mutex_unlock(&iowarrior_mutex);
+	if (!dev)
 		return -ENODEV;
-	}
 
 	mutex_lock(&dev->mutex);
 
@@ -628,7 +618,6 @@ static int iowarrior_open(struct inode *inode, struct file *file)
 
 out:
 	mutex_unlock(&dev->mutex);
-	mutex_unlock(&iowarrior_mutex);
 	return retval;
 }
 
-- 
2.23.0

