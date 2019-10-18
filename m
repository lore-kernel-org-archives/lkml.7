Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE68CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F39C222C5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571408329;
	bh=GY9sgDJVxMpUl2IAi08bvJ70wUz6JavTXmmFwL7vT6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QTv34Si9DQ0Wt21RzWVVH6fw7lCT2QLBM3vwyb/ceb2LSYTKyQ/XDCuheEeM37Ni8
	 rKME1yrEc2CUoHbPTcqj+EtywUrdItGfz+VLC5u0uvMMWBngVHMZPpzO7LiVQSFbff
	 IUjR5BNkuMGBaVWB9Kte+xjD8/MmQpmC1CdzujKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633996AbfJROSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:18:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44840 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732676AbfJROSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:18:40 -0400
Received: by mail-lj1-f194.google.com with SMTP id m13so6385824ljj.11;
        Fri, 18 Oct 2019 07:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lK62GsaMPQOlyqa+AeKYuWxGPH9VRYmA+fAbIM8QXgg=;
        b=UNMMwzrk7l/zo+MYQg8qxs0W8w+SoRYxOpfAT493SwFYcLSyACYWSDQzxjiBRSt8qY
         +pE7IXhgGFUrN4fDEna2IW7CNxmz0fDwt/wWx5Qzd0F9vV3aRlzZxvsiwdX64RCIJtr9
         a5C6G+zhvFNIwoWvEM5T9CJTVHErlTSMQaXFaCCLWgHRlupg8vKwSZ7ViDXEFzkLDIeO
         9HoExPgMa2Zq0Yj/bjsb/gz3B6yyyWQVnh8REXnSKx4TsQNZoMGVthhC86MKvUwFucCR
         LbK6S4wwszjpPyzvQpXDI40x3K7lXVMzFj5cYvwIv8uI3Q+y0CsRlw9Zs0FJ2shBAX+G
         voKw==
X-Gm-Message-State: APjAAAW6Z05oqDPCmq7ml0vfN7g3hMGhP+EU82gcy3D+ZsKUPSNrfwbu
        kYDEfiCK2L08AqKaMVjHAfI=
X-Google-Smtp-Source: APXvYqyT+4O2YoCKFj1gH2GwxW0feEY6wE3RN9nro6b0WUC13Xddq6uNuukLGSswJDT8hLZUJpCl6Q==
X-Received: by 2002:a2e:86cd:: with SMTP id n13mr6579303ljj.252.1571408318149;
        Fri, 18 Oct 2019 07:18:38 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id z26sm2202097lji.79.2019.10.18.07.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 07:18:36 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@xi.terra>)
        id 1iLT5d-0006CE-9Q; Fri, 18 Oct 2019 16:18:49 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>
Subject: [PATCH RFC 2/2] USB: ldusb: fix ring-buffer locking
Date:   Fri, 18 Oct 2019 16:17:50 +0200
Message-Id: <20191018141750.23756-3-johan@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018141750.23756-1-johan@kernel.org>
References: <20191018141750.23756-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The custom ring-buffer implementation was merged without any locking
whatsoever, but a spinlock was later added by commit 9d33efd9a791
("USB: ldusb bugfix").

The lock did not cover the loads from the ring-buffer-entry after
determining the buffer was non-empty, nor the update of the tail index
once the entry had been processed. The former could lead to stale data
being returned, while the latter could lead to memory corruption on
sufficiently weakly ordered architectures.

Fixes: 2824bd250f0b ("[PATCH] USB: add ldusb driver")
Fixes: 9d33efd9a791 ("USB: ldusb bugfix")
Cc: stable <stable@vger.kernel.org>     # 2.6.13
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/misc/ldusb.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/misc/ldusb.c b/drivers/usb/misc/ldusb.c
index 94780e14e95d..c6cf2fa6cf4c 100644
--- a/drivers/usb/misc/ldusb.c
+++ b/drivers/usb/misc/ldusb.c
@@ -477,11 +477,11 @@ static ssize_t ld_usb_read(struct file *file, char __user *buffer, size_t count,
 
 		spin_lock_irq(&dev->rbsl);
 	}
-	spin_unlock_irq(&dev->rbsl);
 
 	/* actual_buffer contains actual_length + interrupt_in_buffer */
 	actual_buffer = (size_t *)(dev->ring_buffer + dev->ring_tail * (sizeof(size_t)+dev->interrupt_in_endpoint_size));
 	if (*actual_buffer > sizeof(size_t) + dev->interrupt_in_endpoint_size) {
+		spin_unlock_irq(&dev->rbsl);
 		retval = -EIO;
 		goto unlock_exit;
 	}
@@ -489,17 +489,26 @@ static ssize_t ld_usb_read(struct file *file, char __user *buffer, size_t count,
 	if (bytes_to_read < *actual_buffer)
 		dev_warn(&dev->intf->dev, "Read buffer overflow, %zd bytes dropped\n",
 			 *actual_buffer-bytes_to_read);
+	spin_unlock_irq(&dev->rbsl);
+
+	/*
+	 * Pairs with spin_unlock_irqrestore() in
+	 * ld_usb_interrupt_in_callback() and makes sure the ring-buffer entry
+	 * has been updated before copy_to_user().
+	 */
+	smp_rmb();
 
 	/* copy one interrupt_in_buffer from ring_buffer into userspace */
 	if (copy_to_user(buffer, actual_buffer+1, bytes_to_read)) {
 		retval = -EFAULT;
 		goto unlock_exit;
 	}
-	dev->ring_tail = (dev->ring_tail+1) % ring_buffer_size;
-
 	retval = bytes_to_read;
 
 	spin_lock_irq(&dev->rbsl);
+
+	dev->ring_tail = (dev->ring_tail + 1) % ring_buffer_size;
+
 	if (dev->buffer_overflow) {
 		dev->buffer_overflow = 0;
 		spin_unlock_irq(&dev->rbsl);
-- 
2.23.0

