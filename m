Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B20C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C605120854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahEZFth9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfCSQck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:32:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45518 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCSQck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:32:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id v21so14056518pfm.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 09:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=5i/HHt59oH/roMrJBlZU0BbeOjy0uT6dJM0jK/9SWRQ=;
        b=ahEZFth98tLqVu7jwRdTuax1PHXLqI4pMwf/+ANiNVFQvT4LnKR5Aqgu17TBHmXLmy
         UytkgvUrmCSxcw6J+iI6AzcvYpHPm4VjalFGUQD+j3CeI7BlGLB4GpkbcMpTTcWno6sm
         KdUeIyRPRD1vi4/ghgVi29hhWZ928dcz2DLcNvgHmwvoDMtysPpeQVAPv+jNgBuRNG2+
         pLVpUqbEW3HKde2hwon1B5dPE37mlXDd+WnFcDl5kUUi8ZW/9l+ZRrc5RuYV3LucYjpu
         CCIGsBpnc5DllFw67kkIhJOml9kBLeaV+lbHpIRVXW1QBZuK4pehwRCfkXWQySLnqsmU
         OkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=5i/HHt59oH/roMrJBlZU0BbeOjy0uT6dJM0jK/9SWRQ=;
        b=jNjDOP6IPlsagPKpmrcb6r1Fea68b8OGuP8LIBn91Ff546SdWzBuiNIBkNasTos2kq
         JI9WIlBpyYteHhCKdCSDT6ttb7amB7XkDMKG1H1RMOIvKAF+N/cP5vmVT/nOlF9rqtxy
         D8wjwWDNywu/JtbJHVeACug8RBCfAJSs7piIz1/oWKESRt6eMIJMIm29IICbC8xkxcBw
         QqsIrGtcc4SyFLBao77UspAytevVx+wawNXuJxftM9RqwY4iQG/DqhQvulwTOClZHqtV
         zSFLhapfmsfGYZrjeUWmTSWz4QOgKa3KQpM2e/nhz/aZjtevDA8ZL8NAqo//zGUecxrt
         49CA==
X-Gm-Message-State: APjAAAVkWe5vDLGjMpor+8zjxpOmThhPzX8Ab6q5ItqzxoWh7SdHsXFt
        yBgmyCTuLjKj3FhBa4p7eqU=
X-Google-Smtp-Source: APXvYqzRMJ7XzqmgGKTAtLENbYRh4JmXqMC5YQyQe45q3nrzC2jJ4Lhy1KuWWupNg06qKHG6M2acCQ==
X-Received: by 2002:a17:902:9f83:: with SMTP id g3mr3015258plq.296.1553013159048;
        Tue, 19 Mar 2019 09:32:39 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 14sm16533723pfh.177.2019.03.19.09.32.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 09:32:38 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Benson Leung <bleung@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Urja Rannikko <urjaman@gmail.com>
Subject: [PATCH] platform/chrome: cros_ec_debugfs: cancel/schedule logging work only if supported
Date:   Tue, 19 Mar 2019 09:32:36 -0700
Message-Id: <1553013156-2808-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following traceback was reported on ASUS C201, which does not support
console logging.

------------[ cut here ]------------
WARNING: CPU: 2 PID: 361 at kernel/workqueue.c:3030 __flush_work+0x38/0x154
Modules linked in: snd_soc_hdmi_codec cros_ec_debugfs cros_ec_sysfs uvcvideo dw_hdmi_cec dw_hdmi_i2s_audio videobuf2_vmalloc cfg80211 gpio_charger rk_crypto rfkill videobuf2_memops videobuf2_v4l2 des_generic videobuf2_common ofpart m25p80 spi_nor tpm_i2c_infineon sbs_battery mtd tpm joydev cros_ec_dev coreboot_table evdev mousedev ip_tables x_tables [last unloaded: brcmutil]
CPU: 2 PID: 361 Comm: systemd-sleep Not tainted 5.1.0-rc1-1-ARCH+ #1
Hardware name: Rockchip (Device Tree)
[<c020e4b0>] (unwind_backtrace) from [<c020ac18>] (show_stack+0x10/0x14)
[<c020ac18>] (show_stack) from [<c07a3e04>] (dump_stack+0x7c/0x9c)
[<c07a3e04>] (dump_stack) from [<c0222748>] (__warn+0xd0/0xec)
[<c0222748>] (__warn) from [<c022279c>] (warn_slowpath_null+0x38/0x44)
[<c022279c>] (warn_slowpath_null) from [<c02365d0>] (__flush_work+0x38/0x154)
[<c02365d0>] (__flush_work) from [<c023786c>] (__cancel_work_timer+0x114/0x1a4)
[<c023786c>] (__cancel_work_timer) from [<bf33233c>] (cros_ec_debugfs_suspend+0x14/0x1c [cros_ec_debugfs])
[<bf33233c>] (cros_ec_debugfs_suspend [cros_ec_debugfs]) from [<c056a888>] (dpm_run_callback+0x64/0xcc)
[<c056a888>] (dpm_run_callback) from [<c056ad2c>] (__device_suspend+0x174/0x3a8)
[<c056ad2c>] (__device_suspend) from [<c056b9e0>] (dpm_suspend+0x174/0x1e0)
[<c056b9e0>] (dpm_suspend) from [<c026b3e0>] (suspend_devices_and_enter+0x6c/0x50c)
[<c026b3e0>] (suspend_devices_and_enter) from [<c026ba8c>] (pm_suspend+0x20c/0x274)
[<c026ba8c>] (pm_suspend) from [<c026a628>] (state_store+0x54/0x88)
[<c026a628>] (state_store) from [<c03cd2d0>] (kernfs_fop_write+0x114/0x180)
[<c03cd2d0>] (kernfs_fop_write) from [<c035d48c>] (__vfs_write+0x1c/0x154)
[<c035d48c>] (__vfs_write) from [<c035f9e8>] (vfs_write+0xb8/0x198)
[<c035f9e8>] (vfs_write) from [<c035fbc0>] (ksys_write+0x3c/0x74)
[<c035fbc0>] (ksys_write) from [<c0201000>] (ret_fast_syscall+0x0/0x4c)
Exception stack(0xe9365fa8 to 0xe9365ff0)
5fa0: 00000004 beef8b28 00000004 beef8b28 00000004 00000000
5fc0: 00000004 beef8b28 02319170 00000004 beef8b28 00000004 b6f3d900 beef8b74
5fe0: 0000006c beef8a98 b6c0adac b6c66534
---[ end trace f4ee5df14e8ea0ec ]---

If console logging is not supported, the work structure is never
initialized, resulting in the traceback. Calling cancel/schedule functions
conditionally fixes the problem.

While at it, also fix error handling in the probe function.

Reported-by: Urja Rannikko <urjaman@gmail.com>
Cc: Urja Rannikko <urjaman@gmail.com>
Fixes: 6fce0a2cf5a05 ("mfd / platform: cros_ec: Move debugfs attributes to its own driver")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/platform/chrome/cros_ec_debugfs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 900c7073c46f..71308766e891 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -440,7 +440,7 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
 
 	ret = cros_ec_create_pdinfo(debug_info);
 	if (ret)
-		goto remove_debugfs;
+		goto remove_log;
 
 	ec->debug_info = debug_info;
 
@@ -448,6 +448,8 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
 
 	return 0;
 
+remove_log:
+	cros_ec_cleanup_console_log(debug_info);
 remove_debugfs:
 	debugfs_remove_recursive(debug_info->dir);
 	return ret;
@@ -467,7 +469,8 @@ static int __maybe_unused cros_ec_debugfs_suspend(struct device *dev)
 {
 	struct cros_ec_dev *ec = dev_get_drvdata(dev);
 
-	cancel_delayed_work_sync(&ec->debug_info->log_poll_work);
+	if (ec->debug_info->log_buffer.buf)
+		cancel_delayed_work_sync(&ec->debug_info->log_poll_work);
 
 	return 0;
 }
@@ -476,7 +479,8 @@ static int __maybe_unused cros_ec_debugfs_resume(struct device *dev)
 {
 	struct cros_ec_dev *ec = dev_get_drvdata(dev);
 
-	schedule_delayed_work(&ec->debug_info->log_poll_work, 0);
+	if (ec->debug_info->log_buffer.buf)
+		schedule_delayed_work(&ec->debug_info->log_poll_work, 0);
 
 	return 0;
 }
-- 
2.7.4

