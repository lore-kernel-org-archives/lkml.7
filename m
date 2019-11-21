Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB8EC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D6420674
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gG6UV0jN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfKUPWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:22:46 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51279 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfKUPWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:22:45 -0500
Received: by mail-wm1-f66.google.com with SMTP id g206so3897616wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 07:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/QUadaJCeZcD2+8+mKTLJYldkMqUQ027wQBvZHXhl6Y=;
        b=gG6UV0jNI2NeY850UKoCqYROQ9KetXMU9fgBVP0OoLCUwQrsA/Xy9cFp2O0szlc1R8
         a1ELzKti/pqs+uI4pF5jiGnqUQGQ2ttOvGr24NXb0Y8rZNJKvTU9+DE1tXf2OInsKAbJ
         ZSJbljPJ2rs7316lPrDiDcXPFwZXcQ7UEqw8ihl5KHvWWgQLVpSyWhDL8TXBP0clzYT9
         Bi2SRoefLqRUu3IZFxooeoTFYyvdunID9gpYl8E/rOGqwdKv8hqtgZjU2hXXsoCRQ0eg
         B18VV2UCvLUTBQ7B2AoH9dmsc7h8E3uq8wEhJA2AkPsCBtnIIgweNqrJTIyF2/QXj2ZX
         GJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/QUadaJCeZcD2+8+mKTLJYldkMqUQ027wQBvZHXhl6Y=;
        b=OXHcPZAUo8qcJxBQi/aMq1tN7+R/kZ332OHR0ujgM5OTmyd0CF+Z+aDXR1EIyrfLJP
         Lok8pmZ7JwPj2es7EsYt8zNozqAfrZ5Zu6mqy/yZv9pWlhPhqrqS8QS8C1IZma047dFN
         KNEmSecovAvpdQlDtSCg+tGynXsmcEhvgeb1WH1VH4sj1B+y0mk194+TZ5VlJheowxns
         OANYJuuUI8sZvqNiJMLoLT5dteDneEr+YqxsKa7ZfPILyIJZuSipFB3L+Zv67QLSFQpn
         ZHYPwGutnV4LySRD8LH9JUdHCqFIduqvDVOCHVd3fUDvAvrJVgJqEupd0bJeXQ57dmuv
         iUYw==
X-Gm-Message-State: APjAAAWUY8Lr31OdV1/s1Bhzk2/UHNQy7R6wpriZ8LLrdVSh+FlNr5Lu
        hL7khHkwSXRSUgnDKoaRvWg=
X-Google-Smtp-Source: APXvYqzmKSvdvICa59slLTFFLxir7/tSh5t+rQmo9mQ3lLpeVjKFEard20Gv+Wx5ZlTgh2n4KJvVdw==
X-Received: by 2002:a1c:a78b:: with SMTP id q133mr10578720wme.115.1574349763302;
        Thu, 21 Nov 2019 07:22:43 -0800 (PST)
Received: from debian.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id t12sm3499467wrx.93.2019.11.21.07.22.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 07:22:42 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v2 2/2] tty: use tty_init_dev_retry() to workaround a race condition
Date:   Thu, 21 Nov 2019 15:22:39 +0000
Message-Id: <20191121152239.28405-2-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191121152239.28405-1-sudipm.mukherjee@gmail.com>
References: <20191121152239.28405-1-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be a race condition in tty drivers and I could see on
many boot cycles a NULL pointer dereference as tty_init_dev() tries to
do 'tty->port->itty = tty' even though tty->port is NULL.
'tty->port' will be set by the driver and if the driver has not yet done
it before we open the tty device we can get to this situation. By adding
some extra debug prints, I noticed that:

6.650130: uart_add_one_port
6.663849: register_console
6.664846: tty_open
6.674391: tty_init_dev
6.675456: tty_port_link_device

uart_add_one_port() registers the console, as soon as it registers, the
userspace tries to use it and that leads to tty_open() but
uart_add_one_port() has not yet done tty_port_link_device() and so
tty->port is not yet configured when control reaches tty_init_dev().

So, add one retry and use tty_init_dev_retry().

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---

v1: had some hardcoded numbers which were difficult to understand.
https://lore.kernel.org/lkml/20191120151709.14148-2-sudipm.mukherjee@gmail.com/

I know this is not a proper fix, and the proper fix should have been to
have a lock. But that will be too intrusive and adding retry was a safer
option than that.

 drivers/tty/tty_io.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 95d7abeca254..f71a11895230 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1945,6 +1945,7 @@ EXPORT_SYMBOL_GPL(tty_kopen);
 /**
  *	tty_open_by_driver	-	open a tty device
  *	@device: dev_t of device to open
+ *	@retry: number of times to retry if tty_init_dev_retry fails
  *	@filp: file pointer to tty
  *
  *	Performs the driver lookup, checks for a reopen, or otherwise
@@ -1957,7 +1958,7 @@ EXPORT_SYMBOL_GPL(tty_kopen);
  *	  - concurrent tty driver removal w/ lookup
  *	  - concurrent tty removal from driver table
  */
-static struct tty_struct *tty_open_by_driver(dev_t device,
+static struct tty_struct *tty_open_by_driver(dev_t device, int retry,
 					     struct file *filp)
 {
 	struct tty_struct *tty;
@@ -2001,7 +2002,7 @@ static struct tty_struct *tty_open_by_driver(dev_t device,
 			tty = ERR_PTR(retval);
 		}
 	} else { /* Returns with the tty_lock held for now */
-		tty = tty_init_dev(driver, index);
+		tty = tty_init_dev_retry(driver, index, retry);
 		mutex_unlock(&tty_mutex);
 	}
 out:
@@ -2036,7 +2037,7 @@ static struct tty_struct *tty_open_by_driver(dev_t device,
 static int tty_open(struct inode *inode, struct file *filp)
 {
 	struct tty_struct *tty;
-	int noctty, retval;
+	int noctty, retval, retry = 1;
 	dev_t device = inode->i_rdev;
 	unsigned saved_flags = filp->f_flags;
 
@@ -2049,7 +2050,7 @@ static int tty_open(struct inode *inode, struct file *filp)
 
 	tty = tty_open_current_tty(device, filp);
 	if (!tty)
-		tty = tty_open_by_driver(device, filp);
+		tty = tty_open_by_driver(device, retry--, filp);
 
 	if (IS_ERR(tty)) {
 		tty_free_file(filp);
-- 
2.11.0

