Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F6CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EAA4205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712457;
	bh=cT2WRBECPsHvsNNeoVIDWb07xf+29mo4gV366PwFG94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=INK+Eh1ZOamRUTXxzo2ullPZFjA81mizwiBvRdY/HIeTpW+/cOHsqUWBXgwye+JvL
	 wvt+Tkqj7fomLNTg9pTviBX10yMzAJhFIRK9dK+K6yJMgCjJs7/nbCa5gXxlEpfrdn
	 2PqK2HVUkZFuAjN9GvF9UwWF2DkMMTnP4d0XzUpc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390777AbfC0STu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:19:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390741AbfC0STi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:19:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DDBC20449;
        Wed, 27 Mar 2019 18:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710777;
        bh=cT2WRBECPsHvsNNeoVIDWb07xf+29mo4gV366PwFG94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=st8+CBurBcBsjUB5aRoPhWbQUE5Ii6mWDgYrpryCbd2g5RazEq0eF/Fr6HAGYCoCU
         Zvh55ur/FTF3fjJgezzO5UIoR+ubWG17vS2aAvuKNlz9Jy2M9RVJt9B+NSSd9SIask
         V+Q2PZ/XXAMvxHpswJtvsBo07FyGyW4VfZYvNx1o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 096/123] backlight: pwm_bl: Use gpiod_get_value_cansleep() to get initial state
Date:   Wed, 27 Mar 2019 14:16:00 -0400
Message-Id: <20190327181628.15899-96-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

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
index 0fa7d2bd0e48..aef3c1c29564 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -211,7 +211,7 @@ static int pwm_backlight_initial_power_state(const struct pwm_bl_data *pb)
 	 */
 
 	/* if the enable GPIO is disabled, do not enable the backlight */
-	if (pb->enable_gpio && gpiod_get_value(pb->enable_gpio) == 0)
+	if (pb->enable_gpio && gpiod_get_value_cansleep(pb->enable_gpio) == 0)
 		return FB_BLANK_POWERDOWN;
 
 	/* The regulator is disabled, do not enable the backlight */
-- 
2.19.1

