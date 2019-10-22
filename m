Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1802BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF32621872
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571754729;
	bh=NskWIJpyVHM8w6Z1Pkzza2wmp9kv9JI+loaU9VCticY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jx6IEW2sGVxKrwVtuEglqJFgG+HCY/0SsoeC4KpO8t/O3gfCJr3uypGr6F3g10vvI
	 vjD7BvKAfx1yY0aw5C8TI+Ciu1pmr8rzkAr+jEttepdYrdNxmxo3PGBSqf2L2Iyy4x
	 G0pUv2XUOrhMnU/X2aGgbQeFdJ05rq4IyC6M+vN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732042AbfJVOcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 10:32:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33152 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbfJVOcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 10:32:05 -0400
Received: by mail-lf1-f68.google.com with SMTP id y127so13328396lfc.0;
        Tue, 22 Oct 2019 07:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hbkTIzbzhsyYpFfbyDPjWabCYNafv764fp+X/E6iWfA=;
        b=GF6pv84J41t8zhYl4uOYI1c2EsSGiiaWXHEyfH4sHa/Coq4Sdnsy0HDJOStVkjavw5
         aHjZhNoujQbYInDXcIZ+dcFcX+/bYvBWx+/lWY0qSX0eL90ScJA9DEj5WkbkjeYnFi/c
         JxiMv9b+2lHyv+Q0EgPuLPyt9EZNvUPh0rqnvHJZ5/fe1ZiXcwLvrZpaCEVOPLHCTQfh
         DjTeGPl075ft0olZfaSbPOoVTWowGkZf7FwuEmsPiVyx1NMMg/4u5R+yf/ygcTgGeJFI
         LkE2rOQ+YVWEndLJ/Gk85m5HpSSX/wIFy4c2Ie1lVa4eB29L/y4N0zsJQ7YgOCw+m582
         lfKQ==
X-Gm-Message-State: APjAAAXWldzWnpyJwPSL8LKjuALwCxIk2A9UIKn029Yke3H3N0zn3/+W
        JFP+uh4m6C5fmW4tl03nF/A=
X-Google-Smtp-Source: APXvYqzD8uLkqOWxlAT89po5BPO0ZBdI2SXmqeR4OiZ17K5kGU1CihYDBS5B/CDqk5sqC2jWbuy0xA==
X-Received: by 2002:a19:7d06:: with SMTP id y6mr3991107lfc.120.1571754722614;
        Tue, 22 Oct 2019 07:32:02 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id z20sm9148065ljk.63.2019.10.22.07.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 07:31:59 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@xi.terra>)
        id 1iMvCn-0001Nl-W9; Tue, 22 Oct 2019 16:32:14 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] USB: ldusb: use unsigned size format specifiers
Date:   Tue, 22 Oct 2019 16:32:03 +0200
Message-Id: <20191022143203.5260-3-johan@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191022143203.5260-1-johan@kernel.org>
References: <20191022143203.5260-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent info-leak bug manifested itself along with warning about a
negative buffer overflow:

	ldusb 1-1:0.28: Read buffer overflow, -131383859965943 bytes dropped

when it was really a rather large positive one.

A sanity check that prevents this has now been put in place, but let's
fix up the size format specifiers, which should all be unsigned.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/misc/ldusb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/misc/ldusb.c b/drivers/usb/misc/ldusb.c
index c3e764909fd0..dd1ea25e42b1 100644
--- a/drivers/usb/misc/ldusb.c
+++ b/drivers/usb/misc/ldusb.c
@@ -487,7 +487,7 @@ static ssize_t ld_usb_read(struct file *file, char __user *buffer, size_t count,
 	}
 	bytes_to_read = min(count, *actual_buffer);
 	if (bytes_to_read < *actual_buffer)
-		dev_warn(&dev->intf->dev, "Read buffer overflow, %zd bytes dropped\n",
+		dev_warn(&dev->intf->dev, "Read buffer overflow, %zu bytes dropped\n",
 			 *actual_buffer-bytes_to_read);
 
 	/* copy one interrupt_in_buffer from ring_buffer into userspace */
@@ -562,8 +562,9 @@ static ssize_t ld_usb_write(struct file *file, const char __user *buffer,
 	/* write the data into interrupt_out_buffer from userspace */
 	bytes_to_write = min(count, write_buffer_size*dev->interrupt_out_endpoint_size);
 	if (bytes_to_write < count)
-		dev_warn(&dev->intf->dev, "Write buffer overflow, %zd bytes dropped\n", count-bytes_to_write);
-	dev_dbg(&dev->intf->dev, "%s: count = %zd, bytes_to_write = %zd\n",
+		dev_warn(&dev->intf->dev, "Write buffer overflow, %zu bytes dropped\n",
+			count - bytes_to_write);
+	dev_dbg(&dev->intf->dev, "%s: count = %zu, bytes_to_write = %zu\n",
 		__func__, count, bytes_to_write);
 
 	if (copy_from_user(dev->interrupt_out_buffer, buffer, bytes_to_write)) {
-- 
2.23.0

