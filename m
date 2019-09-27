Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6A9C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0531B217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfI0NEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 09:04:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40483 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfI0NE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 09:04:29 -0400
Received: from mail-yw1-f70.google.com ([209.85.161.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <ddstreet@canonical.com>)
        id 1iDpv9-0007ZO-1l
        for linux-kernel@vger.kernel.org; Fri, 27 Sep 2019 13:04:27 +0000
Received: by mail-yw1-f70.google.com with SMTP id p185so1823660ywb.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 06:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g2422qWCHM5rl0rhUoaf7+HFNjo5Bz0O/sMP9pLF2y0=;
        b=ZpROtdSd8MQd5EgZHQqe40Axoy4K6V6qDMxMT9Y8oeBCBbdelQWC/Ts1zqnMw5Jghv
         leVhvyYMX5DXBrFlMT65C69tt20UQUPAme5rWzGu8vsBN4EL/fmEwTRFtlsjCy37mvXT
         PQEfjoFexhaUMGePTJstDa9l6DryxjXhEycZWEgO3HdBF3oVPchpXit3UdwcWx2kH5zG
         uqvFaS8eaLNe6sxmK1SVayNi4LV4A/+cFugFAV8WJbWxQDdmI6xrj2doV71W1JzPyLvA
         fgjJWMIsLldvFxs5sy6n1cFhg6dz4uPvB8hoWslBxWbPIupRV6svtK7u3YjhZRlipjKS
         vFCQ==
X-Gm-Message-State: APjAAAVaREm/Nf6T4peEotjU86IfUqF1nXt87hfZKFIC/qeF7bbzbBKL
        1dPx2Zf6Vo4/Q7maLPaNgQTHi8FN5lFdO2t83+gdlqJZAK6LDgKlgo5DFrUr8b/O7yCJx6cMBsC
        7yMYrBDWkD42GAsJ+vL2jbxBSl2/jzbbUWUFhy7Snkw==
X-Received: by 2002:a25:6e04:: with SMTP id j4mr5456858ybc.247.1569589466060;
        Fri, 27 Sep 2019 06:04:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxNyrIpPwjsOyG40TGlnqldKE9gez7r5ejHg/79HBnlJm06dD/CVL8kRGzPsYgyzEnCA72Qwg==
X-Received: by 2002:a25:6e04:: with SMTP id j4mr5456828ybc.247.1569589465668;
        Fri, 27 Sep 2019 06:04:25 -0700 (PDT)
Received: from thorin.lan (45-27-90-188.lightspeed.rlghnc.sbcglobal.net. [45.27.90.188])
        by smtp.gmail.com with ESMTPSA id h136sm569448ywc.83.2019.09.27.06.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 06:04:25 -0700 (PDT)
From:   Dan Streetman <ddstreet@canonical.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Dan Streetman <ddstreet@canonical.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/vio: use simple dummy struct device as bus parent
Date:   Fri, 27 Sep 2019 09:04:02 -0400
Message-Id: <20190927130402.687-1-ddstreet@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dummy vio_bus_device creates the /sys/devices/vio directory, which
contains real vio devices under it; since it represents itself as having
a bus = &vio_bus_type, its /sys/devices/vio/uevent does call the bus's
.uevent function, vio_hotplug(), and as that function won't find a real
device for the dummy vio_dev, it will return -ENODEV.

One of the main users of the uevent node is udevadm, e.g. when it is called
with 'udevadm trigger --devices'.  Up until recently, it would ignore any
errors returned when writing to devices' uevent file, but it was recently
changed to start returning error if it gets an error writing to any uevent
file:
https://github.com/systemd/systemd/commit/97afc0351a96e0daa83964df33937967c75c644f

since the /sys/devices/vio/uevent file has always returned ENODEV from
any write to it, this now causes the udevadm trigger command to return
an error.  This may be fixed in udevadm to ignore ENODEV errors, but the
vio driver should still be fixed.

This patch changes the arch/powerpc/platform/pseries/vio.c 'dummy'
parent device into a real dummy device with no .bus, so its uevent
file will stop returning ENODEV and simply do nothing and return 0.

Signed-off-by: Dan Streetman <ddstreet@canonical.com>
---
 arch/powerpc/platforms/pseries/vio.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index 79e2287991db..63bc16631680 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -32,11 +32,8 @@
 #include <asm/page.h>
 #include <asm/hvcall.h>
 
-static struct vio_dev vio_bus_device  = { /* fake "parent" device */
-	.name = "vio",
-	.type = "",
-	.dev.init_name = "vio",
-	.dev.bus = &vio_bus_type,
+static struct device vio_bus = {
+	.init_name	= "vio",
 };
 
 #ifdef CONFIG_PPC_SMLPAR
@@ -1412,7 +1409,7 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
 	set_dev_node(&viodev->dev, of_node_to_nid(of_node));
 
 	/* init generic 'struct device' fields: */
-	viodev->dev.parent = &vio_bus_device.dev;
+	viodev->dev.parent = &vio_bus;
 	viodev->dev.bus = &vio_bus_type;
 	viodev->dev.release = vio_dev_release;
 
@@ -1499,7 +1496,7 @@ static int __init vio_bus_init(void)
 	 * The fake parent of all vio devices, just to give us
 	 * a nice directory
 	 */
-	err = device_register(&vio_bus_device.dev);
+	err = device_register(&vio_bus);
 	if (err) {
 		printk(KERN_WARNING "%s: device_register returned %i\n",
 				__func__, err);
-- 
2.20.1

