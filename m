Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22AEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7330C2192D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255948;
	bh=xXzr/HEJBLxd8oLLIXo3McwFd/oNSGAhDFrmi9GqaAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bdKTKE5pcbrXAZC2j1xix5U/oFXwpgSbGfbP3mSiX7CwJbwRDi1mijbPH45MzsfP8
	 yLxEIlzARZQ0S0Ojz7o+7HALcHvv1zn1Jd7ZP7CLMoKaGOBngLUIw+L28Zl43pbr4Z
	 tzljUpfjzCmbY0urHl9wpSrpCDhtx8rW5PQqESUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387926AbfCVL7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:59:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387917AbfCVL7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:59:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 487DF20830;
        Fri, 22 Mar 2019 11:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255941;
        bh=xXzr/HEJBLxd8oLLIXo3McwFd/oNSGAhDFrmi9GqaAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bVpz69Yrl4A7MBmWaFRoouxS3h9O/9v25XHxaVB6afx5k1vyHlrIPJ13hg2uOAqcr
         HTsL8ggIOiFsrFB2gcjPUjL6fmiuTMvNZ07/9USM5TN3RESvEeTf96AU2n0QQ51ZK/
         CthUVS+MbO2chHPbQUhoWUhWrYvTu3kl5qJjinXE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Koz=C5=82owski?= <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 043/280] ASoC: samsung: Prevent clk_get_rate() calls in atomic context
Date:   Fri, 22 Mar 2019 12:13:16 +0100
Message-Id: <20190322111308.743358758@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

[ Upstream commit 860b454c2c0cbda6892954f5cdbbb48931b3c8db ]

This patch moves clk_get_rate() call from trigger() to hw_params()
callback to avoid calling sleeping clk API from atomic context
and prevent deadlock as indicated below.

Before this change clk_get_rate() was being called with same
spinlock held as the one passed to the clk API when registering
clocks exposed by the I2S driver.

[   82.109780] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:908
[   82.117009] in_atomic(): 1, irqs_disabled(): 128, pid: 1554, name: speaker-test
[   82.124235] 3 locks held by speaker-test/1554:
[   82.128653]  #0: cc8c5328 (snd_pcm_link_rwlock){...-}, at: snd_pcm_stream_lock_irq+0x20/0x38
[   82.137058]  #1: ec9eda17 (&(&substream->self_group.lock)->rlock){..-.}, at: snd_pcm_ioctl+0x900/0x1268
[   82.146417]  #2: 6ac279bf (&(&pri_dai->spinlock)->rlock){..-.}, at: i2s_trigger+0x64/0x6d4
[   82.154650] irq event stamp: 8144
[   82.157949] hardirqs last  enabled at (8143): [<c0a0f574>] _raw_read_unlock_irq+0x24/0x5c
[   82.166089] hardirqs last disabled at (8144): [<c0a0f6a8>] _raw_read_lock_irq+0x18/0x58
[   82.174063] softirqs last  enabled at (8004): [<c01024e4>] __do_softirq+0x3a4/0x66c
[   82.181688] softirqs last disabled at (7997): [<c012d730>] irq_exit+0x140/0x168
[   82.188964] Preemption disabled at:
[   82.188967] [<00000000>]   (null)
[   82.195728] CPU: 6 PID: 1554 Comm: speaker-test Not tainted 5.0.0-rc5-00192-ga6e6caca8f03 #191
[   82.204302] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   82.210376] [<c0111a54>] (unwind_backtrace) from [<c010d8f4>] (show_stack+0x10/0x14)
[   82.218084] [<c010d8f4>] (show_stack) from [<c09ef004>] (dump_stack+0x90/0xc8)
[   82.225278] [<c09ef004>] (dump_stack) from [<c0152980>] (___might_sleep+0x22c/0x2c8)
[   82.232990] [<c0152980>] (___might_sleep) from [<c0a0a2e4>] (__mutex_lock+0x28/0xa3c)
[   82.240788] [<c0a0a2e4>] (__mutex_lock) from [<c0a0ad80>] (mutex_lock_nested+0x1c/0x24)
[   82.248763] [<c0a0ad80>] (mutex_lock_nested) from [<c04923dc>] (clk_prepare_lock+0x78/0xec)
[   82.257079] [<c04923dc>] (clk_prepare_lock) from [<c049538c>] (clk_core_get_rate+0xc/0x5c)
[   82.265309] [<c049538c>] (clk_core_get_rate) from [<c0766b18>] (i2s_trigger+0x490/0x6d4)
[   82.273369] [<c0766b18>] (i2s_trigger) from [<c074fec4>] (soc_pcm_trigger+0x100/0x140)
[   82.281254] [<c074fec4>] (soc_pcm_trigger) from [<c07378a0>] (snd_pcm_do_start+0x2c/0x30)
[   82.289400] [<c07378a0>] (snd_pcm_do_start) from [<c07376cc>] (snd_pcm_action_single+0x38/0x78)
[   82.298065] [<c07376cc>] (snd_pcm_action_single) from [<c073a450>] (snd_pcm_ioctl+0x910/0x1268)
[   82.306734] [<c073a450>] (snd_pcm_ioctl) from [<c0292344>] (do_vfs_ioctl+0x90/0x9ec)
[   82.314443] [<c0292344>] (do_vfs_ioctl) from [<c0292cd4>] (ksys_ioctl+0x34/0x60)
[   82.321808] [<c0292cd4>] (ksys_ioctl) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
[   82.329431] Exception stack(0xeb875fa8 to 0xeb875ff0)
[   82.334459] 5fa0:                   00033c18 b6e31000 00000004 00004142 00033d80 00033d80
[   82.342605] 5fc0: 00033c18 b6e31000 00008000 00000036 00008000 00000000 beea38a8 00008000
[   82.350748] 5fe0: b6e3142c beea384c b6da9a30 b6c9212c
[   82.355789]
[   82.357245] ======================================================
[   82.363397] WARNING: possible circular locking dependency detected
[   82.369551] 5.0.0-rc5-00192-ga6e6caca8f03 #191 Tainted: G        W
[   82.376395] ------------------------------------------------------
[   82.382548] speaker-test/1554 is trying to acquire lock:
[   82.387834] 6d2007f4 (prepare_lock){+.+.}, at: clk_prepare_lock+0x78/0xec
[   82.394593]
[   82.394593] but task is already holding lock:
[   82.400398] 6ac279bf (&(&pri_dai->spinlock)->rlock){..-.}, at: i2s_trigger+0x64/0x6d4
[   82.408197]
[   82.408197] which lock already depends on the new lock.
[   82.416343]
[   82.416343] the existing dependency chain (in reverse order) is:
[   82.423795]
[   82.423795] -> #1 (&(&pri_dai->spinlock)->rlock){..-.}:
[   82.430472]        clk_mux_set_parent+0x34/0xb8
[   82.434975]        clk_core_set_parent_nolock+0x1c4/0x52c
[   82.440347]        clk_set_parent+0x38/0x6c
[   82.444509]        of_clk_set_defaults+0xc8/0x308
[   82.449186]        of_clk_add_provider+0x84/0xd0
[   82.453779]        samsung_i2s_probe+0x408/0x5f8
[   82.458376]        platform_drv_probe+0x48/0x98
[   82.462879]        really_probe+0x224/0x3f4
[   82.467037]        driver_probe_device+0x70/0x1c4
[   82.471716]        bus_for_each_drv+0x44/0x8c
[   82.476049]        __device_attach+0xa0/0x138
[   82.480382]        bus_probe_device+0x88/0x90
[   82.484715]        deferred_probe_work_func+0x6c/0xbc
[   82.489741]        process_one_work+0x200/0x740
[   82.494246]        worker_thread+0x2c/0x4c8
[   82.498408]        kthread+0x128/0x164
[   82.502131]        ret_from_fork+0x14/0x20
[   82.506204]          (null)
[   82.508976]
[   82.508976] -> #0 (prepare_lock){+.+.}:
[   82.514264]        __mutex_lock+0x60/0xa3c
[   82.518336]        mutex_lock_nested+0x1c/0x24
[   82.522756]        clk_prepare_lock+0x78/0xec
[   82.527088]        clk_core_get_rate+0xc/0x5c
[   82.531421]        i2s_trigger+0x490/0x6d4
[   82.535494]        soc_pcm_trigger+0x100/0x140
[   82.539913]        snd_pcm_do_start+0x2c/0x30
[   82.544246]        snd_pcm_action_single+0x38/0x78
[   82.549012]        snd_pcm_ioctl+0x910/0x1268
[   82.553345]        do_vfs_ioctl+0x90/0x9ec
[   82.557417]        ksys_ioctl+0x34/0x60
[   82.561229]        ret_fast_syscall+0x0/0x28
[   82.565477]        0xbeea384c
[   82.568421]
[   82.568421] other info that might help us debug this:
[   82.568421]
[   82.576394]  Possible unsafe locking scenario:
[   82.576394]
[   82.582285]        CPU0                    CPU1
[   82.586792]        ----                    ----
[   82.591297]   lock(&(&pri_dai->spinlock)->rlock);
[   82.595977]                                lock(prepare_lock);
[   82.601782]                                lock(&(&pri_dai->spinlock)->rlock);
[   82.608975]   lock(prepare_lock);
[   82.612268]
[   82.612268]  *** DEADLOCK ***

Fixes: 647d04f8e07a ("ASoC: samsung: i2s: Ensure the RCLK rate is properly determined")
Reported-by: Krzysztof Kozłowski <krzk@kernel.org>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/samsung/i2s.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index d6c62aa13041..ce00fe2f6aae 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -700,6 +700,7 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 {
 	struct i2s_dai *i2s = to_info(dai);
 	u32 mod, mask = 0, val = 0;
+	struct clk *rclksrc;
 	unsigned long flags;
 
 	WARN_ON(!pm_runtime_active(dai->dev));
@@ -782,6 +783,10 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 
 	i2s->frmclk = params_rate(params);
 
+	rclksrc = i2s->clk_table[CLK_I2S_RCLK_SRC];
+	if (rclksrc && !IS_ERR(rclksrc))
+		i2s->rclk_srcrate = clk_get_rate(rclksrc);
+
 	return 0;
 }
 
@@ -886,11 +891,6 @@ static int config_setup(struct i2s_dai *i2s)
 		return 0;
 
 	if (!(i2s->quirks & QUIRK_NO_MUXPSR)) {
-		struct clk *rclksrc = i2s->clk_table[CLK_I2S_RCLK_SRC];
-
-		if (rclksrc && !IS_ERR(rclksrc))
-			i2s->rclk_srcrate = clk_get_rate(rclksrc);
-
 		psr = i2s->rclk_srcrate / i2s->frmclk / rfs;
 		writel(((psr - 1) << 8) | PSR_PSREN, i2s->addr + I2SPSR);
 		dev_dbg(&i2s->pdev->dev,
-- 
2.19.1



