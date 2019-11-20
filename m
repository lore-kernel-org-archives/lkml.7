Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A1FC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8880C20885
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/ItMUe5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbfKTPRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:17:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34174 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfKTPRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:17:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so270470wrr.1;
        Wed, 20 Nov 2019 07:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zNe+B/f1+GJmh7J9+ReN7Gml0+9dDHHFBQ2k30K1xB4=;
        b=f/ItMUe5As0Rec87lUZ/KBKvYsrOPgVbTorC9MElQhIGF9UTcSgzcKjn8G3uHuXFTZ
         e5drqyZ3kO5BpCuq3p3j/1xajnfJ3n556MlD38tskqTTZcCKqmdu9cEdBpAnWHzeFZnp
         IIb72a+XpNtQEeMrBhAu/38p/lniRaGg+KZlNnSUvS5EuG4tf/r/raFX+YmUMjGVRIwy
         OPSbD6+AmZoQABOEc5j3P6+o9c2JGVveyOxt37hHCWGsoCXvl2b0yRKE1/9Dy7nn66K8
         jhe7Dob5kKSDHZvHK9P9PYwP8TVlnHjupFhnJvNsD5LfPZ35qw4Oo1fI6vEBC4/g16Pe
         y+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zNe+B/f1+GJmh7J9+ReN7Gml0+9dDHHFBQ2k30K1xB4=;
        b=I2F4wqvXpF2LAs3IuLFoaYInM15PuxdJn70cgzlLrXJnheAGxwad5oyMP2UU971dIt
         tOf47dRcGsSM93GUr8QIFSZdOnsYN0ttpM0HU29HAd/oVl/zlrS2X6Ki4WOk4ozCT5rK
         1lMufIeVXBAXqmhZOjtPZGyaMXpL/ndjf3ajcaylGqok39rONROGQXfDAgccZbapEmdE
         5oAfK4BuJuf8mI0LfpmaLgX/LzALp0Qpmf+Hq6ANmxuq1OwXbv6bFQAjrJ/CIbOqVHws
         s8wPlX8m9Hhye8XDWED7rXsL7j643VfUj8RGLpIknT9ve0DLwqa7ap/P9glFwB3LjnOQ
         RRSQ==
X-Gm-Message-State: APjAAAVx/nDR5O2ph2SqN97lSDfiTIcyJbRAnXiFjcYSjiz4Flf2KxsI
        vSd7YGVZv3MLVg2PhslvVlw=
X-Google-Smtp-Source: APXvYqx/M7yd99FDF6FQ/cJiU2pIGWU89akDb3eKzw3rVxeRQJfNwGTnECzvvEeUlDhEvc3czzMWGw==
X-Received: by 2002:a5d:6390:: with SMTP id p16mr3797094wru.55.1574263033616;
        Wed, 20 Nov 2019 07:17:13 -0800 (PST)
Received: from debian.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id y19sm7306119wmd.29.2019.11.20.07.17.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 07:17:12 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 1/2] tty: remove unused argument from tty_open_by_driver()
Date:   Wed, 20 Nov 2019 15:17:08 +0000
Message-Id: <20191120151709.14148-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The argument 'inode' passed to tty_open_by_driver() was not being used.
Remove the extra argument.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/tty/tty_io.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index a81807b394d1..cb6370906a6d 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1925,7 +1925,6 @@ EXPORT_SYMBOL_GPL(tty_kopen);
 /**
  *	tty_open_by_driver	-	open a tty device
  *	@device: dev_t of device to open
- *	@inode: inode of device file
  *	@filp: file pointer to tty
  *
  *	Performs the driver lookup, checks for a reopen, or otherwise
@@ -1938,7 +1937,7 @@ EXPORT_SYMBOL_GPL(tty_kopen);
  *	  - concurrent tty driver removal w/ lookup
  *	  - concurrent tty removal from driver table
  */
-static struct tty_struct *tty_open_by_driver(dev_t device, struct inode *inode,
+static struct tty_struct *tty_open_by_driver(dev_t device,
 					     struct file *filp)
 {
 	struct tty_struct *tty;
@@ -2030,7 +2029,7 @@ static int tty_open(struct inode *inode, struct file *filp)
 
 	tty = tty_open_current_tty(device, filp);
 	if (!tty)
-		tty = tty_open_by_driver(device, inode, filp);
+		tty = tty_open_by_driver(device, filp);
 
 	if (IS_ERR(tty)) {
 		tty_free_file(filp);
-- 
2.11.0

