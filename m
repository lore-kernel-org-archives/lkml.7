Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11302C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34F4218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfCVNyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:54:38 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:16581 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727487AbfCVNyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:54:38 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2MDpoup024526;
        Fri, 22 Mar 2019 14:54:13 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2r8qg53r00-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 22 Mar 2019 14:54:13 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B8F313A;
        Fri, 22 Mar 2019 13:54:12 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 96F665020;
        Fri, 22 Mar 2019 13:54:12 +0000 (GMT)
Received: from localhost (10.75.127.48) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 22 Mar 2019 14:54:12
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [RFC PATCH] iio: core: fix a possible circular locking dependency
Date:   Fri, 22 Mar 2019 14:54:06 +0100
Message-ID: <1553262846-23126-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-22_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a possible circular locking dependency detected warning seen
with:
- CONFIG_PROVE_LOCKING=y
- consumer/provider IIO devices (ex: "voltage-divider" consumer of "adc")

When using the IIO consumer interface, e.g. iio_channel_get(),
the consumer device will likely call iio_read_channel_raw() or similar that
rely on 'info_exist_lock' mutex.

typically:
...
	mutex_lock(&chan->indio_dev->info_exist_lock);
	if (chan->indio_dev->info == NULL) {
		ret = -ENODEV;
		goto err_unlock;
	}
	ret = do_some_ops()
err_unlock:
	mutex_unlock(&chan->indio_dev->info_exist_lock);
	return ret;
...

Same mutex is also hold in iio_device_unregister().

The following deadlock warning happens when:
- the consumer device has called an API like iio_read_channel_raw()
  at least once.
- the consumer driver is unregistered, removed (unbind from sysfs)

======================================================
WARNING: possible circular locking dependency detected
4.19.24 #577 Not tainted
------------------------------------------------------
sh/372 is trying to acquire lock:
(kn->count#30){++++}, at: kernfs_remove_by_name_ns+0x3c/0x84

but task is already holding lock:
(&dev->info_exist_lock){+.+.}, at: iio_device_unregister+0x18/0x60

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (&dev->info_exist_lock){+.+.}:
       __mutex_lock+0x70/0xa3c
       mutex_lock_nested+0x1c/0x24
       iio_read_channel_raw+0x1c/0x60
       iio_read_channel_info+0xa8/0xb0
       dev_attr_show+0x1c/0x48
       sysfs_kf_seq_show+0x84/0xec
       seq_read+0x154/0x528
       __vfs_read+0x2c/0x15c
       vfs_read+0x8c/0x110
       ksys_read+0x4c/0xac
       ret_fast_syscall+0x0/0x28
       0xbedefb60

-> #0 (kn->count#30){++++}:
       lock_acquire+0xd8/0x268
       __kernfs_remove+0x288/0x374
       kernfs_remove_by_name_ns+0x3c/0x84
       remove_files+0x34/0x78
       sysfs_remove_group+0x40/0x9c
       sysfs_remove_groups+0x24/0x34
       device_remove_attrs+0x38/0x64
       device_del+0x11c/0x360
       cdev_device_del+0x14/0x2c
       iio_device_unregister+0x24/0x60
       release_nodes+0x1bc/0x200
       device_release_driver_internal+0x1a0/0x230
       unbind_store+0x80/0x130
       kernfs_fop_write+0x100/0x1e4
       __vfs_write+0x2c/0x160
       vfs_write+0xa4/0x17c
       ksys_write+0x4c/0xac
       ret_fast_syscall+0x0/0x28
       0xbe906840

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&dev->info_exist_lock);
                               lock(kn->count#30);
                               lock(&dev->info_exist_lock);
  lock(kn->count#30);

 *** DEADLOCK ***
...

So only hold the mutex to:
- disable all buffers while 'info' is available
- set 'info' to NULL
Then release it to call cdev_device_del and so on.

Help to reproduce:
See example: Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
sysv {
	compatible = "voltage-divider";
	io-channels = <&adc 0>;
	output-ohms = <22>;
	full-ohms = <222>;
};

First, go to iio:deviceX for the "voltage-divider", do one read:
$ cd /sys/bus/iio/devices/iio:deviceX
$ cat in_voltage0_raw

Then, unbind the consumer driver. It triggers above deadlock warning.
$ cd /sys/bus/platform/drivers/iio-rescale/
$ echo sysv > unbind

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/industrialio-core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 4700fd5..e03d6ff 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1745,19 +1745,19 @@ void iio_device_unregister(struct iio_dev *indio_dev)
 {
 	mutex_lock(&indio_dev->info_exist_lock);
 
-	cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
-
-	iio_device_unregister_debugfs(indio_dev);
-
 	iio_disable_all_buffers(indio_dev);
 
 	indio_dev->info = NULL;
 
+	mutex_unlock(&indio_dev->info_exist_lock);
+
+	cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
+
+	iio_device_unregister_debugfs(indio_dev);
+
 	iio_device_wakeup_eventset(indio_dev);
 	iio_buffer_wakeup_poll(indio_dev);
 
-	mutex_unlock(&indio_dev->info_exist_lock);
-
 	iio_buffer_free_sysfs_and_mask(indio_dev);
 }
 EXPORT_SYMBOL(iio_device_unregister);
-- 
2.7.4

