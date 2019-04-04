Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58ABBC10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2348621872
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368774;
	bh=YoFooV2NTkwcTdEHP6rBFxUyLockUIM7Q6wp/4To9uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mLpAwc3Rp3nphmO9FcD2dH7XArcWMB5c5JLUyXlfkihBEJUHlYZD+ZjcbZ0+WGZ9A
	 oHYIHYcIBA3H7Z9m/+/yRX6ozwLrgb3pD5S3Ca1BPNw1xb5p5U/GZelhMdEPSrnO/f
	 8N413GtZp4hINdwSEl+4gL8vce/NcYw0T2izbUMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732276AbfDDJGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:06:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731783AbfDDJGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:06:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0DC92147C;
        Thu,  4 Apr 2019 09:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368769;
        bh=YoFooV2NTkwcTdEHP6rBFxUyLockUIM7Q6wp/4To9uw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e/KI9k7PzcAxJt0W50gTEAbQTSFy1IMHIO3MPKFs1mFxixoDtMoTXpUoO+SYU7qCH
         sTvfAiwVUSPIqMHj5NsQ0FM+SB4baryKTESGOKG4pHh9zqLb7lrVQ6ZjAKhV/F486h
         Stkg2Ybna5xVTsU3LoQZaIpEi+myFLky7NOJn+5A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 147/187] backlight: pwm_bl: Use gpiod_get_value_cansleep() to get initial state
Date:   Thu,  4 Apr 2019 10:48:04 +0200
Message-Id: <20190404084610.075166039@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit cec2b18832e26bc866bef2be22eff4e25bbc4034 ]

gpiod_get_value() gives out a warning if access to the underlying gpiochip
requires sleeping, which is common for I2C based chips:

    WARNING: CPU: 0 PID: 77 at drivers/gpio/gpiolib.c:2500 gpiod_get_value+0xd0/0x100
    Modules linked in:
    CPU: 0 PID: 77 Comm: kworker/0:2 Not tainted 4.14.0-rc3-00589-gf32897915d48-dirty #90
    Hardware name: Allwinner sun4i/sun5i Families
    Workqueue: events deferred_probe_work_func
    [<c010ec50>] (unwind_backtrace) from [<c010b784>] (show_stack+0x10/0x14)
    [<c010b784>] (show_stack) from [<c0797224>] (dump_stack+0x88/0x9c)
    [<c0797224>] (dump_stack) from [<c0125b08>] (__warn+0xe8/0x100)
    [<c0125b08>] (__warn) from [<c0125bd0>] (warn_slowpath_null+0x20/0x28)
    [<c0125bd0>] (warn_slowpath_null) from [<c037069c>] (gpiod_get_value+0xd0/0x100)
    [<c037069c>] (gpiod_get_value) from [<c03778d0>] (pwm_backlight_probe+0x238/0x508)
    [<c03778d0>] (pwm_backlight_probe) from [<c0411a2c>] (platform_drv_probe+0x50/0xac)
    [<c0411a2c>] (platform_drv_probe) from [<c0410224>] (driver_probe_device+0x238/0x2e8)
    [<c0410224>] (driver_probe_device) from [<c040e820>] (bus_for_each_drv+0x44/0x94)
    [<c040e820>] (bus_for_each_drv) from [<c040ff0c>] (__device_attach+0xb0/0x114)
    [<c040ff0c>] (__device_attach) from [<c040f4f8>] (bus_probe_device+0x84/0x8c)
    [<c040f4f8>] (bus_probe_device) from [<c040f944>] (deferred_probe_work_func+0x50/0x14c)
    [<c040f944>] (deferred_probe_work_func) from [<c013be84>] (process_one_work+0x1ec/0x414)
    [<c013be84>] (process_one_work) from [<c013ce5c>] (worker_thread+0x2b0/0x5a0)
    [<c013ce5c>] (worker_thread) from [<c0141908>] (kthread+0x14c/0x154)
    [<c0141908>] (kthread) from [<c0107ab0>] (ret_from_fork+0x14/0x24)

This was missed in commit 0c9501f823a4 ("backlight: pwm_bl: Handle gpio
that can sleep"). The code was then moved to a separate function in
commit 7613c922315e ("backlight: pwm_bl: Move the checks for initial power
state to a separate function").

The only usage of gpiod_get_value() is during the probe stage, which is
safe to sleep in. Switch to gpiod_get_value_cansleep().

Fixes: 0c9501f823a4 ("backlight: pwm_bl: Handle gpio that can sleep")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/pwm_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 6bde543452f2..7ddc0930e98c 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -425,7 +425,7 @@ static int pwm_backlight_initial_power_state(const struct pwm_bl_data *pb)
 	 */
 
 	/* if the enable GPIO is disabled, do not enable the backlight */
-	if (pb->enable_gpio && gpiod_get_value(pb->enable_gpio) == 0)
+	if (pb->enable_gpio && gpiod_get_value_cansleep(pb->enable_gpio) == 0)
 		return FB_BLANK_POWERDOWN;
 
 	/* The regulator is disabled, do not enable the backlight */
-- 
2.19.1



