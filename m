Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6D1C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DDAC2077C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578605370;
	bh=BhwW9ZVjSZK+DGsmHK8idKRTibrEJR+ee4Tg01VCLPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=iMg5YBuEPQpbAjizdLob8HpeRSXcbclsro70Uca766lEoG882mi/QZrHgg5RDoK6X
	 AfyFavheB6aIl0OzNwfZVKItLvd3ABuBMFj4FpFt8xolR2vAQflbak8M/Nv9oizMV5
	 b+R+BJohagvB1MUkbd/jji097DVsfLOlil6GXxJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgAIV33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:29:29 -0500
Received: from foss.arm.com ([217.140.110.172]:36988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgAIV32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 16:29:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0993631B;
        Thu,  9 Jan 2020 13:29:28 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 850BF3F534;
        Thu,  9 Jan 2020 13:29:27 -0800 (PST)
Date:   Thu, 09 Jan 2020 21:29:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     alsa-devel@alsa-project.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dylan Reid <dgreid@google.com>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tzung-Bi Shih <tzungbi@google.com>
Subject: Applied "ASoC: max98090: fix incorrect helper in max98090_dapm_put_enum_double()" to the asoc tree
In-Reply-To: <20200108115007.31095-1-m.szyprowski@samsung.com>
Message-Id: <applied-20200108115007.31095-1-m.szyprowski@samsung.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: max98090: fix incorrect helper in max98090_dapm_put_enum_double()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.6

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 4e93c1294f4b051d574d6bc59755d2863286990e Mon Sep 17 00:00:00 2001
From: Marek Szyprowski <m.szyprowski@samsung.com>
Date: Wed, 8 Jan 2020 12:50:06 +0100
Subject: [PATCH] ASoC: max98090: fix incorrect helper in
 max98090_dapm_put_enum_double()

Commit 62d5ae4cafb7 ("ASoC: max98090: save and restore SHDN when changing
sensitive registers") extended the code for handling "LTENL Mux", "LTENR
Mux", "LBENL Mux" and "LBENR Mux" controls by adding a custom
max98090_dapm_put_enum_double() function to them. However that function
used incorrect helper to get its component object. Fix this by using the
proper snd_soc_dapm_* helper.

This fixes the following NULL pointer exception observed on
Exynos4412-based Odroid U3 board:
8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 000000b0
pgd = (ptrval)
[000000b0] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 1104 Comm: alsactl Not tainted 5.5.0-rc5-next-20200107 #166
Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
PC is at __mutex_lock+0x54/0xb18
LR is at ___might_sleep+0x3c/0x2e0
...
Process alsactl (pid: 1104, stack limit = 0x(ptrval))
...
[<c0b49630>] (__mutex_lock) from [<c0b4a110>] (mutex_lock_nested+0x1c/0x24)
[<c0b4a110>] (mutex_lock_nested) from [<c0839b3c>] (max98090_shdn_save+0x1c/0x28)
[<c0839b3c>] (max98090_shdn_save) from [<c083a4f8>] (max98090_dapm_put_enum_double+0x20/0x40)
[<c083a4f8>] (max98090_dapm_put_enum_double) from [<c080d0e8>] (snd_ctl_ioctl+0x190/0xbb8)
[<c080d0e8>] (snd_ctl_ioctl) from [<c02cafec>] (ksys_ioctl+0x470/0xaf8)
[<c02cafec>] (ksys_ioctl) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
...
---[ end trace 0e93f0580f4b9241 ]---

Fixes: 62d5ae4cafb7 ("ASoC: max98090: save and restore SHDN when changing sensitive registers")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
Link: https://lore.kernel.org/r/20200108115007.31095-1-m.szyprowski@samsung.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98090.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index c01ce4a3f86d..ede03663cbed 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -98,7 +98,7 @@ static int max98090_put_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component =
-		snd_soc_kcontrol_component(kcontrol);
+		snd_soc_dapm_kcontrol_component(kcontrol);
 	struct max98090_priv *max98090 =
 		snd_soc_component_get_drvdata(component);
 	int ret;
-- 
2.20.1

