Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC7DC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F1B208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfD0P0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:26:22 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34884 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727731AbfD0P0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:26:19 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP3D-0000z8-SF; Sat, 27 Apr 2019 16:15:39 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0004Px-QR; Sat, 27 Apr 2019 16:15:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Wolfram Sang" <wsa@the-dreams.de>, "Yi Zeng" <yizeng@asrmicro.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.647004326@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 030/202] i2c: dev: prevent adapter retries and
 timeout being set as minus value
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Yi Zeng <yizeng@asrmicro.com>

commit 6ebec961d59bccf65d08b13fc1ad4e6272a89338 upstream.

If adapter->retries is set to a minus value from user space via ioctl,
it will make __i2c_transfer and __i2c_smbus_xfer skip the calling to
adapter->algo->master_xfer and adapter->algo->smbus_xfer that is
registered by the underlying bus drivers, and return value 0 to all the
callers. The bus driver will never be accessed anymore by all users,
besides, the users may still get successful return value without any
error or information log print out.

If adapter->timeout is set to minus value from user space via ioctl,
it will make the retrying loop in __i2c_transfer and __i2c_smbus_xfer
always break after the the first try, due to the time_after always
returns true.

Signed-off-by: Yi Zeng <yizeng@asrmicro.com>
[wsa: minor grammar updates to commit message]
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/i2c/i2c-dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -467,9 +467,15 @@ static long i2cdev_ioctl(struct file *fi
 		return i2cdev_ioctl_smbus(client, arg);
 
 	case I2C_RETRIES:
+		if (arg > INT_MAX)
+			return -EINVAL;
+
 		client->adapter->retries = arg;
 		break;
 	case I2C_TIMEOUT:
+		if (arg > INT_MAX)
+			return -EINVAL;
+
 		/* For historical reasons, user-space sets the timeout
 		 * value in units of 10 ms.
 		 */

