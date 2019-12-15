Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA661C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 20:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADE624676
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 20:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfLOU1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 15:27:47 -0500
Received: from gloria.sntech.de ([185.11.138.130]:49584 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbfLOU1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 15:27:47 -0500
Received: from ip5f5a5f74.dynamic.kabel-deutschland.de ([95.90.95.116] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1igaUO-00045X-OG; Sun, 15 Dec 2019 21:27:40 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Soeren Moch <smoch@web.de>, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 4/4] mfd: rk808: Convert RK805 to syscore/PM ops
Date:   Sun, 15 Dec 2019 21:27:40 +0100
Message-ID: <2681192.H4ySjFOPB8@diego>
In-Reply-To: <CANAwSgTtzAZJqpsD7uVKskTnDmrT1bs=JuHxnPrkpQKtnZLhvQ@mail.gmail.com>
References: <cover.1575932654.git.robin.murphy@arm.com> <8642045f0657c9e782cd698eb08777c9d4c10c8d.1575932654.git.robin.murphy@arm.com> <CANAwSgTtzAZJqpsD7uVKskTnDmrT1bs=JuHxnPrkpQKtnZLhvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

Am Sonntag, 15. Dezember 2019, 19:51:50 CET schrieb Anand Moon:
> On Tue, 10 Dec 2019 at 18:54, Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > RK805 has the same kind of dual-role sleep/shutdown pin as RK809/RK817,
> > so it makes little sense for the driver to have to have two completely
> > different mechanisms to handle essentially the same thing. Bring RK805
> > in line with the RK809/RK817 flow to clean things up.
> >
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > ---

[...]

> I am sill getting the kernel warning on issue poweroff see below.
> on my Rock960 Model A
> I feel the reason for this is we now have two poweroff callback
> 1  pm_power_off = rk808_device_shutdown
> 2  rk8xx_syscore_shutdown

Nope, the issue is just the i2c subsystem complaining that the
Rocckhip i2c drives does not provide an atomic-transfer function, see
	"No atomic I2C transfer handler for 'i2c-0'"
in your warning.

Somewhere it was suggested that the current transfer function just
works as atomic as well.


> In my investigation earlier common function for shutdown solve
> the issue of clean shutdown.

This is simply a result of your syscore-shutdown function running way to
early, before the i2c subsystem switched to using atomic transfers.

This also indicates that this would really be way to early, as other parts
of the kernel could also still be running.

Heiko


> for *rockchip,system-power-controller* dts property
> we can used flags if check if this property support clean shutdown
> for that device.
> 
> [  565.009291] xhci-hcd xhci-hcd.0.auto: USB bus 5 deregistered
> [  565.010179] reboot: Power down
> [  565.010536] ------------[ cut here ]------------
> [  565.010940] No atomic I2C transfer handler for 'i2c-0'
> [  565.011437] WARNING: CPU: 0 PID: 1 at drivers/i2c/i2c-core.h:40
> i2c_transfer+0xe4/0xf8
> [  565.012126] Modules linked in: snd_soc_hdmi_codec dw_hdmi_i2s_audio
> rockchipdrm nvme analogix_dp nvme_core brcmfmac hci_uart dw_mipi_dsi
> dw_hdmi btbcm cec panfrost bluetooth drm_kms_helper brcmutil gpu_sched
> cfg80211 crct10dif_ce snd_soc_rockchip_i2s snd_soc_simple_card drm
> ecdh_generic snd_soc_rockchip_pcm snd_soc_simple_card_utils
> phy_rockchip_pcie ecc rtc_rk808 rfkill rockchip_thermal
> pcie_rockchip_host ip_tables x_tables ipv6 nf_defrag_ipv6
> [  565.015578] CPU: 0 PID: 1 Comm: shutdown Not tainted
> 5.5.0-rc1-00292-gd46dd6369c55 #7
> [  565.016260] Hardware name: 96boards Rock960 (DT)
> [  565.016666] pstate: 60000085 (nZCv daIf -PAN -UAO)
> [  565.017087] pc : i2c_transfer+0xe4/0xf8
> [  565.017425] lr : i2c_transfer+0xe4/0xf8
> [  565.017762] sp : ffff80001004baf0
> [  565.018052] x29: ffff80001004baf0 x28: ffff00007d208000
> [  565.018517] x27: 0000000000000000 x26: 0000000000000000
> [  565.018982] x25: 0000000000000008 x24: 0000000000000000
> [  565.019447] x23: ffff00007d208000 x22: ffff80001004bc64
> [  565.019912] x21: ffff80001004bb48 x20: 0000000000000002
> [  565.020377] x19: ffff000078502080 x18: 0000000000000010
> [  565.020842] x17: 0000000000000001 x16: 0000000000000019
> [  565.021307] x15: ffff00007d208470 x14: ffffffffffffffff
> [  565.021772] x13: ffff80009004b857 x12: ffff80001004b860
> [  565.022237] x11: ffff800011841000 x10: ffff800011a10658
> [  565.022702] x9 : 0000000000000000 x8 : ffff800011a11000
> [  565.023167] x7 : ffff800010697c78 x6 : 0000000000000262
> [  565.023632] x5 : 0000000000000000 x4 : 0000000000000000
> [  565.024096] x3 : 00000000ffffffff x2 : ffff800011841ab8
> [  565.024561] x1 : 7b11701b0ae78800 x0 : 0000000000000000
> [  565.025027] Call trace:
> [  565.025246]  i2c_transfer+0xe4/0xf8
> [  565.025556]  regmap_i2c_read+0x5c/0xa0
> [  565.025886]  _regmap_raw_read+0xcc/0x138
> [  565.026230]  _regmap_bus_read+0x3c/0x70
> [  565.026568]  _regmap_read+0x60/0xe0
> [  565.026875]  _regmap_update_bits+0xc8/0x108
> [  565.027241]  regmap_update_bits_base+0x60/0x90
> [  565.027633]  rk808_device_shutdown+0x6c/0x88
> [  565.028010]  machine_power_off+0x24/0x30
> [  565.028356]  kernel_power_off+0x64/0x70
> [  565.028693]  __do_sys_reboot+0x15c/0x240
> [  565.029038]  __arm64_sys_reboot+0x20/0x28
> [  565.029390]  el0_svc_common.constprop.0+0x68/0x160
> [  565.029811]  el0_svc_handler+0x20/0x80
> [  565.030141]  el0_sync_handler+0x10c/0x180
> [  565.030493]  el0_sync+0x140/0x180
> [  565.030785] ---[ end trace 5167e842ce15f686 ]---
> 
> -Anand
> 




