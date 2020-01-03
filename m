Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF726C3276C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F2D217F4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2z2VnSs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgACBFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 20:05:07 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45840 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgACBFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 20:05:07 -0500
Received: by mail-ua1-f68.google.com with SMTP id 59so14176414uap.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 17:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=5Sgvu+ftX8WosJ7WQ0e9tXOw3qR77NQu+UEd3hyiXD4=;
        b=N2z2VnSsKbvyEdCtMIpQM6HpWs2GGuIW4auIa7X1g7wZBWW2kS6hIbjcOP8pPP48lV
         o/ez+NK+dh98E9pOunDBAlTWM9lhlUzVzFqKVLy3IaPvf+0uKvVY5r5Fos3NZ51qd/7L
         2to+TBxFg+m+sGUkfJdFgMh2pr/4JNB2KZ5O+Nz/h77JhmBbwT+8WX//r3Jm+VoqQd0D
         CcZFKcsD3XF1yzMSSSdWYsT7/ia2IQj5XWDn8x+UFPHEowCQBO3qbxHmJafwZSW9ZkUb
         1jK1Ta96QsRDH2ECrm/AbmvMlJPl3A3SeVLmJhOqPUdZxtY80rr8CsQdTGqICVqUdrqf
         +qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=5Sgvu+ftX8WosJ7WQ0e9tXOw3qR77NQu+UEd3hyiXD4=;
        b=emE4DhxYeVKh9zK40UutfUrzes1SSJx7lb3S8u4zkzNJsanAairvI6AU80DzNAG7p4
         O7i3eWG85qCBQxEd/uTGYCcNFrFzYm/lD4jLCORFc7Fxah1+KrnEs9o4zIFPaUMNQAEz
         Fc3OjtIrbuMfvslqj0gV/cKcchjL3YZ6Es7DPadKvC0CamnPIx6L9+VqsUcMhjd3hw8m
         18zeSo8BbnQFiQ4AWAW5kICf9nDG/ytrnjgnCx+IZw0iNKzdyyLFcfzdqCJTKL5d0wlK
         8EDOtT5/SyC+ldLnDNb5ECwmNBMBx0/HgHDERkf8UcMJ3LC3540jDzZry6pKM0YsJKRM
         Ky7w==
X-Gm-Message-State: APjAAAW3zJ4i4bfOspjjGKuPOuFcamlo7Nm8u9NU7q8XPBVgEN2ORI4z
        vSfUYHCyr008sjac80WIVKXbYg3MN6gjoCj2oNOiFgLo
X-Google-Smtp-Source: APXvYqyRysXyaIBX+UDWjrrp1LxFLTBzfE52SoyzQ2oplFoUhEappvh7Q60WzlS74qCyiY36Y5rpaNEvOIjjyV2jTfA=
X-Received: by 2002:ab0:5510:: with SMTP id t16mr53211184uaa.15.1578013505829;
 Thu, 02 Jan 2020 17:05:05 -0800 (PST)
MIME-Version: 1.0
From:   Joseph Kogut <joseph.kogut@gmail.com>
Date:   Thu, 2 Jan 2020 17:04:30 -0800
Message-ID: <CAMWSM7ha5XcoknM1qrNTMM+A5Re2yQPNWvu_ZVKAWBUx-FmasA@mail.gmail.com>
Subject: Orange Pi 4 (RK3399) fails to bring up ethernet on boot
To:     robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm working on getting the newly released Orange Pi 4 up and running
with the mainline kernel. Using the rk3399-orangepi device tree gets
the device to start booting, but the kernel has an oops when starting
networking, and the boot process fails to continue.

[  153.325306] Internal error: Oops: 96000004 [#1] SMP
[  153.325733] Modules linked in: rockchipdrm btsdio(+) brcmfmac
analogix_dp rockchip_rga dw_mipi_dsi brcmutil dw_hdmi hci_uart cec
videobuf2_dma_sg cfg80211 v4l2_mem2mem btqca rc_core videobuf2_memops
btbcm videobuf2_v4l2 btintel videobuf2_common drm_kms_helper bluetooth
dwmac_rk syscopyarea stmmac_platform videodev panfrost sysfillrect
stmmac snd_soc_simple_card sysimgblt fb_sys_fops gpu_sched
snd_soc_simple_card_utils ecdh_generic st_lsm6dsx_spi phylink mc
st_lsm6dsx_i2c ecc inv_mpu6050_i2c drm rfkill st_lsm6dsx inv_mpu6050
adc_keys rockchip_saradc gpio_keys ak8975 cm32181 dw_wdt
rockchip_thermal rtc_rk808
[  153.330457] CPU: 1 PID: 493 Comm: systemd-network Tainted: G
     L    5.5.0-rc4-1-ARCH #1
[  153.331230] Hardware name: Orange Pi RK3399 Board (DT)
[  153.331681] pstate: 40000005 (nZcv daif -PAN -UAO)
[  153.332108] pc : mdiobus_get_phy+0xc/0x28
[  153.332487] lr : stmmac_open+0x288/0xa50 [stmmac]
[  153.332899] sp : ffff800011f2b5e0
[  153.333190] x29: ffff800011f2b5e0 x28: 0000000000000000
[  153.333656] x27: ffff0000eb6448c0 x26: ffff0000eb7e7e10
[  153.334122] x25: 0000000000000001 x24: 0000000000000000
[  153.334587] x23: ffff800011829000 x22: ffff0000eb644000
[  153.335053] x21: ffff800011f2bbd0 x20: ffff0000ea0e6280
[  153.335519] x19: 00000000ffffffff x18: 0000000000000000
[  153.335984] x17: 0000000000000000 x16: 0000000000000000
[  153.336449] x15: 0000000000000000 x14: 0000000000000000
[  153.336915] x13: 0000000000000000 x12: 0000000000000000
[  153.337380] x11: 0000000000000003 x10: 0101010101010101
[  153.337845] x9 : ffff8000090becb0 x8 : 7f7f7f7f7f7f7f7f
[  153.338310] x7 : fefefeff646c606d x6 : 1e091448e4e5f6e9
[  153.338776] x5 : 697665644814091e x4 : 8080808000000000
[  153.339241] x3 : 8343c96b232bb348 x2 : ffff0000ea0b8880
[  153.339707] x1 : 00000000ffffffff x0 : fffffffffffffff8
[  153.340172] Call trace:
[  153.340392]  mdiobus_get_phy+0xc/0x28
[  153.340717]  __dev_open+0x104/0x198
[  153.341025]  __dev_change_flags+0x1a0/0x208
[  153.341393]  dev_change_flags+0x28/0x68
[  153.341731]  do_setlink+0x2cc/0xcc0
[  153.342040]  rtnl_setlink+0xf0/0x188
[  153.342355]  rtnetlink_rcv_msg+0x2b0/0x358
[  153.342719]  netlink_rcv_skb+0x60/0x120
[  153.343056]  rtnetlink_rcv+0x1c/0x28
[  153.343371]  netlink_unicast+0x1a0/0x248
[  153.343716]  netlink_sendmsg+0x1c0/0x3c0
[  153.344061]  sock_sendmsg+0x4c/0x58
[  153.344368]  __sys_sendto+0xd4/0x138
[  153.344683]  __arm64_sys_sendto+0x2c/0x38
[  153.345039]  el0_svc_handler+0xa4/0x188
[  153.345377]  el0_sync_handler+0x1c8/0x260
[  153.345730]  el0_sync+0x140/0x180
[  153.346025] Code: d65f03c0 aa1e03e9 d503201f 8b21cc00 (f941d000)
[  153.346560] ---[ end trace 0d82e8dab5e0c74f ]---

It's worth noting that the rk3399-orangepi device tree isn't
necessarily compatible with this board, though after perusing the
schematics for both the Orange Pi 4 and Orange Pi RK3399, I found no
differences as far as the networking hardware goes. However, this is
not an area in which I am well experienced.

I was able to work around this issue by reading a few other RK3399
based device trees, and adding a phy-handle property to the gmac node,
as well as an mdio child node. I have a patch [0] that works with my
board, but I'm unsure if it's correct for both Orange Pis, and even if
it is, I'm not sure what the original problem was, or how to word the
commit message to actually send the patch.

Could you please advise on how I should proceed?

Best,
Joseph

[0] https://gist.github.com/jakogut/bc21de0535b640f2374c1d07a710e8ab
