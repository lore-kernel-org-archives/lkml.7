Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D709C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 13:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38072206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 13:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfEFNQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 09:16:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:56044 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725856AbfEFNQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 09:16:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9C509AC0C;
        Mon,  6 May 2019 13:16:57 +0000 (UTC)
Date:   Mon, 6 May 2019 15:16:56 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux I2C <linux-i2c@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 2/2] eeprom: ee1004: Deal with nack on page selection
Message-ID: <20190506151656.47494e56@endymion>
In-Reply-To: <20190506151539.69ee75e8@endymion>
References: <20190506151539.69ee75e8@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some EE1004 implementations will not properly ack page selection
commands. They still set the page correctly, so there is no actual
error. Deal with this case gracefully by checking the currently
selected page after we receive a nack. If the page is set right then
we can continue.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/eeprom/ee1004.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- linux-5.0.orig/drivers/misc/eeprom/ee1004.c	2019-05-06 11:57:14.333572368 +0200
+++ linux-5.0/drivers/misc/eeprom/ee1004.c	2019-05-06 15:11:06.009718220 +0200
@@ -1,7 +1,7 @@
 /*
  * ee1004 - driver for DDR4 SPD EEPROMs
  *
- * Copyright (C) 2017 Jean Delvare
+ * Copyright (C) 2017-2019 Jean Delvare
  *
  * Based on the at24 driver:
  * Copyright (C) 2005-2007 David Brownell
@@ -124,6 +124,16 @@ static ssize_t ee1004_read(struct file *
 			/* Data is ignored */
 			status = i2c_smbus_write_byte(ee1004_set_page[page],
 						      0x00);
+			if (status == -ENXIO) {
+				/*
+				 * Don't give up just yet. Some memory
+				 * modules will select the page but not
+				 * ack the command. Check which page is
+				 * selected now.
+				 */
+				if (ee1004_get_current_page() == page)
+					status = 0;
+			}
 			if (status < 0) {
 				dev_err(dev, "Failed to select page %d (%d)\n",
 					page, status);

-- 
Jean Delvare
SUSE L3 Support
