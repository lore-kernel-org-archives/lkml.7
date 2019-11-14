Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A9BC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C60206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=unikie-com.20150623.gappssmtp.com header.i=@unikie-com.20150623.gappssmtp.com header.b="RDXc0Q5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfKNMSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 07:18:51 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37337 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfKNMSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 07:18:51 -0500
Received: by mail-lj1-f194.google.com with SMTP id d5so6437836ljl.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 04:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unikie-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=CxVi3GPGI1Yul7gR4P6aaY8XhBPQyYx/5eSJ5XWodjM=;
        b=RDXc0Q5FmmfY6VL6IwoPjQAuPtBUSiEtl6EszI5DUyp0O6f1LPQ/DqCmNnF1tHd4EN
         T3s2bfVsRv5v1CVoQUT3uswpKpZCT0g6aW5UTJIKnybmWBxvCo/8ToO8Ej0i517psL8I
         6wQqnAInhQYwxnltPTT1cduXQZ5itdKiHoyix3dNENXlW/3FM8bnIxJ5F30SfqQiY8DB
         uPJuArfHDr4udxndKHsXkTLsklV5tiOAnT/fvk0/LoqSWwB5ESOC/7xypOmzEVgH+ujI
         4W0ohNpt0Iow7wZS8qwEf1+fD9iQcVTI4hA/5Dz9pgYYYuivu0tQfG+y3x6DvLo+mhE6
         49XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CxVi3GPGI1Yul7gR4P6aaY8XhBPQyYx/5eSJ5XWodjM=;
        b=lHbKBLpWauwK8+L7zfgrQyy7YyLlckhgkDGybefJQ5z6/KG7d6uWekdBVNcvPeFsUF
         J8ZN7cMZ+flmKQq6NuN5XFbC+h3EJDllqx7sqt3359uoln84Dl5+wT9Qf3XfCekTvhVp
         ospsLTRfZX/Nlz+13o/RBRedY8Bd/dzd5hIICdnmg0loE6RrJM0FxSEyI1Oxxg+jnHvW
         wdixx7R7XNd434RxJsU2JJ6IW7cQAchmffdx6BviZFWYchuKA/KMi0kME7COCRDnDpky
         EEW5yaHfRgppt2r4rVudHFYBECjXBaPj7SVHo2rdTBEf26N3zgIhC/Th8InU1d4kdYbh
         WdVg==
X-Gm-Message-State: APjAAAUtBDhs1sED484XDKXy8PDeP1q6pwKs/Ke1OLUxvZt8Clh0ajcy
        MzXU+XETJjFeetaFSF7QqElAWgMHlTo1Ww==
X-Google-Smtp-Source: APXvYqzgVdhgd5RZgTpQE4UH0meInG+j8TPTvoCZWfGfQYfb03mjbNk/ORv22U+5QNQNDb2FKuuNXA==
X-Received: by 2002:a2e:9712:: with SMTP id r18mr6657897lji.12.1573733928670;
        Thu, 14 Nov 2019 04:18:48 -0800 (PST)
Received: from localhost.localdomain ([109.204.235.119])
        by smtp.gmail.com with ESMTPSA id a15sm2480300lfj.78.2019.11.14.04.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 04:18:48 -0800 (PST)
From:   jouni.hogander@unikie.com
To:     linux-kernel@vger.kernel.org
Cc:     Jouni Hogander <jouni.hogander@unikie.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] drivers/base: Fix memory leak in error paths
Date:   Thu, 14 Nov 2019 14:18:40 +0200
Message-Id: <20191114121840.5585-1-jouni.hogander@unikie.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jouni Hogander <jouni.hogander@unikie.com>

Currently error paths are using device_del to clean-up preparations
done by device_add. This is causing memory leak as free of dev->p
allocated in device_add is freed in device_release. This is fixed by
moving freeing dev->p to counterpart of device_add i.e. device_del.

This memory leak was reported by Syzkaller:

BUG: memory leak unreferenced object 0xffff8880675ca008 (size 256):
  comm "netdev_register", pid 281, jiffies 4294696663 (age 6.808s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
  backtrace:
    [<0000000058ca4711>] kmem_cache_alloc_trace+0x167/0x280
    [<000000002340019b>] device_add+0x882/0x1750
    [<000000001d588c3a>] netdev_register_kobject+0x128/0x380
    [<0000000011ef5535>] register_netdevice+0xa1b/0xf00
    [<000000007fcf1c99>] __tun_chr_ioctl+0x20d5/0x3dd0
    [<000000006a5b7b2b>] tun_chr_ioctl+0x2f/0x40
    [<00000000f30f834a>] do_vfs_ioctl+0x1c7/0x1510
    [<00000000fba062ea>] ksys_ioctl+0x99/0xb0
    [<00000000b1c1b8d2>] __x64_sys_ioctl+0x78/0xb0
    [<00000000984cabb9>] do_syscall_64+0x16f/0x580
    [<000000000bde033d>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
    [<00000000e6ca2d9f>] 0xffffffffffffffff

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Jouni Hogander <jouni.hogander@unikie.com>
---
 drivers/base/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 7bd9cd366d41..cb4b27e82a9f 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1080,7 +1080,6 @@ EXPORT_SYMBOL_GPL(device_show_bool);
 static void device_release(struct kobject *kobj)
 {
 	struct device *dev = kobj_to_dev(kobj);
-	struct device_private *p = dev->p;
 
 	/*
 	 * Some platform devices are driven without driver attached
@@ -1102,7 +1101,6 @@ static void device_release(struct kobject *kobj)
 	else
 		WARN(1, KERN_ERR "Device '%s' does not have a release() function, it is broken and must be fixed. See Documentation/kobject.txt.\n",
 			dev_name(dev));
-	kfree(p);
 }
 
 static const void *device_namespace(struct kobject *kobj)
@@ -2388,6 +2386,7 @@ void device_del(struct device *dev)
 	kobject_del(&dev->kobj);
 	cleanup_glue_dir(dev, glue_dir);
 	put_device(parent);
+	kfree(dev->p);
 }
 EXPORT_SYMBOL_GPL(device_del);
 
-- 
2.17.1

